# Oracle Manipulation as an Attack Class

> **An oracle-manipulation attack makes a protocol accept a technically valid input that is economically false or unsafe.**

## The write-read-action pattern

Many attacks follow three steps:

1. influence the source market or reported value;
2. make the victim read it before correction;
3. borrow, liquidate, mint, or redeem at the distorted price.

If the profit from the victim exceeds the cost of moving the source, the protocol subsidizes the attack.

## Common weak sources

A protocol may trust:

- a spot price from a shallow AMM;
- one exchange or publisher;
- a stale feed after the real market moved;
- an LP-token formula that ignores unclaimed fees or donations;
- a vault share price that an attacker can inflate;
- mismatched decimals or inverted quote units.

Not every oracle attack involves an external provider. Any contract value used as authoritative pricing can act as an oracle.

## Flash loans and ordering

Flash loans let the attacker rent enough capital to move a source and unwind within one transaction. Transaction ordering lets a searcher place manipulation immediately before the victim action and reverse it after.

These tools expose the weak assumption; they are not the underlying validation error.

## Designing the defense

Match the oracle to the maximum extractable value. Use deep markets, time windows, independent sources, freshness and confidence checks, caps, delayed settlement, and emergency behavior.

Then test the complete economic path. A median of three sources is weak if all three ultimately read the same exchange or wrapped asset.

The core review equation is:

```text
cost to corrupt the input  versus  value extractable from the consumer
```

## Check yourself

1. What are the three phases of a typical oracle attack?
2. Why can a vault exchange rate act as an oracle?
3. What does a flash loan change about the attack?
4. Which comparison determines whether manipulation is economically attractive?
