# Private and Public Keys

> **A private key creates signatures. A public key verifies them without revealing the private key; protocol or account rules decide what a valid signature authorizes.**

[Asymmetric Cryptography](017-asymmetric-crypto.md) introduced the one-way mathematical relationship. For a developer, the operational distinction matters more: private material must remain secret because it creates authority-bearing signatures; public material can be distributed because it only verifies them.

## What ownership means on-chain

A blockchain does not know who you are. It knows which key may authorize an action.

Using the supplied, committed, or recovered public key, nodes ask:

```text
Was this exact message signed by the matching private key?
```

Verification proves that the signature matches that message and key. Protocol or account rules separately decide whether the key authorizes the action. The network cannot tell whether the signer was the owner, a wallet, or a thief.

A private key is not an ordinary password: no protocol administrator can reset it, and anyone who obtains it can usually sign until an account-specific recovery or rotation rule changes the authority.

## Key, public key, and address

A scheme may use a random scalar directly or derive signing material from a random seed. Security depends on unpredictable generation, not complicated-looking data.

An address is not always the public key itself. Ethereum derives an address from a public key. Bitcoin addresses encode a spending condition or its hash. Solana commonly displays public-key bytes directly as an address.

## The four failures

- leaked key: someone else can authorize actions;
- lost key: the network cannot recreate it;
- weak randomness: the key may be guessed;
- wrong key: the signature is valid, but for another account.

Seed phrases, hardware signers, and multisig exist because generating a key is easy; keeping authority safe is hard.

## Primary sources

- [SEC 1: Elliptic Curve Cryptography](https://www.secg.org/sec1-v2.pdf) — private-key generation, public-key derivation, encodings, and validation.
- [BIP-32: Hierarchical Deterministic Wallets](https://bips.dev/32/) — derivation of extended private and public keys used by Bitcoin-compatible wallets.

## Check yourself

1. What can a public key do that a private key does not?
2. Why is a private key different from a password?
3. What does a valid signature prove to the network?
4. Why is an address not always a public key?

<!-- corepath:start -->

**Core Path 13/50** · [← Asymmetric Cryptography](017-asymmetric-crypto.md) · [Digital Signature of a Transaction →](020-digital-signature.md)

<!-- corepath:end -->
