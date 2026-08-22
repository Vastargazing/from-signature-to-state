# SVM and Sealevel: Parallel Execution

> **Solana can execute non-conflicting transactions in parallel because transactions declare every account they will read or write before execution.**

## The scheduler sees conflicts

If transaction A writes account X and transaction B writes account Y, the runtime can execute them at the same time.

If both write X—or one writes X while the other reads it—they conflict and must be ordered. Multiple read-only accesses can run together.

```text
A writes X ─┐ conflict
B reads  X ─┘

C writes Y + D writes Z → can run in parallel
```

Sealevel is the parallel runtime model; SVM commonly refers to the Solana Virtual Machine environment executing programs and coordinating accounts.

## Parallelism is application-shaped

A DEX with one writable global account becomes a hotspot even on a fast runtime. Every trade contends for the same lock.

Designs split markets, user positions, order pages, or counters across accounts so unrelated activity can proceed independently. This resembles choosing lock granularity in a concurrent Rust service.

Too much splitting makes transactions include more accounts and complicates consistency.

## Atomic transactions remain atomic

Several instructions can run in one transaction. Cross-program invocations call other programs while preserving the declared account privilege rules.

If any instruction fails, the transaction's state changes revert, though the fee is still charged.

## Limits remain

Transactions face compute-unit budgets, account-data and size constraints, lock contention, and block scheduling limits. Parallel capacity does not guarantee one hot application unlimited throughput.

The practical performance question is not only “how fast is Solana?” It is “which writable accounts does this workload serialize on?”

## Primary sources

- [Solana instructions](https://solana.com/docs/core/instructions) — explicit read/write account metadata supplied to each instruction.
- [Solana transaction pipeline](https://solana.com/docs/core/transactions/transaction-pipeline) — account loading, locking conflicts, sequential instruction execution, and atomic rollback.

Last verified: 2026-08-22.

## Check yourself

1. Which account-access combinations conflict?
2. Why can one global writable account become a bottleneck?
3. How is account splitting similar to lock design in Rust?
4. Does parallel scheduling remove atomic transaction rollback?
