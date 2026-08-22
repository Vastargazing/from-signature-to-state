# Proof of Stake

> **Proof of stake weights consensus participation by capital locked under rules that can reward cooperation and punish provable violations.**

Validators deposit the chain's asset and participate in proposing or voting on blocks. Selection and voting weight depend on the protocol, but influence is tied to stake rather than raw identity count.

This gives Sybil resistance: creating many validator keys does not create additional total stake.

## The security mechanism

Depending on the protocol and duty, participating validators may earn issuance, fees, or both. Validators that go offline can miss rewards or receive penalties. Validators that sign a protocol-defined slashable contradiction can lose stake and be removed.

```text
stake → voting weight
correct participation → rewards
provable contradiction → slashing
```

An attacker must acquire or control enough stake for the attack's particular threshold. In accountable BFT-style designs, conflicting finalization can leave public evidence identifying slashable stake; not every liveness or censorship attack produces such evidence.

## PoS is not free security

Proof of stake avoids the continuous hash race, but it introduces other problems:

- stake can concentrate in custodians or liquid-staking protocols;
- validator keys need high availability and protection;
- old validator keys enable long-range-history attacks;
- governance and social recovery assumptions matter;
- correlated client or cloud failures can stop finality.

Weak subjectivity addresses the old-history problem by requiring a sufficiently recent trusted checkpoint when syncing after a long absence.

## Stake is not one person

One entity can control many validators, while one validator service can operate stake for many users. Count economic control, delegation, client diversity, and infrastructure—not only validator keys.

Proof of stake also does not let a majority declare invalid state transitions valid. Full nodes still enforce execution and consensus rules. Majority stake can threaten ordering, censorship, finality, and reorganization within those rules.

## Primary sources

- [Casper the Friendly Finality Gadget](https://arxiv.org/abs/1710.09437) — stake-weighted checkpoint finality, accountable safety, and slashing conditions.
- [Ethereum consensus specifications](https://github.com/ethereum/consensus-specs) — validator balances, proposer selection, attestations, rewards, penalties, slashing, and weak-subjectivity-dependent operation.

## Check yourself

1. How does PoS resist cheap identities?
2. What behavior can be slashed?
3. Why is validator count a weak decentralization metric?
4. A node has been offline for many months and sees two internally valid histories signed by old validator keys. Why is ordinary signature verification insufficient, and what extra input does the node need?

<!-- corepath:start -->

**Core Path 24/50** · [← Proof of Work](058-proof-of-work.md) · [Ethereum PoS: Slots, Epochs, and Attestations →](062-ethereum-pos-slots-epochs-attestations.md)

<!-- corepath:end -->
