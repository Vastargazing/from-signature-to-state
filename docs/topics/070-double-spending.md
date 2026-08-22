# Double-Spending

> **Double-spending is an attempt to make two conflicting uses of the same value appear valid.**

Digital data can be copied. A ledger prevents copied authorization from creating copied money by enforcing state and choosing one canonical order.

## How conflict appears

In a UTXO system, two transactions double-spend when both consume the same previous output.

In an account system, conflict often appears through the same sender nonce or through both transactions relying on a balance that can fund only one.

```text
same spendable state + two incompatible transitions → consensus must choose
```

Nodes can detect each transaction's rules locally, but different nodes may see the conflicting transactions in different orders. Consensus determines which valid history becomes canonical.

## Common attempts

A user may send one payment to a merchant and a conflicting payment back to themselves with a higher fee. If the merchant accepts a mempool observation as payment, the replacement can win before any block confirms the first transaction.

A stronger attacker may mine or coordinate a private branch containing a conflicting spend, reveal it later, and try to reorganize the public chain.

## Confirmation changes risk

Before inclusion, a transaction is only pending. After inclusion, it can still be removed by a reorg. More accumulated work or economic finality makes reversal harder.

The acceptable wait depends on transaction value, consensus mechanism, attacker capability, and whether the recipient can recover from reversal.

## What signatures solve

A signature proves that a key authorized a transaction. It does not choose between two separately signed conflicting transactions. Nonces and spent-output rules expose the conflict; consensus resolves the order.

The layered answer is:

```text
signatures → authorization
state rules → conflict detection
consensus  → canonical winner
finality   → confidence that the winner stays
```

## Check yourself

1. What conflicts in a UTXO double-spend?
2. How does an account nonce expose conflict?
3. Why is a mempool payment unsafe?
4. Why cannot signatures choose the winning spend?
