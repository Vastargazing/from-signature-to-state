# Forced Inclusion and Escape Hatches

> **Forced inclusion bypasses a censoring sequencer; an escape hatch lets users recover assets when normal L2 operation fails. Both must work from available L1 data.**

## Forced inclusion

A user submits a transaction or message to an L1 inbox contract. The rollup rules require it to enter the L2 chain after a bounded delay or prevent the sequencer from continuing validly.

```text
user → L1 inbox → mandatory future L2 processing
```

This is slower and costs L1 gas, but turns censorship resistance into enforceable protocol behavior.

The details matter: who may enqueue, which transaction types are supported, how long the delay is, and whether an admin can pause the path.

## Escape hatch

If the rollup stops, a user may prove its balance or withdrawal claim against an accepted state root and recover funds from the L1 bridge.

Some designs instead allow users to force an L2 exit transaction through the inbox. Others enter a special withdrawal mode after prolonged failure.

“Funds are in an L1 contract” is insufficient if only the failed operator can produce the proof or missing state data.

## Data availability is the prerequisite

Users need the state and Merkle paths required to build claims. A validity proof can stop theft while a data-withholding operator freezes everyone.

This is the central validium tradeoff and why rollups publish reconstructible data to L1.

## Test the unhappy path

An escape mechanism that has never been exercised may fail through gas limits, stale software, unavailable proof generation, admin restrictions, or undocumented steps.

Credible systems document and test:

- sequencer downtime submission;
- permissionless state reconstruction;
- withdrawal proof construction;
- contract pause and upgrade behavior;
- maximum recovery delay and L1 cost.

## Check yourself

1. How does forced inclusion bypass the sequencer?
2. What does an escape hatch protect against?
3. Why is L1 custody alone not enough for recovery?
4. Which data must users possess to exit independently?
