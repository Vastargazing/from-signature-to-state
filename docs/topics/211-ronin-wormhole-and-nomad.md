# Ronin, Wormhole, and Nomad

> **Three bridge disasters failed at three different layers: signer custody, signature verification, and message-proof initialization.**

## Ronin: the keys were the bridge

Ronin's 2022 bridge required five of nine validator signatures. Attackers compromised enough validator keys to authorize withdrawals that never had legitimate backing.

The lesson is operational: a correct threshold contract is useless when the threshold's independent keys can be captured through one organizational path.

## Wormhole: fake verification became valid minting

The 2022 Wormhole exploit targeted its Solana-side verification path. The attacker bypassed the expected guardian-signature verification and minted 120,000 unbacked wrapped ETH.

The guardian cryptography itself did not need to break. The program accepted crafted inputs as if verification had occurred.

The lesson is implementation: validate account owners, program identities, instruction sources, and every boundary where “verified” state is created.

## Nomad: one bad root opened every message

A Nomad Replica upgrade initialized trusted state in a way that caused the zero root to be accepted. Forged messages could then pass the proof check.

Once the first exploit was visible, many addresses copied transaction calldata and changed the recipient, draining the bridge in a public free-for-all.

The lesson is upgrade and initialization safety: one default value can invert an authentication invariant for every asset.

## The common pattern

All three systems eventually executed a destination action based on a false cross-chain claim:

```text
false claim → accepted verification → real assets released or unbacked assets minted
```

Auditing only token-transfer code misses the real boundary. Review how a message becomes trusted, who can change that logic, and which monitoring or limits contain a false approval.

## Primary sources

- [Ronin: Securing Ronin](https://blog.roninchain.com/p/securing-ronin) — the validator-security response after the key compromise.
- [Wormhole incident report](https://wormholecrypto.medium.com/wormhole-incident-report-02-02-22-ad9b8f21eec6) — the Solana-side verification failure and 120,000 unbacked wrapped ETH.
- [Nomad root-cause analysis](https://medium.com/nomad-xyz-blog/nomad-bridge-hack-root-cause-analysis-875ad2e5aacd) — the initialization error that made forged messages pass authentication.

Last verified: 2026-08-22.

## Check yourself

1. Which threshold failed operationally in Ronin?
2. What did Wormhole's attacker bypass?
3. Why could Nomad's exploit be copied so easily?
4. What shared transition turned all three bugs into asset loss?
