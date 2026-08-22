# Merkle Patricia Trie

> **Ethereum's modified Merkle Patricia Trie turns key-value state into one root commitment and path-sized inclusion or exclusion proofs.**

Ethereum needs a deterministic map from keys to values. A normal hash table can retrieve values quickly, but it does not give the network one compact commitment to the entire map.

A trie organizes keys by their hexadecimal digits, or nibbles. Patricia compression collapses paths where nodes have only one child. Merkle hashing makes every parent commit to its children.

Change one value and hashes change along its path to the root:

```text
changed leaf → changed ancestors → changed root
```

## The node shapes

Ethereum's modified Merkle Patricia Trie uses three conceptual node types:

- branch nodes select among 16 possible nibbles;
- extension nodes compress a shared path;
- leaf nodes hold the remaining path and value.

Nodes are RLP-encoded and then either embedded directly or referenced by their Keccak-256 hash, depending on encoded length. In the state and storage tries, logical keys are hashed before their nibbles form the path. These exact rules matter: every client must calculate the same root from the same state.

## Why the root is useful

A block header contains state and transaction-related roots. A proof can include only the nodes along one trie path. The verifier hashes them upward and checks that the final hash matches the trusted root.

This proves that a key maps to a value—or is absent—without downloading the full database.

The proof is only as trustworthy as the root. A root supplied by the same dishonest server does not independently prove anything.

## The engineering cost

Tries create many small, irregular database reads and writes. One account update may rewrite several path nodes. Caching, node encoding, garbage collection, snapshots, and crash consistency become major client concerns.

Ethereum currently uses modified Merkle Patricia tries and is researching stateless execution together with replacements for the current commitment structure. The design is not settled: EIP-6800's unified Verkle tree is stagnant, while EIP-7864 describes the current unified-binary-tree draft. Ethereum.org's roadmap pages still describe statelessness in terms of Verkle trees, so `Verkle` should not be read as a committed final design.

The durable idea remains:

```text
authenticated map = key-value lookup + cryptographic commitment
```

Rust node work often deals less with the textbook tree and more with making these commitments fast, reproducible, and recoverable after interruption.

## Primary sources

- [Ethereum.org: Patricia Merkle Trie](https://ethereum.org/developers/docs/data-structures-and-encoding/patricia-merkle-trie/) — the current execution-state trie, node types, key paths, and encoding.
- [EIP-6800: Ethereum state using a unified Verkle tree](https://eips.ethereum.org/EIPS/eip-6800) — the stagnant Verkle transition proposal.
- [EIP-7864: Ethereum state using a unified binary tree](https://eips.ethereum.org/EIPS/eip-7864) — the current draft binary-tree direction and its still-open hash choice.
- [Ethereum.org: Statelessness](https://ethereum.org/roadmap/statelessness/) — the roadmap documentation that still uses Verkle terminology.

Last verified: 2026-08-22.

## Check yourself

1. What does Patricia compression remove?
2. Why does one leaf update change the root?
3. What does a membership proof contain?
4. Why is a proof useless without a trusted root?
