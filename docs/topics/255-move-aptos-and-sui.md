# Move: Aptos, Sui, and Resource-Oriented State

> **Move treats valuable state as resources that cannot be implicitly copied or discarded. Aptos and Sui use that language in different storage models.**

## Resources

A Move type can have abilities such as `copy`, `drop`, `store`, and `key`. A coin resource intentionally lacks unrestricted copy and drop.

The type system therefore prevents broad classes of accidental duplication or disappearance before runtime. Modules control how their declared resource types are created and destroyed.

This does not prevent bad authorization, oracle logic, arithmetic, or economic design.

## Aptos

Aptos follows an account-oriented global storage model. Move modules publish code, and resources are stored under account addresses according to type.

Transactions declare entry functions and the runtime can exploit read/write information for parallel execution while preserving deterministic results.

## Sui

Sui makes objects central. Each object has an ID, version, owner model, and contents. Objects may be owned by an address, shared for consensus access, immutable, or wrapped by other objects.

Transactions touching independent owned objects can follow a faster parallel path; shared objects require ordering through consensus.

## Similar language, different platform semantics

Aptos Move and Sui Move share ancestry but differ in object APIs, storage, transaction model, framework modules, and tooling. Code is not automatically portable.

```text
Move resource safety
    + Aptos account storage
    or Sui object storage
```

## Rust comparison

Move's resource rules resemble ownership intuition from Rust, but there are no Rust-style lifetimes or borrow checker across arbitrary on-chain time. Move's verifier enforces its own bytecode and ability rules.

The credible claim is narrow: Move makes asset-like values first-class linear resources; application correctness still needs explicit invariants.

## Check yourself

1. Which abilities are normally withheld from a coin resource?
2. Where does Aptos store resources?
3. Which Sui objects need consensus ordering?
4. Why does resource safety not eliminate economic exploits?
