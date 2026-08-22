# Sybil Resistance

> **Sybil resistance stops one actor from gaining consensus power merely by creating more identities.**

On the internet, creating keypairs and node names is cheap. If consensus counted one vote per identity, an attacker could generate a million identities and become the majority.

A permissionless protocol therefore attaches influence to something costly or limited.

## Common resources

Proof of work weights demonstrated computational work backed by hardware and energy. Proof of stake weights stake registered and exposed to protocol rewards and penalties. Permissioned systems use an approved membership list and legal or organizational identity.

These mechanisms do not prove that participants are unique humans. They make control of more voting weight costly.

```text
many identities + little scarce resource = little consensus weight
```

## Sybil resistance is not consensus itself

The resource rule answers who gets influence and how much. Consensus still needs proposals, validation, voting or fork choice, finality, and network behavior.

Likewise, expensive identities do not guarantee honesty. An attacker may acquire enough hash power or stake to cross a particular safety, liveness, or censorship threshold; that threshold is not always a simple majority. The security claim is conditional on how much weighted resource an attacker controls and what behavior the protocol incentivizes or penalizes.

## Different layers use different defenses

Peer-to-peer networks also face Sybil attacks. Thousands of cheap peers can try to eclipse nodes or consume connections even without gaining consensus weight. Peer diversity, scoring, rate limits, and discovery rules defend this layer.

Governance may use still another weight—tokens, delegated votes, or one approved member per organization. Calling all of these “decentralized” hides who can acquire influence and at what cost.

The useful questions are:

- what resource determines weight?
- can it be borrowed or concentrated?
- who can enter the set?
- what happens if one actor controls the majority?

Sybil resistance turns identity creation from a free attack into a resource problem. It does not make the resource evenly distributed.

## Primary sources

- [The Sybil Attack](https://www.microsoft.com/en-us/research/publication/the-sybil-attack/) — the original analysis of identity multiplication without a trusted identity authority.
- [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf) — proof of work as resource weighting rather than one-network-identity-one-vote.

## Check yourself

1. Why is one-key-one-vote unsafe?
2. What does proof of stake make scarce?
3. Why is Sybil resistance not a full consensus protocol?
4. An attacker runs thousands of peers but owns negligible stake or hash power. What can it attack, and what can it not decide by identity count alone?

<!-- corepath:start -->

**Core Path 21/50** · [← Byzantine Generals Problem](054-byzantine-generals.md) · [Nakamoto Consensus →](057-nakamoto-consensus.md)

<!-- corepath:end -->
