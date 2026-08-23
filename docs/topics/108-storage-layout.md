# State Storage and Storage Layout

> **Solidity variables are compiler conventions mapped onto 256-bit EVM storage slots; upgrades must preserve that mapping.**

## Sequential slots and packing

State variables are assigned from slot zero in declaration and inheritance order. Values smaller than 32 bytes may pack into one slot when Solidity's layout rules allow it.

```solidity
uint128 a; // slot 0, lower half
uint128 b; // slot 0, upper half
uint256 c; // slot 1
```

Packing saves storage slots, but updating one packed value requires reading and rewriting the shared word. Declaration order can therefore affect gas and compatibility.

Structs and fixed arrays occupy calculated sequences of slots, with their own packing rules.

## Mappings and dynamic arrays

A mapping variable reserves a slot `p`, but values are not stored directly at `p`. An entry uses a hash-derived location based on its key and `p`:

```text
mapping value slot = keccak256(encode(key, p))
```

This spreads keys across the 256-bit storage space without enumeration. The contract cannot ask a mapping for all keys unless it maintains a separate list.

A dynamic array stores its length at `p`; elements begin at a hash-derived region based on `p`.

## Source names do not exist in the EVM

The EVM sees slot numbers and 256-bit values. It does not know that slot zero means `owner` or that a hash-derived slot means `balances[Alice]`.

Compiler storage-layout output and source code provide that interpretation. Debuggers and auditors rely on them.

## Layout is part of an upgradeable contract's interface

Proxy calls execute new implementation code against old proxy storage. If the new compiler layout assigns a different meaning to an occupied slot, valid code corrupts live state.

Safe upgrades usually preserve existing variable order and types, then append new variables or use explicitly namespaced storage patterns. Renaming alone is harmless; moving or changing representation is not.

## Primary sources

- [Solidity storage-layout specification](https://docs.soliditylang.org/en/latest/internals/layout_in_storage.html) — packing, inheritance order, arrays, mappings, and transient storage layout.
- [Solidity contract metadata](https://docs.soliditylang.org/en/latest/metadata.html) — compiler-produced metadata and the storage-layout output used by tooling.

## Check yourself

1. When can two Solidity variables share one storage slot?
2. Where is a mapping value located relative to its declared slot?
3. Can the EVM enumerate mapping keys automatically?
4. An upgrade moves `owner` from slot 0 to slot 1 while the proxy keeps its old storage. What does the new implementation read, and why can otherwise valid code become dangerous?

<!-- corepath:start -->

**Core Path 39/51** · [← Contract Deployment](105-contract-deployment.md) · [Gas as Computational Work →](118-gas-as-computational-work.md)

<!-- corepath:end -->
