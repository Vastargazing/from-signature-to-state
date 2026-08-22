# Validity Proof

> **A validity proof shows that a claimed output follows a specified computation for committed inputs; it proves only what the circuit and public inputs express.**

## Statement and witness

A prover has a large private **witness**: transaction data, signatures, Merkle paths, and intermediate states. The verifier sees compact public inputs such as old and new roots.

The proof establishes:

```text
there exists a witness satisfying these circuit constraints
for these public inputs
```

Soundness makes a false statement computationally infeasible to prove under the scheme's assumptions.

## What L1 verifies

The verifier contract does not learn each execution step. It checks algebraic proof relations and binds the result to the correct rollup program or verification key.

If accepted, the rollup contract can update its stored state root.

## The circuit is the law

If the circuit forgets a balance check, uses the wrong hash, or accepts an invalid signature form, the proof can be perfectly valid for a broken state transition.

Formal properties apply to the encoded computation, not the team's intended specification.

The surrounding contracts also matter. An admin that can replace the verifier or verification key can change what future proofs mean.

## Validity is not availability

A proof can establish that a hidden batch was processed correctly while users still lack data to reconstruct their accounts or withdraw.

```text
validity proof    → computation was allowed
data availability → users can reconstruct and continue
```

Rollups need both. Validiums deliberately move the second guarantee elsewhere.

## Proof latency versus finality

Generating and posting proofs takes time. A sequencer's instant receipt is not the same as L1 verification. Final settlement additionally depends on the L1 block becoming final.

## Check yourself

1. What is a witness in a validity-proof system?
2. What exactly does soundness protect?
3. Why can a valid proof enforce buggy rules?
4. How does proof acceptance differ from data availability?
