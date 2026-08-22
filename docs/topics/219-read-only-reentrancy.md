# Read-Only Reentrancy

> **Read-only reentrancy does not modify the reentered contract. It reads that contract while an outer call has left its state temporarily inconsistent.**

## The surprising path

Protocol A starts removing liquidity. It updates token balances, calls the user, and only later updates total LP supply.

During the callback, the user calls A's public `view` price function. The function combines new balances with old supply and returns a distorted price.

Protocol B trusts that price and lends too much or performs a swap. A's view function changed no state, yet its transient answer caused damage elsewhere.

```text
A begins update → external callback → B reads inconsistent A → B changes state
```

## Why `view` is not a safety label

`view` means the function itself does not persistently modify EVM state. It does not mean the returned value is economically valid at every point in a nested call stack.

Composability lets another protocol turn that read into a state-changing decision.

## Defenses

Restore all pricing and accounting invariants before external interaction. If that is impossible, guard sensitive read functions with the same lock as state-changing paths.

Consumers can use time-delayed observations, independent oracles, or reject values while the source is mid-operation. But they need a reliable signal that an update is in progress.

A generic `nonReentrant` modifier may not protect a view function if the implementation deliberately omits it or uses different lock domains.

## The review habit

During each external call, list every public value another contract can observe: share price, reserves, exchange rate, debt, voting power, and collateral value.

An externally visible invariant must hold not only at transaction boundaries but also whenever control is yielded and other code can inspect it inside the transaction.

## Check yourself

1. How can a view function contribute to stolen funds?
2. What inconsistent values appear in the liquidity example?
3. Why may a normal reentrancy modifier miss the read path?
4. When must externally visible invariants hold?
