# zkEVM and Equivalence Levels

> **A zkEVM proves Ethereum-like execution. “Equivalent” describes how much existing Ethereum behavior it reproduces and where translation or exceptions remain.**

## The compatibility spectrum

At the strongest end, a prover targets Ethereum's execution and state-transition rules closely enough to prove existing blocks or run normal client logic with minimal change.

Other systems reproduce EVM opcodes and contract behavior but use different state trees, gas accounting, precompiles, or system contracts.

At the looser, language-compatible end, developers can compile Solidity into a different VM. Source code may port easily while deployed bytecode, addresses, debugging, and low-level behavior differ.

```text
Ethereum state equivalence
        → EVM execution equivalence
        → Solidity-language compatibility
```

These are useful design points, not one universally standardized score.

## Why stronger equivalence costs more

The EVM was designed for execution, not efficient algebraic proving. Its 256-bit words, dynamic memory, Keccak, state trie, and edge-case opcodes are expensive to encode.

A custom VM can choose ZK-friendly fields and hashes, making proofs faster while requiring new compilers and tooling.

## What developers must inspect

Check opcode support, gas differences, precompiles, `SELFDESTRUCT` and `CREATE` behavior, block fields, state layout, transaction types, compiler pipeline, and RPC deviations.

An application written in Solidity can still fail because it depends on exact EVM bytecode, address derivation, gas, or precompile behavior.

## Proof correctness and equivalence are separate

A proof can soundly enforce a modified VM. The issue is not whether the proof is valid, but whether that VM matches the Ethereum semantics the application assumes.

## Check yourself

1. How does Solidity compatibility differ from bytecode equivalence?
2. Why is the EVM expensive to prove directly?
3. What does a custom ZK-friendly VM gain and lose?
4. Can a sound proof enforce semantics different from Ethereum's?
