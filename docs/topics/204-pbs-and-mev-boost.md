# Proposer-Builder Separation and MEV-Boost

> **PBS separates profitable block construction from consensus proposal, letting ordinary validators sell their slot to specialized builders without running search infrastructure.**

## Why separate the roles

If validators must find MEV themselves, large operators with better algorithms and order flow earn more. Higher returns attract more stake, creating centralization pressure.

Under proposer-builder separation, builders compete to construct valuable blocks and bid for inclusion. The randomly selected proposer chooses a bid and receives much of the value regardless of its own search skill.

## MEV-Boost before ePBS

As of August 2026, MEV-Boost implements this market outside Ethereum consensus. A validator connects to relays and requests blinded block headers with bids.

After choosing and signing one header, it receives the full payload for broadcast. Blinding reduces the proposer's ability to steal the builder's strategy before commitment.

Relays are trusted middleware in this exchange. They mediate delivery, validate or police builder payloads, and can censor or fail.

## PBS is not MEV removal

Specialized builders may become concentrated because scale, latency, exclusive order flow, and sophisticated simulation improve bids. PBS distributes much builder revenue to proposers, but it does not guarantee fair transaction ordering.

It can also make censorship correlated when many proposers select blocks from the same small relay and builder set.

## Enshrined PBS

The Glamsterdam upgrade, planned for Q4 2026, is scheduled to introduce enshrined PBS through EIP-7732. It moves builder-proposer coordination and trustless builder payments into consensus, reducing reliance on trusted relays and giving payload propagation a longer window.

Until that fork activates on Mainnet, MEV-Boost remains an off-protocol PBS market. After activation, optional relays or middleware may still offer services, but they are no longer required for the protocol's basic payload-for-payment exchange.

## Primary sources

- [Flashbots MEV-Boost](https://github.com/flashbots/mev-boost) — the out-of-protocol proposer, builder, and relay flow.
- [EIP-7732: Enshrined proposer-builder separation](https://eips.ethereum.org/EIPS/eip-7732) — the consensus-level payload-timeliness and builder-payment design.
- [Ethereum roadmap](https://ethereum.org/roadmap/) — Glamsterdam scheduling and activation status.

Last verified: 2026-08-22.

## Check yourself

1. Why can self-extracted MEV centralize validators?
2. What does the proposer see before committing to a MEV-Boost bid?
3. Which trust does the relay introduce?
4. Does PBS eliminate MEV or fair-order transactions?
