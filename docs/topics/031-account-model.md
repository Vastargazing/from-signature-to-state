# Account Model

> **An account chain updates named state objects: balances, nonces, code, and storage.**

Return now to Ethereum's model: its world state maps addresses to account records. An EOA carries a nonce and native balance; a contract can also have executable code and persistent storage. Newer authorization mechanisms can blur those categories without changing the basic address-to-state model.

A transfer looks like ordinary bookkeeping:

```text
sender.balance   -= amount
receiver.balance += amount
sender.nonce     += 1
```

The transaction does not point to particular coins. It identifies a sender and an optional destination, and execution determines all resulting state changes. The sketch omits gas charges and other protocol bookkeeping.

## The nonce orders actions

Each Ethereum EOA transaction carries a nonce equal to the sender account's current transaction nonce. If that value is 7, a transaction can be included from that sender only with nonce 7. Once a valid transaction is included, the sender's nonce advances to 8 even if EVM execution reverts; a transaction that fails preliminary validation cannot be included at all.

This prevents the same signed transaction from being applied twice and orders transactions from one account. In transaction pools, a transaction with nonce 8 may wait until nonce 7 is included; pool replacement rules are client policy, not an account-model consensus rule.

Applications sending concurrently must coordinate nonces. Two workers choosing the same value create replacements or conflicts.

## Contracts make accounts programmable

A contract call can read and update many storage slots, transfer assets, emit logs, create contracts, and call other contracts. Those dependencies are discovered during execution rather than listed completely in the transaction.

That makes application programming natural: state has a stable address and methods mutate it. It also makes parallel execution harder when calls may touch the same state.

## The balance is not the whole portfolio

An account's native-coin balance is protocol state. Token balances usually live inside token contracts. NFTs, lending positions, and LP shares live in still more contracts.

A wallet constructs the familiar portfolio view by querying and indexing many state sources.

The account model is therefore:

```text
address → current state
transaction → ordered mutation of that state
```

It is not “one database row per human.” One person can control many accounts, and one contract account can represent many users.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — account nonce, balance, storage root, code hash, and ordered account-state transitions.
- [Ethereum Execution Layer Specifications](https://github.com/ethereum/execution-specs) — executable account and transaction semantics.

## Check yourself

1. What state does an Ethereum EOA hold?
2. What two jobs does the nonce perform?
3. Why can contract execution complicate parallelism?
4. Why is a wallet portfolio larger than the native balance?

<!-- corepath:start -->

**Core Path 8/50** · [← UTXO Model](030-utxo-model.md) · [UTXO Model versus Account Model →](032-utxo-vs-accounts.md)

<!-- corepath:end -->
