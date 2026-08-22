# Overcollateralization and Liquidations

> **Permissionless lending replaces identity-based credit with collateral that can be sold before the debt becomes undersecured.**

## Why borrowers post more than they borrow

A smart contract cannot collect wages or take a borrower to court. It protects lenders by requiring collateral worth more than the debt.

Each asset receives risk parameters such as loan-to-value and liquidation threshold. A borrower may be allowed to borrow $70 against $100 of collateral, then become liquidatable before the collateral falls all the way to $70.

The safety gap covers price movement, oracle delay, transaction latency, and the cost of selling collateral.

## Health factor

A simplified health metric is:

```text
risk-adjusted collateral value / debt value
```

When it crosses the protocol's liquidation boundary, anyone can call the liquidation function. Exact formulas and thresholds differ by protocol and version.

## The liquidation trade

A liquidator repays part or all of the borrower's debt and receives collateral worth slightly more. That bonus pays for gas, market risk, and competition.

The borrower loses the bonus and some position size but the protocol reduces dangerous debt. Liquidation is a solvency mechanism, not a punishment added after default.

## Where it fails

If collateral falls faster than liquidators can sell it, its oracle is wrong, or block space is unavailable, the position can become bad debt. Illiquid collateral may look valuable at an oracle price yet be impossible to sell at that price.

Governance therefore controls collateral factors, caps, oracle choice, isolation rules, and liquidation incentives. “150% collateralized” is meaningless without asking which price and how quickly the asset can be sold.

## Check yourself

1. Why can permissionless loans not rely on a borrower's identity?
2. Why is the liquidation threshold below maximum theoretical solvency?
3. What economic service does the liquidation bonus buy?
4. How can an apparently overcollateralized position create bad debt?
