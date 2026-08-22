# The Oracle Problem

> **A blockchain can verify its own state deterministically. It cannot independently know the dollar price, weather, election result, or API response outside consensus.**

## Why contracts cannot call the internet

Every validating node must execute a transaction and obtain the same result. If a contract fetched a website, nodes could receive different answers, timeouts, or regional responses.

Consensus would split over something the blockchain cannot verify.

External facts must therefore enter through a transaction. An oracle is the mechanism that observes, aggregates, signs, or publishes that data in a form contracts can consume.

## The trust does not disappear

Cryptography can prove which oracle key signed a value. It cannot prove that “BTC is worth $70,000” is true in the real world.

The system still needs choices:

- which exchanges or sources count;
- how values are aggregated;
- how quickly updates arrive;
- who can add or remove publishers;
- what happens during outages or market disagreement.

This is the oracle problem: deterministic code must act on a claim whose truth originates outside deterministic consensus.

## The oracle becomes part of the protocol

A lending contract may be bug-free yet lose funds because its price feed is stale or manipulable. Its effective security is no stronger than the data path that controls borrowing and liquidation.

```text
external sources → publishers → aggregation → on-chain feed → protocol action
```

Each arrow has latency, permissions, incentives, and failure modes.

## No universal oracle

Different applications need different facts and timing. A slow robust average may suit collateral; a derivatives venue may need low-latency prices plus confidence bounds. A prediction market may rely on a named resolver because the event itself is ambiguous.

The honest question is not “is it decentralized?” but “which claim is being trusted, from whom, for how long, and with which fallback?”

## Check yourself

1. Why can an EVM contract not fetch a normal API during execution?
2. What can a signature prove about an oracle value?
3. Why is an oracle part of a lending protocol's security boundary?
4. Why can two applications need different oracle designs?
