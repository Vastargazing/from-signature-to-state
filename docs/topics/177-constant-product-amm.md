# AMM and the Constant-Product Formula

> **A constant-product AMM does not match buyers with sellers. It moves a price along a reserve curve: `x × y = k`.**

## The pool

Suppose a pool holds `x` ETH and `y` USDC. Ignoring fees, each swap must leave the product of reserves unchanged.

If a trader adds USDC and removes ETH, USDC becomes more abundant in the pool and ETH becomes scarcer. Each additional unit of ETH therefore costs more.

```text
before: x × y = k
after:  (x - ETH out) × (y + USDC in) = k
```

The reserve ratio gives the local price, but a real trade moves through many prices along the curve. This difference is price impact.

## Fees

The pool charges a fee on the input. Most of that fee accrues to liquidity providers according to the protocol's rules.

Because the fee stays with or is accounted to the pool, the effective reserve product grows over time. The simple equation explains pricing; exact implementation details determine rounding and fee accounting.

## Who keeps the price realistic?

The AMM does not know an external market price. If ETH is cheaper in the pool than elsewhere, arbitrageurs buy it until the reserve ratio approaches the wider market.

Arbitrage is therefore part of price synchronization. LPs pay for it indirectly when their pool trades at a stale price.

## The shape matters

The curve never offers the final unit of either reserve at a finite price. Small trades in a deep pool barely move the ratio; large trades in a shallow pool move it sharply.

The formula is deterministic, not predictive. It answers what price the pool will enforce for a trade—not what an asset is fundamentally worth.

## Check yourself

1. Does a constant-product AMM need a matching seller for each buyer?
2. Why does a large swap receive a worse average price?
3. What role do arbitrageurs play?
4. Does `x × y = k` tell the pool the external market price?
