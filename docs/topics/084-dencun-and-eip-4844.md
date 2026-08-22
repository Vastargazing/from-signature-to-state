# Dencun and EIP-4844

> **Dencun gave rollups a cheaper, temporary data lane through blobs; it did not make the EVM execute rollup transactions.**

## The rollup data problem

Rollups execute many transactions outside Ethereum and publish data to Ethereum so others can reconstruct or verify their state.

Before Dencun, they mainly placed this data in **calldata**. Calldata is available to the EVM and preserved as part of execution history, even though rollups mostly need temporary data availability rather than permanent contract-readable storage.

That mismatch was expensive.

## Blob transactions

EIP-4844 introduced blob-carrying transactions whose execution payload contains commitments and versioned hashes. The large fixed-size blob data travels in consensus-layer sidecars rather than inside the EVM transaction calldata or execution block body.

```text
rollup data → blob → temporarily available from Ethereum nodes
```

EVM contracts cannot read blob contents directly. They can access compact versioned hashes that commit to the blobs. Cryptographic commitments let the network verify that supplied blob data matches what the transaction promised.

Blob data is served for a bounded protocol retention window rather than being a permanent EVM-readable record. A rollup must ensure that this window is sufficient for its reconstruction, proof, or challenge design; Ethereum does not preserve blob contents forever for later application queries.

## After Fusaka: PeerDAS

The original EIP-4844 network design made each full consensus node download every blob. Fusaka activated PeerDAS in December 2025: blobs are erasure-coded into columns, ordinary nodes sample and custody assigned subsets, and enough columns can reconstruct the data. “Ethereum makes blob data available” therefore no longer means every normal node stores every complete blob.

## A separate fee market

Blob space has its own gas accounting and base fee. Heavy demand can raise blob fees independently of the execution base fee. A blob transaction still uses ordinary execution gas for its transaction-level EVM work; only the blob-data resource is priced in the separate market.

This makes rollup data cheaper under normal demand and separates two resources:

```text
execution gas → EVM computation and persistent state effects
blob gas      → temporary data availability
```

## Proto-danksharding

EIP-4844 is called **proto-danksharding** because it introduced the transaction format, commitments, fee mechanism, and data flow needed for later data-availability scaling before full danksharding. PeerDAS is a major subsequent step, but it uses one-dimensional erasure coding and is not the complete full-danksharding design.

Dencun combined the execution-layer Cancun and consensus-layer Deneb upgrades and activated EIP-4844 in 2024.

## What it did not solve

Blobs do not increase smart-contract execution throughput directly. Rollup sequencers still order transactions, proofs or fraud systems still establish correctness, and rollups retain their own trust and decentralization tradeoffs.

Dencun made Ethereum a better data-availability layer for rollups. That is different from executing every rollup transaction on L1.

## Primary sources

- [EIP-4844: Shard Blob Transactions](https://eips.ethereum.org/EIPS/eip-4844) — blob transactions, commitments, versioned hashes, and the separate fee market.
- [EIP-7594: PeerDAS](https://eips.ethereum.org/EIPS/eip-7594) — column custody, sampling, and reconstruction after Fusaka.
- [Ethereum roadmap](https://ethereum.org/roadmap/) — Dencun and Fusaka activation dates.

Last verified: 2026-08-22.

## Check yourself

1. Why was calldata an expensive fit for rollup data?
2. Can an EVM contract read full blob contents?
3. Why do blobs have a separate fee market?
4. What does “proto” mean in proto-danksharding?
