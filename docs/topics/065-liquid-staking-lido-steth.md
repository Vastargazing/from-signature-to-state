# Liquid Staking: Lido and stETH

> **Liquid staking makes a staked position transferable, while adding protocol, market, and concentration risk.**

Native Ethereum staking puts ETH into validator machinery with protocol activation, withdrawal, and exit rules. A liquid-staking protocol tokenizes an accounted share of pooled or collateralized staking exposure so it can be transferred while the underlying validators remain subject to those rules.

With Lido, that token is stETH:

```text
submit ETH → mint stETH shares → buffer, withdrawals, and validator deposits
```

In Lido's core pool, submitted ETH mints stETH and may first sit in a buffer before the Staking Router allocates it to modules and validator deposits. Lido V3 can also account for external shares minted by overcollateralized stVaults, so not every unit of stETH supply is described completely by the simple deposit arrow above.

stETH rebases: balances normally change when oracle reports apply rewards, penalties, fees, withdrawals, and other protocol accounting. Wrapped stETH, or wstETH, keeps a fixed token balance while each wstETH represents a changing amount of stETH; internally it tracks the non-rebasing share relationship.

## A claim is not the underlying asset

stETH represents a share-based accounting claim within the Lido protocol, not title to a particular validator or fixed quantity of ETH. It depends on contracts, governance, staking modules or vaults, operator performance, oracle reports, collateral rules, and Ethereum's withdrawal path. It can trade above or below ETH on secondary markets.

Selling on a DEX and requesting protocol redemption are different exits. Market liquidity may disappear or reprice quickly during stress.

## Added risks

- smart-contract and governance failures;
- validator slashing or operator outages;
- oracle and accounting errors;
- withdrawal queues;
- DeFi liquidation when used as collateral;
- market-price deviation from ETH.

Staking yield compensates participation in a system with these risks. It is not risk-free interest.

## Concentration

Thousands of token holders can still route stake through one protocol's governance, operator set, oracle design, and contract controls.

Count who selects operators, who can upgrade contracts, which clients and clouds validators run, and how much stake follows one coordination system. Number of validator keys alone can hide common control.

Liquid staking improves accessibility and composability. Its network-level tradeoff is that a convenient token can concentrate decisions around a small set of control paths.

## Check yourself

1. What claim does stETH represent?
2. How does wstETH differ from stETH?
3. Why can market price differ from protocol redemption value?
4. How can many holders still create concentrated validation?
