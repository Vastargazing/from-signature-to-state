# Algorithmic Stablecoins and the UST/LUNA Collapse

> **An algorithmic peg backed mainly by its own volatile token can become a death spiral: defending the stablecoin expands the token whose falling value was meant to absorb the loss.**

## The UST mechanism

TerraUSD, now USTC, targeted one dollar through conversion with LUNA.

Conceptually, the protocol allowed one UST to be exchanged for one dollar's worth of LUNA and vice versa:

```text
UST below $1 → buy UST → redeem for $1 of LUNA
UST above $1 → burn $1 of LUNA → mint and sell 1 UST
```

Arbitrage was expected to pull UST toward the peg. LUNA absorbed expansion and contraction.

## Where the backing came from

The system did not hold one independent dollar for every UST. Its defense depended on market demand and liquidity for LUNA, plus confidence that others would continue accepting the conversion.

High subsidized yields around UST increased demand and supply but also concentrated confidence in a fragile growth loop.

## The death spiral

When large UST selling broke the peg, arbitrage redemption created enormous amounts of LUNA.

```text
UST exits → LUNA minted → LUNA price falls
→ more LUNA needed per UST → supply explodes → confidence collapses
```

The theoretical one-dollar conversion lost practical value because LUNA's market capitalization and liquidity could not absorb the outstanding UST at stable prices.

Both assets collapsed in May 2022. The original chain became Terra Classic; a new Terra chain launched without the same UST relationship.

## The general lesson

An algorithm can move losses; it cannot create external collateral. Analyze:

- what asset absorbs redemptions;
- whether that asset's demand is independent;
- market depth during stress;
- redemption caps and timing;
- concentration of yield-driven demand;
- reflexive minting paths.

“Algorithmic” describes control logic, not guaranteed stability.

## Primary sources

- [Terra Ecosystem Revival Plan 2](https://classic-agora.terra.money/t/terra-ecosystem-revival-plan-2-passed-gov/18498/1) — the passed plan for a new chain without the algorithmic stablecoin.
- [Terra exchange migration guide](https://docs.terra.money/migration/exchange-migration/) — Classic/new-chain snapshots and the May 2022 launch schedule.

Last verified: 2026-08-22.

## Check yourself

1. What arbitrage was supposed to restore UST below one dollar?
2. Why was LUNA not independent collateral?
3. How did UST redemption expand LUNA supply?
4. What resource can an algorithm not manufacture during a run?
