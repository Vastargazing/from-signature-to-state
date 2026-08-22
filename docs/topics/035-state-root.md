# State Root

> **The state root is one hash that commits a block to the entire resulting Ethereum world state.**

After processing a block's transactions, withdrawals, and other fork-defined system operations, an Ethereum client has updated accounts and contract storage. Those values are arranged in authenticated tries, producing a root hash recorded in the execution block header.

The root does not contain the state. It is a cryptographic fingerprint of a particular state.

```text
parent state + full block transition → new state → state root
```

## Why every client recomputes it

A node does not trust the root claimed by the block producer. It starts from the parent state, validates and executes transactions, processes withdrawals and other fork-defined operations, and then calculates the root itself.

If its result differs from the header, the block is invalid for that client. This makes execution deterministic consensus work: one wrong opcode, gas rule, or storage update can create a different root.

## Proofs against the root

An account or storage proof contains the tree nodes needed to connect one key-value pair to the state root. A verifier hashes the path and checks the final root.

This allows a light client or bridge to verify a small state claim without downloading the entire database. But the verifier must already trust the block header and its root through consensus or another secure mechanism.

```text
proof + untrusted root = self-consistent claim
proof + trusted root   = authenticated state claim
```

## State root is not every root

Ethereum block headers commit separately to transactions and receipts. The state root answers what the world state became. The transactions root commits to ordered transaction data. The receipts root commits to execution receipts and logs.

Mixing them up causes bad designs: a log proof is not an account-state proof, and a transaction's inclusion does not prove successful execution.

For Rust client code, root calculation joins EVM output, database updates, trie encoding, and block validation. The hash is small; producing it correctly is not.

## Check yourself

1. What does a state root commit to?
2. Why does a node recompute it?
3. What extra trust does a state proof require?
4. How does a receipts root differ from a state root?
