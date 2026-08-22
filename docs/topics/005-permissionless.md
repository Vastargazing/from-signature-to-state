# Permissionless — Participation Without Permission

> **Permissionless is about entry: anyone can join and begin participating without asking anyone. This is separate from how widely power is distributed across the network.**

## The picture

To become a bank, you need a license. A regulator grants it at its discretion and can revoke it.

To become a Bitcoin node, you do not need to ask for anything. Download the client, run it, and you are on the network. An individual peer may disconnect from you, but there is no allowlist to which you must be added.

## Permission is not a barrier

You cannot activate an Ethereum validator with less than 32 ETH. Since Pectra, a validator that opts into compounding credentials can have an effective balance from 32 to 2,048 ETH, but the 32 ETH admission minimum remains. Does that make the network permissioned? No.

> **A barrier is defined by public rules and is the same for everyone. Permission depends on a controlling party's decision.**

Capital, hardware, and fees are barriers: you can overcome them without applying to anyone. An allowlist is permission: the party maintaining the list decides.

Both reduce the number of participants. The difference is not that, but **who decides and on what basis**.

Do not confuse this with removing a participant, which happens in both kinds of system. An Ethereum validator may be slashed and forcibly exited for double-signing. An isolated validator usually loses only part of its effective balance; a correlated mass slashing can destroy the entire effective balance. A protocol rule triggers the process automatically from objectively provable evidence and applies equally to everyone. It is not discretionary.

## Permissions exist at different levels

“Permissionless” is not a single switch. There are several roles, each with its own rules:

| Action | Permissionless | Permissioned |
|---|---|---|
| Read state | anyone | often restricted to participants |
| Submit transactions | anyone who pays the fee | admitted participants |
| Produce blocks | anyone who meets the protocol conditions | an approved list |
| Admission and removal | determined by public protocol rules | determined by an administrator or consortium |
| Examples | Bitcoin, Ethereum | Hyperledger Fabric, Corda |

Any combination is possible. A network may allow anyone to read and submit transactions while maintaining a closed validator list. It is no longer permissionless in the full sense, even if it looks open.

## Why open entry requires a scarce resource

This is the central consequence that explains half of blockchain design.

If anyone can enter, anyone can enter **many times**. A thousand nodes mean nothing if one person controls them through a thousand virtual machines—this is a [Sybil attack](071-sybil-attack.md).

Votes therefore cannot simply be counted per network identity. Consensus influence must be tied to something that cannot be multiplied for free or to an identity that can be shown to be unique. Expended energy (PoW) and locked capital (PoS) are the dominant examples; other designs may use storage, trusted hardware, proof of personhood, reputation, or combinations of mechanisms, each with different assumptions.

A permissioned network does not eliminate the membership problem—it handles it through admission and identity governance. One or more certificate authorities, membership providers, or consortium rules decide which identities are recognized. Compromising enough of that governance to admit arbitrary identities can reintroduce Sybil influence, but compromising one authority does not necessarily compromise a federated system.

> **Sybil resistance is necessary wherever additional identities create additional influence—for example in consensus, voting, quotas, or peer selection. Permissionless consensus usually weights a scarce or verifiably unique resource; permissioned systems control admission and identity issuance.**

Permissioned corporate chains can often use smaller validator sets and simpler consensus because participants are known and admission is governed externally. They do not buy identical resistance more cheaply; they accept a different threat model and additional trust in membership governance. Their actual performance still depends on implementation, workload, network conditions, and fault-tolerance requirements.

## The trap: permissionless ≠ decentralized

Open entry does not guarantee distributed power. The three axes from [Centralization, Distribution, and Decentralization](003-centralization-decentralization.md) are the tool for checking it.

Bitcoin is permissionless to enter, yet measurements of block production often show a significant share concentrated in a few large pools. Pool shares change over time, and a pool is not necessarily one owner of all underlying mining hardware, but its operator still influences block-template construction. Anyone can join, while operational influence may remain concentrated.

Conversely, a consortium of fifty competing banks is closed to new entrants but may be more distributed along the political axis than a network dominated by three pools.

Open entry is also not the same as censorship resistance. Anyone can submit a transaction, but a particular block producer decides whether to include it—and can leave it out. [Private transactions](205-private-transactions.md) and the response to [sanctioned mixers](270-mixers-tornado-cash-and-ofac.md) show how access and inclusion can diverge in practice.

## The cost

- Sybil-resistant consensus weighting must be obtained through a scarce or verifiably unique resource—commonly energy or locked capital. This is specifically a cost of open consensus participation;
- consensus eligibility cannot normally be revoked at one operator's discretion, though peers may disconnect locally and the protocol may punish or forcibly eject a validator for a provable violation;
- open entry also means open entry for spam, so submitting transactions in bulk must cost something: a fee, a small amount of computation, a quota, or another limited resource;
- major public permissionless networks such as Bitcoin and Ethereum have no KYC at the protocol level, creating regulatory friction (Part XXII); this is common, but not part of the abstract definition of permissionless participation.

## Check yourself

1. How does a barrier differ from permission? Why is Ethereum's 32 ETH activation minimum a barrier rather than permission, and what did Pectra change?
2. An Ethereum validator was slashed and forcibly exited. Did the network cease to be permissionless, and must the validator lose its entire stake?
3. Where does the Sybil problem go in a permissioned network, and why might compromising one CA be insufficient?
4. A network is open for reading and transactions but has a closed validator list. Is it permissionless?
5. Why does a permissionless network need a mechanism that makes mass transaction submission expensive?
6. Give an example of a permissionless network with concentrated power and a permissioned network with distributed power.
