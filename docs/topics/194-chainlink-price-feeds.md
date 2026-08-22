# Price Feeds: Chainlink

> **A Chainlink price feed is an on-chain aggregate produced from multiple data sources and oracle nodes—not a direct live query to one exchange.**

## The reporting path

Independent node operators observe market data from selected providers. They reach an off-chain report, sign it, and transmit the aggregated result on-chain through a feed contract.

Aggregation across data sources reduces dependence on one exchange; aggregation across nodes reduces dependence on one operator. It does not remove shared-source, governance, or software risk.

## When a price updates

Feeds commonly publish when price moves beyond a configured deviation threshold or when a heartbeat time elapses. This saves gas, but means the on-chain value is not a tick-by-tick market stream.

A consumer must inspect:

- the correct feed address for that chain and asset pair;
- the returned timestamp or round freshness;
- decimal precision;
- whether the answer is positive and complete;
- documented market hours and operating conditions.

Using `latestRoundData()` without a staleness policy turns a temporary oracle outage into permission to use an old price forever.

## Feed quality is specific

“Uses Chainlink” is not enough. BTC/USD, a thin token/USD pair, and a proof-of-reserves feed measure different things and can have different publishers, thresholds, and risks.

A protocol may also combine a market price with a token's internal exchange rate. If either leg fails, the derived price fails.

## The right fallback

Fallback logic should not blindly choose whichever feed gives the most convenient number. Pausing new borrowing while allowing repayment may be safer than switching to a manipulable DEX spot price.

The contract must define what “fresh enough” means for its own collateral volatility and liquidation latency.

## Primary sources

- [Chainlink Data Feeds documentation](https://docs.chain.link/data-feeds) — aggregation, proxy contracts, feed reads, and consumer responsibilities.
- [Chainlink feed directory](https://data.chain.link/feeds) — chain-specific addresses, decimals, deviation thresholds, and heartbeats.

Last verified: 2026-08-22.

## Check yourself

1. Why aggregate both data sources and oracle nodes?
2. What usually triggers an on-chain feed update?
3. Which returned field helps detect a stale answer?
4. Why is “we use Chainlink” an incomplete risk description?
