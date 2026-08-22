# Blockchain Bridges

> **A bridge makes one chain act on a claim about another chain. Its security is the mechanism that proves that claim.**

## Chains do not read each other automatically

Ethereum consensus does not natively follow Solana, Bitcoin, or every L2. A destination contract needs evidence that an event—such as a deposit, burn, or message—became final on the source.

A bridge supplies that evidence and executes the corresponding action:

```text
source event → verification → destination message
```

The message can mint a token, release custody, call a contract, or change governance state.

## The verifier defines the bridge

Different bridges trust:

- a multisignature or validator committee;
- an external oracle network;
- an optimistic claim with a challenge window;
- an on-chain light client of the source consensus;
- the native proof system of an L2.

Two interfaces can both say “bridge USDC” while having completely different failure conditions.

## Why bridges become honeypots

A lock-and-mint bridge may custody enormous reserves in one contract. If an attacker forges one accepted message, it can mint unbacked claims or withdraw real locked assets.

The attack surface spans contracts on both chains, signature keys, relayers, finality assumptions, token mappings, upgrade admins, rate limits, and off-chain monitoring.

Bridge code must prevent replay, wrong-chain messages, duplicate execution, reorged deposits, and tokens with unusual transfer behavior.

## Liveness and safety differ

A verifier outage may stop withdrawals without stealing assets. A compromised verifier may authorize a false withdrawal. Emergency pauses improve containment but introduce an administrator able to halt users.

The correct review starts with four questions: what is being proven, who can forge it, how long finality takes, and what happens when message delivery stops?

“Trustless bridge” is not an architecture. Name the exact verifier and its assumptions.

## Check yourself

1. Why can one blockchain not simply read another's state?
2. Which component defines a bridge's security model?
3. How do safety failure and liveness failure differ?
4. Why does a bridge holding locked reserves attract attackers?
