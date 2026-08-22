# Safe and Smart Wallets in Production

> **A smart wallet is a contract that owns assets and enforces authorization rules. Safe is the best-known production example, not a synonym for the whole category.**

## The Safe model

A Safe account has a set of owners and a signature threshold. A 2-of-3 Safe, for example, executes a transaction only after two valid owner approvals.

The contract can make one call or batch several calls atomically. This is useful for teams, treasuries, protocols, and individuals who do not want one private key to control everything.

Most deployments use a lightweight proxy pointing to shared implementation code. The proxy keeps that Safe's owners, threshold, nonce, and other state at its own address.

## Extensions

Safe supports additional components:

- **modules** can execute transactions under extra rules;
- **guards** inspect transactions before or after execution;
- **fallback handlers** add handling for signatures and other calls.

These features make a Safe programmable, but each enabled component becomes part of its security boundary. A malicious module may bypass the normal owner threshold.

## Operational reality

A multisig is only as independent as its signers. Three keys in one browser profile are closer to one failure domain than three keys on separate devices held by separate people.

Teams also need a process for rotating owners, testing batches, decoding delegatecalls, handling signer loss, and responding when an integration requests a broad approval.

## Rust lens

Rust services can read Safe state and build transaction calldata through normal Ethereum RPC and ABI tooling. But collecting owner signatures is not enough: the service must reproduce Safe's exact transaction hash, owner ordering, nonce, and signature encoding.

The core lesson is that smart wallets replace one fixed key rule with auditable code and operational policy. That is more capable, not automatically safer.

## Check yourself

1. What does 2-of-3 mean for a Safe?
2. Why can a module bypass the expected security model?
3. Why are three co-located keys a weak multisig setup?
4. Which Safe-specific values must a Rust signer reproduce exactly?
