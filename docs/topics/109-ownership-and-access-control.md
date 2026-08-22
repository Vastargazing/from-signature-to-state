# Contract Ownership and Access Control

> **A contract owner is not a protocol primitive. It is an address that contract code grants privileged actions.**

## Ownership is a storage rule

A simple contract stores an `owner` address and checks it:

```solidity
require(msg.sender == owner);
```

The EVM does not give that address special status. The bytecode reads storage and chooses whether to continue or revert.

Ownership may guard pausing, minting, parameter changes, fund recovery, or upgrades. The real power is the list of reachable privileged actions—not the variable name.

## Beyond one owner

Role-based access control separates responsibilities:

```text
PAUSER_ROLE   → stop dangerous actions
MINTER_ROLE   → create tokens
UPGRADER_ROLE → change implementation
```

This supports least privilege. Compromise of one operational key need not expose every administrative capability.

Roles still require an administrator who can grant or revoke them. Follow the complete authority graph until reaching actual keys, multisigs, timelocks, or governance contracts.

## Safer control paths

Production systems commonly use:

- a multisig instead of one private key;
- two-step ownership transfer so the recipient must accept;
- timelocks that make changes visible before execution;
- separate emergency and routine roles;
- narrow parameter bounds enforced by code.

These mechanisms trade response speed for reduced unilateral power.

## Common traps

`msg.sender` is the immediate caller. If a multisig calls the contract, the multisig is the sender—not the individual signer.

Using `tx.origin` for authorization is unsafe because an attacker contract can trick the original user into a nested call. EIP-7702 also makes old assumptions about `tx.origin` and code-bearing accounts more brittle.

Renouncing ownership is not automatically decentralization. It may permanently disable upgrades or recovery while other privileged roles, proxy admins, or oracle controls remain.

## The audit question

For every sensitive action, ask:

```text
who can trigger it → who controls that address → can control change?
```

## Check yourself

1. Where does a contract owner's power actually come from?
2. Why can role separation limit damage from one key compromise?
3. Why should authorization use `msg.sender` rather than `tx.origin`?
4. Why does renouncing one owner variable not prove decentralization?
