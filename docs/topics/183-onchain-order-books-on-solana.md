# On-Chain Order Books and Solana

> **An on-chain order book stores bids and asks as blockchain state, then matches trades under deterministic price rules. Solana makes its frequent updates economically practical.**

## The book

Buyers place bids with a price and size; sellers place asks. When prices cross, the program matches orders, commonly using price priority and then time priority.

A limit order may remain open until filled or cancelled. Unlike an AMM, the protocol does not invent continuous liquidity from a reserve curve. It can trade only at prices and sizes makers actually posted.

## Why this is demanding

Order books generate many small state changes: insert an order, cancel it, consume matches, update balances, and maintain queues. On a low-throughput, high-fee chain, these operations can cost more than the trade is worth.

Solana offers fast blocks, low transaction costs, and an account model where programs declare the state accounts they will read or write. The runtime can execute non-conflicting transactions in parallel.

That combination supports central-limit-order-book protocols such as OpenBook as fully on-chain programs, alongside AMMs and hybrid venues.

## It is not a centralized exchange clone

The matching program and custody accounts are on-chain, but users still face transaction latency, failed inclusions, priority fees, frontends, and market-maker concentration.

Designs may also require keepers or permissionless crank-style transactions to process events. “On-chain” tells you where rules and state live, not that every operational role disappears.

## Rust lens

A Solana trading program receives all required market, order, vault, and user accounts in each instruction. Rust code must validate their owners, writable status, relationships, and derived addresses before changing the book.

The key contrast: AMMs store a pricing curve in reserves; order books store traders' explicit willingness to trade.

## Check yourself

1. What determines priority in a typical central limit order book?
2. Why are frequent order updates expensive on some chains?
3. How does Solana's declared-account model help parallel execution?
4. What fundamental source of liquidity differs between an AMM and an order book?
