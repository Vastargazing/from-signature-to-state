# Light Client

> **A light client verifies compact consensus commitments and asks other nodes for the data behind them.**

A full node downloads and checks the data needed to validate state transitions after its synchronization trust point. A light client targets phones, browsers, wallets, and embedded systems that cannot store or process the full chain.

It follows a compact authenticated structure—usually block headers plus consensus updates—starting from a trusted checkpoint, then verifies selected data against commitments in those headers.

## Verify, do not merely request

Suppose a server claims that an account has a balance. A light client can request a Merkle proof and check it against a trusted state root:

```text
consensus-verified header → trusted root
server response + proof  → verified state claim
```

The server supplies the requested data; the proof supplies integrity under the trusted root and proof scheme. A dishonest server may hide data or stop responding, but it should not be able to forge a valid value under that root.

This verifies the claim against the header; it does not make the light client independently re-execute the block that produced the root. The security of accepting that header still comes from the light-client consensus protocol and its assumptions.

## The bootstrap problem

The client still needs a trustworthy starting point and a method for updating it. Proof-of-stake light clients may rely on recent checkpoints, sync committees, or weak-subjectivity assumptions. A very old client cannot always distinguish the canonical chain from a convincing long-range alternative using signatures alone.

Light-client security therefore depends on the chain's consensus design, not only Merkle proofs.

## What it does not do

A light client usually does not execute every transaction, maintain the whole mempool, or serve arbitrary historical queries. It verifies selected claims.

If a protocol lacks compact proofs for a needed fact, the application may fall back to trusting RPC. Many wallets called “light” are actually thin clients: they query a server without cryptographic verification.

## Rust lens

A light-client library needs strict proof decoding, consensus updates, fork handling, bounded resources, and a clear trusted-checkpoint interface. Small data does not mean a small security model.

## Check yourself

1. What does a light client verify directly?
2. What can an untrusted data server still do?
3. Why is bootstrapping part of light-client security?
4. How does a thin RPC client differ from a light client?
