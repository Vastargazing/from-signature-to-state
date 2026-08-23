# Full Node

> **A full node independently checks the chain's rules instead of trusting another server's verdict.**

A full node downloads blocks, validates their structure and consensus conditions, executes transactions when the protocol requires it, and maintains enough state to validate the next block.

It also participates in peer-to-peer networking and may expose RPC methods to local applications.

## Full does not mean “stores everything forever”

The word describes validation, not unlimited history.

An Ethereum full node can validate from genesis or a trusted synchronization starting point, maintain current state, and prune old state versions. It may keep block history while being unable to answer arbitrary old storage queries.

An archive node adds historical-state access. A light client verifies selected commitments with much less data. These are different data and trust models, not simply small and large editions of one node.

## Why run one

Using your own node reduces dependence on an RPC provider for chain reads, transaction submission, censorship resistance, query privacy, and protocol verification.

It does not remove all trust. The node trusts its software, configuration, checkpoint assumptions, operating system, hardware, and the protocol's cryptography. It can also be isolated from honest peers.

## A full node is not necessarily a block producer

A full node can verify blocks without proposing them. In proof-of-stake terminology, a validator adds duties such as attesting and proposing and may carry staking penalties; in proof-of-work, a miner produces candidate blocks. Be aware that some ecosystems also use “validating node” simply to mean a full node that validates rules.

Running a non-validating full node still matters: it lets the operator reject invalid chain data independently.

## Rust lens

Full-node engineering joins networking, execution, consensus interfaces, storage, synchronization, RPC, and observability. The main operational questions are whether the node is synced, which head it follows, what data it retains, and which APIs it exposes.

A full node's promise is narrow and valuable: give it candidate blocks and it will verify them itself. That independence is about validity, not perfect network visibility or unlimited historical storage.

## Primary sources

- [Ethereum.org: Nodes and clients](https://ethereum.org/developers/docs/nodes-and-clients/) — execution and consensus clients, validation, synchronization, and node roles.
- [Ethereum Execution Layer Specifications](https://github.com/ethereum/execution-specs) — the execution rules a validating node applies independently.
- [Ethereum consensus specifications](https://github.com/ethereum/consensus-specs) — consensus validation, fork choice, and finality rules.

Last verified: 2026-08-22.

## Check yourself

1. What makes a node “full”?
2. Why can a full node lack arbitrary historical-state queries?
3. How is a full node different from a validator?
4. Which trust dependencies remain when running your own node?

<!-- corepath:start -->

**Core Path 18/51** · [← P2P Network, Gossip, and Discovery](038-p2p-gossip-discovery.md) · [Mempool →](044-mempool.md)

<!-- corepath:end -->
