# WBTC: Custodial Wrapped Bitcoin

> **WBTC is a tokenized claim on BTC held in custody. Ethereum contracts can verify the WBTC token, but not independently enforce control of the backing Bitcoin.**

## Minting and redemption

Authorized merchants facilitate customer flows. BTC is deposited under the custody system, then an equivalent amount of WBTC is minted on a supported smart-contract chain.

For redemption, WBTC is burned and BTC is released through the authorized process.

```text
BTC in custody ↔ WBTC in circulation
```

The target invariant is at least one BTC held for every WBTC claim, across the system's authorized deployments.

## What proof of reserves proves

Published Bitcoin addresses and on-chain WBTC supply let observers compare visible reserves with token liabilities. Mint and burn records add operational transparency.

This is stronger than an unauditable database, but it does not prove that keys cannot be compromised, assets cannot be frozen, legal claims are senior, or redemption will always be processed.

On-chain proof of reserves is evidence about balances, not a complete proof of custody solvency and governance.

## The trust stack

WBTC holders depend on:

- Bitcoin custody and key management;
- merchant and custodian procedures;
- mint and burn permissions;
- token contracts on each supported chain;
- governance and emergency controls;
- bridges used to move representations between chains.

Using WBTC as DeFi collateral adds lending-oracle and liquidation risk on top.

## Why it exists

Bitcoin's native UTXOs cannot be called by EVM contracts. An ERC-20 representation lets DEXs, lending markets, and vaults handle bitcoin-denominated value through standard token interfaces.

The convenience comes from changing the trust model: native BTC follows Bitcoin consensus and key ownership; WBTC follows those plus a custodial issuance system.

## Check yourself

1. What economic asset backs WBTC?
2. Can an Ethereum contract force the Bitcoin custodian to redeem?
3. What does on-chain proof of reserves fail to prove?
4. Which extra risks appear when WBTC is used as lending collateral?
