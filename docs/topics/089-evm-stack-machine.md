# The EVM: A 256-Bit Stack Machine

> **The EVM executes bytecode by taking 256-bit values from a stack, applying an opcode, and pushing results back.**

## Stack execution

Unlike a register machine, EVM instructions usually do not name registers. They consume operands from the top of a stack.

Conceptually:

```text
PUSH1 2   stack: [2]
PUSH1 3   stack: [2, 3]
ADD       stack: [5]
```

The real operand order and stack notation matter when reading traces, but the mental model is simple: opcodes transform the top values.

The stack holds at most 1,024 items. Underflow, overflow, an invalid opcode, or an invalid jump causes exceptional execution of the current frame.

## Why 256-bit words

Every stack item is a 256-bit word, or 32 bytes. This matches Ethereum's heavy use of 256-bit hashes and arithmetic used around cryptography.

Smaller Solidity integers still occupy a full stack word during ordinary computation. Packing smaller values mainly saves persistent storage when the compiler can place several fields in one 32-byte slot.

Arithmetic normally operates modulo `2^256`. Signed opcodes interpret the same bits using two's-complement rules; the bits themselves have no built-in Solidity type.

## The machine needs more than a stack

The stack is good for temporary operands but too small for arbitrary byte arrays or persistent state. An execution frame also has:

- calldata for read-only input;
- expandable memory for temporary bytes;
- access to the current account's persistent storage;
- program counter, remaining gas, return data, and call context.

Bytecode is simply a sequence of opcode bytes and immediate data. Higher-level names, types, loops, and functions are compiler conventions translated into jumps, stack operations, and memory access.

## One EVM, many implementations

Geth, Nethermind, Besu, revm, and other software implement the same state-transition rules. Their internal architecture and programming language differ, but given identical input they must produce identical output.

That makes the EVM a specification, not one executable program shipped by a single vendor.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — the EVM machine state, 256-bit words, 1,024-item stack bound, exceptional halts, and opcode semantics.
- [Ethereum Execution Layer Specifications](https://github.com/ethereum/execution-specs) — an executable Python reference for consensus-critical execution behavior.

## Check yourself

1. How does a stack machine obtain opcode operands?
2. How wide is one EVM stack item?
3. Why does a `uint8` not automatically make arithmetic use eight-bit stack items?
4. Which data areas complement the stack during execution?
5. A trace already has 1,024 stack items and the next opcode would push one more. What happens to that execution frame?

<!-- corepath:start -->

**Core Path 32/51** · [← Contract Account](088-contract-account.md) · [Deterministic Execution →](091-deterministic-execution.md)

<!-- corepath:end -->
