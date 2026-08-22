# What an L2 Is—and What It Is Not

> **An L2 executes activity away from a base chain while relying on that base chain for enforceable security or final settlement. A fast bridged chain is not automatically an L2.**

## The security relationship

For an Ethereum rollup, users transact on a separate execution system. The rollup posts data and state commitments to Ethereum, where contracts verify validity proofs or resolve fraud disputes.

```text
L2 execution → L1 data and proof/dispute → L1 settlement
```

The important property is that invalid L2 state cannot simply become final because the sequencer says so, and users have a protocol path to recover assets under stated assumptions.

State channels are also L2 designs: participants exchange signed states off-chain and use L1 to settle disputes.

## What does not qualify by itself

These features are insufficient:

- EVM compatibility;
- an Ethereum bridge;
- periodic hashes posted to Ethereum;
- ETH used for gas;
- the project calling itself “Layer 2.”

A sidechain with its own validator consensus remains responsible for transaction correctness. Posting a checkpoint to Ethereum does not let Ethereum detect a dishonest sidechain majority unless a verification or dispute mechanism exists.

## L2 security has stages

Real rollups may retain centralized sequencers, upgrade keys, security councils, allowlisted provers, or incomplete proof systems. The architecture can be a rollup while the deployed instance still asks users to trust administrators.

Evaluate the live contracts:

- who can upgrade them and how quickly;
- whether proofs are active and permissionless;
- where transaction data is published;
- whether users can force inclusion or exit;
- what happens during sequencer or proposer failure.

## L2 is not free capacity

Rollups still consume L1 data and settlement resources. They scale by compression, batching, and moving execution—not by escaping all base-layer limits.

## Primary sources

- [Ethereum.org: Layer 2](https://ethereum.org/developers/docs/scaling/) — the base-layer security relationship and major scaling categories.
- [OP Stack specification](https://specs.optimism.io/) — derivation, data publication, settlement, and fault-proof rules for an optimistic rollup.
- [Arbitrum Nitro whitepaper](https://docs.arbitrum.io/nitro-whitepaper.pdf) — a second rollup design with sequencing, execution, data publication, and dispute resolution.

Last verified: 2026-08-22.

## Check yourself

1. What security relationship makes a rollup an L2?
2. A sidechain posts state-root hashes to Ethereum, but Ethereum has no proof verifier or dispute game for its transitions. Why is the hash posting insufficient to make it an L2?
3. Which administrator powers can weaken a deployed rollup?
4. Which L1 resources do rollups still consume?

<!-- corepath:start -->

**Core Path 45/50** · [← The Scalability Trilemma](149-scalability-trilemma.md) · [Optimistic Rollup →](152-optimistic-rollup.md)

<!-- corepath:end -->
