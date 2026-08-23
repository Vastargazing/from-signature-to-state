# Optimistic Rollup

> **An optimistic rollup accepts state claims without a validity proof, then gives challengers time to prove a claim wrong.**

## The normal path

A sequencer orders L2 transactions and executes them. The system batches compressed transaction data, publishes it to Ethereum, and proposes a new L2 state root.

```text
old root + published transactions → claimed new root
```

The claim is accepted optimistically: L1 does not re-execute the whole batch immediately.

Anyone with the data can independently run the rollup and compare the result. If the claim is wrong, a challenger starts the rollup's fault-proof process during the challenge window.

## Where security comes from

Safety requires:

- transaction data available on L1;
- at least one honest party checking claims;
- a working, enforceable fault-proof system;
- correct L1 bridge and rollup contracts;
- enough time and access to challenge.

The sequencer may control ordering and fast confirmations, but it should not be able to finalize invalid state against the proof rules.

## Why it scales

L1 handles compressed data and exceptional disputes rather than ordinary L2 execution. Many user transactions share one publication cost.

Optimistic rollups often reuse EVM semantics, making Solidity application migration easier. Exact equivalence, gas schedule, and system contracts still differ by rollup.

## The delay

L2-to-L1 withdrawals normally wait through the challenge period before the L1 bridge treats the claim as final. Liquidity providers can offer faster exits by paying users early and later collecting the canonical withdrawal.

That is a credit and liquidity service, not faster protocol finality.

## The honest wording

“Optimistic” does not mean the operator is trusted. It means correctness is enforced by detecting and proving fraud rather than proving every batch valid upfront.

## Primary sources

- [Ethereum.org: Optimistic rollups](https://ethereum.org/developers/docs/scaling/optimistic-rollups/) — state commitments, fault proofs, challenge periods, exits, and EVM compatibility.
- [Ethereum.org: Data availability](https://ethereum.org/developers/docs/data-availability/) — why challengers need published batch data.

Last verified: 2026-08-22.

## Check yourself

1. What does an optimistic rollup post to L1?
2. Why must transaction data be available to challengers?
3. What assumption replaces an upfront validity proof?
4. Why can a bridge offer a fast exit before canonical withdrawal finality?

<!-- corepath:start -->

**Core Path 47/51** · [← What an L2 Is—and What It Is Not](151-what-is-an-l2.md) · [ZK-Rollup →](154-zk-rollup.md)

<!-- corepath:end -->
