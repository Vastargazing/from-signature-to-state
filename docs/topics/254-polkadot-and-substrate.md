# Polkadot and Substrate

> **The Polkadot SDK builds customizable Rust runtimes; Polkadot lets parachains use relay-chain validation and cross-chain messaging while keeping their own state-transition logic.**

## FRAME and pallets

Substrate technology now lives in the broader Polkadot SDK. FRAME composes a runtime from **pallets**: Rust modules for balances, staking, governance, assets, or application-specific logic.

The runtime compiles to Wasm and is stored on-chain as the state-transition function. Current Polkadot SDK nodes execute that Wasm with a compiled Wasm engine; the historical native-runtime fast path has been deprecated and its execution strategy is now effectively a no-op. Runtime upgrades can replace the on-chain Wasm logic through governance without a traditional client hard fork, while node code still handles networking, database, and consensus duties.

## Relay chain and parachains

The relay chain coordinates shared security and validation. Parachains produce candidate blocks through collators; relay-chain validators check parachain state transitions before those candidates become part of the shared system.

A parachain has its own runtime and state, not one contract inside the relay chain.

## Coretime

Parachains need access to validation resources called coretime. They can obtain bulk capacity for sustained block production or on-demand capacity for intermittent use.

This replaces the older mental model that every project permanently wins a fixed parachain slot.

## Messaging and sovereignty

XCM is a language for expressing cross-consensus actions and asset movement. Its execution depends on each chain's configured origin conversion, barriers, fees, and asset mappings.

Shared validation does not make every message permission safe. A parachain can still contain buggy runtime logic or dangerous governance.

## Rust lens

Pallet code runs in a constrained `no_std` runtime. Storage access carries weight; hooks and migrations must be bounded; every extrinsic needs origin checks and benchmarked weight.

The stack is Rust-heavy from runtime modules to nodes, but runtime safety still depends on deterministic logic and upgrade governance.

## Primary sources

- [Polkadot parachain architecture](https://docs.polkadot.com/polkadot-protocol/architecture/parachains) — Polkadot SDK, Substrate, FRAME, Cumulus, shared security, and runtime/client separation.
- [Polkadot parachain consensus](https://docs.polkadot.com/polkadot-protocol/architecture/parachains/consensus/) — collators, proof-of-validity blocks, relay-chain validators, and finality.
- [Polkadot elastic scaling](https://docs.polkadot.com/polkadot-protocol/architecture/polkadot-chain/elastic-scaling/) — coretime and multi-core parachain scaling.

Last verified: 2026-08-22.

## Check yourself

1. What does a FRAME pallet define?
2. How does a parachain differ from a relay-chain contract?
3. What resource does coretime purchase?
4. Why can a shared-security parachain still have application bugs?
