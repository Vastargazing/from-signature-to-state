# Source-Code Verification on Etherscan

> **Source verification proves that published source and build settings reproduce on-chain bytecode. It does not prove the source is safe.**

## What the verifier compares

The blockchain stores bytecode, not the original Solidity project. To verify a contract, a developer submits source files and build inputs such as:

- exact compiler version;
- optimizer enabled state and run count;
- EVM target and compiler pipeline settings;
- linked library addresses;
- metadata configuration;
- constructor arguments.

Etherscan recompiles the source and compares the result with deployment or runtime bytecode at the address.

```text
same source + same settings → matching bytecode
```

An exact match gives users readable source, ABI decoding, and a reproducible connection to the deployed machine code.

## Why settings matter

The same Solidity text can compile differently under another compiler release, optimizer configuration, metadata hash, library link, or EVM version.

A failed match does not necessarily mean the source is malicious. It means the submitted build description does not reproduce the deployed artifact.

## Verification is not an audit

A verified contract can contain an obvious exploit, an upgrade backdoor, or broken economics. Verification answers:

```text
“Is this the source for these bytes?”
```

It does not answer:

```text
“Are these bytes safe and governed well?”
```

Users must also inspect proxy implementation addresses. Verifying the proxy alone may reveal only delegation logic, while business behavior lives in a changeable implementation.

## Trust and reproducibility

Explorer verification is convenient but centralized presentation. Independent systems such as reproducible local builds and source registries can confirm the same relationship.

Always bind the result to chain ID and address. Identical addresses on different networks can contain different code.

## Check yourself

1. Which build inputs must match besides Solidity source text?
2. What claim does an exact source verification establish?
3. Why can a verified contract still be malicious?
4. What extra address must be checked for a proxy deployment?
