# UTXO Model versus Account Model

> **UTXO transactions replace independent notes; account transactions mutate named state.**

Both models prevent spending value twice, but they represent ownership and conflicts differently.

## UTXO

A transaction consumes specific previous outputs and creates new outputs. The inputs declare exactly which pieces of state are being changed.

```text
old outputs → transaction → new outputs
```

Two transactions conflict when they consume the same output. Independent inputs make many checks easier to parallelize and make local value flow explicit, although script or application rules can introduce additional dependencies.

The wallet pays with whole outputs, creates change, and performs coin selection. This can improve control and privacy, but it creates fragmentation and more bookkeeping.

## Accounts

A transaction names a sender and mutates account or contract state:

```text
state before → execute call → state after
```

Sequential nonces order transactions initiated by one account and prevent replay on that chain and transaction domain. Stable addresses and mutable contract storage make complex applications natural.

The downside is shared state. Two calls may contend on the same account or discover overlapping storage only while executing, which complicates parallelism.

## Neither model is universally better

UTXO systems can support rich scripts and extended-UTXO application models. Account chains can introduce access lists, local fee markets, or parallel schedulers. The base representation shapes the default, not every possible design.

The comparison that matters is operational:

| Question | UTXO | Account |
|---|---|---|
| What is updated? | explicitly referenced outputs | balances, nonces, code, and storage reached during execution |
| Conflict key | same input | overlapping mutable state or nonce |
| Change needed? | usually | no |
| Default dependency visibility | inputs are explicit | touched state may emerge during execution |

For Rust infrastructure, the model changes data structures, transaction validation, mempool conflicts, state caching, and execution scheduling. It is not merely a wallet-interface difference.

## Primary sources

- [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf) — the output-based transaction model.
- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — the account-based world state and execution model.

## Check yourself

1. What object does each model mutate?
2. How is a double-spend conflict expressed in each?
3. Why does UTXO spending create change?
4. Why can account-based execution be harder to parallelize?

<!-- corepath:start -->

**Core Path 9/50** · [← Account Model](031-account-model.md) · [Cryptographic Hash Function →](014-hash-properties.md)

<!-- corepath:end -->
