# Lab 5 — Turn Examples into Fuzz and Invariant Tests

Lab 4 proved two hand-picked stories: one vault drained and one vault resisted the same caller. This lab asks a harder question: what should remain true across hundreds of amounts and thousands of deposit/withdraw sequences?

The target is still the tiny `SafeVault`. The new work lives in `test/SafeVaultProperties.t.sol`; production code does not change.

## You need

- `forge` from Foundry;
- the project from [Lab 4](04-reentrancy-and-cei.md);
- about twenty-five minutes.

## 1. Start with one property

From the repository root:

```bash
cd projects/reentrancy
forge test --match-test testFuzz_DepositThenWithdraw -vv
```

Foundry recognizes parameters on a `testFuzz_` function and generates values for them. The test turns each raw amount into the domain `1 wei..100 ether`, derives a plain test address from `userSeed`, then checks one round trip:

```text
deposit amount
    → recorded liability = amount
    → vault assets = amount
withdraw
    → recorded liability = 0
    → vault assets = 0
    → user received amount
```

This is stronger than “the call did not revert.” It names the accounting relationship before and after the action.

The test constructs valid inputs instead of discarding most generated cases with `vm.assume`. Constraints should describe the intended domain, not hide inconvenient inputs.

## 2. Test the failure path too

Run both fuzz properties:

```bash
forge test --match-contract SafeVaultFuzzTest -vv
```

`testFuzz_SecondWithdrawAlwaysReverts` performs a successful round trip, then tries to withdraw the consumed balance again. The important word is *always*: the assertion covers every generated non-zero deposit amount and generated user seed in the campaign.

Foundry shrinks a failing input toward a smaller counterexample. Keep the resulting seed or minimized input as a regression case; do not merely increase the run count and hope it disappears.

## 3. Move from inputs to sequences

A fuzz test varies inputs to one fixed path. Stateful invariant testing varies both inputs and the order of calls.

`SafeVaultHandler` exposes two actions to the invariant fuzzer:

```text
deposit(actorSeed, amount)
withdraw(actorSeed)
```

The handler maps arbitrary seeds onto four stable actors, funds them locally, and makes valid calls as those actors. A zero-balance withdrawal returns from the handler instead of reverting. That matters because this project sets `fail_on_revert = true`: an unexpected handler revert fails the campaign rather than quietly consuming depth.

Run the stateful campaign:

```bash
forge test --match-contract SafeVaultInvariantTest -vv
```

The project config requests 64 runs with 50 calls per run. Foundry checks each `invariant_` function after every generated action.

A normal run should end with `calls: 3200` and `reverts: 0` for each invariant. The split between `deposit` and `withdraw` changes with the fuzz seed; the total does not.

## 4. Read the two accounting views

The first invariant derives liabilities from contract state:

```text
vault ETH balance = Σ balances[known actor]
```

If the vault holds less ETH, it is insolvent. If it holds more, the test model has missed an asset path or the contract accepted uncredited ETH.

The second invariant uses **ghost variables** maintained only by the handler:

```text
vault ETH balance = ghostDeposited − ghostWithdrawn
```

Ghost accounting is an independent model. It does not ask the contract to grade its own homework by comparing one contract getter with another getter backed by the same faulty update.

## 5. Confirm the fuzzer is doing work

The handler counts successful deposit and withdrawal calls. With `show_metrics = true`, Foundry also reports which handler functions it called and how often they reverted.

A green invariant campaign with zero meaningful calls is not evidence. Inspect the metrics:

- did both actions run?
- did deposits produce later withdrawals?
- were most generated calls discarded or reverted?
- do the actors and amount bounds cover the states the contract is meant to support?

Coverage says code ran. Handler metrics say the campaign exercised its action model. Neither says the invariant itself was worth checking.

## 6. Make the test catch a harmless accounting mutation

Temporarily change `SafeVault.deposit` locally so it records one wei more than it receives:

```solidity
balances[msg.sender] += msg.value + 1;
```

Run the fuzz and invariant suites again. No attack is required: assets and liabilities diverge on the first deposit, so both suites should expose the mutation—but not necessarily in the same way.

A fuzz property may fail on its first generated case. In that situation Foundry can report `runs: 0` and preserve a large generated argument rather than present a neat minimal value. The stateful campaign can shrink a failing action sequence, but the exact sequence depends on the fuzz seed and Foundry version. Because this project sets `fail_on_revert = true`, an invariant can also fail when the inflated recorded balance makes a handler withdrawal revert with `transfer failed`; that is evidence of the accounting bug, not a failure of the lab.

Restore the original line afterward:

```solidity
balances[msg.sender] += msg.value;
```

This mutation test answers a useful question: would the property notice the class of accounting error it claims to prevent?

## Artifact

Save a short Markdown note containing:

- one fuzz property written as a sentence before showing its code;
- the first failing fuzz input from the one-wei mutation and whether Foundry minimized it;
- any shrunk invariant sequence, together with the Foundry version and fuzz seed that produced it;
- the two invariant equations and why they are independent views;
- handler call metrics;
- one example of a green but useless property and why it proves almost nothing.

## Primary sources

- [Foundry tests](https://getfoundry.sh/forge/tests/) — test discovery, filters, fuzz tests, and verbosity.
- [Foundry invariant testing](https://getfoundry.sh/forge/invariant-testing/) — runs, depth, handlers, targets, ghost variables, and metrics.
- [Foundry replaying failures](https://getfoundry.sh/forge/replay-testing/) — persisted fuzz and invariant counterexamples.

Last verified: 2026-08-22.

## Check yourself

1. What does the fuzz test vary that the Lab 4 unit test fixed in advance?
2. Why is “the call did not revert” a weak property for a vault?
3. What job does the handler perform between the invariant fuzzer and the contract?
4. Why can a ghost variable catch an error that two getters from the same contract might share?
5. How can an invariant campaign pass without exercising meaningful behavior?
