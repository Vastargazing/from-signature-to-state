# Frontrunning in Contract Logic

> **If a pending transaction reveals the secret or opportunity needed to claim a reward, another caller can copy it and pay to execute first.**

## The mempool is public input

A contract offers a reward for submitting the answer to a puzzle. Alice broadcasts `claim(answer)`. A bot reads the answer from calldata, submits the same call with a better inclusion path, and receives the reward.

The contract may be perfectly deterministic. It simply rewards the first caller rather than the person who discovered the answer.

## Other forms

Ordering breaks applications when users reveal:

- an auction bid before bidding closes;
- a new token listing before its initial price is set;
- a liquidation or arbitrage opportunity;
- a username or NFT reservation;
- a governance action whose execution can be raced.

Slippage checks protect swap output; they do not protect every application-specific priority rule.

## Commit–reveal

Alice first posts a hash of her answer plus a private salt. After the commit phase closes, she reveals the answer and salt. The contract checks the hash and credits the original committer.

The salt prevents bots from guessing common answers. Deadlines and deposits handle users who commit but never reveal.

Commit–reveal adds latency and another transaction. It may still leak information during the reveal phase if actions are processed immediately rather than after all reveals.

## Other designs

Batch auctions give all orders in a window one clearing rule. Signed intents bind outcomes instead of paths. Private submission reduces public leakage but adds trust in the private path.

The core defense is to make copying calldata insufficient: bind authorization or reward to a prior commitment, signer, price limit, or fair batch rule.

## Check yourself

1. Why does a puzzle answer become stealable before inclusion?
2. What does the salt add to a commit hash?
3. Why can the reveal phase still need batch processing?
4. What property should copying calldata fail to copy?
