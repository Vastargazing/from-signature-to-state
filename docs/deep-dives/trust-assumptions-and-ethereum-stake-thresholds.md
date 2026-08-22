# Trust Assumptions and Ethereum Stake Thresholds

The word *trustless* becomes useful only when its remaining assumptions are named.

## Synchronization changes what you verify

“I run my own node” does not always mean “I replayed every block from genesis.”

A full-from-genesis sync verifies the complete transition history under the node's protocol implementation. Snapshot and checkpoint-based modes begin from more recent state. The snapshot can be checked against an accepted state root, but the client still needs an authenticated recent block or checkpoint as a trust anchor.

Both modes verify new blocks locally. They differ in how the node established its starting view and how much old execution it reproduced itself.

## Ethereum's threshold ladder

Proof of stake does not have one magic “51% attack” number. Different shares threaten different guarantees:

| Share of stake | What becomes possible |
|---|---|
| ≥1/3 | Prevent finalization by withholding or casting incompatible votes: no two-thirds supermajority remains |
| ≥34% | Attempt double finality by equivocating and splitting honest votes between two forks; the behavior is slashable |
| >1/2 | Dominate fork choice: censorship, short reorgs, and maximum MEV; exactly 50% can sustain balanced competing forks |
| ≥2/3 | Finalize a preferred chain and control both future checkpoints and attempted revisions of finalized history |

Liveness fails before safety. Around 34% does not produce double finality automatically: the attacker must equivocate and arrange for roughly half of honest stake to support each fork. The equivocating stake exposes itself to severe correlation penalties.

Crossing a threshold does not make an invalid signature valid or let the EVM ignore its rules. It takes the consensus protocol outside the honest-weight assumptions under which it promised liveness, fork-choice integrity, or finality.

## Four trust layers

Running a node still leaves at least four categories:

1. **Cryptography:** hashes, signatures, and their security assumptions.
2. **Consensus weight:** enough work, stake, or quorum weight follows the protocol.
3. **Software:** the client implements the intended rules correctly.
4. **Social recovery:** people and institutions decide which software and exceptional recovery path to adopt after extreme failure.

The important question is not whether trust exists. It is whether the assumptions are explicit, independently verifiable where possible, and acceptable for the value at risk.

## Primary sources

- [Ethereum proof-of-stake attack and defense](https://ethereum.org/developers/docs/consensus-mechanisms/pos/attack-and-defense/) — finality delay, double finality, fork-choice control, and dishonest-supermajority thresholds.

Last verified: 2026-08-22.

## Check yourself

1. Which additional starting assumption can checkpoint-based sync introduce?
2. Which Ethereum threshold threatens liveness before finalized safety?
3. Why does 34% stake not guarantee automatic double finality?
4. Can two-thirds stake make an invalid EVM state transition valid under unchanged client rules?
