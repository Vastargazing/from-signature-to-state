# Vyper

> **Vyper is a Pythonic EVM contract language that trades language flexibility for explicit, auditable behavior.**

## Design priority

Vyper compiles to EVM bytecode like Solidity, but its language philosophy emphasizes:

- security;
- simplicity;
- auditability;
- predictable execution.

Python-like syntax makes the surface familiar, but Vyper is statically typed and its semantics are blockchain-specific. It is not Python running on Ethereum.

## Features it deliberately excludes

Vyper removes constructs that can hide control flow or make gas unbounded:

- no class inheritance; modules provide explicit composition;
- no function or operator overloading;
- no modifiers that wrap a function invisibly;
- no inline assembly;
- no recursion or unbounded loops.

External calls use explicit forms such as `extcall` and `staticcall`. Type conversions are explicit, and loops have compile-time bounds.

The reader should have fewer possible meanings to consider when auditing a line.

## What this does not guarantee

A smaller language can prevent some confusing patterns. It cannot prevent:

- broken access-control logic;
- manipulated oracles;
- unsafe economic assumptions;
- incorrect external integrations;
- compiler bugs;
- governance and key compromise.

Clear code is easier to review, not automatically correct.

## Solidity versus Vyper

Solidity has a larger ecosystem, more language features, more libraries, and broader tooling support. Vyper offers a narrower and more opinionated style.

Both target the EVM, use ABI conventions, consume gas, and face the same underlying call, storage, and reentrancy model.

```text
Solidity → flexibility and ecosystem breadth
Vyper    → constrained, explicit audit surface
```

Choose based on team expertise, required features, libraries, audit support, and long-term maintenance—not syntax aesthetics alone.

## Check yourself

1. Does Python-like syntax make Vyper dynamically typed Python?
2. Why does Vyper require bounded loops?
3. What replaces class inheritance for code reuse?
4. Why does a smaller language not guarantee a secure protocol?
