# Time-Bandit Attacks

> **A time-bandit attack reorganizes recent blocks because stealing their MEV is worth more than honestly extending the current chain.**

## Reopening settled-looking history

Imagine a previous block contained a huge arbitrage. A validator or coalition can build an alternative history from before that block, replace the winning transactions with its own, and try to make the network adopt the fork.

This is not ordinary mempool frontrunning. The opportunity already appeared on-chain; the attacker travels backward through a reorganization to capture it.

## The economic test

The attacker compares:

```text
recoverable MEV
versus
lost rewards + missed bids + slashing or social cost + probability of failure
```

If isolated blocks contain extraordinary value, consensus incentives can become less stable. Other validators may join the more profitable fork, turning one extraction attempt into coordination failure.

## Why finality matters

Ethereum's fork choice can reorganize recent unfinalized blocks under network and validator conditions. Reverting finalized history requires far greater consensus failure and brings severe penalties and social response.

Applications therefore distinguish a fast inclusion confirmation from stronger economic or protocol finality.

## MEV and consensus are connected

MEV is often discussed as a trader problem, but time-bandit attacks show that enough execution-layer value can influence consensus behavior.

Proposer-builder separation can reduce a validator's need to perform complex extraction, yet builders still bid from expected MEV and extreme opportunities remain economically relevant.

Defenses include stronger finality, limiting extractable protocol value, auction designs that return value predictably, and avoiding application assumptions that one recent block is irreversible.

The key lesson: when a past block is worth more than chain stability, rational ordering competition can become reorg competition.

## Check yourself

1. How does a time-bandit attack differ from normal frontrunning?
2. Which costs must the attacker compare with captured MEV?
3. Why is a recent inclusion weaker than finality?
4. How can application-layer value threaten consensus incentives?
