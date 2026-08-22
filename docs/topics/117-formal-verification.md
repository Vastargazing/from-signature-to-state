# Formal Verification

> **Formal verification proves that a mathematical model of a program satisfies stated properties under stated assumptions.**

## From examples to all modeled cases

Tests execute selected inputs and sequences. Formal methods translate code and properties into logic, then use solvers or proof assistants to reason over a much larger—or mathematically complete—modeled space.

A property might state:

```text
for every reachable modeled state,
total liabilities never exceed total assets
```

Tools may use symbolic execution, SMT solving, model checking, or interactive proofs. Solidity's SMTChecker can prove or find counterexamples for supported assertions and arithmetic properties.

## The specification is the hard part

A proof only establishes what was written. If the property says “only owner can mint” but the owner is malicious, the proof does not establish a supply cap.

If an oracle is modeled as always honest, the result says nothing about oracle manipulation. If external calls are abstracted incorrectly, reentrancy may disappear from the model.

```text
verified implementation of a bad specification = precisely wrong system
```

## The verification gap

Reasoning may target source code, intermediate representation, bytecode, or a simplified model. Bugs can live between layers:

- compiler behavior;
- unsupported EVM features;
- proxy and deployment configuration;
- external contracts;
- protocol upgrades;
- assumptions about keys and governance.

The assurance claim must name exactly which artifact and environment were verified.

## Where it helps most

Formal verification is especially valuable for compact, high-value logic with crisp invariants: token accounting, authorization, state machines, bridges, consensus code, and cryptographic protocols.

It complements review, unit tests, fuzzing, invariants, differential testing, and monitoring. It does not make audits or operational controls obsolete.

The credible sentence is not “the contract is formally verified.” It is “these properties were proved for this artifact under these assumptions.”

## Check yourself

1. How does formal verification differ from testing examples?
2. Why is writing the property often harder than running the solver?
3. What is the verification gap?
4. What information should accompany a formal-verification claim?
