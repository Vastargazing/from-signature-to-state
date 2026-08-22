# revm: An EVM in Rust

> **revm is a Rust implementation and framework for Ethereum execution; it turns protocol rules into reusable infrastructure.**

## The EVM is not one codebase

Ethereum specifies how transactions transform state. Clients may implement those rules independently.

**revm** provides a high-performance EVM interpreter and execution framework in Rust. A caller supplies transaction and block context plus access to a state database; revm executes the transaction and returns changes, logs, gas usage, and success or failure.

```text
environment + transaction + database → revm → execution result
```

It is used in Rust Ethereum infrastructure such as reth and in tooling, block-building, L2, and testing systems.

## Why a reusable EVM matters

Writing an execution client does not mean rewriting every opcode inside the node's networking code. A reusable library separates concerns:

- interpreter and gas semantics;
- hard-fork configuration;
- precompiles;
- state database interface;
- transaction validation and result handling;
- inspectors for traces and custom tooling.

The database abstraction lets one caller execute against a local node database while another uses cached or remote state. The EVM rules remain shared.

## Why Rust fits

EVM execution handles hostile bytecode and performance-critical state access. Rust offers predictable native performance, explicit data ownership, strong enums and types, and memory safety without a garbage collector.

These properties help architecture; they do not prove consensus correctness. A perfectly memory-safe interpreter can still charge the wrong gas or mishandle an edge case.

## Correctness is cross-implementation

revm must match the Ethereum specification and other clients across every active fork. State tests, official execution-spec tests, fuzzing, and differential comparison catch disagreements.

This is the Rust-in-blockchain pattern worth remembering:

```text
not a smart-contract language replacement
but a core engine for clients, tooling, rollups, and simulation
```

Solidity developers consume the EVM. Rust infrastructure developers can implement, embed, inspect, and optimize it.

Run [Lab 7 — Execute and Trace a Transaction with `revm`](../labs/07-execute-and-trace-with-revm.md) for a pinned, executable version of this boundary.

## Check yourself

1. What inputs must a revm caller provide for transaction execution?
2. Why is a database interface useful in an EVM library?
3. Does Rust memory safety guarantee consensus correctness?
4. Where does revm fit compared with Solidity?
