# Liquidity Pool and LP Positions

> **A liquidity provider owns a claim on changing pool reserves and earned fees—not a guaranteed amount of the tokens originally deposited.**

## Supplying the market

An AMM pool holds assets that traders exchange against. A provider deposits assets under the pool's ratio or position rules and receives an ownership record.

In a simple full-range pool, fungible LP tokens represent proportional shares. Owning 1% of the LP supply means a claim on roughly 1% of both reserves when withdrawing, after protocol-specific accounting.

Concentrated-liquidity positions are not interchangeable because each can have a different price range. They are commonly represented as unique positions rather than one fungible LP token.

## Where returns come from

Traders pay swap fees. An active LP position earns a share based on its liquidity and the protocol's fee accounting.

Additional token incentives may exist, but they are subsidies paid by someone—not trading revenue. A high displayed yield can come mainly from a rapidly issued reward token.

## What the provider is actually doing

As price changes, arbitrageurs trade against the pool. Its reserve composition shifts toward the asset that is falling in relative value and away from the one that is rising.

The LP therefore runs an automated market-making strategy. Fees compensate for inventory risk, adverse selection, smart-contract risk, and the opportunity cost of locked capital.

## Withdrawal is a state-dependent claim

Withdrawing burns or closes the ownership position and returns its current claim. In many fungible full-range pools, accrued LP fees are already reflected in the reserves; concentrated-liquidity designs commonly track fees owed to the position separately for collection. The result may differ greatly from the original deposit.

Always separate three numbers: value from market-price movement, value lost or gained through rebalancing versus holding, and fees or incentives earned.

## Check yourself

1. What does a fungible LP token represent?
2. Why are concentrated positions often non-fungible?
3. Are reward-token emissions the same as swap-fee revenue?
4. Why can an LP withdraw a different token mix than they deposited?
