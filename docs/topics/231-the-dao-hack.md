# The DAO Hack

> **The DAO attacker repeatedly withdrew funds through reentrancy because external payment happened before the contract reduced the caller's internal balance.**

## The mechanism

The DAO was an Ethereum investment organization launched in 2016. Its split and withdrawal logic sent ETH to a recipient before completing the accounting update.

An attacker used a contract whose fallback code reentered the withdrawal path. Each nested call saw the old credit and requested another transfer.

```text
check credit → send ETH → callback reenters → check same credit again
```

This became the canonical example behind checks–effects–interactions, though the full code and exploit involved more than one simple function.

## The damage extended beyond code

The funds moved into a child DAO with a waiting period, giving the community time to respond. Ethereum participants debated whether the chain should preserve the exploit result or change state through a hard fork.

The fork that returned funds continued as Ethereum. The chain preserving the original history continued as Ethereum Classic.

## “Code is law” met governance

Both chains followed explicit social choices about which rules and history their communities would support. The incident showed that protocol governance includes clients, validators, exchanges, developers, and users—not only contract bytecode.

The fork did not edit bytes in already produced blocks; it added an exceptional state transition under newly adopted rules. Immutability prevents one party from silently rewriting canonical history, but it does not make a community physically unable to adopt incompatible rules and split into two chains.

## Lasting lessons

External calls are adversarial control transfers. Large unaudited economic experiments amplify small code errors. Incident response and chain governance are part of the system long before anyone wants to use them.

The DAO hack matters because one contract bug triggered both an asset loss and a lasting split over Ethereum's governing philosophy.

## Primary sources

- [EIP-779: DAO Fork](https://eips.ethereum.org/EIPS/eip-779) — the exceptional state transition adopted by the ETH branch.
- [SEC report on The DAO](https://www.sec.gov/files/litigation/investreport/34-81207.pdf) — The DAO's structure, exploit, and response timeline.

Last verified: 2026-08-22.

## Check yourself

1. Which state update happened too late in The DAO?
2. Why did the child-DAO delay matter to the response?
3. What histories did Ethereum and Ethereum Classic preserve?
4. Why was this more than an application-level security incident?
