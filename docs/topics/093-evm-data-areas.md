# Calldata, Memory, Storage, and Stack

> **EVM data location determines lifetime, mutability, access pattern, and gas cost.**

## Stack

The stack supplies 256-bit operands directly to opcodes. Its 1,024-item bound makes it a place for immediate computation, not large byte arrays.

## Calldata

Calldata is the read-only byte input of the current call. For a normal Solidity function call, it contains the four-byte selector followed by ABI-encoded arguments.

It does not persist as contract state. Reading calldata is relatively cheap, and avoiding an unnecessary copy into memory saves gas.

Each call frame has its own calldata. An internal `CALL` supplies new input to the callee.

## Memory

Memory is a mutable, byte-addressed array private to one call frame. Contracts use it for decoded arguments, temporary arrays, hashing input, and return data.

It starts empty and disappears when the call ends. Its cost grows as execution touches higher offsets, with increasingly expensive expansion.

Memory changes do not survive a transaction and are not shared automatically with a callee.

## Storage

Storage is the current contract account's persistent 256-bit key-value space. `SSTORE` changes global Ethereum state; `SLOAD` reads it.

Because every full node must preserve and commit to this state, storage access—especially writing new nonzero values—is expensive.

```text
stack    → operands now
calldata → read-only call input
memory   → temporary workspace for this call
storage  → persistent contract state
```

## The modern fifth area

Transient storage, accessed with `TSTORE` and `TLOAD`, belongs to an address and lasts for the transaction before being cleared. Its ownership follows contract context: a normal call uses the callee's transient storage, while `DELEGATECALL` uses the caller's. It is useful for temporary state shared by frames executing in the same contract context, such as reentrancy locks.

The classic four-area model remains essential, but modern EVM code should know this separate lifetime exists.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — stack, memory, calldata, storage, call frames, and gas semantics.
- [EIP-1153: Transient storage opcodes](https://eips.ethereum.org/EIPS/eip-1153) — `TLOAD`, `TSTORE`, transaction lifetime, ownership, and `DELEGATECALL` context.

## Check yourself

1. Which area contains ABI-encoded function input?
2. What is the lifetime of EVM memory?
3. Why is persistent storage expensive?
4. A proxy sets a transient reentrancy lock, then enters its implementation with `DELEGATECALL`. Which address's transient storage does the implementation observe, and when is it cleared?

<!-- corepath:start -->

**Core Path 34/51** · [← Deterministic Execution](091-deterministic-execution.md) · [ABI and Function Selector →](098-abi-and-function-selector.md)

<!-- corepath:end -->
