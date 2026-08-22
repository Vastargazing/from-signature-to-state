# KYC, AML, and the Travel Rule

> **Public blockchains move value without asking for a passport; regulated intermediaries usually cannot.**

KYC, or Know Your Customer, is the process of identifying a customer and assessing relevant risk. AML, or anti-money laundering, is broader: it includes monitoring activity, keeping records, screening sanctions, investigating suspicious behavior, and reporting when local law requires it.

These duties usually attach to businesses such as exchanges, custodians, and other virtual-asset service providers—not to a blockchain protocol asking every validator to identify every address.

## The Travel Rule

The Financial Action Task Force applies payment-transparency principles to virtual-asset transfers. Under the Travel Rule, covered service providers and financial institutions must obtain, hold, and transmit specified information about the originator and beneficiary.

The identity data does not need to be written onto the public blockchain. Providers normally exchange it through separate compliance channels while the asset moves on-chain.

This creates a two-layer transfer:

```text
blockchain: address A sends assets to address B
compliance: provider A sends required party data to provider B
```

## FATF is not a world legislature

FATF publishes international standards. Countries implement those standards through their own laws, thresholds, definitions, and enforcement systems. Coverage and exact data requirements therefore vary by jurisdiction.

A transfer to a self-hosted wallet also differs from a transfer between two regulated providers. There may be no second provider to receive Travel Rule data, but the first provider can still have customer due-diligence, recordkeeping, sanctions, or risk-assessment duties.

## The real tension

Compliance systems try to connect legal identities to financial flows. Public blockchains expose flows but usually not legal names. Privacy protocols expose less of the flow itself.

That tension is why compliance cannot be reduced to “the chain is transparent” or “the address passed a screening score.” Analytics provide evidence; institutions still need policies, investigation, and legal judgment.

## Primary sources

- [FATF: Virtual assets](https://www.fatf-gafi.org/en/topics/virtual-assets.html) — VASP preventive measures and the originator/beneficiary information requirement.
- [FATF: Updated risk-based guidance for virtual assets and VASPs](https://www.fatf-gafi.org/en/publications/Fatfrecommendations/Guidance-rba-virtual-assets-2021.html) — the Travel Rule, unhosted-wallet boundary, and national implementation model.

Last verified: 2026-08-22.

## Check yourself

1. How is KYC narrower than AML?
2. Which entities usually carry these obligations?
3. Where is Travel Rule identity data normally transmitted?
4. Why do exact requirements differ between countries?
