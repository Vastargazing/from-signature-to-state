# The Scalability Trilemma

> **A blockchain cannot maximize decentralization, security, and throughput independently: raising capacity changes who can verify and how failures spread.**

## The three goals

**Scalability** means processing more useful activity at acceptable cost and latency.

**Decentralization** means validation and control remain open across many independent participants.

**Security** means invalid state, censorship, reorgs, and capture remain expensive under explicit assumptions.

The trilemma is a design lens, not a mathematical theorem saying only two are possible.

## The hidden node bill

A simple way to increase throughput is to make every block much larger and more frequent. But every validating node must then receive, execute, and store more data fast enough:

```text
more L1 capacity → higher hardware and bandwidth needs
                 → fewer independent validators may keep up
```

If validation concentrates, the network may look fast while depending on a small operator class.

Reducing validator count or using permissioned high-performance machines improves coordination but changes the decentralization and censorship model.

## Scaling by changing the architecture

The trilemma does not mean progress is impossible. Better clients, cryptography, networking, parallel execution, and state management improve the frontier.

Layered systems avoid making every L1 node execute every user transaction. Rollups batch computation and use L1 for data availability, proofs or disputes, and settlement.

This introduces new components—sequencers, provers, bridges, and data publication—but can preserve a permissionless verification and exit path.

## Ask what was moved

When a chain claims high transactions per second, ask:

- how many nodes can independently validate it;
- what hardware and bandwidth they need;
- whether data is available;
- what happens when the main operator disappears;
- where final settlement occurs;
- whether the benchmark includes real state contention.

Throughput without a failure model is a marketing number.

## Check yourself

1. Why can larger blocks reduce decentralization?
2. Is the trilemma a formal impossibility theorem?
3. How do rollups avoid executing every user transaction on L1?
4. Which questions make a throughput claim meaningful?

<!-- corepath:start -->

**Core Path 45/51** · [← Unit, Fuzz, and Invariant Tests](115-unit-fuzz-and-invariant-tests.md) · [What an L2 Is—and What It Is Not →](151-what-is-an-l2.md)

<!-- corepath:end -->
