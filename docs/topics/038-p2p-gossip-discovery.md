# P2P Networking: Discovery and Gossip

> **Discovery finds peers; gossip spreads new information through them.**

A blockchain node does not normally connect to every other node. It maintains a limited peer set and relies on the network to relay transactions, blocks, and consensus messages.

## Discovery

When a node starts, it needs addresses of possible peers. It may use hardcoded bootstrap nodes, a distributed discovery protocol, DNS records, or previously saved peers.

Discovery answers “who might be reachable?” It does not prove that a peer is honest. The node still performs handshakes, checks network and protocol identifiers, limits resources, and scores behavior.

## Gossip

When a node learns a new object, protocol-specific gossip rules decide whether and when it announces or forwards that object to peers. Recipients apply the required validation and may relay it further:

```text
origin → nearby peers → their peers → network
```

Gossip avoids a central broadcaster and tolerates peers going offline. Duplicate paths improve delivery but waste bandwidth, so protocols use message IDs, seen caches, topic subscriptions, and rate limits.

Nodes should perform cheap framing, size, duplicate, and basic validity checks before expensive processing, and must satisfy the protocol's gossip-validation rules before propagation. Validation is often staged because fully executing every item before relay would itself enable denial of service.

## The network view is local

Propagation takes time. Two honest nodes can temporarily know different transactions or competing blocks. A node's mempool is therefore not global state.

Peer selection also matters. In an eclipse attack, an adversary surrounds one node with controlled peers and filters its view. Diverse connections, peer rotation, inbound peers, and discovery sources make this harder.

## Rust lens

P2P code combines asynchronous I/O, binary codecs, connection limits, timeouts, backpressure, peer scoring, and hostile-input parsing.

The protocol must remain live under slow peers and bounded under floods. Memory safety helps, but a safe Rust program can still allocate without limit or let one peer monopolize work.

Discovery builds the peer graph; gossip moves protocol data across it. A node can succeed at one and fail at the other: finding peers does not guarantee that they deliver an honest or timely view.

## Primary sources

- [Ethereum devp2p specifications](https://github.com/ethereum/devp2p) — node discovery, RLPx transport, and capability-specific peer protocols.
- [Bitcoin P2P protocol documentation](https://developer.bitcoin.org/reference/p2p_networking.html) — peer messages, inventory relay, transaction propagation, and block propagation.

Last verified: 2026-08-22.

## Check yourself

1. What question does peer discovery answer?
2. Why does gossip intentionally create duplicates?
3. Why is one node's mempool only a local view?
4. What is an eclipse attack trying to control?
5. A node has eight peers, all controlled by one attacker, but every gossip message is syntactically valid. Which property has failed, and what can the attacker distort?

<!-- corepath:start -->

**Core Path 17/51** · [← Trustless](004-trustless.md) · [Full Node →](039-full-node.md)

<!-- corepath:end -->
