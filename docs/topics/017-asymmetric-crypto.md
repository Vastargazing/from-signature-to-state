# Asymmetric Cryptography

> **A participant keeps a private key and publishes the corresponding public key. Recovering the private key from the public one is practically impossible, so an action can be verified without knowing the secret.**

## The problem it solves

Symmetric encryption is fast but requires a pre-shared secret.

Asymmetric cryptography removes the need to pre-share the private secret: the public key can be distributed, while the owner retains the private key. Participants who have never met can verify signatures without a shared secret. They still need an authenticated way to associate the public key or its address with the account or identity they intend to trust.

## How the keys are related

In scalar-based elliptic-curve schemes, the simplified model is that the private key is a secret scalar `x`, and the public key is a point on an elliptic curve:

```text
P = xG
```

Computing `P` from `x` is easy. Recovering `x` from `P` means solving the practically infeasible discrete-logarithm problem. Concrete key formats differ: some schemes derive the scalar from a random seed rather than storing a uniformly sampled scalar directly.

This is a one-way relationship, not a universal “secret back door”: RSA is constructed differently. What matters is only that the inverse problem is practically infeasible.

A 256-bit elliptic-curve key provides roughly the same 128-bit security as a 3,072-bit RSA key. For blockchain applications, the main advantage is compact keys and signatures.

## Encryption and signatures solve different problems

| | Encryption | Signature |
|---|---|---|
| Who uses the public key | sender | verifier |
| Who uses the private key | recipient | signer |
| What it provides | confidentiality | message integrity and proof of possession of the signing key |

> **Encrypt for the recipient. Sign as the signer.**

These are different cryptographic schemes, not one operation with the keys reversed. Even RSA uses different rules for secure encryption and signatures. ECDSA, Schnorr, and Ed25519 are designed for signatures and cannot become encryption by being “run backward.”

## What a blockchain verifies

Transactions are usually not encrypted: nodes must read and verify them to derive the same state.

A successful signature verification establishes two cryptographic facts:

- the signature is valid for the exact message supplied to the verifier;
- it was produced by someone with access to the private key corresponding to the specified public key, assuming the scheme is secure.

Whether that key **authorizes** the requested action is a separate rule enforced by the protocol, account, or smart contract. A signature also contains no trustworthy timestamp, so “when it was signed” must come from other data.

It does not prove which person pressed the button: a wallet, bot, multisig, or attacker with a stolen key may have signed. The network verifies the key's authority, not a passport identity.

Different protocols choose different signature schemes—ECDSA, Schnorr, Ed25519, or BLS—but all must combine cryptographic verification with rules that say what the key may authorize. That general mechanism becomes concrete at two boundaries: custody of the private key and the exact bytes signed in a transaction.

## The cost

- a lost private key cannot be computed from the public key; recovery is possible only from a previously stored seed or backup;
- a sufficiently large fault-tolerant quantum computer running Shor's algorithm would break RSA and the elliptic-curve schemes discussed here.

## Primary sources

- [NIST FIPS 186-5: Digital Signature Standard](https://csrc.nist.gov/pubs/fips/186-5/final) — public/private key pairs and digital-signature generation and verification.
- [SEC 1: Elliptic Curve Cryptography](https://www.secg.org/sec1-v2.pdf) — elliptic-curve key generation, public-key validation, and signature primitives.

## Check yourself

1. How does asymmetric cryptography remove the need for a pre-shared secret?
2. Why is `P = xG` easy to compute in only one direction?
3. How does a signature differ from encryption?
4. What does signature verification establish cryptographically, and which authorization and identity questions remain outside it?
5. Why will the network still accept a valid signature made with a stolen key?

<!-- corepath:start -->

**Core Path 12/50** · [← Merkle Tree and Merkle Proof](016-merkle-tree.md) · [Private and Public Keys →](018-private-public-key.md)

<!-- corepath:end -->
