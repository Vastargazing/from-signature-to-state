# Nakamoto Consensus

> **Nakamoto consensus combines proof of work, a heaviest-chain rule, and incentives so an open network converges without a fixed voter list.**

Miners build candidate blocks and compete by producing proof of work. A newly found block is gossiped; it is not automatically “the winner.” Nodes first validate it, then miners normally extend the valid branch with the greatest accumulated work in their current view.

## Agreement emerges over time

Two miners can find blocks nearly together, creating a temporary fork. Different nodes may see different tips first.

As more work lands on one branch, it becomes the canonical choice and the other branch is abandoned. Transactions gain confidence as additional blocks bury them.

This gives probabilistic finality rather than one instant finalization vote.

## Why the pieces belong together

Proof of work supplies scarce weight; the heaviest-chain rule tells nodes how to compare branches; rewards give miners a reason to extend the history other nodes will accept. Remove any one of the three and this convergence story changes.

Creating fake nodes does not add chain weight. An attacker's leverage comes from hash power and network position, not the number of identities it advertises.

## Incentives connect security to behavior

Block rewards and fees pay miners who extend valid blocks accepted by the network. Work on an invalid or losing branch is unlikely to earn spendable rewards.

Nodes still verify every block. Miners do not gain permission to change supply rules or spend invalid coins merely because they own hash power.

The mechanism is:

```text
proof of work → scarce proposal weight
heaviest chain → convergence rule
rewards       → incentive to extend accepted history
```

Security assumes honest mining controls enough work and blocks propagate well enough. That makes the production and cost of proof-of-work weight worth examining on its own.

## Primary sources

- [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf) — proof-of-work ordering, chain selection, confirmations, and the honest-majority security argument.
- [Bitcoin Core chain selection](https://github.com/bitcoin/bitcoin/blob/master/src/validation.cpp) — executable selection of the valid chain with the most accumulated work.

## Check yourself

1. What three pieces form Nakamoto consensus?
2. Why can honest nodes temporarily choose different tips?
3. Why do fake node identities add no chain weight?
4. A miner with majority hash power proposes a block that creates coins outside the supply rules. What do honest full nodes do?

<!-- corepath:start -->

**Core Path 22/50** · [← Sybil Resistance](056-sybil-resistance.md) · [Proof of Work →](058-proof-of-work.md)

<!-- corepath:end -->
