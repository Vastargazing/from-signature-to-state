# Digital Signature of a Transaction

> **A signature binds one authorization key to one exact transaction message. Change a committed byte, and verification fails.**

A wallet does not sign the vague sentence “send one coin.” It signs a precisely serialized byte sequence defined by the protocol.

That sequence may include the destination, amount, nonce, fees, chain ID, and contract call data:

```text
transaction fields → canonical bytes → signing digest → signature
```

Nodes rebuild the same payload and verify it with the public key. If an attacker changes a committed field, nodes compute a different message and reject the old signature.

## Verification is not execution

A valid signature answers only the cryptographic question: it is valid for this message and key. Protocol or account rules must still decide whether that key is an authorized signer, and the transaction may fail because the nonce is wrong, funds are insufficient, the fee is unacceptable, or contract execution reverts.

Remember the pipeline:

```text
valid signature ≠ valid transaction ≠ successful execution
```

Ethereum derives the sender from an ECDSA transaction signature. Bitcoin checks signatures against the spending conditions of earlier outputs. Solana matches signatures to the required signer positions in its message.

## What signatures do not provide

- **Secrecy:** transaction data is normally public.
- **Human identity:** a key may belong to a person, bot, company, or thief.
- **Replay protection by itself:** the signed payload must include a nonce, chain ID, recent block reference, or another domain boundary.
- **User understanding:** a dishonest interface can describe malicious bytes as a harmless action.

This last point is the real signing boundary. Cryptography protects the exact bytes, not the story shown on screen. Hardware-wallet displays, transaction simulation, and human-readable signing exist to connect intention to those bytes.

In Rust, prefer the chain's canonical transaction and signing types. Rebuilding serialization manually can create a perfectly valid signature over the wrong payload.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — transaction signing hash, signature fields, and sender recovery.
- [EIP-155: Simple replay attack protection](https://eips.ethereum.org/EIPS/eip-155) — inclusion of chain identity in the signed legacy-transaction payload.
- [BIP-66: Strict DER signatures](https://bips.dev/66/) — Bitcoin's consensus encoding requirements for ECDSA signatures.

## Check yourself

1. Why does changing a nonce invalidate a signature?
2. Why can a signed transaction still fail?
3. Why is a signature not replay-resistant by itself, and which signed protocol fields can provide that protection?
4. Why can strong cryptography not fix a misleading wallet screen?

<!-- corepath:start -->

**Core Path 14/50** · [← Private and Public Keys](018-private-public-key.md) · [Trustless →](004-trustless.md)

<!-- corepath:end -->
