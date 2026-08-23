# State and the State Transition Function

> **A blockchain is not merely a payment log but a state machine. A block does not contain the full resulting state: it supplies inputs and commitments, and every validating node computes the accepted result independently.**

## The picture

A bank statement and an account balance are different things. Given an initial balance and every accepted operation, you can reconstruct the current balance. The current balance alone cannot reconstruct the operations.

A blockchain orders and commits to the operations while validating nodes maintain their result. Nodes may prune old data, but the canonical state still follows from the initial state and accepted transitions. **History is what was accepted. State is what follows from it.**

## The formula

> **state′ = f(state, block)**

Three properties matter:

- **f is the same for everyone**—that is the protocol. There may be many implementations, but if two behave differently, the network splits; this is called a consensus bug.
- **f is deterministic**—the same input produces the same output, always and on every machine.
- **state is derived**, not negotiated.

> **Consensus chooses a shared, ordered history of valid blocks. The transition function turns it into shared state.**

Balances follow from the chosen history. An Ethereum block also commits to its resulting state, and a node rejects the block if its own result does not match. That commitment detects divergence; it is not a vote on balances.

## State is not stored in the block

A block body contains transactions—the main execution inputs. Its header also contains commitments to results, such as state and receipt roots, but not the full post-state itself.

An Ethereum execution block header contains `stateRoot`, a short fingerprint of the entire state after applying the block. It is a **commitment**—“this is the result I obtained”—not the state itself. Every full validating node maintains enough state locally to validate new blocks.

To learn a value, a client can maintain state by executing transitions, verify a proof against an authenticated commitment, or trust an RPC response. Ethereum and Bitcoin commit to different state models, so their native proof paths differ.

That distinction is unpacked in [State Commitments, Proofs, and Synchronization](../deep-dives/state-commitments-proofs-and-synchronization.md).

## Why f must be deterministic

Every validating node must obtain the same result; otherwise states diverge and the network splits. Hence the general rule:

> **Every operation must have exactly the same semantics on all nodes and platforms.**

That rules out several ordinary programming techniques:

- **No local random-number generator.** Randomness must arrive as shared protocol input. Ethereum exposes `PREVRANDAO`, but proposer influence and short-term predictability make it insufficient for high-value lotteries; stronger designs use mechanisms such as commit–reveal or VRFs.
- **No calls to external systems.** A contract cannot call an API for the dollar exchange rate. The only way to bring external data in is to submit it in a transaction, making it an input. This is why oracles exist (Part XV).
- **No system time.** Only the block timestamp, which is the same for everyone, is available.
- **No EVM floating point.** Contract arithmetic uses deterministic integer operations and explicit fixed-point conventions.

These restrictions are what make execution reproducible across machines.

## How it differs from a conventional database

It is tempting to say, “a blockchain does not write state.” That is false: the `SSTORE` opcode quite literally writes a value to contract storage.

The difference is not whether a write exists, but **who controls it**:

> **In a conventional database, a trusted server can execute an arbitrary `UPDATE`. In a blockchain, every change must follow from an agreed input and the rules of the transition function.**

No accepted input means no change. No rule allowing the write means no write.

The DAO hard fork from [Trustless](004-trustless.md) is called an **irregular state change** because clients applied a special transition at the fork boundary rather than deriving it from an ordinary transaction under the old rules. Doing that required new client code and ecosystem adoption—an appeal to the social layer.

## The cost

- state tends to grow unless explicit transitions clear it, and every full validating node pays to maintain current state;
- every full node executes each new block it accepts; synchronization may replay history or start from an authenticated recent snapshot;
- undeclared shared-state access limits parallel execution; systems such as Solana require transactions to declare account access in advance;
- randomness and external data need explicit input mechanisms, each with its own trust boundary.

## Primary sources

- [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf) — transaction ordering, UTXO validation, and reconstructing ownership history from authorized spends.
- [Ethereum Execution Layer Specifications](https://github.com/ethereum/execution-specs) — an executable state-transition definition for Ethereum blocks and transactions.

## Check yourself

1. Why is consensus about transaction order rather than balances?
2. What does an Ethereum execution block header contain: state or a commitment to it?
3. Why can a smart contract not fetch the dollar exchange rate itself?
4. What is an irregular state change, and how did clients apply The DAO change if it did not come from an ordinary transaction?
5. **Deep dive:** Name three ways to learn a balance. Which native proof path differs in Bitcoin, and why?
6. `PREVRANDAO` is identical for all nodes. Why is it still insufficient for a lottery?

<!-- corepath:start -->

**Core Path 3/51** · [← Web2, Web3, and the Architecture of a Dapp](101-decentralized-application.md) · [A Transaction and Its Fields →](007-transaction.md)

<!-- corepath:end -->
