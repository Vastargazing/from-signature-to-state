# Foundry Internals

> **Foundry feels like a Solidity toolkit, but its engine room is Rust and revm.**

Foundry is a family of tools:

- `forge` builds, tests, fuzzes, and deploys contracts;
- `cast` encodes data, signs transactions, and queries RPC endpoints;
- `anvil` runs a local Ethereum development node;
- `chisel` provides an interactive Solidity environment.

They share Rust crates for Ethereum types, compilation, RPC, tracing, wallets, configuration, and EVM execution.

## How a Forge test runs

Forge compiles Solidity to EVM bytecode, creates a test environment, and executes calls through revm. An inspector observes the execution and provides traces, coverage, logs, and Foundry cheatcodes.

Cheatcodes can change the caller, timestamp, balances, storage, expected revert, or mocked call. They work because the host intercepts special test calls. A deployed contract cannot execute `vm.prank` on Ethereum.

Fuzz tests run one property with many generated inputs. Invariant tests generate sequences of calls and check that a system property remains true across changing state. Both are strongest when the assertion describes a real invariant rather than merely “the call did not revert.”

## Fork testing

On a fork, Foundry reads state from an RPC endpoint at a chosen block and executes new transactions locally. This makes real protocol integrations reproducible without spending funds.

But a fork is a snapshot, not tomorrow's network. It may miss later governance changes, new liquidity, different oracle values, pending transactions, and future reorgs. Results also depend on the chosen RPC data and block.

## Rust lens

Foundry work connects Rust systems code to Solidity developer experience. Typical problems include faster compilation, EVM instrumentation, state caching, RPC behavior, fuzzing engines, debuggers, and readable traces.

The mental model is:

```text
Solidity source → bytecode → revm execution → Rust inspectors → developer feedback
```

## Check yourself

1. What does each main Foundry tool do?
2. How are cheatcodes implemented?
3. What is an invariant test checking?
4. Why is a fork test not a prediction of future mainnet state?
