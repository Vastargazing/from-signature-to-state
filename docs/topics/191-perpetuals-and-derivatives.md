# Perpetuals and On-Chain Derivatives

> **A perpetual contract gives price exposure without owning the asset and has no expiry; funding and liquidations keep that exposure economically anchored.**

## The position

A trader posts margin and opens a long or short notional position. Profit and loss follow the difference between entry and exit prices multiplied by position size.

Leverage means the notional is larger than margin. A 5% adverse move on 10× leverage can erase roughly half the margin before fees and exact protocol rules.

The trader owns a contractual claim against the venue's accounting system, not the underlying BTC or ETH.

## Funding

Because a perpetual has no expiry date that forces convergence, protocols use periodic funding payments between longs and shorts.

When perpetual prices trade above the reference index, longs typically pay shorts; below it, shorts pay longs. Funding encourages positions that pull the market back toward the index. It is not a guaranteed interest rate and can change sign.

## On-chain architectures

Protocols may use an order book, virtual AMM, liquidity vault, or hybrid off-chain matching with on-chain settlement. Oracles provide index prices, while separate mark-price logic may reduce manipulation of liquidations.

Each design distributes risk differently among traders, LPs, insurers, and governance.

## Liquidation and insolvency

When margin falls below maintenance requirements, bots or protocol logic close the position. Fast moves, oracle failures, or thin liquidity can produce losses larger than margin.

Insurance funds, partial liquidation, auto-deleveraging, or socialized loss mechanisms handle the remaining shortfall.

The credible comparison asks where matching occurs, who controls the sequencer, how prices are built, where collateral sits, and who absorbs bad debt.

## Check yourself

1. Does a perpetual long own the underlying asset?
2. Why are funding payments needed without an expiry?
3. How does leverage change the effect of a price move on margin?
4. Who may absorb losses when liquidation happens too late?
