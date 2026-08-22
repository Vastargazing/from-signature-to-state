# TWAP and Manipulation

> **A TWAP averages an on-chain market price over time, forcing an attacker to influence the market for a window instead of one instant.**

## From spot to average

A spot oracle reads the current pool price. If a protocol reads it after an attacker makes one large swap, the protocol may act on the manipulated value.

A time-weighted average price accumulates price observations and computes the average across a chosen interval:

```text
TWAP = time-weighted price over [now - window, now]
```

Protocols such as Uniswap record cumulative tick or price information so a consumer can derive the average without storing every trade.

## Why the attack becomes harder

Moving a deep pool for one block may be affordable with a flash loan. Holding it away from the external market for many blocks repeatedly invites arbitrageurs to trade against the attacker.

The attack cost grows with pool liquidity, window length, price displacement, arbitrage access, and trading fees.

## Not manipulation-proof

A TWAP from a shallow or inactive pool can still be cheap to move. A long window resists short attacks but responds slowly to a real crash. A short window stays fresh but gives less protection.

Block proposers or sequencers with ordering power may sustain manipulation more efficiently, especially when arbitrage transactions can be censored. Concentrated liquidity can also disappear from the active price range during stress.

## Integration details matter

Consumers must choose the correct pool, quote direction, decimals, observation window, minimum liquidity, and behavior when observations are unavailable.

Using several weak pools does not automatically create one strong oracle if the same capital can manipulate all of them.

TWAP is an economic defense: it raises manipulation cost. It is not a cryptographic proof that the average equals fair value.

## Check yourself

1. What attack does a TWAP make more expensive than a spot price?
2. Why does a longer window also create risk?
3. How can sequencer censorship weaken a TWAP?
4. Does a valid TWAP prove the economic price is correct?
