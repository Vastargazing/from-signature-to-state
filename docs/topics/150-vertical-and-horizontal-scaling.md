# Vertical and Horizontal Scaling

> **Vertical scaling makes each machine do more; horizontal scaling divides work across more machines or execution domains.**

## Vertical scaling

Increase block capacity, use faster CPUs, more RAM, higher bandwidth, optimized clients, and better databases:

```text
same chain + stronger nodes → more work per block
```

This keeps one shared state and simple synchronous composability. Every validator still sees the same ordered execution.

The limit is node accessibility. If keeping up requires datacenter hardware, fewer independent people can verify the chain. Hardware improves over time, but raising requirements faster than commodity hardware improves centralizes validation.

## Horizontal scaling

Split work so different systems process different activity:

```text
users → rollup A
      → rollup B
      → rollup C
```

Rollups, shards, application chains, and some parallel execution designs use this idea. Each domain handles part of total demand while a base layer coordinates data, proofs, or settlement.

Horizontal scaling increases aggregate capacity without requiring every node to execute everything. Its cost is coordination: messages cross boundaries asynchronously, liquidity fragments, state can diverge temporarily, and atomic calls become harder.

## Parallel is not automatically horizontal

A single validator using many CPU cores is local parallelism and may vertically accelerate one chain. True horizontal scaling changes which participants must process which work.

Likewise, launching ten independent chains adds capacity but also ten security and bridge models. Capacity cannot be counted without counting trust.

## Ethereum uses both

Client optimization and cautious gas-limit increases improve L1 vertically. Rollups provide horizontal execution domains. Blob scaling increases shared data capacity so more rollups can settle through Ethereum.

The credible design question is:

```text
What work is divided, and what must every verifier still process?
```

## Check yourself

1. What is the decentralization cost of aggressive vertical scaling?
2. Which coordination problems appear with horizontal scaling?
3. Why is multicore execution not necessarily horizontal scaling?
4. How does Ethereum combine both approaches?
