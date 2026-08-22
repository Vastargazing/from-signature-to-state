# OP Stack and the Superchain

> **The OP Stack is software for building chains. The Superchain is the plan to make many such chains behave like a coordinated network.**

## The stack

The OP Stack separates an L2 into replaceable parts: execution engine, rollup node, batch submission, state proposals, fault proofs, bridge contracts, and configuration.

A rollup node reads Ethereum and sequencer data, derives the L2 chain, and asks an execution engine to process it. Contracts on Ethereum hold assets and enforce the settlement rules.

This modularity lets different chains reuse the same code while choosing parameters, operators, fee policies, and governance.

## The Superchain idea

The Superchain aims for OP Stack chains to share standards and security infrastructure, then gain safer interoperability and a more unified user experience.

```text
shared stack + common standards + coordinated upgrades
                         ↓
              easier chain interoperability
```

It does not mean every chain has one state, one mempool, or instant synchronous composability. Until a cross-chain message is finalized under the relevant protocol, the chains remain separate state machines.

## Shared code is not shared safety by magic

A bug in widely reused code can affect many chains. Different chains may also have different sequencers, upgrade keys, fault-proof deployments, DA choices, or emergency controls.

Interoperability introduces its own weakest-link question: can a compromised chain or message path create assets or messages that another chain accepts?

## Rust lens

An OP Stack chain commonly exposes Ethereum-compatible RPC and execution semantics, so Rust tooling can use Alloy, revm-based testing, indexers, and standard transaction types. But chain-specific predeploys and deposit transaction types still matter.

Think of the OP Stack as a reusable implementation kit; Superchain is the coordination layer and destination architecture built around that kit.

## Primary sources

- [OP Stack specification](https://specs.optimism.io/) — derivation, execution, batch submission, and fault-proof rules.
- [OP Stack smart-contract overview](https://docs.optimism.io/op-stack/protocol/smart-contracts) — L1 settlement contracts, upgrade paths, and dispute components.
- [Superchain interoperability documentation](https://docs.optimism.io/op-stack/interop/explainer) — the shared interop model and its deployment status.

Last verified: 2026-08-22.

## Check yourself

1. Is the OP Stack a chain or a software stack?
2. Do Superchain members share one global state today?
3. Why can reused code create correlated risk?
4. Which chain-specific details can still affect Rust tooling?
