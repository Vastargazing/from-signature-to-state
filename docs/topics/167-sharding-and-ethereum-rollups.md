# Sharding and Why Ethereum Chose Rollups

> **Ethereum moved from splitting execution across L1 shards to scaling execution through rollups while L1 supplies settlement and abundant data.**

## The original execution-sharding idea

Sharding divides work among groups of nodes. Instead of every node executing and storing everything, different shards handle different parts of the state.

That can increase capacity, but creates hard questions: which shard owns an account, how contracts call across shards, when cross-shard results become final, and how validators are assigned safely.

For a globally composable smart-contract platform, these boundaries leak into application design.

## Rollup-centric scaling

Rollups offered a cleaner separation:

- L2 systems execute transactions and choose their VMs;
- Ethereum verifies proofs or disputes, orders commitments, and secures data availability;
- blobs make publishing rollup data cheaper;
- PeerDAS uses erasure coding, partial custody, and sampling to expand blob capacity without making every ordinary node download every complete blob.

Execution innovation can now happen in multiple rollups without forcing Ethereum consensus to execute every environment.

## What “sharding” means now

Terms such as danksharding refer mainly to sharding data availability for rollups, not creating many independent EVM execution shards.

Since the Fusaka upgrade, PeerDAS is the first deployed form of this approach: Ethereum can handle more blob data while individual nodes custody and sample only part of the erasure-coded columns. Rollups consume that data lane and amortize its cost across many transactions. Full danksharding remains a broader roadmap direction rather than the name for today's exact mechanism.

## The trade did not remove complexity

Rollups introduce fragmented liquidity, bridges, separate sequencers, different upgrade controls, and asynchronous cross-rollup messages. Ethereum simplified its own execution roadmap by moving some complexity to the L2 ecosystem.

So “Ethereum abandoned sharding” is misleading. It abandoned the old execution-shard plan and kept data sharding as part of a rollup-centric design.

## Primary sources

- [Ethereum roadmap](https://ethereum.org/roadmap/) — the rollup-centric scaling path and current upgrade status.
- [EIP-7594: PeerDAS](https://eips.ethereum.org/EIPS/eip-7594) — the data-availability sampling design introduced with Fusaka.

Last verified: 2026-08-22.

## Check yourself

1. What was difficult about execution shards for smart contracts?
2. Which jobs belong to L2 and which remain on Ethereum?
3. Does danksharding mean many independent EVM shards?
4. Which new problems appear in a rollup-centric ecosystem?
