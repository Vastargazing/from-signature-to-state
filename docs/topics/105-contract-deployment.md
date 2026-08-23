# Contract Deployment

> **Deploying a contract is a state-changing transaction whose successful execution creates an address, initializes storage, and installs runtime bytecode.**

## Build the deployment transaction

For an ordinary top-level deployment, the transaction has no recipient. Its data contains creation bytecode plus encoded constructor arguments.

The sender supplies:

- nonce and chain ID;
- gas limit and fee fields;
- optional ETH for a payable constructor;
- a signature authorizing the transaction.

The future CREATE address can be calculated from the sender and nonce before inclusion.

## What changes on-chain

During deployment, the EVM turns creation code into installed runtime code as one atomic state transition:

1. derives the new address;
2. transfers any deployment value;
3. runs creation code in the new account context;
4. applies constructor storage writes;
5. charges code-deposit gas;
6. stores returned runtime bytecode.

All steps succeed together or creation reverts. For a top-level deployment, a successful receipt records `status = 1` and the created contract address.

## Deployment is not initialization-safe by default

Constructors run automatically for ordinary contracts. Proxy deployments are different: implementation constructors write to the implementation's storage, not the proxy's storage.

Upgradeable systems therefore use an initializer called through the proxy, usually atomically during proxy creation. An unprotected or forgotten initializer can hand ownership to an attacker.

## After deployment

The network knows only bytecode and state. Teams normally:

- record the chain and address;
- verify source and compiler settings;
- confirm ownership and upgrade roles;
- test a read call against the deployed contract;
- monitor deployment and initialization events.

Publishing an address without chain ID is ambiguous. The same hex address can hold unrelated code on another network.

## Factories

Contracts can deploy other contracts with `CREATE` or `CREATE2`. Those are internal creation operations inside one outer transaction, not separately signed deployments.

## Primary sources

- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf) — `CREATE`, creation execution, address derivation, code deposit, and exceptional failure.
- [EIP-1014: Skinny CREATE2](https://eips.ethereum.org/EIPS/eip-1014) — deterministic address derivation from deployer, salt, and init-code hash.
- [Solidity documentation: Creating contracts](https://docs.soliditylang.org/en/latest/contracts.html#creating-contracts) — language-level deployment and constructor behavior.

## Check yourself

1. How does a top-level deployment transaction indicate contract creation?
2. Which execution output becomes deployed code?
3. A proxy is deployed without calling its unprotected initializer. What state is missing, and how can an attacker exploit the gap?
4. Why must a deployment record include chain ID?

<!-- corepath:start -->

**Core Path 38/51** · [← Creation Code and Runtime Code](104-creation-code-and-runtime-code.md) · [State Storage and Storage Layout →](108-storage-layout.md)

<!-- corepath:end -->
