# Lab 4 — Exploit and Repair Reentrancy

The goal is to watch a single withdrawal drain a vault, read the drain in a call trace, then fix it by moving one line. Every contract here is written for this lab. Nothing touches a public network, a real address, or a real balance.

## The setup

Three contracts live in `projects/reentrancy/src`:

- `VulnerableVault` pays ETH out **before** it zeroes the caller's recorded balance. That ordering is the whole bug.
- `ReentrancyAttacker` deposits once, calls `withdraw`, and its `receive` function calls `withdraw` again while the vault still shows the old balance.
- `SafeVault` has the same accounting but reorders the withdrawal to checks–effects–interactions.

The attacker talks to the vault through a two-function interface, `deposit` and `withdraw`. It uses nothing but the public teaching surface.

## You need

- `forge` from Foundry;
- about twenty minutes.

The test suite is dependency-free. It declares the small slice of the cheatcode interface it needs directly in the test file, so `forge test` runs from a clean clone with no `forge install` and no network access.

## 1. Build

From the repository root:

```bash
cd projects/reentrancy
forge build
```

Solc 0.8.30 is pinned in `foundry.toml`. A clean build compiles the three sources and the test file and prints `Compiler run successful!`.

## 2. Run one unit test

Start with the single test that proves the loss, and nothing else:

```bash
forge test --match-test test_VulnerableVault_LosesDepositorFunds
```

The scenario is small and fixed. An honest depositor puts 3 ETH into the vault. The attacker seeds 1 ETH and calls `attack`. When the test passes, its assertions have held:

- the vault ends with `0` ETH;
- the attacker holds all 4 ETH;
- the victim's recorded balance still reads 3 ETH, yet their `withdraw` reverts, because the vault has nothing left to pay.

A passing test here is not good news for the vault. It is a proof that the artificial vault loses funds that were deposited before the attack.

## 3. Run it again with a full trace

`forge test` tells you *whether* the loss happened. `-vvvv` shows you *how*:

```bash
forge test --match-test test_VulnerableVault_LosesDepositorFunds -vvvv
```

Read the block under `Traces:`. Indentation is call depth. Each step to the right is one more frame on the call stack, still inside the same transaction.

## 4. Read the trace by depth

The center of the trace is the attack call. Trimmed to its shape:

```text
ReentrancyAttacker::attack{value: 1e18}()
├─ VulnerableVault::deposit{value: 1e18}()
├─ VulnerableVault::withdraw()
│  ├─ ReentrancyAttacker::receive{value: 1e18}()
│  │  ├─ VulnerableVault::withdraw()
│  │  │  ├─ ReentrancyAttacker::receive{value: 1e18}()
│  │  │  │  ├─ VulnerableVault::withdraw()
│  │  │  │  │  ├─ ReentrancyAttacker::receive{value: 1e18}()
│  │  │  │  │  │  ├─ VulnerableVault::withdraw()
│  │  │  │  │  │  │  └─ ReentrancyAttacker::receive{value: 1e18}()  ← vault empty, stops
```

Three things to notice:

- **`attack` called `withdraw` once.** Every deeper `withdraw` was launched from `receive`, not from the test. One external call produced four withdrawals in total.
- **Each `receive{value: 1e18}` sits between two `withdraw` frames.** That is the callback. The vault sent ETH, control moved into the attacker's code, and the attacker called back down before the vault finished.
- **The nesting stops on a balance check, not on the accounting.** The deepest `receive` runs while the vault holds less than one unit, so it returns without another `withdraw`. The vault's `balances[attacker] = 0` assignments run only while the frames unwind, after every payout has already happened.

At the bottom of the trace, after the attack unwinds, the victim's honest `withdraw` fails:

```text
VulnerableVault::withdraw()
├─ 0x...bEEF::fallback{value: 3e18}()
│  └─ ← [OutOfFunds]
└─ ← [Revert] transfer failed
```

The books still credit the victim 3 ETH. The vault has 0 ETH. The credit is now a number the contract cannot honor.

### Why this works on a single-threaded EVM

There is no second thread here. The EVM executes one instruction at a time. What the trace shows is **nesting**: an external call transfers control into another contract, and that contract can call back before the first call returns. The first `withdraw` is still open on the stack when the second one starts.

Reentrancy is this re-entry into a function whose work is not finished. The danger is not concurrency; it is that the vault handed control away in the middle of an operation, while its state still described the world as it was before the payment.

## 5. Move the state update before the external call

Open the two vaults side by side. The only difference that matters is the order of three lines in `withdraw`.

`VulnerableVault`:

```solidity
uint256 amount = balances[msg.sender];
require(amount != 0, "nothing to withdraw");

(bool ok, ) = msg.sender.call{value: amount}(""); // interaction
require(ok, "transfer failed");

balances[msg.sender] = 0;                          // effect, too late
```

`SafeVault`:

```solidity
uint256 amount = balances[msg.sender];
require(amount != 0, "nothing to withdraw");       // checks

balances[msg.sender] = 0;                          // effects

(bool ok, ) = msg.sender.call{value: amount}(""); // interactions
require(ok, "transfer failed");
```

Checks, then effects, then interactions. By the time control leaves the contract, the caller's balance is already zero. A reentrant `withdraw` reads zero and reverts on the `amount != 0` check.

The `require(ok)` matters as much as the ordering. If the transfer fails, the whole call reverts, and the zeroed balance is rolled back atomically with everything else in the frame. A failed withdrawal leaves the depositor's credit exactly as it was — the vault never books a payment it did not make.

## 6. Regression test

Run the safe-vault tests:

```bash
forge test --match-contract ReentrancyTest -vvvv
```

Look at `test_SafeVault_ProtectsOtherDepositors`. The attack now collapses:

```text
ReentrancyAttacker::attack{value: 1e18}()
├─ SafeVault::deposit{value: 1e18}()
├─ SafeVault::withdraw()
│  ├─ ReentrancyAttacker::receive{value: 1e18}()
│  │  ├─ SafeVault::withdraw()
│  │  │  └─ ← [Revert] nothing to withdraw
│  │  └─ ← [Revert] nothing to withdraw
│  └─ ← [Revert] transfer failed
```

The nested `withdraw` hits the zeroed balance, reverts with `nothing to withdraw`, and that revert propagates outward: the transfer reports failure, `require(ok)` fires, and the entire `attack` — including the attacker's own seed deposit — is undone. After it returns, `attacker.reentries()` reads `0`, because the increment inside `receive` was rolled back with the rest.

The other two assertions close the loop:

- the victim's 3 ETH is still in the vault after the failed attack;
- an ordinary depositor still deposits and withdraws their own ETH with no reverts (`test_SafeVault_NormalWithdrawStillWorks`).

The fix removed the exploit without removing the feature.

## Where checks–effects–interactions stops

Reordering three lines closed this hole. It is not a blanket guarantee.

- **Cross-function reentrancy.** The callback can enter a *different* function that reads the same half-updated state. If `withdraw` zeroes one variable but another function depends on a second variable that is still stale, the ordering inside `withdraw` does not protect it. The unit of protection is the invariant those functions share, not any single function.
- **Read-only reentrancy.** A callback can call a `view` function while your accounting is mid-flight and feed the temporarily wrong value — a price, a share ratio — to another protocol. Your contract's state is fine at the end of the transaction; the damage happens elsewhere, during the window. See [Read-Only Reentrancy](../topics/219-read-only-reentrancy.md).

The habit that survives all of these: before any external call, ask which invariant must hold, and confirm it holds *at the moment control leaves the contract*, not just at the end of the transaction. A reentrancy guard or a pull-payment design can help, but each is a way to keep that invariant, not a substitute for naming it. Background: [Reentrancy](../topics/217-reentrancy.md), [Checks–Effects–Interactions](../topics/218-checks-effects-interactions.md), and the incident that made this canonical, [The DAO Hack](../topics/231-the-dao-hack.md).

## Artifact

Save a short Markdown note containing:

- the trimmed attack trace for `VulnerableVault`, with call depth preserved;
- the count of `withdraw` frames produced by one call to `attack`, and where each one was launched from;
- the vault balance and the victim's recorded balance after the drain, and why they disagree;
- the three-line diff between the two `withdraw` functions;
- the trimmed `SafeVault` trace showing the reentrant `withdraw` reverting and the attack unwinding;
- one paragraph on why the reorder works on a single-threaded EVM, phrased in terms of nesting rather than threads.

## Primary sources

- [Solidity security considerations: Reentrancy](https://docs.soliditylang.org/en/latest/security-considerations.html#reentrancy) — the callback mechanics and the checks–effects–interactions ordering.
- [Foundry: `forge build`](https://getfoundry.sh/forge/reference/forge-build/)
- [Foundry: `forge test`](https://getfoundry.sh/forge/reference/forge-test/) — test filtering and verbosity flags.
- [Foundry: understanding traces](https://getfoundry.sh/forge/tests/traces/) — how to read call traces and verbosity levels.
- [Foundry: `forge fmt`](https://getfoundry.sh/forge/reference/forge-fmt/)

Last verified: 2026-08-22.

## Check yourself

1. In the vulnerable trace, one call to `attack` produced four `withdraw` frames. Where was each one called from, and which state update was supposed to stop them?
2. `SafeVault` zeroes the balance before it sends ETH. If the send then fails, what happens to that zeroed balance, and why does the depositor not lose their credit?
3. The EVM runs one instruction at a time. Reconstruct, without using the word "thread," how a second `withdraw` starts before the first one finishes.
4. You add checks–effects–interactions to every state-changing function and consider the contract safe. Give one reentrancy path this does **not** close, and name the property you would have to check instead.
