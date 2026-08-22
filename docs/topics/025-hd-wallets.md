# Deterministic Wallets: BIP-32, BIP-39, and BIP-44

> **One root can generate a tree of keys: BIP-39 creates the seed, BIP-32 derives the tree, and BIP-44 names common branches.**

These standards solve different layers:

```text
BIP-39 words + optional passphrase
              ↓
         binary seed
              ↓ BIP-32
     tree of extended keys
              ↓ BIP-44
coin / account / change / address index
```

People call every stage “the seed,” but the words, binary seed, master key, and derived private keys are different values.

## BIP-32: the key tree

An extended key contains a key plus a chain code. An extended private key can derive descendant private and public keys.

An extended public key can derive public keys along non-hardened branches without directly providing spending authority. Its standard mainnet BIP-32 serialization commonly begins with `xpub`, though wallets also use other version prefixes. This is useful for watch-only wallets and payment servers.

An extended public key is still sensitive: it can reveal an entire branch of addresses. A parent extended public key plus one corresponding leaked non-hardened descendant private key and its derivation path can also expose the parent extended private key. Hardened derivation prevents public-only child derivation by requiring parent private-key material.

## BIP-44: branch meanings

A common path looks like:

```text
m / purpose' / coin_type' / account' / change / address_index
```

The apostrophe marks hardened derivation. The path is a wallet convention, not a consensus rule.

Two wallets can use the same words yet show different addresses because their paths, address formats, or discovery rules differ.

## BIP-39: words to seed

BIP-39 encodes generated entropy and a checksum as words, then combines them with an optional passphrase to produce a binary seed. The words must come from strong randomness; inventing a memorable sentence creates a weak wallet.

Full compatibility needs more than the phrase:

```text
words + passphrase + derivation path + address format
```

## Check yourself

1. What separate job does each BIP perform?
2. What can an xpub do?
3. Why does hardened derivation exist?
4. Why can the same words restore different addresses in two wallets?
