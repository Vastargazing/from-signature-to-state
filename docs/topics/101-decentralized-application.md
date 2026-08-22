# Decentralized Application

> **A dapp uses smart contracts as a shared backend, but its full product usually includes ordinary off-chain components too.**

## The common architecture

A decentralized application often contains:

```text
browser or mobile UI
        ↓
wallet signs transaction
        ↓
RPC node sends it to the network
        ↓
smart contracts change state
        ↓
indexer serves readable history
```

The contracts are only one layer. Frontends, DNS, hosting, RPC providers, price feeds, databases, and analytics may remain centralized.

## What makes it decentralized

The useful test is not whether the landing page says “Web3.” Ask whether users can still use the protocol if one company disappears.

Strong properties include:

- contracts that anyone can call directly;
- public, verifiable state;
- user-controlled keys and assets;
- replaceable frontends and RPC providers;
- governance that cannot silently seize control;
- permissionless participation where the design requires it.

Decentralization is a set of failure properties, not a binary badge.

## Reads and writes differ

Reading state through `eth_call` usually requires no transaction or gas payment, because an RPC node simulates the call locally.

Changing state requires an included transaction or another on-chain operation. A wallet asks the user to authorize it, and the network charges gas.

An indexer may make complex reads fast, but its answer is derived data. Critical clients can verify it against RPC state, events, or proofs instead of treating the indexer's database as consensus.

## The frontend can lie

A malicious or compromised UI can request an approval to the wrong address, display fake prices, or hide contract powers. The wallet signature still authorizes the encoded transaction.

Open contracts do not make every access path trustworthy. Users need verified addresses, understandable signing prompts, and alternative interfaces.

## Better vocabulary

Instead of saying “the dapp is decentralized,” name the layer:

```text
contract execution is decentralized;
sequencing is centralized;
frontend hosting is replaceable;
oracle uses a committee.
```

That is credible engineering language.

## Check yourself

1. Which components commonly exist outside a dapp's contracts?
2. What test reveals whether one company is a critical dependency?
3. Why does an indexed read not automatically equal consensus truth?
4. Can a decentralized backend make a compromised frontend safe?
