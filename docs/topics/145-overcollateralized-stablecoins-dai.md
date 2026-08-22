# Overcollateralized Stablecoins: DAI

> **Much of DAI is generated as debt against overcollateralized Vaults, where liquidation protects the system when the safety margin disappears. PSM mechanisms also supply DAI against approved stablecoins near parity.**

## The vault model

A user locks an approved collateral asset in a Vault and generates DAI up to a collateral-specific limit.

```text
$150 collateral → borrow at most $100 DAI
```

The extra collateral absorbs price movement. To recover collateral, the user repays DAI debt plus accrued stability fees.

DAI is not a direct claim on one bank dollar. It is a liability of a governed on-chain collateral system.

## Liquidation

Oracles report collateral prices. If a Vault falls below its required collateral ratio, keepers can trigger liquidation. The protocol sells collateral to cover debt and a penalty.

Liquidation must happen before losses exceed the buffer. Fast crashes, oracle failure, network congestion, or weak auction demand can create bad debt.

## Maintaining the peg

Borrowing and repayment change DAI supply. Fees alter incentives to create it. Market operations and facilities that exchange DAI against approved stable assets provide direct liquidity near the target.

Governance adjusts collateral types, debt ceilings, liquidation ratios, fees, and other risk parameters.

## Decentralization is not binary

Some collateral can be decentralized crypto; some can be fiat-backed stablecoins or real-world-asset structures with custodians and legal claims.

Those additions may stabilize the peg and scale supply while importing issuer freezes, banking, governance, and regulatory risk.

The Maker system and its broader Sky-era governance have evolved, so a current risk assessment must inspect active collateral composition and contracts rather than rely on the original “ETH-backed DAI” story.

## The core difference

```text
USDC → issuer promises fiat redemption
DAI  → protocol manages collateralized debt and liquidations
```

DAI can still inherit USDC risk when USDC-backed mechanisms form part of its collateral or peg liquidity.

## Check yourself

1. Why must a DAI Vault begin overcollateralized?
2. What event triggers liquidation?
3. How do oracles enter the trust model?
4. Why can DAI inherit centralized stablecoin risk?
