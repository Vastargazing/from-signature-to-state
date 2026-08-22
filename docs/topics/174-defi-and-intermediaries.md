# DeFi and the Removal of Financial Intermediaries

> **DeFi replaces some institutional discretion with public programs and collateral rules. It does not remove every intermediary or every form of trust.**

## What changes

A lending contract can hold collateral, calculate debt, and permit liquidation without a bank employee approving each action. A DEX can settle a trade from a user's wallet without taking custody first.

The core shift is from an institution's private ledger and policy to shared state and executable rules:

```text
request → institution decides → institution updates ledger

transaction → contract checks rules → blockchain updates state
```

Anyone able to submit a valid transaction can usually interact with the same contract interface.

## What remains

Real systems still rely on actors and services:

- developers write and upgrade contracts;
- governance changes parameters;
- oracles report external prices;
- liquidators keep loans solvent;
- frontends, RPC providers, and wallets provide access;
- stablecoin issuers and bridges may control underlying assets.

The difference is that many of these roles are explicit and separable. A user can inspect contracts or use another frontend, but cannot code away a centralized stablecoin issuer or a compromised upgrade key.

## New risks replace old ones

Bank credit risk may become smart-contract and collateral risk. Human review may become oracle dependence. Customer support may become irreversible execution. Open access may invite bots that exploit bad parameters immediately.

“Permissionless” also describes the protocol path, not every interface or asset. A website can block an address while the underlying immutable contract remains callable; an upgradeable contract may not remain immutable.

## The honest claim

DeFi makes financial rules composable, inspectable, and automatically settled on a blockchain. It reduces dependence on selected intermediaries, but its actual trust model is the sum of contracts, admins, data feeds, assets, and chain security.

## Check yourself

1. Which decision does a lending contract automate?
2. Why does an oracle remain an intermediary-like dependency?
3. Can a permissionless contract have a restricted frontend?
4. Which risks replace traditional institutional trust?
