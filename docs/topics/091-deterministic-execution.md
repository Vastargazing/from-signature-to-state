# Deterministic Execution

> **Given the same pre-state, transaction, block context, and protocol version, every honest EVM implementation must produce the same result.**

## Consensus needs replay

Chapter 2 introduced deterministic state transitions. The EVM is where Ethereum makes that promise concrete: a producer executes the block, and every validating execution client replays it locally.

```text
old state + ordered inputs + rules → new state
```

If execution depended on a node's local clock, filesystem, random generator, or web request, different nodes could calculate different roots and split consensus.

The EVM therefore exposes only protocol-defined inputs. `block.timestamp`, `block.number`, `msg.sender`, calldata, and stored state may vary between executions, but their values are fixed for a particular transaction in a particular block.

## Deterministic does not mean predictable early

A contract result can be unknown before inclusion because the producer may choose transaction order and constrained block fields. State may change before the transaction executes.

Once the complete block context and pre-state are fixed, the result must be reproducible.

This distinction matters for randomness. On post-Merge Ethereum, `block.timestamp` is derived from the beacon-chain slot rather than freely chosen by the proposer. A proposer can still influence whether a transaction appears in the current slot or a later one and can choose its ordering; other EVM chains may define timestamp rules differently. Determinism does not make a block-derived value unpredictable or manipulation-free.

## External data needs an oracle

A contract cannot directly call an exchange API or read today's temperature. An off-chain actor must submit that information in a transaction, often through an oracle protocol with signatures and aggregation.

Consensus can then deterministically verify and consume the submitted value. It does not prove that the real-world claim was true; oracle design handles that trust problem.

## Implementation diversity

EVM clients can use Go, Rust, Java, or C#. They may optimize storage, caching, and instruction dispatch differently.

Consensus tests and differential testing check that all implementations agree on edge cases. An overflow, gas-accounting mismatch, or call-reversion bug can become a chain split even if the program looks correct at the application level.

Determinism is the contract between implementations; exact protocol semantics are what make it real.

## Primary sources

- [Ethereum Execution Layer Specifications](https://github.com/ethereum/execution-specs) — executable state-transition rules shared by execution-client implementations.
- [Ethereum consensus validator specification: Bellatrix](https://github.com/ethereum/consensus-specs/blob/master/specs/bellatrix/validator.md) — construction of an execution payload timestamp from the beacon-chain slot.

Last verified: 2026-08-22.

## Check yourself

1. Which inputs must be identical for deterministic EVM replay?
2. Why is `block.timestamp` compatible with deterministic execution?
3. A lottery uses a block-derived value. Every validator reproduces the winner, but the proposer can exclude the lottery transaction from this slot. Which guarantee holds, and which one fails?
4. Why do smart contracts need oracles for external facts?

<!-- corepath:start -->

**Core Path 33/51** · [← The EVM: A 256-Bit Stack Machine](089-evm-stack-machine.md) · [EVM Data Areas →](093-evm-data-areas.md)

<!-- corepath:end -->
