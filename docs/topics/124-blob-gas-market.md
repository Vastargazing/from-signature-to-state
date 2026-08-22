# Blob Gas as a Separate Market

> **Blob gas prices temporary data availability independently from ordinary EVM execution gas.**

## Two scarce resources

An EIP-4844 blob-carrying transaction consumes normal execution gas for its transaction processing and **blob gas** for attached blob data.

```text
execution gas → EVM work and state access
blob gas      → temporary data availability capacity
```

Each market has its own base-fee logic and usage target. Heavy smart-contract execution need not directly make blob space expensive, and high rollup data demand need not consume the same capacity as `SSTORE` or contract calls.

## How blob fees work

A blob transaction declares a maximum fee per blob gas. The protocol calculates a blob base fee from accumulated usage relative to the target.

Blob fees are burned. If the transaction is included, its required blob fee is charged for attached blobs; a failed EVM execution does not undo the fact that blob data was included and made available.

The exact targets and update parameters can change through upgrades. The durable idea is independent congestion pricing for a different resource.

## Why rollups care

Rollups need to publish compressed transaction data so others can reconstruct and verify their state. Permanent calldata pricing includes execution-history costs that temporary rollup data does not need.

Blobs provide a cheaper lane whose contents are available for a protocol window and then may be pruned. Commitments remain in the chain.

## Separate does not mean free

If rollups fill blob capacity persistently, the blob base fee rises. They compete with one another within that market.

Rollup users also pay for L2 execution, sequencing, proving or challenging, and the rollup's share of L1 settlement. Blob gas is one important component, not the complete L2 fee.

## Primary sources

- [EIP-4844: Shard Blob Transactions](https://eips.ethereum.org/EIPS/eip-4844) — blob gas accounting, excess blob gas, and blob base fee.
- [EIP-1559: Fee market change](https://eips.ethereum.org/EIPS/eip-1559) — the base-fee mechanism adapted by the blob market.

Last verified: 2026-08-22.

## Check yourself

1. Which resource does blob gas price?
2. Can one transaction consume both execution gas and blob gas?
3. Why does failed EVM execution not erase the blob's inclusion cost?
4. Why can blob fees rise even when L1 execution demand is low?
