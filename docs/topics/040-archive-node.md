# Archive Node

> **An archive node is a full node that preserves efficient access to historical state.**

A normal full node validates the chain and maintains current state. It may prune old state versions once they are no longer needed for validation or recent reorgs.

An archive node keeps the ability to ask what an account balance, storage slot, or contract code looked like at an earlier block.

It is not merely a folder containing old blocks. Block history supplies transactions and other transition inputs, but answering every old-state query by replaying from genesis or a distant snapshot would be too slow. Archive implementations may keep old state versions, reverse diffs, or indexes that make those queries practical.

## Who needs one

Archive access is useful for explorers, analytics, auditors, researchers, historical simulations, and applications that must reproduce state at a precise block.

Many indexers do not need full archive state. If an application only needs transfers and events, it can process blocks and receipts into its own database. The correct infrastructure depends on the question.

## The cost

Historical-state access usually consumes much more disk and increases database maintenance, backup, migration, indexing, and query costs. Exact overhead varies sharply: newer schemes may store one full state plus historical diffs rather than a complete trie snapshot at every block. Expensive public RPC calls can also become a denial-of-service vector.

Clients may store history differently, so “archive” does not promise identical disk size or implementation. It promises query capability.

## Trust boundary

A hosted archive provider can return a plausible but false old value. Pin the block hash, compare providers, or verify a state proof against a trusted header when the result is security-critical.

The clean distinction is:

```text
full node    → validates chain and current state
archive node → full node plus historical-state access
indexer      → custom model derived from selected chain data
```

Rust archive work is mostly database engineering: versioned state, snapshots, indexes, compaction, retention, and predictable query limits.

## Check yourself

1. What capability makes an archive node different?
2. Why are old blocks insufficient for fast old-state queries?
3. When can an indexer replace archive access?
4. Why should a critical query pin a block hash?
