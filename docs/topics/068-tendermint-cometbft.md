# Tendermint and CometBFT

> **CometBFT commits a block after more than two-thirds of voting power precommits it in one round; one-third or more unavailable power can stop progress.**

CometBFT is the successor to Tendermint Core and is widely used with Cosmos SDK chains. It assumes a known validator set with voting power, commonly determined by stake.

## One consensus round

A height may contain several rounds. In each round:

1. a proposer suggests a block;
2. validators prevote;
3. validators precommit;
4. more than two-thirds voting power precommits one block, so it commits.

Locks and round changes prevent honest validators from finalizing conflicting blocks when less than one-third of voting power is Byzantine.

## Deterministic finality

Once committed, the block is final under the protocol assumptions. There is no normal “wait six more blocks because the heavier branch may win” behavior.

This is often called instant finality, though users still wait for proposal, network propagation, and the voting rounds. Final does not mean zero latency.

## The cost

If one-third or more of voting power is offline or refuses to participate, the remaining power cannot form the required greater-than-two-thirds quorum, so the chain can halt. This protects safety while fewer than one-third is Byzantine.

Safety can fail once Byzantine voting power reaches one-third: two conflicting commits imply at least one-third equivocated or otherwise violated the locking protocol. With more than two-thirds, malicious validators can form a commit by themselves. Either case can require application penalties and social recovery.

Communication also grows with validator participation, so these systems usually use a smaller active validator set than simple gossip-based PoW networks.

## Application boundary

CometBFT orders transactions and finalizes blocks. The application—often built with Cosmos SDK—decides whether transactions are valid and how they update state through the ABCI boundary.

```text
CometBFT → ordering and consensus
application → state-transition rules
```

## Check yourself

1. What vote commits a block?
2. Why is finality deterministic?
3. What happens when more than one-third is unavailable?
4. What does the application decide instead of CometBFT?
