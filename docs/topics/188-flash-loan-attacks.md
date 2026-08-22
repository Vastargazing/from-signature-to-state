# Flash-Loan Attacks

> **A flash loan usually does not create a protocol bug. It gives anyone enough temporary capital to exploit an existing economic or validation bug in one transaction.**

## The amplifier

Suppose a lending protocol values collateral using the current price in a shallow AMM. An attacker can:

1. borrow large flash liquidity;
2. trade against the shallow pool and move its spot price;
3. use the manipulated price to borrow or withdraw too much;
4. reverse trades and repay the flash loan;
5. keep the extracted value.

The vulnerable oracle is the root cause. The flash loan makes the attack permissionless and capital-efficient.

## Other root causes

Flash-funded exploits also expose:

- governance voting based on momentary token balances;
- incorrect share or exchange-rate calculations;
- donation and first-depositor attacks;
- reentrancy across composed protocols;
- liquidation formulas that trust manipulable prices.

Removing flash loans would raise the attacker's capital cost but not repair these assumptions. A wealthy attacker or off-chain loan could still exploit them.

## Atomic composition cuts both ways

The same composability that enables refinancing and arbitrage lets attackers chain many protocols without holding inventory. Every external call can become one step in an adversarial state transition.

Defenses include time-weighted or multi-source oracles, conservative limits, snapshots for governance, invariant checks, reentrancy protection, and testing against extreme temporary balances.

## The review question

Ask: “What becomes possible if an attacker can control any available token balance for one transaction?”

Do not assume capital scarcity is a security control. On a composable chain, temporary capital can be rented at protocol speed.

## Check yourself

1. What is usually the root cause of a flash-loan oracle exploit?
2. Why does banning flash loans not fully fix the bug?
3. Which governance design is vulnerable to temporary balances?
4. What adversarial assumption should a protocol review make about capital?
