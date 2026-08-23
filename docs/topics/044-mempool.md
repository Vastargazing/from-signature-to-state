# Mempool

> **A mempool is one node's temporary set of valid-looking transactions waiting for inclusion.**

When a node receives a transaction, it performs admission checks defined by protocol and local policy, stores the transaction if acceptable, and may gossip it to peers. A local block builder chooses from its pool; external builders and private order-flow systems may use different inputs.

There is no single global mempool. Nodes receive transactions at different times, apply different capacity rules, connect to different peers, and may use private order flow.

## Admission is not inclusion

A transaction in a mempool has not changed canonical state. It may be included, replaced, evicted, dropped, or become invalid before inclusion.

On Ethereum, transactions from one sender are ordered by nonce. A high-nonce transaction may wait behind a missing lower nonce. A new transaction with the same sender and nonce can replace an old one if it satisfies the node's fee policy.

Nodes also evict low-value transactions when memory limits are reached. “Pending” therefore means observed and retained locally, not promised.

## Builders choose order

Builders usually value fees, but ordering is also constrained by nonces, gas limits, validity, bundles, and MEV opportunities. Seeing a transaction first does not guarantee being executed first.

Public visibility enables bots to react before inclusion. That creates frontrunning, backrunning, and sandwich opportunities. Private submission hides order flow from the public pool but introduces trust in the private path.

## Rust lens

A transaction pool needs concurrent indexes by sender, nonce, hash, and fee; bounded memory; replacement logic; eviction; revalidation after every new block; and protection from spam.

The state can change under it. A transaction acceptable at admission may later become stale or unaffordable and be dropped. Separately, a transaction can remain consensus-valid and be included yet revert during EVM execution because contract state changed; that is an execution outcome, not the same as mempool invalidity.

Keep pending and canonical data separate in both code and thought. A mempool is one node's waiting room; a block is an ordered candidate for canonical execution.

## Primary sources

- [Geth transaction-pool implementation](https://github.com/ethereum/go-ethereum/tree/master/core/txpool) — executable admission, replacement, nonce ordering, and pool maintenance policy.
- [Bitcoin Core mempool policy](https://github.com/bitcoin/bitcoin/tree/master/src/policy) — a second implementation showing the boundary between local relay policy and consensus validity.

Last verified: 2026-08-22.

## Check yourself

1. Why is there no global mempool?
2. What can happen after a transaction is admitted?
3. How does nonce ordering block later transactions?
4. A node accepted Alice's transaction, but a competing transaction with the same sender and nonce entered the canonical block. What should the pool do, and why?

<!-- corepath:start -->

**Core Path 19/51** · [← Full Node](039-full-node.md) · [The Role of Consensus →](053-role-of-consensus.md)

<!-- corepath:end -->
