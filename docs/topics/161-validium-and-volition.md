# Validium and Volition

> **A validium proves state transitions but stores the data off-chain. Funds cannot be moved by invalid computation, yet users can still be frozen by withheld data.**

## Validity without availability

Like a ZK-rollup, a validium sends a validity proof and a new state commitment to an L1 verifier. The proof prevents the operator from inventing an invalid transition under the circuit's rules.

Unlike a rollup, it does not publish all state-reconstruction data on L1. A committee or external DA network supplies it instead.

```text
correctness → protected by validity proof on L1
availability → protected by an external system
```

## The real failure mode

Suppose the operator and DA providers disappear after a valid update. Ethereum knows the new root is legitimate, but users may not know the Merkle paths or balances needed to make the next update or prove an individual exit.

The attacker may be unable to steal funds, yet can make them inaccessible. This is why “valid proofs” and “rollup security” are not synonyms.

## Volition

Volition lets users or applications choose where their data lives:

- rollup mode publishes it to L1 and costs more;
- validium mode uses external DA and costs less.

Both modes can share the same execution system and validity proofs. Their availability guarantees differ per account, transaction, or application, depending on the design.

## How to evaluate one

Find the DA committee or network, reconstruction threshold, replacement process, emergency exit, upgrade keys, and what happens when data is missing.

Validium is not a broken ZK-rollup. It is a deliberate trade: lower publication cost and higher throughput in exchange for an extra assumption about data availability.

## Check yourself

1. What does the validity proof protect in a validium?
2. How can users be harmed without an invalid state transition?
3. What choice does volition give a user?
4. Why is a validium not equivalent to an L1-data rollup?
