# Sequencer and Its Centralization

> **A rollup sequencer provides fast ordering and confirmations, but a centralized sequencer can censor, reorder, extract MEV, or stop—even when it cannot forge final state.**

## What the sequencer does

Users normally send L2 transactions to a sequencer. It:

- checks and orders transactions;
- produces L2 blocks;
- gives fast preconfirmations;
- batches data for L1;
- coordinates proving or state assertions.

One sequencer avoids consensus latency and makes blocks fast. It also becomes an operational chokepoint.

## Power versus limits

A centralized sequencer can choose order, delay users, censor calls, go offline, and capture ordering value.

In a properly functioning rollup it cannot finalize an invalid transition, because L1 validity or fraud-proof rules constrain state.

```text
sequencer controls the fast path
L1 contracts control accepted settlement
```

That distinction separates liveness and ordering centralization from custody over final state.

## Soft and hard confirmations

A sequencer receipt can be useful within seconds but may be dropped or reordered before batch publication.

Stronger confidence arrives as data is posted, the claim or proof is accepted, the challenge window ends when relevant, and the L1 block finalizes.

Applications should state which confirmation level they treat as final.

## Decentralizing sequencing

Possible designs include rotating sequencers, leader elections, shared sequencing, based rollups using L1 proposers, and permissionless fallback proposers.

Each changes latency, MEV, cross-rollup coordination, failure recovery, and proof integration. More sequencers do not help if one governance key can replace all rules instantly.

## Measure the escape path

The strongest protection is not a promise that the sequencer behaves. It is a working path to publish a transaction or exit through L1 when it does not.

## Check yourself

1. Which ordering powers does a centralized sequencer retain?
2. Why can it censor without forging valid final state?
3. How does a sequencer confirmation differ from L1 settlement?
4. What mechanism matters when the sequencer stops cooperating?
