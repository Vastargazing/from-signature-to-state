# Ethereum World State

> **Ethereum is a deterministic machine whose current world state maps addresses to accounts.**

Ethereum blocks commit to ordered transactions and other protocol inputs, such as withdrawals and system-level operations. Applying the block transition rules from genesis produces the current world state.

Each address maps to an account containing:

- a nonce;
- an ETH balance;
- a code hash;
- a storage root.

For a conventional EOA, code and storage are empty. For a contract, the code hash identifies its bytecode and the storage root commits to its persistent key-value storage. Authorization features such as EIP-7702 delegation mean “EOA always has empty code” is no longer a safe general rule.

## Transactions transform state

Each valid transaction runs against the state left by the previous transaction:

```text
state₀ + transaction₁ → state₁
state₁ + transaction₂ → state₂
```

The order matters. A swap can change a pool price before the next swap runs. A nonce changes before the next transaction from the same sender is valid.

Every correct execution client must apply the same rules and reach the same result. Consensus chooses the canonical block order; execution computes what that order means.

## Where application data lives

Ethereum does not have one protocol-level table for ERC-20 balances. A token contract stores balances inside its own storage. An NFT contract stores ownership there. DeFi positions may be distributed across several contracts.

Logs help applications discover activity, but logs are not readable by contracts as current state. Indexers turn history and logs into convenient query models.

## State is not history

Current state answers “what is true now?” Blocks contain the ordered protocol inputs, while receipts record transaction outcomes and logs. A regular full node may retain enough block history and recent state to validate the chain without serving every old state value directly.

The clean separation is:

```text
blocks and system operations = ordered inputs
execution rules              = transition function
world state                  = current result
```

This is why replaying every required transition from a trusted starting state can reconstruct later state, and why an execution bug can make two clients disagree even when they received the same blocks.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — account fields, world state, storage state, and the execution state-transition function.
- [Ethereum Execution Layer Specifications](https://github.com/ethereum/execution-specs) — executable state and transaction processing across network upgrades.

## Check yourself

1. What fields belong to an Ethereum account?
2. Why does transaction order affect the result?
3. Where are ERC-20 balances stored?
4. How are block history and world state different?

<!-- corepath:start -->

**Core Path 7/51** · [← Transaction Lifecycle](046-transaction-lifecycle.md) · [UTXO Model →](030-utxo-model.md)

<!-- corepath:end -->
