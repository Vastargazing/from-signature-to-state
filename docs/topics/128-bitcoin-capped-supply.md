# Bitcoin's Capped Supply

> **Bitcoin's current consensus rules make the block subsidy halve until it reaches zero, keeping total issuance below 21 million BTC.**

## The schedule

Bitcoin began with a 50 BTC block subsidy. Every 210,000 blocks, the subsidy is divided by two using integer base units:

```text
50 → 25 → 12.5 → 6.25 → 3.125 → ... → 0
```

The interval is measured in block height, not years. Ten-minute target blocks make it roughly four years, but real calendar dates vary.

Because satoshis are indivisible integer units, repeated halving eventually rounds the subsidy to zero. Summing all allowed subsidies produces the familiar cap just below 21 million spendable BTC.

## Cap does not mean circulating supply

Some bitcoin is provably unspendable or likely lost because keys disappeared. Some is held long-term or locked in scripts.

```text
issued supply ≠ liquid supply ≠ actively traded supply
```

The protocol does not know whether an untouched key is lost or patient. Supply dashboards therefore use definitions and assumptions.

## Security after subsidy

As issuance falls, transaction fees must become a larger part of miner revenue. The long-term security question is whether demand for scarce block space will support enough hash rate to discourage attacks.

A cap does not answer that question automatically. It trades ongoing monetary issuance for reliance on the fee market.

## Can the cap change?

Any developer can publish software with another schedule. Existing nodes would reject blocks violating the rules they currently enforce.

Changing Bitcoin's canonical cap would therefore require broad social and economic adoption of incompatible consensus rules. The barrier is not mathematical impossibility; it is independent validation and extremely strong coordination norms.

This is a stronger claim than “a maintainer cannot edit one variable,” and a more honest claim than “humans can never change it.”

## Primary sources

- [BIP-42: A finite monetary supply for Bitcoin](https://bips.dev/42/) — subsidy halving, integer behavior, and the finite issuance schedule.
- [Bitcoin Core validation code](https://github.com/bitcoin/bitcoin/blob/master/src/validation.cpp) — executable enforcement of block subsidy and fee limits.

Last verified: 2026-08-22.

## Check yourself

1. Why is Bitcoin's halving defined by height rather than date?
2. Why does the subsidy eventually become exactly zero?
3. How does issued supply differ from liquid supply?
4. What security question grows as subsidy revenue shrinks?
