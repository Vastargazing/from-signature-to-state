# How the Base Fee Responds to Block Utilization

> **Ethereum's base fee rises after blocks above the gas target and falls after blocks below it.**

## Target versus maximum

EIP-1559 gives execution blocks an elastic maximum and a target equal to half that maximum under its standard parameters.

```text
gas used = target → next base fee unchanged
gas used > target → next base fee rises
gas used < target → next base fee falls
```

The current block's base fee is determined from the parent block. A proposer cannot simply choose any value; nodes verify the formula.

## Bounded movement

At a completely full block, the execution base fee can rise by at most 12.5% for the next block. An empty block can lower it by up to 12.5%.

That makes the immediate range predictable. A wallet can set a fee cap high enough to survive several expected increases without agreeing to pay the full cap.

## Sustained demand compounds

The per-block change is bounded, but repeated full blocks compound:

```text
base × 1.125 × 1.125 × 1.125 ...
```

Fees can therefore rise quickly during persistent congestion. The mechanism seeks an economic clearing price; it does not hold fees near a human-friendly constant.

When demand drops, under-target blocks push the fee downward again.

## Why elasticity helps

The maximum lets a sudden burst use extra capacity immediately rather than forcing every transaction to wait. The higher following base fee then discourages sustained use above the target.

Elasticity smooths short spikes while targeting a lower long-run average load for nodes.

## Tips solve a different problem

The base fee expresses network congestion and is burned. The priority fee lets a sender compete for ordering and compensates the block producer.

A large tip cannot make a transaction valid when its max fee fails to cover the base fee.

## Check yourself

1. Which block's gas usage determines the current block's base fee?
2. What happens when gas used equals the target?
3. Why can a 12.5% maximum change still produce rapid fee growth?
4. What different jobs do base fee and priority fee perform?
