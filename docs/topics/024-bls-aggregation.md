# BLS Signatures and Aggregation

> **BLS can combine many validator signatures into one fixed-size signature; Ethereum uses BLS for consensus validators, while native execution-layer transactions use secp256k1 ECDSA. Contracts may still implement or verify other schemes.**

Proof-of-stake Ethereum has many validators attesting to blocks and checkpoints. Sending every signature separately would make consensus messages grow with the number of voters.

BLS signatures can be aggregated:

```text
sig₁ + sig₂ + sig₃ → one aggregate signature
```

Ethereum's aggregate remains 96 bytes. It proves that a set of public keys signed, but the signature alone does not identify that set. An aggregation bitfield tells the protocol which validators participated.

## Ethereum has two key worlds

- native execution-layer transactions recover an EOA signer through secp256k1 ECDSA, while contract-account authorization may use other rules;
- consensus validators use BLS12-381 keys for blocks and attestations.

An attestation aggregator collects compatible attestations, combines their signatures and participation bits, then broadcasts the compact result. Stake is still counted per validator; aggregation reduces transport and storage, not the number of voters.

## What can go wrong

BLS verification uses elliptic-curve pairings. Aggregation also needs strict protocol rules:

- validate public keys;
- bind each signature to the correct message and domain;
- prevent rogue-key attacks;
- never count a participant twice.

Ethereum uses proof-of-possession protections and domain-separated signing roots. The domain separates duties and fork versions, so a signature for one purpose cannot silently authorize another.

## Aggregation is not threshold signing

With aggregation, validators create complete signatures and someone combines them afterward. In threshold signing, participants create shares of one signing operation; no individual share is a complete signature.

In Rust clients, calling `verify` is the easy part. The hard part is constructing the exact signing root, domain, participant set, and bitfield required by consensus.

## Check yourself

1. What does BLS aggregation compress?
2. Why is a participation bitfield still needed?
3. Which Ethereum keys use BLS?
4. How does aggregation differ from threshold signing?
