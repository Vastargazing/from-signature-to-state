# Privileged Functions: Mint, Pause, and Upgrade

> **A contract's real trust model is the strongest action its privileged keys can perform, not the decentralization of its ordinary user functions.**

## Three major powers

**Mint** can dilute supply or create unbacked claims. A minter on a bridge or stablecoin may be able to turn one compromised key into assets accepted across DeFi.

**Pause** can stop transfers, deposits, or withdrawals. It limits damage during incidents but can censor users or trap positions during liquidation.

**Upgrade** can replace contract logic. An unrestricted upgrader can usually simulate every other privilege by installing code that transfers funds or rewrites accounting.

## Indirect privileges

Changing an oracle, fee recipient, collateral factor, router, implementation beacon, signer set, or role administrator can be as powerful as a direct withdrawal.

Follow privileges through every contract. A governance contract may look decentralized while an emergency council can replace it instantly.

## Scope and delay

Reduce blast radius with separate roles, mint caps, withdrawal limits, scoped pauses, allowlisted upgrade implementations, multisig thresholds, and timelocks.

Emergency power and delayed governance serve different needs. A fast pause may be justified; a fast arbitrary upgrade usually deserves stronger scrutiny.

## Transparency is not prevention

Publishing admin addresses lets users monitor actions. It does not stop a compromised admin. Verification, alerts, and clear runbooks shorten response time only if someone can act before irreversible damage.

When describing a protocol, state the capability plainly: “a 3-of-5 multisig can replace all logic immediately” is more useful than “community governed.”

The security question is what one successful privilege escalation buys the attacker.

## Check yourself

1. Why is upgrade authority often stronger than mint authority?
2. How can pause power harm users while preserving funds?
3. Which indirect parameter changes can become asset-control powers?
4. Does public monitoring prevent a malicious admin transaction?
