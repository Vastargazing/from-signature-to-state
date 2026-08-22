# Custodial and Non-Custodial Storage

> **Custody is a bundle of powers: who can move funds, who can block movement, and who can recover control when another party disappears.**

With a custodian, an exchange or service controls the signing keys or internal system that moves funds. The balance on screen may be a database entry—a claim on pooled assets—not a dedicated on-chain account controlled by the user.

Custody can provide account recovery, customer support, easy trading, and institutional controls. The tradeoff is counterparty risk: the service can freeze withdrawals, be hacked, misuse funds, fail, or be legally ordered to block access.

## Self-custody

With a non-custodial wallet, the user controls the keys or mechanism that authorizes transactions. No exchange permission is needed under normal protocol rules.

The operational burden moves to the user:

- lost keys may be unrecoverable;
- malware can create malicious transactions;
- phishing can trick the user into signing;
- backups and inheritance need a plan.

Self-custody is not the absence of all trust. Wallet software, hardware, RPC providers, smart contracts, and asset issuers can still fail. The narrower claim is that a custodian lacks unilateral signing authority.

## The boundary can be shared

Real systems sit between “company has one key” and “user has one seed.” A multisig may require several devices. An MPC wallet may split signing shares between a user and service. A smart account may use guardians, limits, and recovery delays.

Classify them by their rules:

```text
Can the provider move funds alone?
Can it block the user?
Can the user recover without it?
What happens if one party disappears?
```

“Not your keys, not your coins” is a useful warning. These questions are more precise.

A wallet may be an interface, a key manager, a signer, or a smart-account controller. Custody is determined by the underlying authorization and recovery rules, not by the app's label.

## Check yourself

1. What question determines custody?
2. Why can an exchange balance differ from direct ownership?
3. Which burden moves to the user in self-custody?
4. How would you classify a wallet requiring both user and provider to sign?
