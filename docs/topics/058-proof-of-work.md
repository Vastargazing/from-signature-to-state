# Proof of Work

> **Proof of work makes chain weight expensive to produce and cheap for everyone else to verify.**

A miner builds a candidate block header and changes a nonce or other adjustable data until its hash falls below the network target.

Under the hash function's security assumptions, each candidate behaves like a fresh random trial and no generally useful shortcut beats repeated attempts:

```text
hash(header) < target → valid proof of work
```

Checking the header's proof-of-work needs one hash and a target comparison. Validating the rest of the block still requires all normal consensus checks. Producing the proof may require trillions or far more attempts.

## What work proves

The proof shows that somebody spent expected computation on this exact block header. Because the header commits to the previous block and transactions, changing history requires redoing work for the changed block and catching up with the honest chain.

Nodes choose the valid chain with the greatest accumulated work, not simply the most blocks.

Proof of work does not prove that the miner is honest or that every transaction is fair. Nodes still reject blocks that violate consensus rules.

## Security and cost

An attacker seeking sustained reorganization or censorship needs a large share of hash power. Hardware, electricity, and lost honest rewards make the attack costly.

The same expenditure creates the main criticism: much computation is intentionally spent in the leader-selection race. Mining can also concentrate where energy, chips, financing, and pool infrastructure are cheapest.

## Difficulty keeps the clock stable

If total hash rate rises, valid hashes appear more often. The protocol periodically adjusts difficulty so average block production returns toward its target interval.

Individual discovery remains random. A ten-minute average does not mean a block arrives every exact ten minutes.

Nakamoto consensus uses work for proposal weight, but work is not the whole protocol. It buys probability of proposing; validation decides whether the proposal is allowed; accumulated work chooses among the allowed histories.

## Primary sources

- [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf) — hash-based proof of work, difficulty, chain weight, and the asymmetry between producing and verifying work.
- [Bitcoin Core proof-of-work implementation](https://github.com/bitcoin/bitcoin/blob/master/src/pow.cpp) — target validation and difficulty adjustment in executable consensus code.

## Check yourself

1. Why is work expensive to produce but cheap to verify?
2. What does a valid proof commit to?
3. Why can miners not change consensus rules?
4. A chain's total hash rate suddenly doubles. What changes before the next difficulty adjustment, and what should the adjustment restore afterward?

<!-- corepath:start -->

**Core Path 23/50** · [← Nakamoto Consensus](057-nakamoto-consensus.md) · [Proof of Stake →](061-proof-of-stake.md)

<!-- corepath:end -->
