# The Merge

> **The Merge replaced Ethereum's Proof-of-Work consensus with the Beacon Chain's Proof of Stake without resetting execution state.**

## Two systems before the event

Before September 2022, Ethereum Mainnet had the familiar EVM state, accounts, contracts, and transactions secured by Proof of Work.

Separately, the Beacon Chain had run Proof-of-Stake consensus since 2020. It managed validators and attestations but did not execute Mainnet user transactions.

The Merge joined their responsibilities:

```text
Beacon Chain consensus + Mainnet execution state → PoS Ethereum
```

The Beacon Chain became Ethereum's consensus layer. Existing execution clients continued to execute EVM transactions, now receiving and validating payloads through consensus clients.

## What did not happen

Ethereum did not restart from genesis. Account balances, contract storage, transaction history, and applications continued across the transition.

Users did not need to convert “old ETH” into a new token. There was no official ETH2 coin created by The Merge.

The Merge also did not immediately enable validator withdrawals or make L1 transaction fees cheap. Withdrawals arrived with Shapella; rollup data scaling advanced with Dencun and later upgrades.

## What changed

Mining and PoW difficulty disappeared from canonical Ethereum. Validators now propose blocks and attest using staked ETH.

Energy consumption fell dramatically because security no longer required a continuous hash race. Issuance also changed because the protocol no longer paid PoW miners.

Execution and consensus became explicit client layers:

```text
execution client → EVM, transactions, state
consensus client → PoS, fork choice, finality
Engine API       → communication between them
```

A working node needs both sides.

## Why the name fits

The event was not “Ethereum 2.0 launching as a new chain.” It was the moment the existing execution history merged into the already-running PoS consensus system.

This preserved application continuity while replacing the engine securing new blocks—like changing an aircraft's engine in flight without replacing its passenger manifest.

## Primary sources

- [Ethereum.org: The Merge](https://ethereum.org/roadmap/merge/) — the execution/consensus-layer transition, preserved state, and features not delivered by the event itself.
- [Ethereum roadmap](https://ethereum.org/roadmap/) — activation dates and the sequence from the Beacon Chain through later upgrades.

Last verified: 2026-08-22.

## Check yourself

1. Which two pre-existing systems were joined by The Merge?
2. Did Ethereum reset balances or contract state?
3. Which client layer took over consensus?
4. Which commonly expected features did The Merge not itself deliver?
