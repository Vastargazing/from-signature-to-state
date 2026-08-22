# Unprotected Initialization and the Parity Multisig

> **An initializer is a constructor exposed as a function. If anyone can call it once, the attacker may become the contract's first—and legitimate—owner.**

## Why initializers exist

Proxy contracts keep state while delegating logic to an implementation. The implementation's constructor does not initialize proxy storage, so deployments call an `initialize()` function through the proxy.

That function must execute exactly once, atomically during deployment when possible, and reject every later caller.

## Parity's 2017 ownership failure

Parity multisig wallets delegated wallet logic to shared library code. An initialization function that configured owners was reachable without proper one-time protection.

Attackers initialized wallets they did not own, installed their own owners, and used normal privileged withdrawal logic. The authorization code worked after the attacker changed who was authorized.

## The later library freeze

A subsequent Parity design still left the shared library contract itself uninitialized. A user initialized the library, became its owner, and invoked its destruction path.

Wallets depending on that library could no longer execute, freezing funds. This was a liveness catastrophe rather than the same theft path.

That 2017 outcome depended on the old `SELFDESTRUCT` semantics, which removed an existing contract's code. Since EIP-6780, Ethereum generally deletes code and storage only when `SELFDESTRUCT` occurs in the same transaction that created the contract, so the identical old-library deletion path would not work on current Mainnet. The initialization and shared-dependency lessons still apply.

## Modern defenses

Use a proven initializer guard, initialize the proxy in the deployment transaction, and disable initializers on implementation contracts.

Verify every proxy instance on-chain. A safe implementation does not rescue an uninitialized proxy, and a safe proxy does not rescue an exposed implementation with dangerous direct state or destruction behavior.

Test reinitialization, upgrade migrations, inherited initializers, and deployment scripts. Initialization is part of the security-critical runtime, not mere setup.

## Primary sources

- [Parity's multisig-library postmortem](https://medium.com/paritytech/a-postmortem-on-the-parity-multi-sig-library-self-destruct-63daca3a4cf7) — the uninitialized owner, library destruction, and affected dependent wallets.
- [EIP-6780: SELFDESTRUCT only in the same transaction](https://eips.ethereum.org/EIPS/eip-6780) — the post-Dencun deletion semantics behind the modern caveat.

Last verified: 2026-08-22.

## Check yourself

1. Why does a proxy need an initializer instead of relying on the implementation constructor?
2. How did ownership become attacker-controlled in the first Parity failure?
3. Why did destroying the shared library freeze other wallets?
4. Which two contracts need initialization analysis in a proxy system?
