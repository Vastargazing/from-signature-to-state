# Schnorr Signatures and Taproot

> **Schnorr makes multi-party signing cleaner; Taproot lets Bitcoin hide unused spending conditions.**

BIP-340 defines Schnorr signatures over secp256k1, the same curve Bitcoin already used for ECDSA. It uses x-only public keys and fixed-size signatures.

Schnorr's important property is linearity: public keys and signature contributions can be combined using ordinary curve operations. This supports protocols such as MuSig, where several participants cooperate to produce one signature.

Naively adding keys is unsafe. A real multisignature protocol must bind participants and nonces to prevent rogue-key and related attacks.

## What Taproot adds

A Taproot output always has a tweaked output key and may also commit to a tree of scripts. It can therefore offer a key path and, when a script tree is present, one or more script paths:

```text
key path    → provide a valid BIP-340 Schnorr signature for the tweaked output key
script path → provide the script's witness arguments, reveal one script leaf, and prove its commitment with a control block
```

The key path is the expected case. Several participants can cooperate off-chain and create one signature that looks like an ordinary single-key spend on-chain.

A spender may intentionally use a script path—for recovery, a timelock, or another condition—even if a key path was originally possible. Only the selected leaf and its Merkle path are revealed; other alternatives remain hidden. The common key-path case is compact, while script-path spending reveals less than publishing every condition upfront.

## The privacy boundary

Taproot does not make Bitcoin anonymous. Inputs, outputs, amounts, and the transaction graph remain public. A script-path spend reveals the executed branch, and unusual behavior may still stand out.

It is also not used by every Bitcoin output. Legacy and SegWit v0 outputs keep their existing rules, commonly ECDSA. Schnorr applies when spending Taproot outputs under Taproot rules.

In Rust, a cryptography crate can verify the Schnorr equation, while a Bitcoin crate constructs the exact transaction digest being authorized. Both layers must be correct.

## Check yourself

1. What stayed the same when Bitcoin added Schnorr?
2. Why does linearity help multi-party signing?
3. How do Taproot's key and script paths differ?
4. Why does Taproot improve privacy without making Bitcoin private?
