# Impermanent Loss

> **Impermanent loss is the value gap between providing liquidity and simply holding the same starting assets, measured at current prices.**

## Why it appears

In a constant-product pool, arbitrageurs continuously rebalance reserves as the external price changes. The pool sells some of the asset that rises and accumulates the asset that falls.

Consider a 50/50 pool with no fees. If one asset doubles relative to the other, the LP position is worth about 5.7% less than holding the original quantities at the new price.

The LP may still have a positive dollar return. Impermanent loss is a comparison with the hold strategy, not necessarily a loss against the original deposit value.

## “Impermanent” is a dangerous name

If the relative price returns to its entry level, the gap can disappear before fees. If the provider withdraws while the price remains changed, the difference is realized.

But waiting does not guarantee recovery. The price may never return, and the pool or token can fail first. “Divergence loss” is often the clearer mental model.

## Fees can offset it

LP performance is:

```text
current pool position + earned fees + incentives
versus
current value of simply holding the original assets
```

High volume can produce enough fees to beat the hold benchmark. High displayed APR does not prove that it will.

Concentrated liquidity magnifies both fee efficiency and inventory changes inside a chosen range. When price leaves the range, the position may become entirely one asset and stop earning fees.

## What to compare

Use the same starting capital, time, prices, and gas costs. Do not compare LP yield with cash while ignoring that the alternative was holding volatile tokens.

## Check yourself

1. What is the benchmark used to calculate impermanent loss?
2. Can an LP have impermanent loss and still be up in dollars?
3. Why is the word “impermanent” misleading?
4. Which revenues can offset divergence loss?
