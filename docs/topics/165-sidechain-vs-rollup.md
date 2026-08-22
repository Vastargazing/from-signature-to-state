# Sidechain versus Rollup

> **A rollup asks L1 to enforce its history. A sidechain asks its own consensus to enforce history and uses a bridge to connect assets.**

## Rollup security

A rollup publishes the data needed to reconstruct its state to the settlement chain and posts state commitments there. L1 contracts accept updates only through the rollup's fraud-proof or validity-proof rules.

If the sequencer disappears, the intended design still gives users an L1-enforced path to recover, force inclusion, or exit—subject to the rollup's actual implementation and upgrade controls.

## Sidechain security

A sidechain runs an independent validator set and consensus. Its bridge observes or verifies sidechain events, then locks, mints, burns, or releases assets across chains.

If the sidechain consensus becomes malicious, it may finalize a history that its bridge accepts even though Ethereum would never accept that history under Ethereum consensus.

```text
rollup:    Ethereum verifies the scaling system's claims
sidechain: another consensus makes claims to an Ethereum bridge
```

## Common sources of confusion

EVM compatibility does not make a network an L2. Posting occasional checkpoints to Ethereum does not automatically make it a rollup. Cheap fees and an Ethereum bridge are product features, not security definitions.

A sidechain can be highly decentralized and useful. It simply has a different trust root.

## The test

Ask what happens if the external validators sign an invalid withdrawal. If Ethereum's contracts can independently reject it using rollup proofs and L1-published data, it may be a rollup. If the bridge ultimately trusts that validator consensus or a committee, it is sidechain-style security.

The boundary can blur in hybrid systems, so describe the actual proof and DA path rather than fighting over labels.

## Check yourself

1. Which consensus is the trust root for a sidechain?
2. What lets L1 reject a bad rollup state claim?
3. Does EVM compatibility make a chain an Ethereum L2?
4. Why are occasional L1 checkpoints insufficient by themselves?
