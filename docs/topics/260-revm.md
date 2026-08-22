# revm

> **revm is an EVM engine you embed in another program; it is not an Ethereum node by itself.**

The EVM needs transaction context, block context, bytecode, and access to account state. revm accepts those inputs, runs EVM instructions under a selected Ethereum fork, and returns an execution result plus state changes.

The caller decides where state comes from. It may be a node database, an in-memory test database, a forked RPC snapshot, or a custom rollup backend.

## The execution boundary

A simplified flow looks like this:

```text
environment + transaction + database
                 ↓
                revm
                 ↓
result + logs + gas used + state diff
```

During execution, revm journals changes. If an inner call reverts, its writes and logs can be discarded while the surrounding call continues according to EVM rules. That rollback behavior is part of EVM semantics, not ordinary Rust error handling.

revm also implements fork-dependent opcodes, gas schedules, precompiles, call rules, and transaction validation. A one-unit gas error or wrong edge case can make a client disagree with the network.

## Why tools build on it

Execution clients, local development nodes, debuggers, block builders, simulators, rollups, and zkVM integrations need the same EVM core but different surrounding systems. An embeddable engine prevents each project from rebuilding the interpreter.

Inspectors let a host observe execution steps and implement tracing, coverage, debugging, or development-only behavior such as cheatcodes. They are hooks around execution; cheatcodes are not real EVM opcodes deployed on Ethereum.

## Rust lens

revm code sits where protocol law becomes machine behavior. Useful work includes interpreter optimization, database interfaces, tracing, precompiles, new-fork support, and conformance testing.

Its API can evolve, but the stable mental model is: the host supplies context and state; revm supplies deterministic EVM semantics.

Run [Lab 7 — Execute and Trace a Transaction with `revm`](../labs/07-execute-and-trace-with-revm.md) to supply bytecode and account state yourself, inspect the opcode sequence, and separate returned bytes from the state diff.

## Primary sources

- [revm repository](https://github.com/bluealloy/revm) — execution, host context, inspectors, supported users, and extension framework.
- [revm migration guide](https://github.com/bluealloy/revm/blob/main/MIGRATION_GUIDE.md) — current API boundaries and breaking changes between releases.

Last verified: 2026-08-22. Pin a revm version before writing code against its API.

## Check yourself

1. Why is revm not a complete Ethereum node?
2. What does the caller supply to the engine?
3. Why does revm journal state changes?
4. What can an inspector do?
