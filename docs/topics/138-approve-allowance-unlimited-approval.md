# Approve, Allowance, and Unlimited Approval

> **An ERC-20 allowance lets a spender pull tokens later; an unlimited approval turns one signature into an open-ended future capability.**

## The pull model

First, the owner sets an allowance:

```text
approve(router, 1,000)
```

Later, the router calls:

```text
transferFrom(owner, pool, 200)
```

The token checks the router's allowance, moves the tokens, and normally reduces the remaining allowance.

This lets a contract atomically pull payment while performing a swap, deposit, or repayment.

## Why unlimited approval is common

Approving `2^256 - 1` avoids another approval transaction for each use. Many implementations treat it as effectively infinite.

Convenience increases blast radius. If the approved contract is exploited, upgraded maliciously, or controlled by a compromised admin, it may pull every supported token up to the allowance without another wallet prompt.

Disconnecting a site from a wallet does not revoke on-chain allowances.

## The approval-change race

Changing a nonzero allowance directly to another nonzero value can be raced. A spender may use the old allowance before the update, then use the new allowance afterward.

Interfaces often set allowance to zero first or use increase/decrease helpers where supported. This reduces a known race but does not protect against a malicious spender while a nonzero approval exists.

## Safer habits

- approve only the needed amount when practical;
- verify spender address, chain, and purpose;
- review and revoke stale allowances on-chain;
- inspect whether the spender is upgradeable;
- use transaction-bounded transfer designs when available.

Revocation is another state-changing transaction and can arrive too late after compromise.

An approval is not a transfer, but it is authority to cause future transfers. Treat it like granting a limited key.

## Check yourself

1. Who calls `transferFrom` in the allowance model?
2. Why does unlimited approval reduce friction?
3. Why does disconnecting a frontend not revoke an allowance?
4. What race can occur when changing one nonzero allowance to another?
