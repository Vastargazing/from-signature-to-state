# Liquidation Cascades

> **A liquidation cascade is a feedback loop: falling prices trigger forced sales, and those sales push prices low enough to trigger more liquidations.**

## The loop

Leveraged borrowers often use the same popular asset as collateral. When its price falls:

1. health factors decline;
2. liquidators repay debt and seize collateral;
3. seized collateral is sold for the debt asset;
4. those sales add downward pressure;
5. more positions cross their thresholds.

The original price move can therefore create a larger mechanical move.

## On-chain amplification

Liquidation bots compete for limited block space and DEX liquidity. During stress, gas or priority fees rise while AMM depth falls. Large liquidations receive worse execution and may leave bad debt.

If many protocols share the same oracle, collateral, and liquidity venues, failure is correlated. A price move in one pool can affect an oracle, then trigger borrowing liquidations that sell back into that pool.

## Self-liquidation and recursive leverage

Some users repeatedly supply an asset, borrow against it, buy more, and resupply. Their displayed collateral is large, but their net equity is small.

This recursive leverage makes a modest market move destroy the safety buffer quickly. Protocol TVL can count the same economic capital through several layers.

## Defenses

Protocols use conservative collateral factors, supply and borrow caps, isolated markets, robust oracles, partial liquidation, circuit breakers, and backstop funds.

These measures trade capital efficiency for survival. A high collateral factor attracts borrowing in calm markets but leaves less room during a fast crash.

The useful mental model is not “one loan failed.” It is a graph of loans, shared collateral, oracles, DEX liquidity, and bots all reacting at once.

## Check yourself

1. How can a liquidation itself lower collateral prices?
2. Why does shared collateral create correlated protocol risk?
3. How does recursive lending hide leverage behind high TVL?
4. What tradeoff comes with conservative collateral factors?
