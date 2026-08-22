# Sybil Attack

> **A Sybil attack uses many identities controlled by one actor to exploit a system that mistakes identity count for independence.**

Creating keys, accounts, or cloud nodes is cheap. If a protocol gives one unit of influence to each apparent participant, one attacker can manufacture a crowd.

The attack matters wherever the system assumes many identities mean many independent actors.

## Different targets

At the consensus layer, fake validators could dominate one-identity-one-vote. Proof of work, proof of stake, or permissioned membership attaches influence to a scarce or controlled resource.

At the network layer, Sybil peers can surround a node, filter its messages, delay blocks, or learn which transactions it originates. Consensus weight does not stop this eclipse-style attack; peer diversity and connection policy do.

In governance or airdrops, one actor can split activity across wallets to collect rewards or votes intended for distinct users. Token weighting changes the cost but may favor wealthy actors instead.

In reputation systems, fake accounts can endorse one another and create artificial trust.

## The defense must match the resource

Possible defenses include stake, computation, verified membership, rate limits, social trust, cost per identity, or proof of unique personhood. Each changes who can participate and who can acquire power.

No defense proves decentralization by itself. A resource may be scarce but concentrated, rented, delegated, or controlled through one provider.

The analysis should be:

```text
What privilege does one identity receive?
How cheaply can one actor create or control many?
What independent resource limits that control?
```

This atom describes the attack. Sybil resistance describes the protocol mechanism that prices or restricts it.

## Check yourself

1. What mistaken assumption does a Sybil attack exploit?
2. How can Sybil peers attack networking without consensus power?
3. Why does token weighting not prove equal participation?
4. How does a Sybil attack differ from Sybil resistance?
