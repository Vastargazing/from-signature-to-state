# Where the Rust Blockchain Jobs Actually Are

> **Companies rarely hire “Rust syntax”; they hire someone who can own a hard system built in Rust.**

Rust jobs cluster around infrastructure more than ordinary EVM application contracts. The role name may not even include “blockchain.” Look for the system being built.

## The main lanes

**Nodes and runtimes** need asynchronous networking, storage engines, state tries, transaction pools, consensus or execution rules, profiling, and observability. Correctness comes from protocol specifications and cross-client tests.

**Indexers and RPC systems** ingest blocks, decode data, and answer queries. Their hard problems are reorgs, idempotent processing, backfills, schema evolution, high write volume, and deciding what “final” means.

**MEV infrastructure** simulates transactions and constructs or routes bundles under severe latency. It combines EVM semantics, mempool knowledge, networking, search, risk controls, and performance measurement.

**ZK systems** need finite-field and circuit knowledge or zkVM engineering, plus prover profiling, parallelism, memory management, and sometimes GPU or distributed-compute work.

**Chain-specific development** includes Solana programs and validators, Polkadot SDK runtimes, CosmWasm contracts, bridges, sequencers, and rollup components. Each adds a runtime model that Rust alone does not teach.

## What makes a credible portfolio

A useful project proves one real skill:

- a reorg-safe Ethereum indexer with restartable checkpoints;
- a revm-based transaction simulator with traces;
- a small Solana program with explicit account validation;
- a FRAME pallet with benchmarks and a tested migration;
- a zkVM guest with measured cycle costs.

Include tests, failure cases, benchmarks where performance matters, and a short design explanation. A cloned tutorial with no tradeoffs says little.

[Lab 6 — Make a Rust Indexer Survive a Reorg](../labs/06-reorg-safe-rust-indexer.md) turns the first portfolio idea into a dependency-free implementation with rollback, idempotency, an atomic reconciliation boundary, and restartable checkpoints.

## EVM still matters

Even when the production language is Rust, EVM literacy unlocks Ethereum clients, Foundry, MEV, rollups, security tooling, and transaction simulation. You need to understand the thing your infrastructure executes.

The hiring equation is:

```text
Rust fundamentals + one systems specialty + one protocol model + evidence
```

## Check yourself

1. What makes indexer work harder than simply inserting blocks?
2. Which knowledge does MEV infrastructure combine?
3. What should a portfolio project demonstrate?
4. Why does EVM knowledge matter for a Rust engineer?
