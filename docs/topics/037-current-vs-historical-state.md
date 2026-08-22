# Current State versus Historical State

> **Current state tells you what is true now; historical state tells you what was true after an earlier block.**

Suppose a contract storage slot contains `9` today and contained `4` one million blocks ago. A current-state query needs only the latest value. A historical query needs enough old information to reconstruct or retrieve the earlier value.

These are different storage promises.

## Three kinds of data

It helps to separate:

- **history:** blocks, transactions, and receipts;
- **current state:** latest accounts, balances, code, and storage;
- **historical state:** old versions of those accounts and storage values.

A node can keep old blocks without keeping every old state snapshot. In principle, it can replay all block-transition inputs from an earlier checkpoint, but doing that for each query is expensive.

An archive configuration preserves or reconstructs historical state so queries such as `eth_getBalance` at an old block can be served. The performance and retained indexes depend on the client and archive mode. A normal full node validates the chain and maintains current state but may prune old state versions.

## Reorgs need recent old state

Even a pruned node needs some rollback capability. If the canonical chain changes, it must undo recent execution and apply the replacement blocks.

Clients use journals, change sets, checkpoints, or retained trie data to unwind. “Pruned” therefore does not mean “only one state exists on disk.” It means the node does not promise arbitrary historical queries forever.

## Ask the exact data question

Applications often request “historical data” without distinguishing logs from state. An old transfer event may be available from receipts while the old contract storage is unavailable.

The useful decision tree is:

```text
need old transaction or log? → history/indexer may be enough
need old account or storage? → historical-state access is required
need only latest truth?      → current state is enough
```

This distinction determines node type, database size, RPC cost, and indexer design.

## Check yourself

1. How is block history different from historical state?
2. Why can a full node lack an old balance query?
3. Why does a pruned node retain rollback data?
4. When is an indexer enough without archive state?
