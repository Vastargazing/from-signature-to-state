# A Block and the Transactions Inside It

> **The word “block” hides two different things: a small header containing commitments, and a body containing data. The chain is built from headers; bodies are attached to them.**

## The picture

Think of an inventory sheet and a box.

The box holds items—the transactions. The inventory fits on one sheet: which box this is, which box came before it, checksums of its contents, and its total weight.

The separation matters because nodes use the parts differently: headers link and commit; bodies provide the inputs that full nodes execute.

## Header and body are different things

| | Header | Body |
|---|---|---|
| Size | tens to hundreds of bytes | kilobytes to megabytes |
| Contents | commitments and parameters | transactions, stake withdrawals |
| What is done with it | linked into a chain and checked sequentially | processed under the protocol rules |
| What it enables | light verification—together with proofs and confirmation of canonicity | full re-execution |

A Bitcoin header is exactly 80 bytes and never changes size: version, previous-block hash, transaction-tree root, time, difficulty, and nonce. An Ethereum header is richer and gains new fields over time.

## What headers can prove

Headers are compact, but they prove less than a full node does.

With PoW, a header chain exposes links, header-level rules, and accumulated work. It does not prove that every body was available and valid because a header-only client does not execute those transactions.

With PoS, commitments in an execution header likewise do not establish canonicity by themselves. An Ethereum light client uses consensus-layer updates and sync-committee signatures to follow a finalized header.

Light verification therefore combines three claims: this header is canonical under the client's consensus assumptions, this root commits to the relevant data structure, and this item has a valid proof against that root.

## What an execution block header contains

The fields are easiest to read in groups based on their purpose.

**Link to the past.** `parentHash` is the hash of the previous block's header. This field alone turns the chain into a chain.

**Commitments to contents.** `stateRoot` (the state after applying the block—see [State and the State Transition Function](006-state-transition.md)), `transactionsRoot`, `receiptsRoot`, and `withdrawalsRoot`. Each is a cryptographic commitment: a short fingerprint that can prove one item without transmitting everything else.

The root names identify different committed data sets. A proof must use the exact tree and encoding rules for its root.

**Block economics.** `gasLimit` is the amount of work a block may hold, `gasUsed` is what it actually consumed, and `baseFeePerGas` is the base gas price (Part IX).

Post-Merge execution headers also retain fields whose proof-of-work meanings were disabled. Format compatibility can outlive the semantics that created a field.

Ethereum's two block layers, exact root families, frozen PoW fields, and resource ceilings are separated into [Ethereum Block Layers, Roots, and Limits](../deep-dives/ethereum-block-layers-roots-and-limits.md).

## The body: not just a list

Ethereum transactions are committed through an authenticated Merkle–Patricia trie whose root is stored in the execution header. The practical consequence is that a proof can bind a transaction to that root without sending the entire block; the exact encoding and proof format matter.

Not everything referenced by a block is stored inside it. A block does not contain EIP-4844 blob data: the transaction contains versioned hashes derived from KZG commitments, while blobs, commitments, and proofs are transmitted separately in sidecars and retained for a protocol-defined limited period (Part XII).

## Transaction order becomes shared history

From [State and the State Transition Function](006-state-transition.md): state follows from an ordered history. Therefore, **order within a block is not a packaging detail but part of the result.**

Consensus does not sort the transactions. A builder chooses an order, a proposer proposes the block, and validating nodes reject it if that order produces an invalid result. If the block becomes canonical, the chosen order becomes part of the history every node replays.

This gives rise to all of Part XVI: placing one's own transaction before or after someone else's has value, and that value is called MEV.

It also creates a censorship boundary: builders select from the order flow they see, while proposers decide which available payload to propose.

## The cost

- a block does not appear instantly: there is always a wait between submission and inclusion, built into the design;
- a higher `gasLimit` means higher throughput and a heavier burden for full nodes—the trade-off from [Centralization, Distribution, and Decentralization](003-centralization-decentralization.md);
- the block builder decides what to include and in what order, giving it economic leverage;
- headers may outlive separately propagated data they reference, such as time-limited blob sidecars.

## Primary sources

- [Ethereum consensus specification: Bellatrix](https://github.com/ethereum/consensus-specs/blob/master/specs/bellatrix/beacon-chain.md) — beacon blocks and their execution payloads.
- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — execution block headers, transaction and receipt tries, gas accounting, and state transition.
- [EIP-7934: RLP Execution Block Size Limit](https://eips.ethereum.org/EIPS/eip-7934) — the encoded execution-block ceiling introduced with Fusaka.

Last verified: 2026-08-22.

## Check yourself

1. What does a chain of PoW headers prove, and what does it not prove?
2. **Deep dive:** How does a beacon block differ from an execution block, and what does each layer's similarly named state root commit to?
3. What do `stateRoot`, `transactionsRoot`, and `receiptsRoot` have in common, and how do they differ from an ordinary data field?
4. **Deep dive:** Why do execution block headers still contain `difficulty` and `nonce` long after Proof of Work was disabled?
5. Why is transaction order within a block not merely a packaging detail?
6. **Deep dive:** How do Ethereum's execution-gas, blob-gas, and encoded-size limits differ from Bitcoin's block-weight limit?

<!-- corepath:start -->

**Core Path 4/50** · [← A Transaction and Its Fields](007-transaction.md) · [Transaction Lifecycle →](046-transaction-lifecycle.md)

<!-- corepath:end -->
