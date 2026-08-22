# SNARK versus STARK

> **SNARK and STARK name proof-system families, not single algorithms. Compare the concrete construction, setup, proof size, prover cost, verifier cost, and assumptions.**

## SNARK

SNARK means **succinct non-interactive argument of knowledge**. Proofs are compact and verification is much cheaper than repeating the represented computation.

Many deployed SNARKs use elliptic-curve polynomial commitments. Groth16 needs a circuit-specific trusted setup and produces very small proofs. PLONK-family systems can use a universal or updateable setup. Other SNARK constructions use transparent commitments.

So “all SNARKs require toxic waste” is false.

## STARK

STARK means **scalable transparent argument of knowledge**. STARKs commonly use hash-based commitments and publicly derived randomness rather than a trusted setup.

They scale well for large execution traces and avoid elliptic-curve setup assumptions. Their proofs are usually larger, making direct L1 verification and data publication more expensive.

## The real engineering trade

Proof size is only one metric. Measure:

- time and memory to generate a proof;
- verifier time and on-chain gas;
- recursion and aggregation support;
- hardware acceleration;
- field and hash compatibility;
- setup and cryptographic assumptions;
- maturity of libraries and audits.

A STARK can be wrapped in a SNARK to combine a transparent inner proof with a small outer proof. The final system inherits assumptions and bugs from both layers.

## Zero-knowledge is separate

Both families can be used with zero-knowledge techniques, but validity systems may expose all relevant transaction data. “ZK-SNARK” and “ZK-STARK” emphasize privacy properties; SNARK/STARK alone emphasize proof structure.

Choose by the complete workload and verifier environment, not by declaring one family universally superior.

## Check yourself

1. Does every SNARK require a circuit-specific trusted setup?
2. Why are STARK proofs often more expensive to publish on L1?
3. What can wrapping a STARK in a SNARK achieve?
4. Which metrics matter beyond proof size?
