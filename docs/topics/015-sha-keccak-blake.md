# SHA-256, Keccak-256, and BLAKE3

> **These are not three steps from worst to best. The functions differ in design, age, and protocol role. The choice depends on the task and on compatibility already established.**

## SHA-256—the foundation of Bitcoin

SHA-256 appeared in the draft FIPS 180-2 in 2001 and was standardized by NIST in 2002 as part of SHA-2. It uses the Merkle–Damgård construction and is susceptible to a length-extension attack:

```text
given H(x), one can compute H(x ‖ padding(x) ‖ y)
```

Bitcoin hashes its block header twice: `SHA256(SHA256(header))`. The fixed-length inner digest means the ordinary length-extension attack on `SHA256(header)` does not extend the Bitcoin `hash256` construction. This cannot be claimed as the proven reason for the design choice, and hashing twice does not simply double every security level.

Double SHA-256 is also used for transaction identifiers and the Merkle tree. Forget the second pass, and you get different hashes that are incompatible with Bitcoin.

## Keccak-256—the foundation of Ethereum

Keccak won the NIST competition in 2012. Ethereum adopted it before SHA-3 was finally standardized.

In 2015, the SHA3-256 standard received a different domain-separation suffix: `0x06` instead of the original Keccak's `0x01`. Therefore:

> **`keccak256(x)` and `sha3_256(x)` produce different results.**

Ethereum requires a library that specifically implements Keccak-256. Solidity's function is accordingly named `keccak256`.

Keccak uses a sponge construction, so the ordinary Merkle–Damgård length-extension attack does not apply. Ethereum uses Keccak-256 in contract-address derivation and state tries, for full event-signature topics, and—truncated to four bytes—for ABI function selectors.

## BLAKE3—when speed matters

BLAKE3 was released in 2020. It is faster for two reasons:

- its BLAKE2s-based compression function uses fewer rounds, which is noticeable even for short inputs;
- large inputs are divided into independent chunks and hashed in parallel as a tree.

The price is youth: BLAKE3 has undergone fewer years of public cryptanalysis than SHA-256 or Keccak.

## One protocol may use different hashes

Solana is a good example. Proof-of-History generation uses a sequential SHA-256 chain: every next hash depends on the previous one, or the cryptographic clock would not work. Recorded checkpoints allow portions of the sequence to be verified in parallel. Separately, the program runtime exposes hashing syscalls including BLAKE3 for application data.

The right question is therefore not “which hash is best?” but “what exactly are we hashing, and which properties are needed here?”

| | SHA-256 | Keccak-256 | BLAKE3 |
|---|---|---|---|
| Construction | Merkle–Damgård | sponge | tree |
| Length extension | yes | no | no |
| Parallelism for one large input | no | no | yes |
| Primary example | Bitcoin | Ethereum | fast application-level tasks |

Changing a consensus hash requires a coordinated protocol upgrade. The upgrade need not split the network; a split occurs if participants disagree about the new rules.

## Primary sources

- [NIST FIPS 180-4: Secure Hash Standard](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.180-4.pdf) — the SHA-2 family including SHA-256.
- [NIST FIPS 202: SHA-3 Standard](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf) — standardized SHA3 domain separation and sponge functions.
- [BLAKE3 specification](https://github.com/BLAKE3-team/BLAKE3-specs/blob/master/blake3.pdf) — compression, chunk tree, and parallel evaluation.

Last verified: 2026-08-22.

## Check yourself

1. Why can `keccak256` not be replaced with `sha3_256`?
2. What is actually known about Bitcoin's double SHA-256, and what remains an assumption?
3. Where does BLAKE3 gain its speed on short and large inputs?
4. Why is Proof-of-History generation sequential even though verification work can be split?
5. Why can these three functions not be placed on a single “worse to better” scale?
