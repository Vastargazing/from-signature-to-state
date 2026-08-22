# Push and Pull Oracles: Pyth

> **A push oracle pays to keep selected values current on-chain. A pull oracle lets the transaction bring a signed recent update when the value is needed.**

## Push

In a push model, oracle operators submit updates under rules such as a heartbeat or price-deviation threshold. Consumer contracts read the latest value already stored on-chain.

This is simple for the consumer, but updating thousands of rarely used feeds wastes block space. Fast markets also move between scheduled updates.

## Pull

Pyth publishers report prices, and its network aggregates them. An off-chain service distributes signed update messages. Anyone can attach a recent message to a transaction and update the on-chain Pyth contract before the application reads it.

```text
fetch signed update off-chain
          ↓
submit update + application call in one transaction
```

The user supplies delivery gas; the contract verifies authenticity and publication time. Pull does not mean the user chooses an arbitrary price.

## Confidence and freshness

Pyth reports a price plus a confidence interval representing publisher uncertainty or disagreement. Applications can reject prices with an interval too wide for their risk model.

They must also enforce maximum age. A correctly signed price from yesterday is authentic but unsafe for a liquidation today.

## Different failure surfaces

Push feeds may be stale between updates or unavailable when operators stop transmitting. Pull feeds depend on users obtaining and including an update, and a malicious user may choose among still-acceptable timestamps if rules are loose.

Both models depend on publisher quality, aggregation, governance, contract correctness, and the market definition behind the symbol.

The distinction is delivery: who pays to put which update on which chain, and at what moment?

## Primary sources

- [Pyth: Why update prices?](https://docs.pyth.network/price-feeds/core/why-update-prices) — fetching update data, submitting it on-chain, and reading a fresh price in the pull model.
- [Pyth price-feed best practices](https://docs.pyth.network/price-feeds/core/best-practices) — freshness, confidence intervals, and application-side checks.

Last verified: 2026-08-22.

## Check yourself

1. Who normally pays the on-chain delivery cost in each model?
2. Can a pull-oracle user invent the signed price?
3. What does Pyth's confidence interval communicate?
4. Why must a consumer check both authenticity and age?
