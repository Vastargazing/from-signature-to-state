# Seed Phrase

> **A seed phrase can be a portable root backup. Rebuilding the intended wallet may also require its passphrase, derivation scheme, paths, and address formats.**

In a BIP-39 wallet, the words encode computer-generated entropy plus a checksum. The wallet combines them with an optional passphrase to produce a binary seed. An HD wallet then derives accounts and keys from that seed. “Seed phrase” is broader than BIP-39, however: not every wallet mnemonic follows this word list, checksum, or derivation process.

The phrase is not stored on-chain. A new device recovers the same keys because it repeats the same deterministic calculations.

## Backup, not password

A service password can normally be reset. A seed phrase directly regenerates signing authority, and no blockchain support desk can revoke a copied backup.

This creates two opposite failures:

- someone copies it: they can restore the wallet elsewhere;
- every copy is lost: the owner may permanently lose access.

A PIN protects one device. It does not neutralize a leaked seed phrase.

## The optional passphrase

BIP-39 supports an additional passphrase, sometimes marketed as a “25th word.” Every passphrase produces a valid but different wallet:

```text
correct words + wrong passphrase = different empty wallet
```

There is no error message revealing the intended passphrase. Losing it is equivalent to losing the wallet.

## A safe recovery model

- let a trusted wallet generate the phrase;
- record it offline and in order;
- protect it from theft, fire, water, and disposal;
- never enter it into a website or support chat;
- test recovery before depending on the backup;
- record any passphrase and derivation details needed later.

Informally splitting words between people often creates fragile recovery without sound threshold security. Use a designed secret-sharing or multisig system when shared control is required.

The one sentence to remember is:

> **The device is replaceable. The root backup is the wallet.**

## Check yourself

1. What do BIP-39 words encode?
2. Why is a seed phrase not a resettable password?
3. What happens when the optional passphrase is wrong?
4. Why is an untested backup only an assumption?
