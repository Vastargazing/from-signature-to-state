# The Role of Consensus

> **Consensus makes many nodes converge on one ordered history even when messages are delayed and some participants misbehave.**

Replicating a ledger is easy if one trusted server decides the order. Remove that server and the hard question appears: when several valid blocks compete, which history should everyone build on?

Execution rules determine whether an execution payload and its resulting state are valid; the consensus protocol must not treat a known-invalid payload as a valid candidate. Among viable blocks, fork choice and finality determine which ordered history becomes canonical.

## The two goals

**Safety** means honest nodes do not finalize conflicting histories.

**Liveness** means the system continues making progress under its stated network and participant assumptions. Inclusion of any particular transaction additionally depends on fees, capacity, propagation, and censorship assumptions.

A protocol may protect safety during a partition by stopping finality. A protocol that keeps moving under every condition may risk different groups deciding different histories.

## The components

A blockchain consensus design usually combines:

- a way to propose blocks;
- a way to weight participants or proposals;
- validity rules;
- a fork-choice or voting rule;
- finality conditions;
- incentives and penalties;
- network timing assumptions.

In permissionless systems, the weighting rule also needs Sybil resistance: identity alone cannot carry voting power when identities are free to create.

## What consensus cannot promise

Consensus cannot guarantee that a valid transaction is fair, a contract is bug-free, an oracle reports reality, or most participants are honest. It provides guarantees only under its explicit assumptions.

It also cannot make all observers see new information instantly. Before convergence, honest nodes may temporarily hold different tips or mempools.

Execution rules reject forbidden payloads and transitions. Fork choice and finality select a canonical history among the viable candidates. Applying the state transition to that ordered history produces the state. Collapsing those three decisions into the word “consensus” hides where a client disagreement actually occurred.

Rust client work must preserve all three boundaries. A fast implementation that makes a different consensus decision is not an optimization; it is a fork bug.

## Check yourself

1. What does consensus order?
2. How do safety and liveness differ?
3. Why does an open network need Sybil resistance?
4. What application truths can consensus not guarantee?

<!-- corepath:start -->

**Core Path 20/51** · [← Mempool](044-mempool.md) · [Byzantine Generals Problem →](054-byzantine-generals.md)

<!-- corepath:end -->
