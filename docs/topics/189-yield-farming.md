# Yield Farming and Liquidity Mining

> **Yield farming moves capital between protocols to collect fees, interest, and token incentives. The headline APY often mixes all three.**

## The incentive

A new protocol needs deposits and trading depth. It can distribute governance or reward tokens to suppliers, borrowers, or LPs.

This is liquidity mining: users provide useful on-chain liquidity and receive newly issued tokens according to program rules.

Yield farmers compare opportunities, deposit capital, claim rewards, sell or compound them, then leave when risk-adjusted return falls.

## Real yield versus subsidy

Separate return sources:

- borrowers pay interest;
- traders pay swap fees;
- a protocol treasury distributes incentives;
- the protocol mints new reward tokens.

Only the first two are direct usage revenue. Token incentives may bootstrap a market, but their value depends on buyers and future issuance.

## Why APY misleads

APY assumes compounding and often extrapolates a short observation window. Reward-token price, pool TVL, utilization, fee volume, and emission rate can all change immediately.

A 200% displayed APY can be negative after reward-token collapse, impermanent loss, gas, withdrawal penalties, or a contract exploit.

## Layered positions

A farmer may deposit LP tokens into another contract, borrow against the receipt, and stake the next receipt again. Each layer adds yield and another smart contract, oracle, liquidation rule, admin key, and exit constraint.

The transaction graph matters more than the dashboard label. Ask where the original asset sits and which exact sequence returns it.

## The mental model

Liquidity mining rents capital with token emissions. Sustainable yield must eventually be paid by real demand or an explicit subsidy source—not by the percentage shown on a website.

## Check yourself

1. Which yield sources represent direct protocol usage?
2. Why can token emissions attract only temporary liquidity?
3. What assumption makes a quoted APY fragile?
4. Why does stacking receipt tokens increase more than return?
