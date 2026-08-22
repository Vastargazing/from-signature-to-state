# Solana Programs in Rust

> **A Solana program is mostly stateless code; the mutable state lives in accounts passed into each instruction.**

Solana programs commonly use Rust and compile to Solana's on-chain bytecode target. When an instruction runs, the runtime gives the program three kinds of input: its program ID, a list of accounts, and instruction data.

The program parses those inputs, validates permissions, reads or changes account data, and returns. It can invoke another program through a cross-program invocation, or CPI.

## The account checks are the security model

The client chooses which accounts to pass. Rust types do not prove that those accounts are the intended ones. A program must explicitly verify properties such as:

- the expected account is a signer;
- an account is owned by the correct program;
- a PDA was derived with the expected seeds and program ID;
- writable accounts are actually allowed to change;
- serialized data has the expected type and relationships;
- amounts and authority transitions preserve the protocol's invariants.

Missing one of these checks can turn a valid Rust program into an exploitable protocol.

## Native Rust and Anchor

Native Solana Rust exposes the runtime model directly. The program parses instructions and accounts manually, which gives control but creates repetitive validation code.

Anchor adds account constraints, serialization, generated interfaces, and a conventional project structure. It removes boilerplate, not responsibility. Developers still need to understand what every constraint proves and which relationship remains unchecked.

## Runtime constraints

Programs execute under a compute-unit budget. Excessive loops, costly serialization, repeated PDA derivation, large account scans, and deep CPIs can make an instruction fail even when its logic is correct.

Memory and account data are also constrained. Programs should use bounded work, checked arithmetic, compact layouts, and explicit versioning for stored state.

The Rust skill is useful, but the Solana skill is knowing the runtime contract:

```text
accounts are supplied by the caller → verify them before trusting them
```

Run [Lab 8 — Make Hostile Anchor Accounts Fail Before the Handler](../labs/08-hostile-anchor-accounts.md) to turn that sentence into six negative tests at the generated Anchor validation boundary.

## Check yourself

1. Where does a Solana program keep persistent state?
2. Why can the client-selected account list be dangerous?
3. What does Anchor provide, and what does it not prove?
4. Why must instruction work be bounded?
