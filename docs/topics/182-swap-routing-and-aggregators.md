# Swap Routing and Aggregators

> **A swap aggregator searches several pools and paths, then encodes the chosen route into one transaction with an enforceable minimum output.**

## Why routes matter

The direct pool between two tokens may be shallow. Trading `TOKEN → WETH → USDC` can return more than using the direct `TOKEN/USDC` pool even after extra fees.

An aggregator models pools as a graph, estimates execution across possible paths, and may split the order:

```text
60% → pool A
25% → pool B through WETH
15% → market maker quote
```

The best route depends on current reserves, fees, gas cost, token behavior, and order size.

## Quote versus execution

Route search usually happens off-chain. The resulting transaction calls a router that performs the swaps on-chain.

The quote is not a guarantee because state can change before inclusion. The user's minimum-output limit is the on-chain guarantee: either the route satisfies it or the whole transaction reverts.

## More integration, more surface

Aggregators may touch several protocols, approve helper contracts, unwrap assets, or use external market-maker signatures. A failure or malicious adapter in one route can threaten the transaction.

Unlimited token approval to an upgradeable router also outlives the current swap. Permit signatures and exact approvals reduce exposure only if their scope and spender are correct.

## Routing is an optimization problem

The largest gross output is not always best. An extra hop may add more gas than it saves. On L2, data cost and bridge state can matter; on Solana, account lists and compute limits matter.

A serious quote compares net output after all fees and gas, then simulates the exact transaction against recent state.

## Check yourself

1. Why can an indirect route beat a direct pool?
2. Where does route search usually happen?
3. Which value turns a quote into an enforceable execution limit?
4. Why might the route with the highest gross output be worse?
