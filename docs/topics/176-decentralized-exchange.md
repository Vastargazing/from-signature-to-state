# Decentralized Exchange

> **A DEX is a set of contracts or programs that defines trade and settlement rules without requiring users to deposit into one exchange operator's private ledger.**

## The defining property

On a centralized exchange, users transfer assets into accounts controlled by the venue. Trades update its internal database; blockchain settlement happens mainly on deposits and withdrawals.

On a DEX, the user's signed transaction interacts with on-chain liquidity or orders. The chain executes the transfer under protocol rules, and the result becomes shared state.

## Several execution models

“DEX” does not imply one price mechanism:

- an AMM quotes against pool reserves;
- an order book matches bids and asks;
- an RFQ system obtains signed quotes from market makers;
- an aggregator routes across several venues.

Some computation may occur off-chain while settlement remains on-chain. The right question is which party can censor, change the price, or take custody—not whether every component runs in a contract.

## Users still trust code and assets

Self-custody before settlement does not make the trade risk-free. A user can approve a malicious router, receive a fake token, suffer price impact, be sandwiched, or interact with an upgradeable contract.

Frontends and token lists also shape what users see. A compromised website can construct a harmful transaction even when the underlying DEX contracts remain correct.

## Final settlement is the anchor

A credible description separates:

```text
discovery: where the quote or order comes from
execution: how matching and pricing happen
settlement: which program transfers the assets
```

DEX decentralization can differ at each layer. A centralized sequencer or frontend may influence access, while the settlement contract still enforces that a user receives at least the signed minimum amount.

## Check yourself

1. How does custody differ between a CEX and a DEX?
2. Must all DEX price discovery happen on-chain?
3. Which signed limit protects a swap from a worse execution price?
4. Why can a correct DEX contract still be reached through a dangerous frontend?
