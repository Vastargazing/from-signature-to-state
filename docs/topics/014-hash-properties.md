# Cryptographic Hash Function

> **A hash turns data of any size into a short, fixed-length label. Given a good hash, recovering the input or invisibly substituting another is computationally infeasible.**

## The picture

A hash resembles a fingerprint of data: it is convenient for checking a match, but it neither stores nor replaces the data itself.

Collisions inevitably exist: there are infinitely many possible inputs but only finitely many hashes. Security does not mean “there are no collisions”; it means “finding the required one is practically impossible.”

## Five properties

**Determinism.** The same input always produces the same hash. Otherwise, nodes could not compare the `stateRoot` from [State and the State Transition Function](006-state-transition.md).

**Avalanche effect.** Changing one bit changes roughly half the output bits. This conceals the structure of changes but does not guarantee secrecy by itself.

**Preimage resistance.** Given a hash, finding an input that produces it is practically impossible.

**Second-preimage resistance.** Given a specific input, finding a different one with the same hash is practically impossible. This is what protects an already committed block from substitution in [Linking Blocks with Hashes](009-hash-linking.md).

**Collision resistance.** Finding any pair of different inputs with the same hash is practically impossible.

## Three similar attacks

| Attack | What is given | What is sought |
|---|---|---|
| Preimage | a hash | any matching input |
| Second preimage | a hash and a specific input | another input with the same hash |
| Collision | nothing | any matching pair |

For an ideal `n`-bit hash, a preimage requires about `2^n` attempts, while a collision requires `2^(n/2)` because of the birthday paradox. For a 256-bit hash, that is `2^256` versus `2^128`; both are practically unreachable.

## Where mistakes are easy

Preimage resistance does not hide a weak secret. A six-digit PIN can be brute-forced and its hashes compared. A hiding commitment therefore adds high-entropy randomness and uses an unambiguous encoding, for example `H(encode(secret, random_nonce))`. Password verifiers use a unique salt and a deliberately expensive password-hashing or key-derivation function such as Argon2 or scrypt, not a fast SHA-256 hash.

MD5 and SHA-1 demonstrate another distinction: practical collision attacks can create specially constructed matching pairs, but do not let an attacker replace any arbitrary old file. That would require the harder second-preimage attack. SHAttered's two different PDFs with one SHA-1 hash were a collision, not a universal file-replacement tool.

## The boundary of the guarantees

- comparing a freshly computed hash with an independently trusted expected hash confirms a match under the collision-resistance assumption, but does not store the data or prove that its source is honest;
- resistance is an assumption tested over time, not a mathematical guarantee;
- Grover's quantum algorithm reduces 256-bit preimage resistance to roughly 128 bits, which is still considered a large safety margin.

## Primary sources

- [NIST FIPS 180-4: Secure Hash Standard](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.180-4.pdf) — SHA-2 definitions and digest sizes.
- [NIST SP 800-107 Rev. 1](https://csrc.nist.gov/pubs/sp/800/107/r1/final) — preimage, second-preimage, collision resistance, and effective security strength.

## Check yourself

1. How does a preimage differ from a second preimage?
2. Why can a collision be found faster than a preimage?
3. Why does hashing a six-digit PIN not conceal it?
4. If SHA-1 collision resistance is broken, can any old file be replaced?
5. What does a hash prove, and what does it not prove?

<!-- corepath:start -->

**Core Path 11/51** · [← UTXO Model versus Account Model](032-utxo-vs-accounts.md) · [Merkle Tree and Merkle Proof →](016-merkle-tree.md)

<!-- corepath:end -->
