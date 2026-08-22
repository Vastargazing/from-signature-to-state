# Arithmetization and Circuits

> **Arithmetization turns program correctness into equations over a finite field so a prover can show one hidden assignment satisfies all constraints.**

## From code to constraints

A normal program has branches, loops, bytes, and memory. A proof system wants algebraic relations.

For an addition rule, the circuit may enforce:

```text
a + b - c = 0
```

The witness assigns values to `a`, `b`, `c`, and every intermediate cell. Public inputs expose only the values the verifier must bind.

## Constraints do not know types automatically

A field element is not inherently a 32-bit integer or boolean. To make `bit` a boolean, the circuit adds:

```text
bit × (bit - 1) = 0
```

Range checks prove an integer fits a chosen width. Omitting them can let field arithmetic satisfy equations using values impossible in the intended program.

## Arithmetization families

R1CS, PLONKish circuits, and AIR describe computation differently. They still reduce correctness to structured polynomial constraints checked through a proof system.

Custom gates and lookup tables compress repeated operations such as ranges, hashes, or VM instructions.

## Circuit cost differs from CPU cost

Bit operations and familiar hashes like SHA-256 or Keccak can be expensive inside arithmetic circuits. ZK-friendly hashes use algebra that needs fewer constraints.

The designer balances proving cost, compatibility, auditability, and assumptions. Replacing Ethereum's hash with a cheaper one may save proving time but require new commitments and integration code.

## Rust lens

Rust circuit libraries build constraint systems through typed APIs, but Rust type safety does not guarantee constraint completeness. A value computed by host code but never constrained can become a dangerous prover-controlled hint.

The audit target is the equations actually emitted.

## Check yourself

1. What does the witness assign values to?
2. Why must a circuit constrain a boolean explicitly?
3. How can a valid field value violate intended integer semantics?
4. Why is fast native Rust code not necessarily cheap to prove?
