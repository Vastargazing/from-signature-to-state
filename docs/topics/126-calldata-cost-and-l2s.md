# Calldata Cost and Why L2s Reduce It

> **L2s lower per-user data cost by compressing many transactions into one L1 publication—and increasingly by using blobs instead of calldata.**

## Why calldata costs gas

Transaction calldata must propagate to Ethereum nodes and remains in execution history. Its bytes also drive EVM input processing.

Historically, zero bytes cost less gas than nonzero bytes because they compress and burden the network differently. Later upgrades can add pricing floors or adjust the schedule, but calldata remains an L1 resource paid through execution gas.

## Rollup batching

A rollup executes transactions away from L1 and publishes compressed information for a whole batch.

```text
1,000 individual user transactions
        ↓ compress and batch
one L1 data publication + one state commitment
```

The L1 data cost is divided across many users. Rollups remove redundant signatures, addresses, and formatting or encode them more compactly.

The L2 does not magically reduce Ethereum's gas price for one calldata byte. It reduces how many expensive L1 bytes each user needs.

## Blobs changed the main lane

Before EIP-4844, rollups mainly posted batches as calldata. Blobs now provide temporary data availability with a separate fee market and are the preferred path for most rollup batch data.

Calldata remains useful for data the EVM must read directly and for rollup metadata or fallback paths. Blob contents are not directly readable by contracts.

## The L2 fee breakdown

A rollup user fee can include:

- L2 execution;
- amortized L1 data or blob cost;
- proof, sequencing, and infrastructure costs;
- congestion or operator margin.

When blob fees rise or ETH price changes, L2 fees can change even if the rollup's own execution is cheap.

Compression also has limits: already-random signatures and hashes compress poorly, while repeated addresses and structured fields compress well.

## Check yourself

1. Why does Ethereum charge for calldata bytes?
2. Does a rollup change the L1 gas cost of one calldata byte?
3. How does batching reduce the cost per user?
4. When is calldata still needed instead of blobs?
