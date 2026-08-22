# Address Derivation

> **An address is a chain-specific destination or spending rule—not a universal name for a public key.**

A common wallet pipeline is:

```text
private key → public key → chain-specific address
```

The first arrow is cryptography. The second is a protocol convention: hash some bytes, select a part, add network information, and encode the result for people.

## Three useful examples

For a normal Ethereum EOA, Keccak-256 hashes the 64-byte uncompressed secp256k1 coordinates without the `0x04` prefix; the last 20 bytes become the address. EIP-55 mixed case adds a checksum, not a different account.

Bitcoin has no single address algorithm. A legacy address, a SegWit address, and a Taproot address encode different spending programs. The address tells a wallet which locking script to create. It is closer to a compact payment instruction than a raw account ID.

For a normal Solana keypair, the 32-byte public key is the address. A PDA is derived off the Ed25519 curve and has no private key. During a cross-program invocation, its program can authorize it with the same seeds through `invoke_signed`.

## What an address does not prove

An address does not prove a person's identity, current ownership, or even that somebody knows a corresponding private key. Assets can be sent to contracts, PDAs, mistyped destinations, or permanently unspendable values.

A checksum catches some typing errors. Some address formats also encode a network and allow software to reject a mismatch; others, including ordinary EIP-55 Ethereum addresses, do not. No checksum can know which network you intended or detect that you copied an attacker's otherwise valid address.

Treat an address as a typed protocol value, not arbitrary text. Before sending, verify the chain, network, format, and expected destination type.

The memorable difference is:

```text
public key → verifies cryptographic authorization
address    → tells one protocol where value is controlled
```

## Check yourself

1. Which step of address derivation is chain-specific?
2. Why is a Bitcoin address not simply a public key?
3. How does a Solana PDA differ from a normal address?
4. What can a checksum not detect?
