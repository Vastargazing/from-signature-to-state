# Reading the Ethereum Roadmap

> **The Surge, Verge, Purge, and Splurge are problem areas, not sequential software releases with fixed completion dates.**

## Themes, not a waterfall plan

Ethereum's rhyming roadmap labels group goals, but work happens in parallel and designs change.

The Merge was a concrete past transition to PoS. The remaining labels describe continuing directions:

## The Surge

Scale Ethereum through rollups and much more data availability. Blobs, data-availability sampling, and related networking work let L2s publish more data without making every node store everything forever.

The goal is ecosystem throughput, not simply a huge L1 gas limit.

## The Scourge

Reduce centralization and censorship risks around block construction, MEV, staking, and transaction inclusion.

## The Verge

Make block verification lighter through better state commitments, witnesses, and succinct-proof work across execution and consensus. The direction is toward clients verifying chain correctness without every verifier holding and re-executing all underlying data.

Do not reduce “the Verge” to one permanent data-structure promise. The exact commitment design can change while the stateless-verification goal remains.

## The Purge

Remove old protocol complexity and reduce permanent storage obligations. History expiry, state-management work, and retiring legacy behavior make clients easier to run and maintain.

Purge does not mean deleting users' live balances. It means avoiding the requirement that every node preserve every historical artifact forever.

## The Splurge

A catch-all for improvements that do not fit elsewhere: account abstraction, cryptography, and EVM refinements.

## How to read current plans

Official roadmaps now also use named upgrade releases such as Dencun, Pectra, and Fusaka. A release can advance several themes at once; one theme can span many releases.

```text
theme   → why Ethereum is changing
EIP     → exact proposed rule
upgrade → coordinated delivery bundle
```

For engineering decisions, verify the current EIP status and scheduled upgrade. A roadmap diagram is direction, not a production guarantee.

## Primary sources

- [Ethereum roadmap](https://ethereum.org/roadmap/) — current named upgrades, their status, and the explicit warning that plans change.
- [Ethereum scaling roadmap](https://ethereum.org/roadmap/scaling/) — rollups, blobs, and the data-availability direction behind scaling work.

Last verified: 2026-08-22.

## Check yourself

1. Why should the roadmap labels not be read as sequential phases?
2. What is the Surge mainly trying to scale?
3. What shared goal connects the Verge and Purge to node accessibility?
4. How do a roadmap theme, an EIP, and a named upgrade differ?
