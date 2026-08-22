# Arbitrum, Optimism, Base, zkSync, and Starknet

> **These networks differ along separate axes: proof system, virtual machine, data publication, sequencer, bridge, and upgrade control. “L2” is only the category.**

## Optimistic families

**Arbitrum** uses optimistic execution and an EVM-compatible Nitro stack. Disputed claims are resolved through its fault-proof system. Its tooling feels Ethereum-like, but its sequencing, fee rules, precompiles, and proving design are Arbitrum-specific.

**Optimism** is built from the OP Stack. It derives L2 blocks from sequencer batches and Ethereum data, then uses fault proofs to challenge incorrect state claims.

**Base** also uses the OP Stack. It is a separate chain and product, not a new proof category. Its main technical family resemblance is to Optimism; governance, upgrades, operators, applications, and economics can still differ.

## Validity-proof families

**zkSync Era** proves batches with zero-knowledge validity proofs. It targets Ethereum application compatibility, but its VM, compiler path, system contracts, and opcode behavior are not simply “geth with proofs.”

**Starknet** uses STARK validity proofs and the Cairo VM. Contracts are written for Cairo's execution model rather than native EVM bytecode, even when compatibility layers exist.

## A useful comparison checklist

Never compare these chains by TPS alone. Ask:

1. What executes the transaction—EVM, modified EVM, or another VM?
2. What proves an incorrect or correct state claim?
3. Where is transaction data published?
4. Who sequences, proves, upgrades, and can pause the system?
5. When can a user force a transaction or exit without that operator?

Decentralization status changes over time. A protocol's architecture, current deployment, and future roadmap are three different facts.

The credible sentence is: Arbitrum, Optimism, and Base belong to optimistic EVM-oriented families; zkSync and Starknet use validity proofs, with Starknet choosing a distinct Cairo VM.

## Primary sources

- [OP Stack specification](https://specs.optimism.io/) — the protocol implemented by OP Stack chains.
- [Arbitrum Nitro whitepaper](https://docs.arbitrum.io/nitro-whitepaper.pdf) — Arbitrum's execution, proving, and rollup architecture.
- [ZKsync protocol documentation](https://docs.zksync.io/zksync-protocol) — ZKsync's validity-rollup design.
- [Starknet protocol documentation](https://docs.starknet.io/learn/protocol/intro) — Starknet execution, proofs, and settlement.

Last verified: 2026-08-22.

## Check yourself

1. Why is Base not a third proof category?
2. Which listed network uses Cairo rather than native EVM bytecode?
3. Why can two OP Stack chains still have different trust assumptions?
4. Which six axes should you compare instead of TPS alone?
