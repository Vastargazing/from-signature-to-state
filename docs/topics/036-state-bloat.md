# State Bloat

> **State bloat is the long-term cost of making stateful execution nodes carry and access more live data.**

Block space meters data and computation for a particular block, although block data may still be retained as history. Live state is different: a new account, contract, or storage slot may remain relevant to future execution indefinitely.

That creates a hidden multiplication:

```text
one persistent write × many stateful nodes × many years
```

The user typically pays gas when creating or updating state, while operators can continue paying for disk, database compaction, cache misses, synchronization, and proof generation. Exact costs and retention duties depend on the protocol and client mode.

## Why size affects decentralization

Large state needs more storage and makes random reads less likely to fit in memory. Syncing and maintaining a node becomes slower and more expensive.

If ordinary hardware can no longer keep up, fewer people run independent nodes. The protocol may remain permissionless in theory while verification becomes concentrated among professional providers.

State growth is therefore not only a disk problem. It affects latency, node accessibility, and the cost of independently checking the chain.

## History and state are different

Old block bodies are history. Current account and contract values are live state. Pruning old history does not remove a storage slot that future transactions may read.

Deleting a logical value also may not immediately shrink the physical database. Clients still need garbage collection and compaction, and the protocol needs clear rules about what remains provable.

## Mitigations

Protocols can price persistent writes, refund some deletions, expire or rent state, move data to cheaper layers, improve authenticated structures, or make stateless verification practical through witnesses.

Each option has tradeoffs. Expiry and rent complicate application guarantees. Higher fees punish legitimate storage. Better databases improve constants but do not stop unbounded growth.

Rust client engineers experience state bloat as a storage-system problem: key layouts, caches, snapshots, compaction, trie updates, and recovery must stay fast as the dataset grows.

## Check yourself

1. Why is persistent state different from temporary block space?
2. How can state growth reduce decentralization?
3. Why does pruning history not solve state bloat?
4. What tradeoff does state expiry introduce?
