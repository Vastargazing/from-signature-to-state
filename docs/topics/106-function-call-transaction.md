# Calling a Contract Function Through a Transaction

> **A state-changing function call is a signed transaction whose `to` chooses the contract and whose calldata chooses the function and arguments.**

## Constructing the call

For a call such as:

```solidity
transfer(0xAlice, 100)
```

the wallet encodes:

```text
to    = token contract address
data  = 4-byte selector ++ ABI-encoded arguments
value = native ETH sent with the call, often zero
```

It also includes the sender nonce, gas limit, fee fields, chain ID, and signature.

The signature authorizes the exact encoded transaction. A friendly wallet label is not part of consensus.

## Before the function runs

Nodes check transaction-level rules: signature, nonce, fee capacity, intrinsic gas, and chain context. Inclusion determines the transaction's exact position among other state changes.

The EVM then executes the contract's dispatcher. Matching selector logic reaches the function; an unknown selector may reach `fallback` or revert.

Inside the top-level call:

- `msg.sender` is the transaction sender;
- `msg.value` is the attached ETH;
- calldata contains the encoded input;
- `tx.origin` is also the sender, though using it for authorization is unsafe and increasingly brittle.

## Success and return values

A successful transaction can update state and emit logs. Its return bytes are available during execution and simulation but are not exposed in the standard transaction receipt like logs are.

A top-level revert produces a failed receipt and rolls back state changes and logs, while consuming gas used.

## Read calls are simulations

Wallets and frontends call `eth_call` for `view` functions. An RPC node runs the same code locally against a selected state without broadcasting a transaction.

```text
eth_call       → simulation, no consensus state change
signed tx call → possible inclusion and state change
```

A successful simulation does not guarantee later transaction success because state, ordering, gas, or block context may change.

## Check yourself

1. Which transaction fields select a contract function and its arguments?
2. What is `msg.sender` in the top-level contract frame?
3. Why does a reverted transaction still cost gas?
4. Why can a successful `eth_call` be followed by a failed transaction?
