# Solidity

> **Solidity is a statically typed source language that compiles contracts into EVM bytecode and an ABI. Ethereum does not execute Solidity text.**

## What the compiler produces

A Solidity build can produce:

- creation bytecode for deployment;
- runtime bytecode stored at the contract address;
- a JSON ABI for calls and events;
- source maps for debugging;
- storage-layout and metadata information.

The blockchain receives bytecode. Source code becomes useful to humans only when published and matched to that bytecode through verification.

## EVM-shaped language features

Solidity looks familiar to developers from C-family languages, but its important concepts come from Ethereum:

- `address`, `wei`, and payable calls;
- `storage`, `memory`, and `calldata` locations;
- external versus internal function calls;
- `msg.sender`, `msg.value`, and block context;
- events, custom errors, and revert behavior;
- gas-sensitive loops and state writes.

Ignoring those distinctions produces code that compiles but behaves unexpectedly or costs too much.

## Types help, but do not provide safety automatically

Modern Solidity checks ordinary integer overflow and underflow by default. Developers can use `unchecked` blocks when wraparound is intentional.

The compiler also enforces visibility and data-location rules. It cannot know that an access-control condition is economically correct, that an oracle is trustworthy, or that an external call is safe from reentrancy.

```text
type-correct ≠ logic-correct ≠ economically safe
```

## Version and settings matter

Compiler behavior changes across versions. Optimizer settings, EVM target, linked libraries, metadata, and intermediate-representation pipelines can change bytecode.

Projects pin a compiler version and commit build configuration. A broad pragma alone does not make reproducible deployments.

## Where Rust fits

Solidity is the dominant language for EVM application contracts. Rust commonly appears below and around it: revm executes the bytecode, reth manages an Ethereum node, and Foundry provides development tooling.

Knowing Rust does not replace Solidity semantics; it gives you another route into the infrastructure implementing them.

## Primary sources

- [Solidity documentation](https://docs.soliditylang.org/en/latest/) — language semantics, data locations, compilation, and security guidance.
- [Solidity contract metadata](https://docs.soliditylang.org/en/latest/metadata.html) — compiler settings, source hashes, and metadata embedded into bytecode.

Last verified: 2026-08-22.

## Check yourself

1. Does Ethereum execute Solidity source code?
2. What role does the JSON ABI play?
3. Why does static typing not prevent reentrancy or bad economics?
4. Which build settings affect reproducible bytecode?
