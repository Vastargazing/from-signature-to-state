# Stablecoin Swaps and Curve

> **A stable-swap AMM concentrates liquidity near equal prices, giving low slippage while assets remain close to their intended peg.**

## Why constant product is wasteful here

USDC and USDT are expected to trade near one dollar. A normal constant-product curve spreads liquidity across a huge price range, including prices such as 0.20 or 5.00 that are rarely useful in healthy markets.

Curve's StableSwap invariant blends two behaviors:

- near the peg, it behaves more like a constant-sum market with a flat price;
- far from the peg, it bends toward constant-product behavior so reserves are harder to drain completely.

An amplification parameter controls how strongly liquidity concentrates near balance.

## Low slippage has an assumption

The design is capital-efficient only when the assets deserve similar prices. If one stablecoin loses backing, arbitrageurs sell the weak asset into the pool and remove the strong assets.

LPs can end up holding mostly the depegged token. The pool did not fail mathematically; it executed its promise to trade near the assumed relationship.

## More than stablecoins

The same idea can serve assets expected to track one another, such as wrapped versions or liquid-staking tokens. Their peg mechanisms and redemption liquidity still differ, so “correlated” is not “risk-free.”

## Fees and gauge incentives

Swap fees compensate LPs, while governance-directed token emissions may attract liquidity to selected pools. These are separate return sources and can create competition for governance influence.

When evaluating a Curve-style pool, inspect the invariant, amplification, asset redemption, oracle assumptions, admin controls, and how quickly a broken peg could concentrate losses in LP reserves.

## Check yourself

1. Why is constant-product liquidity inefficient near a stable peg?
2. What happens to LP reserves when one asset depegs downward?
3. What does the amplification parameter influence?
4. Why must swap fees and token incentives be evaluated separately?
