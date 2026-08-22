# Coin Versus Token

> **A coin is native to a network's protocol; a token is issued and accounted for by logic running on a network.**

## Native coin

BTC is native to Bitcoin, ETH to Ethereum, and SOL to Solana. Base-layer rules define balances or UTXOs, issuance, fees, and transfers.

The native coin normally pays for block space and often secures consensus through mining rewards or staking.

## Token

An ERC-20 token is accounting inside an Ethereum contract. The EVM sees contract storage and calls; the token standard tells wallets how to interpret functions such as `balanceOf` and `transfer`.

```text
coin  → ledger rules built into the network
token → asset rules implemented on top of the network
```

Creating a token does not create a new independent blockchain. Its transfers inherit the host chain's execution and finality while adding contract, admin, and issuer risks.

## The boundary can be contextual

Wrapped BTC on Ethereum is a token representing a claim on BTC elsewhere. WETH is an ERC-20 token backed by native ETH locked in its contract.

An L2 may use ETH as its fee asset even though settlement occurs through Ethereum. Depending on the architecture, people may call it the L2's native gas token, but it is not newly issued by an ERC-20 contract on Ethereum.

Cross-chain bridges can create several token representations with the same ticker. Symbol and name do not establish origin or backing.

## Why the distinction matters

For a coin, inspect protocol issuance, consensus, and network governance.

For a token, additionally inspect:

- contract address and chain ID;
- mint, pause, blacklist, and upgrade powers;
- issuer or collateral backing;
- bridge or redemption mechanism;
- holder and liquidity concentration.

A token can be decentralized and useful; a coin can be centralized in practice. The label describes the accounting layer, not quality.

## Check yourself

1. Where are ERC-20 balances maintained?
2. Why does issuing a token not create an independent blockchain?
3. What makes WETH technically different from ETH?
4. Why is a ticker insufficient to identify a cross-chain asset?
