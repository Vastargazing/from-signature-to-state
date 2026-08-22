# Blobs and EIP-4844

> **A blob is temporary Ethereum data made for rollups: cheaper than calldata, visible to consensus, but unavailable to smart contracts.**

## The problem it solves

Rollups execute transactions away from Ethereum, but still need to publish compressed batch data. Before EIP-4844, they placed it in calldata—contract-readable bytes embedded in Ethereum's execution history rather than a separate temporary DA lane.

That was more expensive than the rollup actually needed. The data must be available long enough for verification and reconstruction, but it does not need to live inside EVM storage forever.

## What a blob transaction carries

A blob-carrying transaction contains versioned hashes that reference separate blob data distributed through the consensus layer. Ethereum consensus checks data availability and consistency with the cryptographic commitments.

The EVM can access a versioned hash of a blob commitment, not the blob bytes themselves. A rollup contract can therefore bind a state update to published data without contracts processing that data byte by byte.

```text
rollup batch → blob data
             → commitment visible to the contract
```

## Why blobs are cheaper

Blobs have their own capacity target and fee market. Demand for blob space therefore does not directly compete with normal EVM gas in the same way calldata does.

Their data is also temporary at the protocol level. Since Fusaka activated PeerDAS, blob data is erasure-coded into columns: ordinary nodes custody and sample subsets rather than every node downloading every complete blob. The network provides the data during the availability window; archival services may retain it longer. Commitment references and the resulting rollup state remain after the temporary data can be pruned.

## What EIP-4844 did not do

It did not execute rollup transactions, remove sequencers, or make bridges trustless by itself. It created a cheaper data lane and introduced the commitment machinery later used by PeerDAS for data-availability scaling.

The useful mental model is simple: calldata is permanent contract-readable input; blobs are temporary consensus-available cargo.

## Primary sources

- [EIP-4844: Shard Blob Transactions](https://eips.ethereum.org/EIPS/eip-4844) — blob sidecars, commitments, versioned hashes, retention, and gas accounting.
- [Ethereum.org: Dencun](https://ethereum.org/roadmap/dencun/) — activation and the rollup-data purpose of blobs.

Last verified: 2026-08-22.

## Check yourself

1. Why did rollups use calldata before blobs?
2. Can an EVM contract read arbitrary blob bytes?
3. Why can blob data be temporary without losing rollup state?
4. Why do blobs have a separate fee market?
