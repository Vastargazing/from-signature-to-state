# Probabilistic Finality

> **With probabilistic finality, reversal becomes less likely as more work or weight accumulates after a block.**

Return to the proof-of-work branch for a moment. Bitcoin does not mark a block permanently final at one protocol moment; nodes follow the valid chain with the greatest accumulated work.

Another branch can replace recent blocks if it later becomes heavier. As honest miners add more blocks above a transaction, an attacker must catch up from farther behind.

## Confirmations measure depth

A transaction in the latest block has one confirmation. Each new block above it adds another.

Under the usual assumption that an attacker controls a minority but nonzero share of hash power, more confirmations reduce the probability of a successful catch-up but do not create a protocol checkpoint. The practical risk depends on attacker hash power, network conditions, merchant assumptions, and transaction value—not only a magic confirmation number.

```text
more accumulated work after a block → lower practical reversal probability
```

## Temporary forks are normal

Two miners can find valid blocks nearly together. Different nodes see different tips first. Miners extend one branch, and eventually one gains more accumulated work. Transactions from the losing block may return to mempools or appear in the winning branch later.

This ordinary short fork is different from a protocol split. All nodes still apply the same rules and fork-choice rule.

## Finality is an application decision

A coffee payment may accept more risk than an exchange deposit or bridge transfer. Applications choose confirmation thresholds based on the cost of reversal and their ability to pause or recover.

“Six confirmations” is a common Bitcoin convention, not a universal consensus guarantee. A powerful attacker or severe partition changes the assumptions.

Proof-of-stake systems may add explicit economic finality checkpoints. Probabilistic head selection can still operate before that checkpoint, so one chain can expose several confidence levels.

The useful distinction is:

```text
included      → currently in the chosen chain
confirmed     → buried under more chain weight
final enough  → application accepts remaining risk
```

## Primary sources

- [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf) — the probability of an attacker catching up as confirmations accumulate.
- [Bitcoin Core chain selection](https://github.com/bitcoin/bitcoin/blob/master/src/validation.cpp) — adoption of the valid chain with the most accumulated work.

## Check yourself

1. Why is one Bitcoin confirmation reversible?
2. What makes reversal less likely over time?
3. Why are short competing branches normal?
4. Why is a confirmation threshold application-specific?

<!-- corepath:start -->

**Core Path 28/51** · [← LMD-GHOST and Casper FFG](063-lmd-ghost-and-casper-ffg.md) · [Economic Finality →](048-economic-finality.md)

<!-- corepath:end -->
