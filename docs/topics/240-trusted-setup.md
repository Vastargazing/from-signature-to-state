# Trusted Setup

> **A trusted setup creates public proving parameters from secret randomness. If forbidden secret material survives, some proof systems can accept fabricated statements.**

## The toxic waste

Certain SNARK constructions need a structured reference string. A ceremony samples secret values, publishes derived parameters, then must destroy the original secrets.

The public parameters are safe to use. The hidden trapdoor is “toxic waste” because someone retaining it may forge proofs that verify.

## Multi-party ceremonies

Several participants contribute randomness sequentially. Each transforms the parameters and destroys its own secret contribution.

If at least one participant behaves honestly and erases its secret, no coalition of the others knows the final trapdoor.

Public transcripts let anyone verify that contributions transformed the parameters correctly. They cannot directly prove a participant erased local copies; security needs only one honest erasure.

## Per-circuit, universal, and updateable

Groth16-style setups are tied to a circuit, so a circuit change needs new parameters. Universal setups can support many circuits up to a size bound.

An updateable setup allows later participants to add fresh entropy, restoring security if at least one update is honest.

These differences change ceremony cost and blast radius. Compromising universal parameters can affect many circuits using them.

## Transparent systems

STARKs and some SNARKs avoid secret setup by using transparent public randomness or different commitment schemes. They trade setup assumptions for other costs such as proof size, verification work, or cryptographic assumptions.

A trusted setup is not automatically unacceptable. It is one explicit trust event whose construction, participants, transcript, reuse, and circuit binding must be understood.

## Check yourself

1. Why is retained setup randomness called toxic waste?
2. How many honest participants can secure a multi-party ceremony?
3. How does a universal setup differ from a circuit-specific setup?
4. Do all succinct proof systems require a trusted setup?
