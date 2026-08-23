# Gas as a Measure of Computational Work

> **Gas is deterministic resource accounting for EVM execution; the gas price converts that accounting into an ETH fee.**

## Units before money

Every EVM operation consumes a protocol-defined number of gas units. Basic arithmetic is cheap; persistent storage writes, contract creation, and state access cost more.

A transaction's execution-gas cost separates into:

```text
gas used × effective gas price = ETH fee
```

Gas used describes the work according to consensus rules. Gas price describes how much ETH the sender pays per unit in that block.

For a blob transaction, this equation covers execution gas only. Blob gas has a separate market and adds `blob gas used × blob base fee` to the total fee.

The same contract call can use the same gas on a quiet and busy day while costing very different amounts of ETH because the price per gas changed.

## Why not meter milliseconds

Nodes run different hardware and client implementations. One machine may execute an opcode faster than another, but consensus needs every node to charge the same amount.

Gas therefore uses a fixed logical schedule, not wall-clock measurement. The schedule approximates pressure on CPU, memory, bandwidth, database access, and long-term state.

It is imperfect and can be changed by network upgrades when real resource costs or attack patterns become better understood.

## Gas protects liveness

Without metering, an attacker could submit an infinite loop or extremely expensive computation and force every node to work forever.

The sender sets a finite gas limit and must be able to pay. When execution exhausts it, the current frame stops. This bounds the damage of any one transaction.

The block gas limit bounds total execution work across a block. This is a separate ceiling from the gas limit a sender places on one transaction.

## Gas is not a performance benchmark

Lower gas often means less protocol-accounted work, but not always lower latency on every client. Cache behavior, database layout, parallelism, and implementation details affect real speed.

Gas optimization should preserve clarity and correctness. Obscuring authorization logic to shave tiny costs can increase audit and exploit risk.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — opcode gas schedule, out-of-gas behavior, refunds, and block gas accounting.
- [EIP-1559: Fee market change](https://eips.ethereum.org/EIPS/eip-1559) — the separation between gas units, effective gas price, base fee, and priority fee.
- [EIP-4844: Shard Blob Transactions](https://eips.ethereum.org/EIPS/eip-4844) — the independent blob-gas accounting and fee market.

## Check yourself

1. What is the difference between gas used and gas price?
2. Why can gas not be measured in CPU milliseconds?
3. How does gas protect nodes from non-terminating code?
4. Why is lower gas not automatically better contract design?

<!-- corepath:start -->

**Core Path 40/51** · [← State Storage and Storage Layout](108-storage-layout.md) · [Transaction and Block Gas Limits →](120-transaction-and-block-gas-limits.md)

<!-- corepath:end -->
