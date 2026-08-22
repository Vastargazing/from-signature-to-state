# Arbitrage and Liquidations as Beneficial MEV

> **Some MEV pays actors to repair protocol state: arbitrage aligns prices and liquidation removes unsafe debt. The competition can still create harmful side effects.**

## Arbitrage

Suppose ETH costs 2,000 USDC in one pool and 2,020 in another. A searcher buys from the cheap pool and sells to the expensive one.

Its profit comes from shrinking the inconsistency. After the trade, users see prices closer to the wider market.

AMMs depend on this behavior because their formulas know only reserves, not external fair value.

## Liquidation

When a loan crosses its risk threshold, a searcher can repay debt and claim discounted collateral. The bonus rewards fast action and protects lenders from a growing shortfall.

Without liquidation MEV, insolvent positions could remain until collateral no longer covers debt.

## Competition leaks cost

Many bots may detect the same opportunity. Only one wins; the rest can submit reverted transactions, raise priority fees, burden RPC infrastructure, or spam a sequencer.

The winning bot may also route collateral through shallow pools and move prices enough to trigger further liquidations.

Builder auctions can turn part of searcher profit into proposer revenue. Protocol auctions can instead capture or redistribute it to users, LPs, or a treasury.

## “Beneficial” depends on the baseline

An arbitrage can improve price consistency while extracting value from an LP trading at a stale price. A liquidation can protect lenders while penalizing a borrower.

The service is useful; its exact reward and ordering method may still be inefficient or unfair.

The right distinction is not good bot versus bad bot. Ask which broken state is repaired, who pays for the repair, and whether the reward exceeds the minimum needed for reliable execution.

## Check yourself

1. Why do AMMs need arbitrageurs?
2. Which risk do liquidators remove for lenders?
3. How can competition for one opportunity waste block space?
4. Why can useful MEV still transfer value unfairly?
