# Issuance

> **Issuance is the protocol creation of new coin units, usually to fund security or distribute the asset.**

## Where new coins enter

In Bitcoin, the block subsidy creates BTC in a miner's coinbase transaction. In Proof-of-Stake Ethereum, consensus rewards increase validator balances.

```text
previous supply + newly created rewards = supply before burns
```

Fees are different. A fee normally transfers existing coins from users to producers or destroys them through burning. It creates no new units unless protocol rules explicitly say otherwise.

## Why issue coins

Early networks need a way to distribute their native asset and pay participants before fee demand is mature.

Issuance can subsidize:

- mining or validation;
- ecosystem treasuries;
- development or public goods;
- initial allocations and incentives.

Security issuance is not free. It dilutes existing holders' percentage of supply unless they receive proportional rewards or an equal amount is burned.

## Schedule versus rate

Bitcoin uses a block-height schedule whose subsidy halves every 210,000 blocks until it rounds to zero.

Ethereum's PoS issuance depends on protocol formulas and validator participation. More total active stake changes aggregate issuance and each validator's rate. It has no Bitcoin-style fixed cap.

Different mechanisms answer different goals: predictable scarcity, stable validator incentives, treasury funding, or adaptive security budgets.

## Gross and net supply change

Always separate issuance from net supply:

```text
net supply change = issuance - protocol burns
```

Ethereum can issue ETH to validators while total supply decreases during a period with larger fee burns. Saying “no inflation” would hide both flows.

Locked, vested, staked, bridged, and lost coins also affect tradable supply but are not necessarily issuance or burn.

## Governance still exists

A schedule is enforced by software that nodes choose to run. Changing it requires a consensus upgrade and social adoption, not permission from one API.

“Fixed by code” means current rules are explicit and independently validated—not that humans are physically unable to fork them.

## Check yourself

1. How does issuance differ from transaction fees?
2. Why can issuance be viewed as payment for security?
3. What is the formula for net supply change when burning exists?
4. Why is a coded issuance schedule still connected to governance?
