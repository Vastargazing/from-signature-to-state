# Completeness, Soundness, and Zero-Knowledge

> **Completeness protects honest provers, soundness protects verifiers from false claims, and zero-knowledge protects witnesses from disclosure.**

## Completeness

If a statement is true, the witness is valid, and both sides follow the protocol, the verifier should accept.

A system with poor completeness rejects honest proofs. In production this appears as proving failures, edge cases the circuit cannot represent, or incompatible parameters.

## Soundness

A cheating prover should not convince the verifier of a false statement except with negligible probability.

For an argument of knowledge, acceptance also implies the prover knows a witness satisfying the relation, under the system's computational assumptions.

Soundness protects rollups from forged state transitions. It depends on the proof system, parameters, circuit, implementation, and verifier—not on the acronym alone.

## Zero-knowledge

The proof should reveal nothing about the witness beyond what follows from the public statement.

This does not hide public inputs, calldata, timing, wallet addresses, network metadata, or later contract effects. A circuit can use a zero-knowledge proof while its application remains easy to trace.

## Independent properties

A proof system can provide succinct validity without an application needing privacy. Zero-knowledge may be optional in some constructions.

```text
completeness: true claims pass
soundness: false claims do not pass
zero-knowledge: secrets do not leak through the proof
```

Breaking each property hurts a different party. Completeness failure blocks honest users. Soundness failure accepts fraud. Zero-knowledge failure exposes private data even if every accepted statement is correct.

## The practical check

Ask which information is public before analyzing zero-knowledge. Then ask which assumptions make false-proof probability negligible and which implementation paths could bypass verification entirely.

## Check yourself

1. Which property fails when honest proofs are rejected?
2. Which property prevents acceptance of false statements?
3. Can a sound proof leak its witness?
4. Why can a zero-knowledge application still leak user identity?
