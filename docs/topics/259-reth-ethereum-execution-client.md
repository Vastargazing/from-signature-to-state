# reth: an Ethereum Execution Client in Rust

> **reth is the part of an Ethereum node that understands transactions, executes the EVM, and maintains Ethereum state.**

After the Merge, one program is not the entire Ethereum node. A consensus client chooses the canonical beacon-chain view. An execution client such as reth validates and executes the payloads inside its blocks. They coordinate through the Engine API.

## What reth does

reth combines several systems:

- peer-to-peer networking for blocks and transactions;
- block and transaction validation;
- EVM execution through revm;
- account, storage, receipt, and trie persistence;
- transaction-pool and block-building logic;
- JSON-RPC for wallets, indexers, and applications.

When reth receives a block, it does not trust the claimed result. It checks the block, executes its transactions in order, calculates the resulting state, and verifies the commitments. Every correct client must reach the same answer.

## Why its architecture matters

reth is built from reusable Rust crates rather than one inseparable binary. A developer can use its networking, database, EVM, RPC, or chain types without adopting the full node.

Its synchronization pipeline separates work such as downloading headers, fetching bodies, executing transactions, and computing state commitments. Stages can checkpoint progress and unwind when the canonical chain changes.

Execution Extensions let applications observe or derive data from the canonical execution stream close to the node. That is useful for custom indexes and rollup infrastructure, but extension code still needs backpressure and reorg handling.

## Rust lens

Working on reth is systems engineering, not smart-contract authoring. The useful skills are asynchronous networking, binary protocols, storage design, profiling, concurrency, Ethereum data structures, and specification-driven testing.

The key distinction is:

```text
reth = full execution-layer system
revm = embeddable EVM engine inside that system
```

Knowing Rust syntax is only the entrance. Knowing why a node must unwind state, survive hostile peers, and reproduce the protocol exactly is the real job.

## Primary sources

- [Reth repository](https://github.com/paradigmxyz/reth) — execution-client scope, Engine API compatibility, modular crates, and project status.
- [Reth synchronization stages](https://github.com/paradigmxyz/reth/blob/main/docs/crates/stages.md) — headers, bodies, execution, state-root work, checkpoints, and unwind behavior.
- [Reth Execution Extensions](https://reth.rs/exex/overview/) — canonical-chain notifications, reorgs, indexers, bridges, and in-process extension architecture.

Last verified: 2026-08-22.

## Check yourself

1. How does reth cooperate with a consensus client?
2. Why does it execute a received block again?
3. What does pipeline unwinding handle?
4. How is reth different from revm?
