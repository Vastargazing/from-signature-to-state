# Foundry: The Primary EVM Toolbelt

> **Foundry is a Rust-written toolkit that keeps building, testing, debugging, scripting, and chain interaction close to EVM execution.**

## The four core tools

```text
forge  → build, test, fuzz, debug, script, deploy
cast   → encode, call, send, inspect, and convert data
anvil  → run a local development node or network fork
chisel → experiment in a Solidity REPL
```

Most application work centers on `forge`. Tests are commonly written in Solidity, so contract code and tests share types, interfaces, and execution semantics.

`cast` is the command-line bridge to RPC and ABI data. It can inspect blocks and storage, calculate selectors, decode calldata, simulate calls, and send signed transactions.

## Cheatcodes

Foundry exposes special testing operations through `vm` cheatcodes. Tests can change time, block number, balances, callers, expected reverts, logs, storage, or fork state.

Cheatcodes are powers of the local test runner. They do not exist on Mainnet and cannot be called by production contracts.

This is both useful and dangerous: an unrealistic test can pass because it skipped the real authorization, ordering, or deployment path.

## Why Rust matters

Foundry is predominantly Rust and integrates a fast EVM execution stack, RPC tooling, tracing, fuzzing, and command-line ergonomics in native binaries.

For a Rust developer, the project demonstrates blockchain infrastructure work: interpreters, compilers, providers, transaction encoding, local nodes, fuzz engines, and debuggers—not contracts written in Rust for Ethereum.

## A minimal loop

```text
forge build
forge test
forge test -vvvv   # inspect detailed traces when needed
```

Then add fuzz tests, invariants, fork tests, deployment scripts, and verification as risk demands.

Foundry makes execution fast. It does not choose good properties, safe upgrade procedures, or realistic assumptions for you.

## Primary sources

- [Foundry documentation](https://getfoundry.sh/) — Forge, Cast, Anvil, Chisel, tests, traces, and cheatcodes.
- [Foundry repository](https://github.com/foundry-rs/foundry) — the Rust implementation, releases, and source of the toolchain.

Last verified: 2026-08-22.

## Check yourself

1. Which Foundry tool runs Solidity tests?
2. What role does Cast play?
3. Why must production code never depend on a cheatcode?
4. What kind of Rust blockchain engineering does Foundry represent?

<!-- corepath:start -->

**Core Path 43/51** · [← EIP-1559 Fees](122-eip-1559-fees.md) · [Unit, Fuzz, and Invariant Tests →](115-unit-fuzz-and-invariant-tests.md)

<!-- corepath:end -->
