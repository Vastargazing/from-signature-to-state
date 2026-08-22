# Blockchain as a Special Case of DLT

> **A blockchain is a DLT in which records are grouped into blocks and linked by hashes. Hashes make tampering with the past visible, while consensus and fork choice determine which history the network treats as canonical.**

## The picture

Imagine a shared notebook. Records are not added one at a time: they accumulate and are periodically stitched into a page. At the top of every new page is the fingerprint of the previous one.

Forge a record on page 100, and its fingerprint changes; page 101 no longer matches, nor does any page after it. The past becomes inseparable: you cannot touch one record without affecting everything that follows.

But this does not stop forgery by itself—recomputing hashes is cheap. To have the forgery accepted, an attacker must build a different **valid** history and make the network choose it. The cost depends on the consensus mechanism: in one system the attacker must outpace everyone else in computation; in another, they must collect votes and put their stake at risk.

## What blockchain adds to DLT

[Distributed Ledger — DLT](001-dlt.md) says only one thing: participants verify records independently and assume that someone may lie. It says nothing about **how** history should be stored.

A blockchain provides three answers:

1. Records are grouped into **blocks** instead of being applied one at a time.
2. Consensus and fork choice select a **canonical linear order** from branches that may temporarily compete—once selected, “before” and “after” mean the same thing to everyone following that history.
3. Every block contains the **hash of the previous block**, so editing an old block breaks the entire chain after it.

The result is a canonical shared history. Hashes make a changed block visible; consensus makes an alternative history unacceptable or costly as long as the protocol's security assumptions hold. These are two different guarantees and should not be confused.

## How it differs from other DLTs

Not every DLT builds a chain of blocks:

| | Typical blockchain | Hedera hashgraph | Corda |
|---|---|---|---|
| Structure | chain of blocks | DAG of events | separate state records and transactions |
| Who validates or applies a record | full validating nodes | consensus nodes | parties required to see the transaction |
| Shared global state | typically yes | yes | no |
| Examples | Bitcoin, Ethereum | Hedera | Corda |

It is easy to confuse data structure with ordering guarantees. Hedera uses a DAG, but its consensus produces a **deterministic shared order** of transactions with consensus timestamps. In other words, “not a chain of blocks” does not by itself mean “no single ordering.”

A single order is not a luxury but a trade-off. It provides a simple shared state that can be verified in full. It also imposes a ceiling: in a classic monolithic blockchain, every **full validating node** checks every new state transition it accepts, so consensus work is replicated rather than divided among nodes—throughput is limited by the capabilities of an ordinary node. Initial synchronization is a separate issue: a full sync replays history from genesis, while snapshot-based modes may start from a recent trusted state. Light clients do still less work and rely on headers, proofs, and additional trust assumptions. This pressure leads to the scaling designs collected in [Scaling and L2s](../index.md#xii-scaling-and-l2s).

## A hash chain is not yet a blockchain

Git uses a content-addressed **Merkle DAG**: an ordinary commit points to one parent, while a merge commit may point to several. Replacing an old commit creates new descendant objects with new hashes. That does not make Git a blockchain.

What it lacks is a protocol-wide consensus rule that decides which branch is canonical and makes rewriting costly. A `git push --force` moves a branch reference to a different commit; it does not mutate the old commit objects, which may remain in other repositories. Git makes replacement **visible**, but not inherently **expensive**.

A blockchain adds precisely this to a hash chain: a rule for choosing one chain among several and a consensus mechanism that makes substitution invalid or unprofitable.

## The cost

- every full validating node must maintain enough current state to validate new blocks; whether it stores or re-executes complete history depends on its sync and pruning mode;
- a transaction waits for the next block—latency is built into the design;
- throughput has an upper bound and does not increase when more nodes are added;
- the more demanding it is to run a node, the fewer people will do so—and the less distributed the network becomes.

## Check yourself

1. Why does forging a block in the middle of the chain break everything that follows?
2. What does the hash chain provide, and what does consensus provide? Where is the boundary?
3. Git stores commit history as a Merkle DAG. Why does that not make it a blockchain?
4. Name a DLT that is not a blockchain. Does that mean it lacks a single transaction order?
5. What does a single global order provide, and what does it cost?
