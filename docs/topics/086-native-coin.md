# A Network's Native Coin

> **A native coin is part of the blockchain's core accounting rules; a token is state managed by a program on that blockchain.**

Ethereum's native coin is ETH. Bitcoin's is BTC. Solana's is SOL.

## Built into the protocol

An Ethereum account's ETH balance is a field in Ethereum state. Moving ETH and charging gas are defined by the protocol and executed by every client.

An ERC-20 balance usually lives inside a smart contract mapping:

```text
native ETH balance → Ethereum account state
USDC balance       → storage inside the USDC contract
```

The EVM does not know what a contract's numbers represent. Token standards give applications a common interface.

## What the native coin does

A native coin commonly serves several protocol roles:

- paying transaction fees;
- rewarding block producers or validators;
- supplying stake or another security resource;
- denominating base-layer balances.

ETH pays gas because Ethereum rules say so, not because it implements ERC-20.

## Native does not mean application-free

Contracts can hold and transfer ETH. Wrapped ETH, or WETH, converts ETH into an ERC-20 representation so applications can use the standard token interface.

```text
ETH  → native protocol balance
WETH → contract-issued token backed by deposited ETH
```

WETH is designed as a redeemable contract claim on escrowed ETH, so the two are closely linked economically but remain different assets with different accounting and contract risk.

Bridged assets add another layer. “ETH” on another network may be a wrapped claim controlled by a bridge, not native Ethereum ETH. Always ask which chain defines the asset and what redemption path connects representations.

## Coin versus token is technical, not prestigious

A native coin can be poorly designed; a token can be highly valuable. The distinction tells you where the accounting and security rules live.

If an asset's ledger and issuance rules are implemented by deployed application code, it is a token even when widely used for fees or collateral. If the base protocol directly defines and maintains the asset, it is native; using it for fees or security is common but not part of the definition.

## Check yourself

1. Where does Ethereum store an account's ETH balance?
2. Where does an ERC-20 contract usually store token balances?
3. Why is WETH not literally the same state object as ETH?
4. What should you check when an asset is called ETH on another chain?
