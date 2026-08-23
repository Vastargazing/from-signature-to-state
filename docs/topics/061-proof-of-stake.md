# Proof of Stake

> **Proof of stake weights consensus participation by capital locked under rules that can reward cooperation and punish provable violations.**

Validators deposit the chain's asset and participate in proposing or voting on blocks. Selection and voting weight depend on the protocol, but influence is tied to stake rather than raw identity count.

This gives [Sybil resistance](056-sybil-resistance.md): creating many validator keys does not create additional total stake. Like [proof of work](058-proof-of-work.md), proof of stake supplies scarce consensus weight rather than a complete consensus protocol.

## The security mechanism

Depending on the protocol and duty, participating validators may earn issuance, fees, or both. Validators that go offline can miss rewards or receive penalties. Validators that sign a protocol-defined slashable contradiction can lose stake and be removed.

```text
stake → voting weight
correct participation → rewards
provable contradiction → slashing
```

An attacker must acquire or control enough stake for the attack's particular threshold. Slashing applies only when the protocol defines cryptographic evidence for a violation. In accountable BFT-style designs, conflicting finalization can identify slashable stake; a liveness failure or censorship attack does not automatically produce such evidence.

## Proof of stake versus proof of work

Proof of work and proof of stake make consensus weight costly in different ways. Neither mechanism alone specifies block validity, fork choice, or finality.

| Question | Proof of work | Proof of stake |
|---|---|---|
| What creates consensus weight? | Valid accumulated proof of work. | Capital registered under staking rules. |
| How is a proposer chosen? | Hash power determines the chance of finding a valid block. | Selection is protocol-specific and weighted by stake. |
| What makes attacks costly? | Hardware, continuing energy expenditure, and foregone canonical rewards. | Control of sufficient capital; provable violations may destroy stake. |
| How do nodes choose history and gain finality? | Greatest accumulated work; confidence grows probabilistically with depth. | Protocol-specific fork choice; BFT finality is not automatic. |
| How does a long-offline node bootstrap? | It compares valid histories by accumulated work. | Some designs require a recent trusted checkpoint. |
| What can concentrate operation? | Chip supply, financing, geography, and mining pools. | Capital ownership, delegation, custodians, clients, and shared infrastructure. |

These are different security budgets, not a ranking that makes one mechanism universally safer. [Majority attacks](072-51-percent-attack-and-reorganization.md) and application finality thresholds depend on the particular protocol and resource distribution.

## PoS is not free security

Proof of stake avoids the continuous hash race, but it introduces other problems:

- stake can concentrate in custodians or liquid-staking protocols;
- validator keys need high availability and protection;
- old validator keys enable long-range-history attacks;
- governance and social recovery assumptions matter;
- correlated client or cloud failures can stop finality.

Some PoS designs, including Ethereum, address the old-history problem with weak subjectivity: a node syncing after a sufficiently long absence starts from a recent trusted checkpoint. [Long-Range Attacks and Weak Subjectivity](074-long-range-attack-and-weak-subjectivity.md) explains why old signatures alone cannot identify the live history.

## Stake is not one person

One entity can control many validators, while one validator service can operate stake for many users. Count economic control, delegation, client diversity, and infrastructure—not only validator keys.

Proof of stake also does not let a majority declare invalid state transitions valid. Full nodes still enforce execution and consensus rules. Majority stake can threaten ordering, censorship, finality, and reorganization within those rules.

## Primary sources

- [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf) — proof-of-work resource weighting, accumulated-work chain selection, and probabilistic confirmation security.
- [Casper the Friendly Finality Gadget](https://arxiv.org/abs/1710.09437) — stake-weighted checkpoint finality, accountable safety, and slashing conditions.
- [Ethereum consensus specifications](https://github.com/ethereum/consensus-specs) — validator balances, proposer selection, attestations, rewards, penalties, slashing, and weak-subjectivity-dependent operation.

## Check yourself

1. How does PoS resist cheap identities?
2. What behavior can be slashed?
3. Why is validator count a weak decentralization metric?
4. A node has been offline for many months and sees two internally valid histories signed by old validator keys. Why is ordinary signature verification insufficient, and what extra input does the node need?
5. Why is it wrong to describe PoS as simply PoW without the energy use?

<!-- corepath:start -->

**Core Path 25/51** · [← Proof of Work](058-proof-of-work.md) · [Ethereum PoS: Slots, Epochs, and Attestations →](062-ethereum-pos-slots-epochs-attestations.md)

<!-- corepath:end -->
