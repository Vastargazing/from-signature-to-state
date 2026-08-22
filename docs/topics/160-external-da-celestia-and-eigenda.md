# External DA: Celestia and EigenDA

> **An external DA layer publishes rollup data somewhere other than its settlement chain. Capacity gets cheaper, but the security boundary moves.**

## What the DA layer does

A rollup sends batch data to a network that makes the data available and returns a commitment. The rollup may then post only that commitment, plus state roots or proofs, to Ethereum.

The DA network does not normally execute the rollup or decide whether its state transition was correct. Its job is narrower: ensure the committed bytes can be obtained.

## Celestia

Celestia is an independent blockchain designed around ordering data and proving its availability. It uses erasure coding and data-availability sampling so light clients can check availability without downloading every blob.

A rollup using Celestia depends on Celestia's validator set and DA rules for its transaction data, while it may still settle proofs or bridge assets elsewhere.

## EigenDA

EigenDA is an Ethereum-oriented DA service. Rollup data is erasure-coded and dispersed across operators, who validate assigned chunks and sign batch attestations. Commitments and stake-weighted attestations let a rollup reason about availability without placing the whole batch on Ethereum.

Its security depends on the selected operator quorums, stake and slashing configuration, dispersal and retrieval software, and reconstruction thresholds. In the currently documented architecture, the disperser is centralized and is explicitly trusted for liveness, even though encoding and commitments prevent it from silently inventing valid chunks.

## The classification matters

If Ethereum verifies a validity proof but the underlying data lives on Celestia, EigenDA, or a committee, Ethereum does not itself guarantee that users can reconstruct the state.

This is commonly described as external-DA, validium-like, or a modular rollup design—not a strict Ethereum rollup with Ethereum DA.

The right question is not “which logo is safer?” Ask: who can withhold the data, what evidence proves availability, and can users still exit if that system stops?

## Primary sources

- [Celestia data-availability layer](https://docs.celestia.org/learn/celestia-101/data-availability/) — namespaced Merkle trees, erasure coding, and data-availability sampling.
- [EigenDA whitepaper](https://docs.eigencloud.xyz/assets/files/EigenDA_Whitepaper-c917fb56c146ebd146abfba3c52648a1.pdf) — dispersal, stake-threshold certificates, verification, and retrieval.

Last verified: 2026-08-22.

## Check yourself

1. What job does an external DA layer perform?
2. Does Celestia execute the rollup's state transition?
3. What does a rollup gain by moving data away from Ethereum?
4. Which new failure can prevent users from reconstructing state?
