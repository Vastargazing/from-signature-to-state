# Externally Owned Account

> **An Externally Owned Account is authorized by a private key and can originate Ethereum transactions.**

## The classic EOA

Traditionally, an EOA has:

- an ETH balance;
- a transaction nonce;
- no persistent contract bytecode;
- authority tied to a secp256k1 private key.

The address is derived from the public key. The protocol recovers the signer from a transaction signature and checks that the nonce is next for that account.

```text
private-key signature + correct nonce → authorized transaction
```

Creating an EOA requires no on-chain action. A key pair can be generated offline, and the address may receive assets before it ever sends a transaction.

## What an EOA can start

Every current top-level Ethereum transaction still has a secp256k1-recovered sender. Newer transaction types can carry additional authorizations—for example, a type-4 transaction's outer sender may pay to install a delegation signed by another EOA. A transaction can:

- transfer ETH;
- call a contract;
- deploy a contract;
- carry calldata and a gas budget.

Once execution begins, contracts can make internal calls. Those calls are not separately signed transactions and do not have independent account nonces.

## The key is the account's authority

Ethereum does not store a password reset service or a human identity for an EOA. Whoever can produce a valid signature controls it.

Losing the key usually loses control. Leaking it transfers control to the attacker. Seed phrases and hardware wallets are key-management systems around this fact.

## The modern caveat: EIP-7702

The old slogan “EOAs have no code” is no longer absolute after EIP-7702. An EOA can sign an authorization tuple that persistently writes a 23-byte delegation indicator into its code field. Code-executing operations follow that pointer and run the target code in the EOA's context, while the original key can still originate transactions and replace or clear the delegation.

This enables delegate implementations to provide batching, sponsored gas, and limited permissions; EIP-7702 does not make those policies safe automatically. It also breaks assumptions such as “an address with code cannot originate transactions” and makes a malicious delegation nearly equivalent to handing over the account.

The durable distinction is therefore authorization:

```text
EOA authority      → cryptographic key
contract authority → rules executed by code
```

Modern accounts can combine both behaviors, so code size is not a safe identity test.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — externally controlled accounts, transaction sender recovery, account nonce, and contract creation.
- [EIP-7702: Set EOA account code](https://eips.ethereum.org/EIPS/eip-7702) — delegation indicators, authorization tuples, replacement, and clearing.

Last verified: 2026-08-22.

## Check yourself

1. What authorizes a traditional EOA transaction?
2. What role does the account nonce play?
3. Why does generating an EOA cost no gas?
4. How does EIP-7702 weaken the slogan “EOAs have no code”?

<!-- corepath:start -->

**Core Path 30/51** · [← Economic Finality](048-economic-finality.md) · [Contract Account →](088-contract-account.md)

<!-- corepath:end -->
