# Creation Code and Runtime Code

> **Creation code runs once to build a contract; runtime code is the bytecode left behind and executed on later calls.**

## Deployment is execution

A contract-creation transaction does not simply copy its input bytes into account code. The EVM executes those bytes as **creation code**, also called init code.

Creation code contains or performs:

- constructor logic;
- constructor argument handling;
- initial storage writes;
- checks that may revert deployment;
- production of the final runtime bytecode.

Its successful return data becomes the new account's runtime code.

```text
creation code executes → RETURN(runtime bytes) → runtime code stored
```

## What disappears

Constructor logic does not remain as callable contract code unless the compiler also includes equivalent logic in the runtime section.

Constructor arguments are ABI-encoded after the creation bytecode in a typical Solidity deployment. The creation code reads them during initialization. They are not automatically preserved as a retrievable argument list.

Values marked `immutable` are calculated during creation and embedded into copies of the runtime code. Ordinary state variables initialized by the constructor are stored in contract storage.

## Why the distinction matters

Explorers compare deployed runtime bytecode when identifying code at an address, but full source verification may also reproduce creation bytecode, linked libraries, metadata, and constructor arguments.

`CREATE2` commits to the hash of creation code, not only the returned runtime code. Two constructors can return the same runtime bytes yet produce different CREATE2 addresses because their init code differs.

## Failure is atomic

If the constructor reverts, runs out of gas, or returns code that violates deployment rules, the contract is not created and its initialization state changes do not persist.

Gas spent attempting the failed creation is still consumed.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — contract creation, init-code execution, returned runtime code, and exceptional failure.
- [EIP-1014: Skinny CREATE2](https://eips.ethereum.org/EIPS/eip-1014) — the address formula and its commitment to the init-code hash.

## Check yourself

1. Which bytecode is actually executed during deployment?
2. What determines the bytes stored at the new contract address?
3. Where do ordinary constructor-initialized state variables live afterward?
4. Why can identical runtime code still have different CREATE2 addresses?

<!-- corepath:start -->

**Core Path 36/50** · [← Smart Contract](100-smart-contract.md) · [Contract Deployment →](105-contract-deployment.md)

<!-- corepath:end -->
