# What Exactly a ZK Proof Proves

> **A verified proof says: there exists a witness that satisfies this exact relation for these exact public inputs under this verification key. Nothing more.**

## Statement, witness, relation

The **statement** is public: for example, old state root, new state root, and batch commitment.

The **witness** is private or too large to verify directly: transactions, signatures, Merkle paths, and intermediate execution values.

The circuit or program defines a relation `R`:

```text
R(public inputs, witness) = true
```

The prover produces a compact proof that it knows a satisfying witness. The verifier checks the proof without re-running the full computation.

## The circuit is the law of the proof

If the circuit forgets to enforce a balance check, a proof can be cryptographically perfect and economically wrong. The proof guarantees compliance with encoded constraints, not the developer's English intention.

Public inputs also matter. A proof about state root A does not authorize updating a contract currently at state root B unless the verifier binds that root correctly.

## What it does not prove automatically

A validity proof does not prove:

- transaction data is available to users;
- the application preserves privacy outside the witness;
- the sequencer is live or fair;
- the verification contract cannot be upgraded;
- the compiler translated source into constraints correctly;
- the external oracle facts are true.

Each requires a separate argument.

## Verification key and parameters

The verification key identifies the relation and proof system parameters the contract accepts. Replacing it may change what counts as valid.

An admin able to upgrade the verifier may effectively change the proven rules, even though every accepted proof remains mathematically valid under the new key.

The review habit is precise: write the public inputs, witness, constraint relation, and powers around the verifier before saying “ZK-secured.”

## Check yourself

1. What are the three parts of the relation being proven?
2. Can a perfect proof enforce a check omitted from the circuit?
3. Why must public state roots be bound explicitly?
4. Which guarantees remain outside validity-proof verification?
