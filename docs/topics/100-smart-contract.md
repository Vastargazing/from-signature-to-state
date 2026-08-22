# Smart Contract

> **A smart contract is deterministic code at a blockchain address that can read and change shared state when execution reaches it.**

## What “smart” means here

A smart contract is not an AI agent and is not automatically a legal contract. It is a program executed under blockchain consensus.

On Ethereum, a deployed account holds runtime bytecode and persistent storage. A transaction or another contract supplies calldata; validating nodes execute the resulting call as part of the shared state transition.

```text
pre-state + call + bytecode → return data, logs, and new state
```

## What it can do

A contract can:

- enforce asset-transfer rules;
- maintain balances and permissions;
- call other contracts;
- create contracts;
- emit logs for off-chain systems;
- reject a call by reverting.

This makes contracts useful as shared backends for tokens, exchanges, lending, governance, games, and wallets.

## What it cannot do alone

A contract cannot fetch a web API or private database; an oracle or another transaction must bring external facts on-chain. It cannot wake itself up either. Some transaction or protocol operation must trigger execution, and someone normally pays gas.

## Deterministic does not mean correct

Consensus guarantees repeatable execution, not that the rules match the author's intention. A vulnerable contract may deterministically let an attacker drain it. “The transaction was valid” says nothing about business correctness.

## Immutable code, changeable systems

Runtime bytecode at an ordinary contract address is generally fixed. Storage can change, and the contract can call addresses containing other code.

Proxy patterns exploit this separation: users call a stable proxy whose storage remains, while an authorized upgrade changes which implementation code runs through `DELEGATECALL`.

So ask whether the contract is truly immutable, upgradeable, pausable, owner-controlled, or dependent on external contracts. The address alone does not answer that.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — message-call execution, state changes, logs, return data, and reversion.
- [Solidity documentation: Contracts](https://docs.soliditylang.org/en/latest/contracts.html) — contract functions, state, calls, creation, and high-level language semantics.

## Check yourself

1. What inputs determine a smart contract's execution result?
2. Can a contract fetch a web API directly?
3. Why can deterministic code still be vulnerable?
4. How can a system change behavior while its proxy address remains fixed?

<!-- corepath:start -->

**Core Path 35/50** · [← ABI and Function Selector](098-abi-and-function-selector.md) · [Creation Code and Runtime Code →](104-creation-code-and-runtime-code.md)

<!-- corepath:end -->
