# EVM Opcodes

> **An opcode is one byte of EVM instruction; its semantics and gas cost are consensus rules.**

## From bytecode to actions

Solidity compiles into bytecode such as:

```text
60 80 60 40 52 ...
```

The EVM reads the byte at the program counter, interprets it as an opcode, charges gas, changes machine state, and advances or jumps.

Opcode groups include:

- arithmetic: `ADD`, `MUL`, `DIV`;
- bit and comparison: `AND`, `SHL`, `LT`;
- stack: `PUSH`, `DUP`, `SWAP`, `POP`;
- memory and storage: `MLOAD`, `MSTORE`, `SLOAD`, `SSTORE`;
- context: `CALLER`, `CALLVALUE`, `CHAINID`;
- control flow: `JUMP`, `JUMPI`, `STOP`, `REVERT`;
- calls and creation: `CALL`, `DELEGATECALL`, `CREATE2`;
- logs: `LOG0` through `LOG4`.

## Gas is part of the instruction

Opcodes do not all cost the same. Persistent storage writes, account access, hashing, memory growth, and contract creation cost more than basic stack arithmetic.

Some costs depend on runtime conditions. `SSTORE` depends on old and new slot values; memory charges grow with the highest accessed offset; cold state access costs more than repeated warm access within a transaction.

Gas pricing protects nodes from bytecode that is cheap to publish but expensive to execute.

## Byte boundaries matter

Most opcodes are one byte. `PUSH1` through `PUSH32` consume following bytes as immediate data, so those bytes are not independent instructions.

Jumps target valid `JUMPDEST` positions. Jumping into the middle of push data is invalid, even if that byte numerically equals `JUMPDEST`.

## Opcodes evolve

Network upgrades can add instructions or reprice existing ones. A byte may be valid after one fork and invalid before it. Different EVM-compatible networks may support different revisions.

Therefore, “EVM bytecode” is incomplete without the chain and fork rules used to execute it.

## Check yourself

1. What does the EVM do before executing an opcode?
2. Why is the gas cost of `SSTORE` not a single fixed number?
3. Why can bytes after a `PUSH` opcode not be decoded independently?
4. Why must an EVM interpreter know the active network fork?
