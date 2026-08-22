# ECDSA on secp256k1

> **ECDSA is the signature scheme; secp256k1 is the elliptic curve it uses in Bitcoin and Ethereum.**

A private key is a number `d`. The matching public key is the curve point:

```text
Q = dG
```

To sign a message digest, ECDSA also uses a one-time secret number `k`, called the signing nonce. The exact formula matters less than the dependency:

```text
private key + message digest + unique secret nonce → signature
```

Under ECDSA's assumptions, a valid signature is evidence that its creator knew the private key—not proof of identity or intent.

## The dangerous nonce

If the same `k` signs two different messages, an attacker can recover the private key. Biased or partially leaked nonces can also be fatal.

Modern libraries commonly derive `k` deterministically from the private key and message instead of requesting fresh randomness for every signature. This removes one failure mode, but not key theft or side-channel leaks. Application code should not implement ECDSA arithmetic itself.

## Same primitive, different protocols

Bitcoin and Ethereum both use ECDSA over secp256k1, but their signatures are not interchangeable.

Bitcoin ECDSA signatures use strict DER encoding as a consensus rule. Bitcoin Core also applies low-`s` normalization and relay policy to remove the inherent `(r, s)` versus `(r, n-s)` malleability; low-`s` is not a universal consensus rule for every legacy script context. Ethereum transactions carry `(r, s)` plus recovery information, and EIP-2 makes low-`s` a transaction-validity rule, allowing the sender address to be recovered without accepting the high-`s` twin. Each protocol also defines different transaction bytes, hashes, and validation rules.

“Same curve” therefore does not mean “same signed message.”

## Rust lens

Common crates include `secp256k1` and `k256`. Preserve their types:

- a digest is not an arbitrary message;
- a secret key is not any 32-byte array;
- DER, compact, and recoverable signatures are different encodings.

Let reviewed libraries reject invalid scalars and non-canonical values.

## Check yourself

1. What is the difference between ECDSA and secp256k1?
2. Why must a signing nonce never repeat?
3. Why are Bitcoin and Ethereum signatures not interchangeable?
4. What does low-`s` normalization prevent?
