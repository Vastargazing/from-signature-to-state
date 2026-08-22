# Substrate: Pallets and Runtime

> **A Substrate runtime is the chain's state-transition function assembled from reusable modules called pallets.**

The Polkadot SDK provides FRAME, a Rust framework for building blockchain runtimes. A pallet usually defines one domain—balances, staking, governance, assets, or a custom application—and contributes several pieces:

- storage items;
- callable functions known as dispatchables;
- events and errors;
- configuration types and constants;
- hooks that run during block processing.

The chain composes pallets into one runtime. An extrinsic enters the runtime, its origin is checked, a dispatchable runs, and storage changes become part of the new state.

## Runtime Rust is not server Rust

The runtime must produce the same result on every validating node. It therefore avoids ordinary operating-system effects such as network requests, local files, wall-clock time, and uncontrolled randomness.

It is compiled to deterministic Wasm stored in chain state. Current Polkadot SDK nodes execute that runtime through a compiled Wasm engine; the old separate native-runtime execution path is deprecated. Runtime code is usually `no_std`, because it cannot assume a normal operating system.

## Weight is part of correctness

Each dispatchable declares a weight: an estimate of its computational and storage cost. Blocks have weight limits, so one user cannot demand unlimited work.

Weights should come from benchmarks. Underestimating them creates denial-of-service risk; badly overestimating them wastes block capacity. Unbounded storage iteration is especially dangerous because state grows over time.

## Upgrades and migrations

Governance can replace runtime Wasm without replacing every node binary. That makes protocol upgrades flexible, but stored data survives the code change. If a pallet changes its layout, the upgrade needs a versioned storage migration with bounded cost and tests.

The central mental model is:

```text
node = networking, database, consensus machinery
runtime = deterministic rules that change chain state
```

## Check yourself

1. What does a FRAME pallet contribute to a runtime?
2. Why can runtime code not call an arbitrary web API?
3. What security problem do weights address?
4. Why can a runtime upgrade require a storage migration?
