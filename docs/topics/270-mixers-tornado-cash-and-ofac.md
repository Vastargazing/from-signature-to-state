# Mixers, Tornado Cash, and OFAC Sanctions

> **A mixer tries to break the obvious link between deposit and withdrawal; it does not make law, metadata, or bad operational choices disappear.**

If Alice sends coins directly to Bob, the public ledger shows the connection. A mixer lets many users deposit into a common mechanism and withdraw without revealing which specific deposit funded which withdrawal.

Tornado Cash implemented this idea with smart contracts and zero-knowledge proofs. A deposit creates a private secret and an on-chain commitment. A later withdrawal proves that some valid commitment exists and has not already been spent, without identifying it publicly. A nullifier prevents the same deposit from being withdrawn twice.

The privacy comes from the anonymity set: the withdrawal could correspond to multiple deposits. Unique amounts, close timing, address reuse, relayer metadata, or later transparent activity can shrink that set.

## Technology and legal status are separate

Mixers have legitimate privacy uses, but stolen funds and sanctioned actors have also used them to obscure flows. That makes them a focus of money-laundering and sanctions enforcement.

In August 2022, the US Treasury's OFAC sanctioned Tornado Cash and listed associated addresses. After litigation and policy review, Treasury removed those economic sanctions and OFAC deleted the listings on March 21, 2025.

That delisting did not create a universal declaration that every mixer transaction is lawful. Money laundering, sanctions involving other parties, unlicensed-service rules, and local restrictions remain separate questions. The answer depends on jurisdiction, facts, counterparties, and current law.

## The useful mental model

```text
privacy protocol = hides a transaction link
compliance system = evaluates people, funds, and legal obligations
```

Neither substitutes for the other. Code may remain callable while interfaces, relayers, custodians, or users face legal obligations. Conversely, a legal status change does not alter what the immutable contracts technically do.

## Primary sources

- [OFAC: Tornado Cash designation removal, 21 March 2025](https://ofac.treasury.gov/recent-actions/20250321) — the SDN-list deletions and related update.
- [US Treasury: Tornado Cash delisting](https://home.treasury.gov/news/press-releases/sb0057) — Treasury's explanation of the decision and continuing sanctions-enforcement posture.

Last verified: 2026-08-22.

## Check yourself

1. What link does a mixer try to hide?
2. What does a Tornado Cash nullifier prevent?
3. Why can timing reduce an anonymity set?
4. What changed on March 21, 2025, and what did not?
