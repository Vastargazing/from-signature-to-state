# Bytecode Decompilation

> **A decompiler reconstructs a readable approximation from EVM bytecode, but it cannot recover the original source and intent.**

## What survives compilation

Runtime bytecode contains opcodes, constants, jump destinations, and dispatch logic. It does not preserve most source-level meaning:

- variable and function names;
- comments;
- original file structure;
- user-defined type names;
- elegant loops and conditions;
- many optimizer-eliminated boundaries.

Some function selectors and event signature hashes can be matched against known databases, but collisions and unknown signatures remain possible.

## What a decompiler does

A decompiler builds control flow, tracks stack values, guesses memory and storage usage, recognizes ABI patterns, and emits pseudocode.

```text
bytecode → control-flow and data-flow analysis → guessed high-level form
```

Its output may label a storage slot `stor_0` and a function `unknown12345678`. Those labels are analyst aids, not recovered truth.

Optimized bytecode is especially difficult: functions share blocks, expressions are folded, dead code disappears, and source constructs become low-level jumps.

## Creation code and proxies complicate analysis

Runtime decompilation does not show constructor logic that already disappeared. Initial storage values may explain behavior but require chain-state inspection.

A proxy's bytecode mostly shows fallback and delegation. Analysts must resolve the current implementation slot, implementation history, and storage layout before reasoning about the application.

## How to use the result

Decompilation is useful for finding selectors, privileged calls, delegatecalls, external targets, storage patterns, and suspicious paths when source is unavailable.

Treat it as a hypothesis generator. Confirm important claims with:

- raw disassembly and execution traces;
- storage reads;
- transaction simulation;
- bytecode pattern checks;
- comparison against verified related contracts.

Never redeploy decompiled pseudocode and assume equivalent behavior.

## Check yourself

1. Which source information is normally lost during compilation?
2. Why are names produced by a decompiler only guesses?
3. Why does runtime bytecode omit constructor behavior?
4. What extra indirection must be resolved when decompiling a proxy?
