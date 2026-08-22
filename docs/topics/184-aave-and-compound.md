# Lending Protocols: Aave and Compound

> **A lending protocol pools supplied assets, lets overcollateralized borrowers draw from them, and changes interest rates as pool utilization changes.**

## The shared mechanism

Suppliers deposit assets into contracts and receive an accounting claim. Borrowers post approved collateral, then borrow only within risk limits set for that collateral.

Interest is not paid from a guaranteed treasury yield. It comes mainly from borrowers. As more available liquidity is borrowed, the rate model usually raises borrow rates to attract supply and discourage further borrowing.

```text
suppliers → liquidity pool → borrowers
             ↑ interest ←
```

The protocol tracks debt continuously through indexes or exchange rates rather than sending a monthly invoice.

## Aave and Compound are families, not one design

Aave markets can support several supplied and borrowed assets, each with collateral, reserve, cap, and liquidation parameters. A user's combined position is summarized by metrics such as health factor.

Compound III centers each market around one borrowable **base asset**. Other supported assets primarily serve as collateral, while suppliers of the base asset provide borrowable liquidity.

Older protocol versions have different architecture. Saying only “Compound” without a version can hide important assumptions.

## What the interest rate does not cover

Suppliers face smart-contract risk, oracle failure, bad debt, collateral liquidity, governance changes, and token risk. A displayed supply APY can move immediately when utilization changes.

The supplied claim may be composable elsewhere, which adds another dependency layer. If it trades below the assets redeemable from the lending pool, the reason may be liquidity stress rather than a protocol-guaranteed discount.

## The key question

Do not ask only “what is the APY?” Ask who borrows, what collateral backs the debt, which oracle values it, when liquidation starts, and who absorbs a shortfall.

## Check yourself

1. Where does ordinary lending yield come from?
2. Why do rates rise when utilization becomes high?
3. How does Compound III's base-asset model differ from a broad multi-asset pool?
4. Which risks remain for a supplier despite overcollateralization?
