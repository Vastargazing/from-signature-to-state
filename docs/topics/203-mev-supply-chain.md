# Searcher, Builder, Relay, and Proposer

> **Modern Ethereum block production is a market: searchers find value, builders assemble blocks, relays broker bids, and proposers publish one block.**

## Searcher

A searcher monitors mempools and chain state for arbitrage, liquidation, mint, and ordering opportunities. It creates transactions or bundles with constraints such as “execute together in this order or not at all.”

Searchers compete on algorithms, latency, private order flow, and relationships with builders.

## Builder

A builder combines searcher bundles, private transactions, and public mempool transactions into a full execution payload. It simulates candidate blocks and bids part of their value to the slot's proposer.

The highest raw MEV block is not useful if invalid or delivered too late.

## Relay

As of August 2026, before the planned Glamsterdam upgrade, Ethereum Mainnet still uses an off-protocol PBS market in which a relay sits between builders and proposers. It receives blocks and bids, checks or gates builders under its policy, forwards blinded headers, and reveals the selected payload after the proposer commits.

This solves a fair-exchange problem but gives relays visibility and influence over censorship, timing, and builder access.

Glamsterdam is planned to introduce enshrined PBS (EIP-7732), moving payload-for-payment and builder/proposer coordination into consensus. That reduces the protocol's dependence on trusted third-party relays, although optional middleware may continue to offer extra services.

## Proposer

Ethereum consensus selects a validator to propose the slot. The proposer may choose the best relay bid through MEV-Boost or fall back to a locally built block.

It signs and broadcasts the beacon block; other validators verify the result. Outsourcing construction does not outsource consensus responsibility.

## Follow the information

```text
user intent → searcher → builder → relay → proposer → validators
```

Not every transaction visits every actor. Public transactions may go directly to builders; private systems may expose them only to selected participants.

The trust question is who sees transaction contents before commitment and who can withhold, copy, reorder, or censor them.

## Primary sources

- [Flashbots MEV-Boost](https://github.com/flashbots/mev-boost) — current builder, relay, MEV-Boost, and proposer message flow.
- [EIP-7732: Enshrined Proposer-Builder Separation](https://eips.ethereum.org/EIPS/eip-7732) — proposed protocol-native builder/proposer separation.
- [Ethereum roadmap](https://ethereum.org/roadmap/) — current upgrade scheduling and the placement of ePBS in Glamsterdam.

Last verified: 2026-08-22. Roadmap scheduling is not a protocol guarantee.

## Check yourself

1. Which actor discovers the MEV strategy?
2. Who assembles the complete execution payload?
3. What fair-exchange role does a relay perform?
4. Which actor is selected by Ethereum consensus for the slot?
