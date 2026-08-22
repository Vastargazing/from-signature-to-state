# Contract Account

> **A contract account is an Ethereum address whose behavior is defined by EVM bytecode and persistent storage.**

## What lives at the address

A contract account can have:

- an ETH balance;
- deployed runtime bytecode;
- persistent key-value storage;
- a nonce used when it creates contracts.

Its address has no private key that “owns the contract.” Control comes from access checks, multisig rules, governance, or sometimes no privileged path at all.

## Contracts react; they do not originate

A normal contract account cannot sign and originate a top-level Ethereum transaction. Its code runs when execution reaches it through:

- a transaction from an EOA;
- a call from another contract;
- a protocol-defined system operation in special cases.

Contract creation is slightly different: the EVM executes separate initialization code, and the bytes it returns become the new account's runtime bytecode. That stored runtime code begins running only on later message calls.

During that execution, it can call other contracts, transfer ETH, create contracts, emit logs, and update its own storage.

```text
signed transaction → contract A → contract B → contract C
```

Only the outer transaction is signed. The nested message calls are effects of deterministic EVM execution.

## Code is not the whole application

Runtime bytecode is generally immutable at its address, but behavior can still change indirectly. A proxy can use `DELEGATECALL` to execute code stored at another address. Governance may update that implementation pointer.

Contract state also matters. The same bytecode can return different results after storage changes, and two contracts with identical bytecode can hold unrelated state.

## No automatic token awareness

A contract can hold ETH directly. Token contracts record ERC-20 and NFT ownership in their own ledgers.

Sending assets to a contract does not guarantee the code can send them back. Recoverability depends on its implemented functions.

## Do not classify an address by code size

EIP-7702 makes the boundary deliberately awkward: a key-authorized account can delegate execution to code. For security, ask which authorization and execution rules apply—not whether a block explorer labels the address “EOA” or “contract.”

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — account code, message calls, nested execution, storage, and contract creation.
- [EIP-7702: Set EOA account code](https://eips.ethereum.org/EIPS/eip-7702) — the key-authorized delegation behavior that invalidates code-size-based classification.

Last verified: 2026-08-22.

## Check yourself

1. What controls a contract account if it has no private key?
2. Can a normal contract originate a top-level signed transaction?
3. Why can immutable proxy bytecode still expose upgradeable behavior?
4. Why might tokens sent to a contract become stuck?

<!-- corepath:start -->

**Core Path 30/50** · [← Externally Owned Account](087-externally-owned-account.md) · [The EVM: A 256-Bit Stack Machine →](089-evm-stack-machine.md)

<!-- corepath:end -->
