# The Byzantine Generals Problem

> **Distributed agreement is hard because a faulty participant can send different lies to different peers.**

Imagine generals surrounding a city. They must all attack or retreat together, but communicate only through messengers. Some generals may be traitors who send conflicting messages.

The computer-science version asks how honest nodes can agree under a specified network model when messages may be delayed or reordered and faulty participants may send deliberately contradictory data. Whether messages may be lost forever is a separate model assumption.

## Byzantine means arbitrary

A crash fault is simple: a node stops responding. A Byzantine fault is broader: the node may equivocate, forge malformed messages, cooperate with attackers, or behave correctly only toward selected peers.

Digital signatures identify who signed a message and make equivocation provable. They do not tell the receiver which signed claim is true.

Consensus still needs quorum and timing rules.

## Quorum intersection

Classical Byzantine fault-tolerant protocols often require more than two-thirds of voting power for a decision and tolerate less than one-third Byzantine power.

The intuition is that two supermajority quorums must overlap. If honest participants do not sign conflicting decisions, that overlap prevents two incompatible values from both finalizing.

Once faulty or unavailable voting weight reaches the protocol's liveness threshold, it may stop progress even without creating a conflicting finalization. Exact quorum and fault bounds depend on the protocol and network assumptions.

## Blockchains add one more problem

Traditional BFT starts with a known validator set. A permissionless chain must also decide who receives voting weight. Without Sybil resistance, one attacker can manufacture thousands of identities and appear to be a majority.

Signatures reveal who said what. Consensus still has to define how much intersecting, weighted support is enough to make one decision canonical.

The guarantees always depend on limits for faulty weight and assumptions about eventual message delivery.

## Primary sources

- [The Byzantine Generals Problem](https://lamport.azurewebsites.net/pubs/byz.pdf) — the original formulation of agreement with faulty or malicious participants.
- [Practical Byzantine Fault Tolerance](https://pmg.csail.mit.edu/papers/osdi99.pdf) — a concrete quorum-based state-machine-replication protocol under Byzantine faults.

## Check yourself

1. How is a Byzantine fault different from a crash?
2. Why do signatures not solve agreement alone?
3. What does quorum intersection protect?
4. What extra problem does open membership create?
5. Two conflicting decisions each carry signatures from more than two-thirds of the same validator set. What must their signer sets reveal?

<!-- corepath:start -->

**Core Path 20/50** · [← The Role of Consensus](053-role-of-consensus.md) · [Sybil Resistance →](056-sybil-resistance.md)

<!-- corepath:end -->
