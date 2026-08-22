# Indexers, The Graph, and Reading Blockchain Data

> **A blockchain is optimized for verification and execution; an indexer reshapes its history for application queries.**

Nodes can fetch blocks, receipts, logs, and current state. They are poor at questions such as “show every swap by this user, grouped by token, with daily totals.”

An indexer reads canonical chain data, decodes it, and writes a query-friendly database.

```text
blocks + receipts + optional traces/calls → decoder → application tables
```

## Why events matter

Smart contracts emit logs for off-chain consumers. Logs are usually easier to scan than reconstructing application meaning from storage, but they are not automatic truth.

A contract can omit an expected event or emit one whose name does not match its true semantics. If the containing EVM call frame reverts, its logs are reverted too and do not appear in the canonical receipt, although debug traces may expose attempted execution. Indexers must use canonical receipts and understand the contract's semantics. Historical state sometimes requires archive-node access or transaction replay.

## Reorgs make ingestion reversible

An indexer cannot simply append forever. A previously processed block may leave the canonical chain.

Store block numbers and hashes, make handlers deterministic, support rollback, and process records idempotently. Then wait for a confidence level appropriate to the product before treating data as settled.

## The Graph model

The Graph lets developers define a subgraph manifest, schema, data sources, and handlers for events, calls, or blocks. Graph Node processes chain data into entities according to that definition, and applications query the derived entities through GraphQL; on The Graph Network, independent Indexers can serve those queries, often through a gateway.

This improves developer experience but does not turn derived data into consensus. The subgraph code, indexing progress, network participants, and query endpoint form another trust and availability layer.

## Rust lens

Indexer work is durable backend engineering: high-volume ingestion, ABI decoding, reorg handling, checkpoints, schema migrations, backfills, and query design.

The key principle is:

```text
chain data is the source; indexed data is a rebuildable projection
```

Run [Lab 6 — Make a Rust Indexer Survive a Reorg](../labs/06-reorg-safe-rust-indexer.md) to replace the phrase “support rollback” with a tested algorithm: find a common ancestor by hash, reverse the removed branch, apply the replacement, and restart from a canonical journal.

## Primary sources

- [EIP-1898](https://eips.ethereum.org/EIPS/eip-1898) — block-hash queries and canonical-chain requirements.
- [Reth Execution Extensions](https://reth.rs/exex/overview/) — canonical-chain notifications for commits, reverts, and reorgs.

Last verified: 2026-08-22.

## Check yourself

1. Why are node APIs poor for application-shaped queries?
2. Why can an event still mislead an indexer?
3. What data enables rollback after a reorg?
4. Why is a subgraph not consensus truth?
