# Alloy and ethers-rs

> **Alloy is the modern Rust toolbox for speaking Ethereum; ethers-rs is the older toolbox officially deprecated in Alloy's favor.**

An Ethereum application needs more than an HTTP request. It needs exact primitive types, transaction encoding, ABI handling, signing, RPC transports, and providers that combine those pieces.

Alloy splits this work into focused crates. A project can use only the layers it needs:

- primitives such as addresses, hashes, and 256-bit integers;
- consensus transaction and block types;
- ABI encoding and generated bindings through `sol!`;
- HTTP, WebSocket, or IPC transports;
- providers for JSON-RPC calls;
- signers and wallet abstractions.

This modularity matters in infrastructure, where a node component may need Ethereum types without needing a complete wallet stack.

## Where ethers-rs fits

ethers-rs established a broad and productive Rust interface to Ethereum. Existing projects still use it, but the project has been deprecated in favor of Alloy and Foundry's maintained ecosystem. For new work, Alloy is normally the starting point.

Migration is not just renaming imports. Types, middleware patterns, generated bindings, provider composition, and error behavior differ. Move one boundary at a time and keep integration tests around encoding, signing, and RPC calls.

## The library cannot protect you from Ethereum

A typed provider improves code, but it does not make RPC data trusted or chain behavior synchronous. Production code still must handle:

- chain IDs and replay protection;
- nonce coordination between concurrent senders;
- fee changes and replacement transactions;
- dropped transactions and RPC disagreement;
- confirmations, reorgs, and finality.

The strongest habit is to keep Ethereum concepts visible in the design. A `PendingTransaction` is not a receipt, a receipt is not finality, and an RPC response is not consensus proof.

## Primary sources

- [Alloy documentation](https://alloy.rs/) — current crate structure, providers, transports, transactions, signers, and migration material.
- [Alloy repository](https://github.com/alloy-rs/alloy) — maintained package layout and installation surface.
- [ethers-rs repository](https://github.com/gakonst/ethers-rs) — the project's own deprecation notice and migration direction.

Last verified: 2026-08-22. Pin crate versions; examples can age faster than the mental model.

## Check yourself

1. What layers does Alloy provide?
2. Why is modularity valuable for infrastructure code?
3. Why is migrating from ethers-rs more than changing names?
4. What can a provider library not guarantee?
