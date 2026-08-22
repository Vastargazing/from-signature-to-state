# Fraud Proof and Challenge Period

> **A fraud proof turns “this state root is wrong” into a small dispute that L1 can decide; the challenge period gives honest watchers time to start it.**

## Narrow the disagreement

Re-executing an entire L2 batch on Ethereum would destroy the scaling benefit. Interactive systems instead bisect an execution trace:

```text
large disputed trace
→ choose disagreeing half
→ repeat
→ isolate one machine step
→ L1 verifies that step
```

The losing claim is rejected and economic bonds can be penalized according to the protocol.

Some designs use different fault-proof architectures, but the goal is the same: make an invalid state transition cheaply adjudicable by L1.

## Why a time window exists

State assertions cannot become final immediately because watchers need time to:

- obtain L1-published data;
- replay the rollup;
- detect disagreement;
- submit a challenge despite congestion or censorship;
- complete every timed dispute round.

Canonical withdrawals therefore wait until the relevant assertion survives the window.

## “One honest verifier” has requirements

The slogan assumes that an honest party can run the software, access data, post L1 transactions, fund gas and bonds, and remain online through deadlines.

If challenges are allowlisted, disabled, unaffordable, or blocked by upgrade keys, the deployed trust model is weaker than the paper design.

## Invalidity versus unavailability

A fraud proof can show incorrect execution only when the input data is known. A commitment to hidden data cannot be replayed.

This is why on-chain data availability is part of rollup security, not an optional archive service.

## Check yourself

1. Why do interactive proofs bisect an execution trace?
2. What operational work must fit inside the challenge period?
3. Which conditions hide behind the “one honest verifier” assumption?
4. Why can a fraud-proof system not rescue unavailable transaction data?
