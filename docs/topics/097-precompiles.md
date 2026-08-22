# Precompiles

> **A precompile exposes client-native functionality behind a contract-like address when EVM bytecode would be impractically expensive.**

## Contract interface, native execution

Ethereum reserves certain low addresses for protocol-defined functions. A contract invokes one with `CALL` or `STATICCALL`, passing bytes and receiving bytes.

From EVM code, this looks similar to calling a contract. Inside the client, however, optimized native code performs the operation rather than interpreting stored bytecode.

Common precompiles provide operations such as:

- ECDSA public-key recovery;
- SHA-256 and RIPEMD-160 hashing;
- modular exponentiation;
- elliptic-curve addition, multiplication, and pairing checks;
- point evaluation for blob commitments.

## Why not ordinary bytecode

Some cryptographic operations require large-integer arithmetic or curves the EVM instruction set cannot implement efficiently. Charging millions of gas for an awkward bytecode version would make useful verification impossible.

A precompile defines a deterministic input-output function and a consensus gas formula. Every client must return exactly the same bytes and failure behavior.

```text
address + input bytes + gas → protocol-defined result
```

## They are not deployed libraries

A precompile usually has no normal runtime bytecode or storage. `EXTCODESIZE` is therefore not a reliable way to discover its behavior.

It cannot be upgraded by a contract owner. Changing or adding a precompile requires a network upgrade because its implementation is part of consensus.

## Chain and fork differences

The available set can change over time and differ across EVM-compatible networks. Code that assumes a precompile exists must know the target chain and fork.

Precompiles also create implementation risk: clients written in different languages or using different cryptographic libraries must agree on malformed inputs and edge cases, not only successful examples.

## Check yourself

1. How does EVM code invoke a precompile?
2. Why are cryptographic operations common precompile candidates?
3. Why might a precompile have no ordinary bytecode?
4. Why is adding a precompile a consensus change?
