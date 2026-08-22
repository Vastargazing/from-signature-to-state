# Fiat-Backed Stablecoins: USDT and USDC

> **A fiat-backed stablecoin is an issuer liability represented on-chain: the peg depends on reserves, redemption, banking, law, and contract controls.**

## Mint and redeem

In the primary market, an approved customer sends dollars to the issuer. The issuer mints corresponding tokens. On redemption, tokens are burned and fiat is returned under the issuer's terms.

```text
deposit USD → issuer mints stablecoin
redeem token → issuer burns token and sends USD
```

Arbitrage links secondary-market price to redemption. If the token trades below one dollar, eligible traders can buy and redeem it—when redemption remains available and economical.

USDT is issued by Tether; USDC by Circle. Their reserve composition, legal entities, eligible customers, fees, supported chains, and disclosure regimes differ.

## The trust model

Holders rely on:

- reserve assets existing and remaining liquid;
- custodians and banks honoring claims;
- issuer solvency and operations;
- accurate attestations or audits;
- legal enforceability and redemption eligibility;
- smart-contract and blockchain security.

Tokens can trade permissionlessly on-chain while direct fiat redemption requires identity checks, minimums, jurisdictional eligibility, and compliance.

## Centralized controls

Issuers can generally mint and burn and may freeze or block addresses under contract powers and legal obligations.

That control helps respond to theft and sanctions but means the asset is not censorship-resistant like native ETH. A finalized token transfer can remain on-chain while the recipient's tokens become frozen later.

## Peg is a market price

One-dollar backing does not force every exchange trade to equal exactly one dollar. Banking outages, reserve concerns, liquidity stress, and redemption friction can produce temporary deviations.

The credible phrase is “designed to be redeemable near one dollar under stated conditions,” not “one token is cryptographically a dollar.”

## Check yourself

1. What connects secondary-market price to the fiat redemption price?
2. Can every wallet holder necessarily redeem directly with the issuer?
3. Which centralized powers do fiat-backed issuers retain?
4. Why can a fully reserved token temporarily trade below one dollar?
