# Lock-and-Mint and Burn-and-Mint

> **Lock-and-mint moves a backed representation between custody domains. Burn-and-mint moves one token supply between chains by destroying it here before creating it there.**

## Lock-and-mint

A bridge locks the canonical asset on its origin chain, then mints a wrapped representation on the destination:

```text
100 tokens locked on A → 100 wrapped tokens minted on B
```

Returning reverses the flow: burn the wrapped tokens on B, prove the burn to A, then unlock the originals.

The destination token is only fully backed while locked reserves remain secure and messages cannot be forged.

## Burn-and-mint

An issuer can deploy native versions of one asset on several chains. To transfer supply, it burns tokens on the source and mints the same amount on the destination.

No pool of that same token needs to remain locked on the source. Global accounting instead depends on the issuer and messaging system never minting without a valid burn.

This pattern is common for issuer-controlled stablecoins and omnichain token designs.

## Liquidity bridges are another model

A user may deposit into a liquidity pool on chain A and receive existing liquidity from a provider on chain B. Providers rebalance later.

That is not the same as canonical lock-and-mint. It adds inventory, pricing, and provider solvency constraints while offering faster delivery.

## Required protections

Every model needs source and destination identifiers, token mapping, amount normalization, nonce, recipient, finality policy, and replay protection.

Decimals deserve special attention. Converting an 18-decimal amount to a 6-decimal token can create rounding or overflow bugs if units are implicit.

The key invariant is global supply or backing: every destination claim must correspond to locked reserves, a proven burn, or already-funded destination liquidity.

## Check yourself

1. What backs a lock-and-mint wrapped token?
2. What event authorizes destination minting in burn-and-mint?
3. How does a liquidity bridge deliver assets without minting them?
4. Why must token decimals be explicit in cross-chain messages?
