# Logs and Events

> **An EVM log is receipt data for off-chain consumers; a Solidity event is a typed convention for creating that log.**

## What the EVM stores

`LOG0` through `LOG4` append a log entry during successful execution. Each entry contains:

- the emitting contract address;
- zero to four 32-byte topics;
- an arbitrary data byte string.

Logs are included in the transaction receipt and committed through the receipts root. If execution reverts, logs created in the reverted frame disappear too.

## Solidity events

Solidity normally places the hash of the event signature in topic zero:

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

The indexed `from` and `to` values become searchable topics. The unindexed `value` is ABI-encoded in the data section.

Dynamic indexed values such as strings are stored as hashes in topics, so an indexer can filter by a known value but cannot recover the original string from the topic alone.

## Why logs are useful

Wallets, explorers, and indexers use logs to build transaction histories, token balances, analytics, and application notifications. Bloom filters help nodes quickly identify blocks that may contain matching logs.

Logs are cheaper than persistent storage because contracts cannot later read historical logs through normal EVM execution. They are output for external observers, not a contract database.

## Events are not state

A token transfer should update its balance mapping; emitting `Transfer` alone does not move tokens. Conversely, changing state without the expected event may make off-chain systems miss the change.

Indexers must also handle reorganizations. A log from a removed block was once valid but is no longer canonical.

```text
storage → truth available to future contracts
logs    → indexed history for off-chain consumers
```

## Check yourself

1. Where are EVM logs recorded?
2. What does Solidity usually place in topic zero?
3. Can a contract query its old logs through normal EVM opcodes?
4. Why must indexers wait for confirmations or handle reorgs?
