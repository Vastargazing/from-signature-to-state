# Turing Completeness and Gas

> **The EVM can express general computation, but every individual execution is bounded by gas so the network can always stop it.**

## The halting problem becomes operational

A general-purpose language can express loops whose completion cannot always be decided in advance. On one computer, the user can kill a stuck process. On Ethereum, every validator must know when to stop executing the same transaction.

Gas solves this without proving that the program halts.

Each operation consumes gas. A transaction starts with a gas limit:

```text
next operation requires more gas than remains → exceptional out-of-gas halt
```

At the top level, an out-of-gas halt reverts the transaction's execution changes and consumes the gas supplied to the failed execution. An infinite loop therefore fails instead of freezing the chain.

## Why “quasi-Turing-complete” is precise

The EVM instruction set can express general computation given enough time and storage. But one transaction has finite gas, a block has a gas limit, the stack is bounded, and memory expansion costs grow.

The Yellow Paper therefore describes the EVM as **quasi-Turing-complete**: expressive like a general computer, intrinsically bounded per execution.

Long computations can be split across transactions by storing progress, but each step remains bounded and paid for.

## Gas is metering, not a CPU stopwatch

Gas units are protocol prices assigned to operations. They approximate scarce node resources such as CPU, memory, storage growth, and database access.

Gas is deterministic. Two machines may execute at different physical speeds, yet they must charge the same gas under the same fork rules.

Prices sometimes change through upgrades when an opcode is found to underprice real work. Otherwise, attackers could consume disproportionate resources cheaply.

## Failure boundaries

Out-of-gas reverts state changes in the failing call frame and consumes all gas supplied to that frame. A caller may catch a failed subcall if it used a low-level call and still has gas left.

So “the transaction ran out of gas” and “one internal call ran out of gas” can produce different top-level outcomes.

## Check yourself

1. Why can validators not simply wait for every loop to finish?
2. What makes the EVM only quasi-Turing-complete per transaction?
3. Why is gas not measured in milliseconds?
4. What happens to state and spent gas after out-of-gas failure?
