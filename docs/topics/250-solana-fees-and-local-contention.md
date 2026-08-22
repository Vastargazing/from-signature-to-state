# Local Fee Markets and Priority Fees on Solana

> **Solana fees pay for signatures and optional priority, while congestion is often local to the writable accounts many transactions compete to lock.**

## Fee components

Every transaction pays a base fee tied mainly to signature verification. A transaction can also set a compute-unit limit and a price per compute unit.

The prioritization fee is based on the requested compute limit, not only the units eventually consumed. Over-requesting compute can therefore overpay.

Priority raises the chance a leader schedules the transaction ahead of competing work. It does not guarantee success; account state can change and the transaction can still fail after paying fees.

## Local contention

Two unrelated applications writing different accounts can run in parallel. Thousands of trades writing the same market or vault account contend for one serialized resource.

The economically relevant fee competition can therefore concentrate around hot accounts rather than making every transaction on the network equally expensive.

This is the intuition behind local fee markets: congestion should be priced near the state causing contention.

The phrase can mislead. Solana does not currently attach an independent on-chain base-fee auction to every account. It has transaction priority fees, per-writable-account scheduling limits, and fee observations that clients can filter by writable-account set. “Local fee market” describes the resulting contention and bidding locality, not a separate consensus market object stored beside each account.

## Compute budgets

A client simulates the transaction, estimates compute use, adds safety margin, and sets a priority price based on current demand.

Setting the maximum limit blindly raises potential cost. Setting it too low causes compute exhaustion.

## Program design affects fees

Splitting state can reduce lock contention, but more accounts enlarge transactions and complicate atomicity. A global counter may be logically simple and economically hot.

Rust services submitting Solana transactions should monitor recent priority conditions for the actual writable-account set, rebuild expired blockhashes, and distinguish compute failure from scheduling and account-lock contention.

The key question is “what state is hot?” not only “what is the network-wide gas price?”

## Primary sources

- [Solana fee structure](https://solana.com/docs/core/fees/fee-structure) — base fee, prioritization-fee formula, charging on failure, and scheduling priority.
- [Solana compute budget](https://solana.com/docs/core/fees/compute-budget) — requested versus consumed compute and per-writable-account scheduler limits.
- [`getRecentPrioritizationFees`](https://solana.com/docs/rpc/http/getrecentprioritizationfees) — fee samples optionally filtered by a writable-account set.

Last verified: 2026-08-22.

## Check yourself

1. Which two fee components does a Solana transaction pay?
2. Why can an excessive compute limit waste money?
3. What makes congestion local to an application?
4. How can splitting state reduce and also increase cost?
