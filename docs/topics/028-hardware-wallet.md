# Hardware Wallet

> **A hardware wallet keeps the private key inside a small signing device; it does not make every transaction safe.**

The wallet application on a computer prepares a transaction. The hardware device receives the signing payload, asks for approval, signs internally, and returns only the signature.

```text
computer builds transaction → device displays and signs → computer broadcasts
```

The private key should never leave the device. Malware on the computer can observe activity or propose a malicious transaction, but it cannot simply copy the key.

## The trusted display

An independent device display is a critical security boundary when the signer has one. Verify the destination, amount, network, and action there—not only on the computer that may be compromised. A screenless signer can still isolate keys, but transaction interpretation then depends on another trusted component. Even with a screen, firmware, transaction decoding, and device authenticity remain part of the trust boundary.

This becomes harder with smart contracts. A device may show raw calldata or “blind signing,” which asks the user to approve bytes they cannot understand. Transaction decoding and simulation help, but they depend on correct metadata and software.

The intended hardware-wallet property is that signing keys remain isolated and that the device signs only after its local policy or confirmation flow. The resulting blockchain signature, however, proves only this:

```text
the exact payload was signed by the key
```

It does not prove that a human reviewed the screen, that the display decoded the payload honestly, that a contract is safe, or that the address belongs to the intended person.

## The recovery secret remains critical

Many devices derive keys from recoverable seed material, but seedless and multisignature designs also exist. Where a recovery phrase is used, it can restore the wallet if the device breaks—and an attacker who obtains it can bypass the hardware entirely.

A PIN protects the physical device, not a leaked backup. An optional passphrase creates another wallet and must be backed up correctly.

## Remaining risks

- tampered device or unsafe initialization;
- malicious firmware or supply-chain compromise;
- physical extraction from a captured device;
- phishing and address substitution;
- approving dangerous contract permissions;
- losing both device and recovery material.

Buy through a trusted channel, initialize the device yourself, verify firmware and packaging as the vendor instructs, and test recovery before storing serious value.

## Check yourself

1. What information should never leave a hardware wallet?
2. Why is an independent device display useful, and what does it still not guarantee?
3. How can blind signing defeat the user's understanding?
4. Why does a hardware wallet not protect a leaked seed phrase?
