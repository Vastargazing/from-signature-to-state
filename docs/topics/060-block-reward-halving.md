# Block Reward and Halving

> **A miner's block income combines new issuance and transaction fees; halving reduces only the issuance part.**

Bitcoin's protocol allows a valid block's coinbase transaction to claim no more than the permitted subsidy plus the block's transaction fees. Those fees are the differences between non-coinbase transaction inputs and outputs; the coinbase output becomes spendable only after its maturity period.

```text
maximum coinbase claim = block subsidy + transaction fees
```

The subsidy introduces new bitcoin according to a known schedule. It is not created at a central bank's discretion, but nodes still enforce the rule by rejecting blocks that claim too much.

## Halving

At each 210,000-block subsidy interval, Bitcoin halves the per-block subsidy, rounding down to whole satoshis. Because block time is probabilistic, the calendar date is estimated rather than fixed.

Halving does not halve account balances, transaction fees, hash rate, or price. It changes the amount of new BTC a miner may claim per block.

## The security-budget question

Proof of work needs miners to spend real resources. Their incentive comes from block revenue. As subsidy declines, fees are expected to become a larger part of that revenue.

The long-term question is whether fees provide enough security budget to support sufficient hash power. There is no rule saying price or fees must rise after a halving.

If revenue falls, inefficient miners may leave. Difficulty later adjusts to the remaining hash rate, restoring average block timing but not automatically restoring the old attack cost.

## Supply schedule versus monetary certainty

The schedule is highly predictable under current consensus rules. It is still software enforced by nodes and social agreement around those rules—not a physical law.

The useful distinctions are:

```text
subsidy → newly issued coins
fees    → existing coins paid by users
reward  → both together
```

## Check yourself

1. What two parts make up miner block revenue?
2. What exactly does halving reduce?
3. Why does difficulty adjustment not restore the security budget?
4. Who enforces the issuance limit?
