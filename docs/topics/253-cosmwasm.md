# CosmWasm

> **CosmWasm runs Rust-compiled WebAssembly contracts as actors inside Cosmos SDK chains, with messages returned to the chain instead of arbitrary synchronous system access.**

## The stack

A Cosmos SDK chain includes the `x/wasm` module and CosmWasm VM. Developers write Rust against `cosmwasm_std`, compile to Wasm, then instantiate contract instances with separate addresses and state.

Common entry points include:

- `instantiate` for initial state;
- `execute` for state-changing messages;
- `query` for reads;
- `migrate` for authorized upgrades;
- `reply` for handling submessage results.

## Actor-style communication

A contract processes one message against its storage and returns a `Response` containing attributes and outgoing messages.

It does not directly hold a Rust reference to another contract's memory. The chain dispatches returned messages to bank, staking, IBC, or other contracts under transaction semantics.

Submessages can request a reply on success or failure, giving explicit control over multi-step workflows.

## State and schemas

Contract state is namespaced key-value storage. Libraries such as storage containers provide typed access, while message enums define the public interface.

Schema generation lets clients know exact JSON message shapes. Rust types help locally, but incoming addresses, funds, authorization, and cross-contract replies remain adversarial inputs.

## Chain-specific environment

CosmWasm is portable across supporting chains, yet chains can expose different custom messages, modules, gas rules, upload permissions, and governance.

The same Wasm code does not imply the same deployment policy or security on every zone.

## Rust lens

Avoid floating point, nondeterminism, OS access, and unbounded iteration. Test contract logic with multi-contract simulation, then test the actual chain configuration and migration authority.

CosmWasm is Rust smart-contract infrastructure—not a Rust rewrite of the Cosmos validator stack.

## Primary sources

- [CosmWasm documentation](https://cosmwasm.github.io/) — `x/wasm`, the VM, Rust contracts, messages, and IBC integration.
- [CosmWasm repository](https://github.com/CosmWasm/cosmwasm) — standard library, VM crates, schemas, and contract entry points.

Last verified: 2026-08-22.

## Check yourself

1. Which Cosmos SDK module hosts CosmWasm execution?
2. How does a contract request another action?
3. What purpose does the `reply` entry point serve?
4. Why can one Wasm binary have different risk across chains?
