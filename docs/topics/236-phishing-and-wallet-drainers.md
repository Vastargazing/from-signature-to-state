# Phishing, Wallet Drainers, and Blind Signing

> **Most wallet drainers do not crack private keys. They persuade the owner to sign a transaction, approval, permit, or delegation that grants the attacker valid authority.**

## The lure

Fake airdrops, support accounts, search ads, compromised frontends, and look-alike domains create urgency. The site asks the wallet to connect, then presents a signature.

Connecting alone usually reveals addresses. The dangerous step is approving an action whose meaning the user does not understand.

## What the signature may authorize

- transfer an NFT or token;
- approve an operator for all NFTs;
- grant a large ERC-20 allowance;
- sign a permit usable later;
- execute a smart-wallet batch;
- delegate EOA behavior through EIP-7702;
- authorize an off-chain marketplace order.

A message can move assets later even if it consumes no gas now.

## Blind signing

Blind signing means approving opaque hashes or undecoded calldata. A hardware wallet protects the key from extraction but will still sign what the user confirms.

Simulation and human-readable decoding help, yet a malicious contract can make behavior depend on changing state, caller, or later admin action.

## Reduce blast radius

Use separate wallets for storage and experiments, bookmark important sites, verify contract and spender addresses, avoid unlimited approvals, inspect simulation and token changes, and revoke permissions that are no longer needed.

Treat unsolicited support as hostile. Real teams do not need a seed phrase or private key to debug a transaction.

If compromised, stop signing from the suspected device, move unaffected assets through a clean environment when safe, revoke permissions, and assume every related account or session may be exposed.

The mental model: phishing attacks the authorization ceremony around cryptography, not the signature algorithm.

## Check yourself

1. Why can a zero-gas signature still drain assets later?
2. What does a hardware wallet protect, and what does it not?
3. Why do separate wallets reduce phishing damage?
4. Which secret should legitimate support never request?
