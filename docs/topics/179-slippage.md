# Slippage

> **Slippage is the gap between the price you expected and the price at which your trade actually executes.**

## Two sources

Your own trade can move the market. In an AMM, taking one reserve changes the pool ratio; larger orders relative to liquidity create greater price impact.

The market can also move after the quote but before inclusion. Other swaps, arbitrage, oracle updates, and reordered transactions may change available execution.

Price impact is therefore a predictable cause of slippage, but the terms are not identical.

## The minimum output

A swap transaction usually commits to a limit such as `amountOutMinimum`. If execution would return less, the transaction reverts.

The wallet often derives that number from a quoted output and a slippage tolerance:

```text
quote: 1,000 USDC
tolerance: 0.5%
minimum accepted: 995 USDC
```

Tolerance does not promise 0.5% slippage. It defines the worst result the user authorizes before reverting.

## Too tight and too loose

A very tight limit protects price but may fail in a moving market, still consuming gas. A very loose limit executes more reliably but grants searchers room to move the price against the trader, including through sandwich attacks.

Deep liquidity, smaller order size, split routing, private submission, and limit orders can reduce different parts of the problem.

## Token mechanics matter

Transfer-fee, rebasing, or unusual tokens can make quoted and received amounts diverge from standard assumptions. Routers must either support those mechanics explicitly or reject them.

The practical rule: never sign a swap without understanding the exact minimum received, deadline, route, and tokens involved.

## Check yourself

1. How does price impact differ from slippage?
2. What does `amountOutMinimum` enforce?
3. Why can a loose tolerance help a sandwich attacker?
4. Why may an extremely tight tolerance still cost gas?
