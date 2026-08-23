# ZK-Rollup

> **A ZK-rollup proves that an off-chain batch followed its state-transition rules before L1 accepts the new state root.**

## Replace the challenge with a proof

Like an optimistic rollup, this system executes a batch away from L1. The difference is how L1 accepts the result: a prover supplies a cryptographic proof linking:

```text
previous state root + batch inputs → new state root
```

An Ethereum verifier contract checks the proof and its public inputs. A valid proof convinces L1 that some witness satisfying the rollup circuit exists without L1 repeating every transaction.

## Why it scales

Proof verification is much cheaper than the computation represented by the proof. Thousands of transactions can share proof and L1 publication costs.

Proof generation can be computationally heavy and delayed. Users may receive a sequencer confirmation quickly while L1 settlement waits for batching, proving, publication, and Ethereum finality.

## “ZK” does not guarantee privacy

Zero-knowledge proof technology can hide witness data, but scaling rollups usually publish enough information for users to reconstruct state. Their main use of proofs is **validity compression**, not private transactions.

Balances and calls may remain publicly visible.

## Data is still required

A validity proof establishes correct computation. It does not give users the transaction data needed to know balances, create future transactions, or exit independently.

A true rollup publishes data through Ethereum calldata or blobs. A similar validity-proof system with off-chain data availability is a validium and has a different freeze risk.

## Trust remains outside the proof

Evaluate the circuit, verifier contract, upgrade keys, prover permissions, sequencer, data publication, and escape mechanisms. A mathematically valid proof can faithfully enforce buggy or centrally upgradeable rules.

## Primary sources

- [Ethereum.org: Zero-knowledge rollups](https://ethereum.org/developers/docs/scaling/zk-rollups/) — validity proofs, state roots, L1 verification, publication, and exit mechanics.
- [Ethereum.org: Data availability](https://ethereum.org/developers/docs/data-availability/) — why correct computation does not replace access to state-reconstruction data.

Last verified: 2026-08-22.

## Check yourself

1. Which roots does a rollup validity proof connect?
2. Why is verification cheaper than re-executing the batch?
3. Does the term ZK-rollup guarantee transaction privacy?
4. Why must a ZK-rollup still publish state-reconstruction data?

<!-- corepath:start -->

**Core Path 48/51** · [← Optimistic Rollup](152-optimistic-rollup.md) · [Data Availability →](158-data-availability.md)

<!-- corepath:end -->
