# Proof Recursion and Aggregation

> **Recursive proving lets one proof verify other proofs, compressing many computations into one final object that a verifier checks once.**

## Proof inside a proof

A recursive circuit contains the verifier logic of another proof system. Its witness includes earlier proofs; its statement says those proofs verified and their public inputs connect correctly.

```text
proof A + proof B → recursive proof C
proof C + proof D → recursive proof E
```

The final verifier checks E instead of A, B, C, and D separately.

## Aggregation

Aggregation combines many independent proofs into one verification result. Recursion is a common way to build it, often as a tree so proving work can happen in parallel.

Rollups use aggregation to spread one L1 verification cost across many batches or chains. Privacy systems can aggregate many user proofs without exposing their witnesses.

## Public-input wiring is critical

The outer proof must enforce continuity: batch B's old root equals batch A's new root, chain IDs match, and no proof is counted twice.

Verifying several individually valid proofs without linking their statements can prove a meaningless collection.

## Engineering costs

The inner verifier itself becomes a circuit and can be expensive. Systems choose compatible fields, curve cycles, hash functions, or proof wrappers to reduce this cost.

Recursion adds proving latency, memory, implementation complexity, and more cryptographic code. It can reduce final proof size without reducing total prover work.

## The trust stack

The outer proof inherits the correctness, setup, circuit, and soundness assumptions of every inner layer plus its own aggregation logic.

Compression makes verification cheaper; it does not erase dependencies.

## Check yourself

1. What computation does a recursive circuit contain?
2. Why use a tree rather than one long aggregation chain?
3. Which public-input relationship links consecutive rollup proofs?
4. Does recursion necessarily reduce total proving work?
