# Unit, Fuzz, and Invariant Tests

> **Unit tests check chosen examples, fuzz tests vary inputs, and invariant tests explore sequences while checking what must always remain true.**

## Unit tests

A unit test sets up one scenario, performs an action, and asserts an expected result:

```text
given Alice has 10
when Alice transfers 4
then Alice has 6 and Bob has 4
```

Unit tests are readable and excellent for known rules, access control, revert cases, events, and exact boundary examples. They cover what the author remembered to write.

## Fuzz tests

Foundry identifies parameters on a fuzz test and generates many values. Instead of testing one transfer amount, it tests zero, large numbers, boundaries, and unexpected combinations.

A good fuzz test asserts a property:

```text
after a valid transfer, total balances are conserved
```

Input constraints should describe the valid domain, not filter away every difficult case. When Foundry finds a failure, it shrinks the input toward a simpler counterexample.

## Invariant tests

Stateful invariant testing generates sequences of calls from varying actors and checks properties after each step.

Useful invariants include:

- sum of user balances equals total supply;
- assets remain sufficient for liabilities;
- unauthorized actors never gain an admin role;
- a pool accounting identity always holds.

Handlers guide the fuzzer toward meaningful actions and track **ghost variables**—test-only accounting used to compare the system with a model.

## They complement each other

```text
unit      → one known path
fuzz      → many inputs to one path
invariant → many inputs across many paths and states
```

More runs do not rescue a weak assertion. A test that only checks “did not revert” may miss theft, insolvency, or privilege escalation.

Also test failure paths, external-call behavior, upgrades, and adversarial senders. Coverage measures executed code, not correctness of expectations.

Run [Lab 5 — Turn Examples into Fuzz and Invariant Tests](../labs/05-fuzz-and-invariant-testing.md) to turn the safe vault from Lab 4 into a stateful test target. You will use a handler, independent ghost accounting, call metrics, and a deliberate one-wei mutation to check whether the properties can actually catch a bug.

## Primary sources

- [Foundry tests](https://getfoundry.sh/forge/tests) — test discovery, filters, fuzz runs, and generated counterexamples.
- [Foundry invariant testing](https://getfoundry.sh/forge/invariant-testing/) — runs, depth, targets, handlers, ghost variables, and metrics.

Last verified: 2026-08-22.

## Check yourself

1. What does a unit test provide that fuzzing may not?
2. What makes a strong fuzz assertion?
3. Why are invariant tests stateful?
4. What is a ghost variable used for?

<!-- corepath:start -->

**Core Path 43/50** · [← Foundry](114-foundry.md) · [The Scalability Trilemma →](149-scalability-trilemma.md)

<!-- corepath:end -->
