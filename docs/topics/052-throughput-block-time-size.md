# Throughput, Block Time, and Block Capacity

> **Throughput is constrained by how much work fits in a block and how quickly the network can safely agree on new blocks.**

Block time is the target or observed interval between blocks. Block capacity limits how much data or computation one block can contain. Together they place a rough ceiling on transaction throughput.

```text
throughput ≈ useful work per block / seconds per block
```

“Transactions per second” hides transaction size. A simple transfer and a complex contract call consume different resources, so gas, compute units, bytes, reads, and writes are often better measures.

## Why not make blocks huge and fast?

Bigger blocks take longer to propagate, validate, execute, and store. Slower peers may fall behind, block producers gain an advantage from better hardware and networking, and reorg risk can rise.

Shorter block times leave less time for information to cross the network. More producers build on stale views, creating competing blocks or requiring stronger coordination.

The system balances:

- user capacity and fees;
- propagation delay;
- validator hardware cost;
- state growth;
- consensus safety and decentralization.

## Capacity is not finality

A chain can produce blocks quickly while finalizing them later. User latency has several stages: submission, inclusion, confirmations, and finality.

Burst throughput also differs from sustained throughput. A benchmark may fill blocks briefly while databases, state growth, or downstream indexers cannot maintain that rate for months.

## Scaling changes where work happens

Rollups execute many transactions away from Ethereum L1 and publish compressed data or proofs back to it. Parallel runtimes execute non-conflicting work simultaneously. Neither removes bottlenecks; each changes which resource becomes scarce.

When comparing chains, ask what transaction was measured, under what hardware, for how long, with which finality, and whether data availability and state costs were included.

## Check yourself

1. Why is TPS alone a weak comparison?
2. What cost does increasing block capacity create?
3. Why is block time different from finality time?
4. How can burst and sustained throughput differ?
