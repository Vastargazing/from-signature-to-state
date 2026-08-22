# Checks–Effects–Interactions

> **Validate first, commit internal state second, and call untrusted code last. That way a callback sees the operation as already consumed.**

## The pattern

For a withdrawal:

1. **Checks:** caller has enough balance; amount is valid.
2. **Effects:** reduce the caller's recorded balance.
3. **Interactions:** transfer tokens or ETH.

```solidity
uint256 amount = balances[msg.sender];
require(amount != 0);
balances[msg.sender] = 0;
(bool ok, ) = msg.sender.call{value: amount}("");
require(ok);
```

If the recipient calls back, its balance is already zero. If the transfer fails and `require` reverts, the earlier balance update rolls back atomically.

## Why state changes before payment are safe

Developers from database systems may fear “debit before send.” In the EVM, a revert unwinds state changes and nested calls across the whole call frame.

The early effect is not permanently committed until the transaction succeeds. It only closes the temporary reentrancy window.

## Where the pattern becomes subtle

A protocol may update the user's balance but forget total shares, reserves, or reward indexes. During the external call, another entry point can observe an invariant that is still inconsistent.

Some flows require external results before final calculation. Then use a reentrancy guard, a state machine with explicit phases, or isolate the interaction in a trusted adapter.

Tokens may call hooks or return unusual values, so “interaction” includes more than raw ETH calls.

## Pull over push

Instead of sending funds to many users in one loop, record claims and let each user pull their own payment. One malicious recipient then cannot block everyone or reenter the distribution's central accounting.

CEI is a reasoning discipline, not a magic modifier. The contract must make all relevant effects before control leaves.

Run [Lab 4 — Exploit and Repair Reentrancy](../labs/04-reentrancy-and-cei.md) to compare the vulnerable and reordered traces. The regression test also shows why a failed external call rolls the early state update back.

## Primary sources

- [Solidity security considerations: Reentrancy](https://docs.soliditylang.org/en/latest/security-considerations.html#reentrancy) — vulnerable ordering and the checks–effects–interactions repair.

## Check yourself

1. What are the three phases in order?
2. Why does a failed transfer undo the earlier balance update?
3. How can incomplete effects still leave a reentrancy bug?
4. Why are pull payments easier to isolate than batch pushes?
