# Proof of History in Solana

> **Proof of History is a verifiable cryptographic clock that helps Solana order events; it is not the consensus mechanism by itself.**

This chapter describes Solana's PoH-and-Tower-BFT design before the Alpenglow migration. As of August 2026, Alpenglow has been accepted as the replacement design, but its mainnet migration feature is not yet activated; once activated, it removes PoH/Tower lockouts from the consensus path and this historical framing must not be read as the new protocol.

A sequential hash chain repeatedly feeds one output into the next:

```text
h₁ = H(seed)
h₂ = H(h₁)
h₃ = H(h₂)
```

Because each step depends on the previous one, generating the sequence takes ordered work. Other nodes can verify the sequence and place recorded events between known positions.

## What the clock helps with

Distributed nodes do not share one perfectly trusted wall clock. Proof of History gives the protocol a common, verifiable ordering reference. Leaders can stream entries, and validators can reason about when events appeared in the sequence.

This reduces some coordination overhead and supports Solana's short slots and high-throughput pipeline.

## What it does not decide

Proof of History does not determine who may lead, which fork wins, or whether a transaction is valid. Solana combines it with stake-weighted leader scheduling, voting, fork choice, and execution rules.

Calling PoH “Solana's consensus algorithm” therefore hides the rest of the system.

## Failure boundary

A malicious leader can censor transactions, produce a bad block, or stop. Other validators verify entries and state transitions, vote on forks, and the schedule moves to later leaders.

The clock improves ordering; it does not remove network delays, stake concentration, validator hardware requirements, or fork recovery.

## Rust lens

Validator code must generate and verify the hash stream efficiently while coordinating networking, block propagation, transaction execution, and votes. Performance matters, but every optimization must preserve deterministic order.

For the pre-Alpenglow design, remember:

```text
PoH → when and in what sequence?
PoS votes and fork choice → which sequence becomes canonical?
```

## Primary sources

- [Solana upgrade tracker: Alpenglow](https://solana.com/upgrades/alpenglow) — current development and Mainnet-activation status.
- [SIMD-0326: Alpenglow](https://github.com/solana-foundation/solana-improvement-documents/blob/main/proposals/0326-alpenglow.md) — the proposed replacement of PoH/TowerBFT consensus with Votor.
- [SIMD-0384: Alpenglow migration](https://github.com/solana-foundation/solana-improvement-documents/blob/main/proposals/0384-alpenglow-migration.md) — the feature-gated handoff and low-power PoH migration path.

Last verified: 2026-08-22.

## Check yourself

1. Why is the PoH hash chain sequential?
2. What coordination problem does it reduce?
3. Which decisions does PoH not make?
4. Why is PoH not consensus by itself?
