# The DAO Hack and the ETH/ETC Split

> **The DAO exploit did not break Ethereum's consensus. The response changed Ethereum's state and revealed that social consensus sits above code.**

## What was exploited

The DAO was a large investment contract deployed on Ethereum in 2016. Its withdrawal logic sent ETH before safely updating internal accounting.

An attacker used recursive calls to withdraw repeatedly before the contract recorded the reduced balance. This pattern became the classic **reentrancy** example.

Ethereum executed the contract exactly according to its deployed bytecode. The protocol, signatures, and EVM were not cryptographically hacked. The application contained the bug.

## The hard-fork response

Because The DAO held a large share of circulating ETH, the community debated intervention. The adopted Ethereum hard fork introduced a special state change that moved affected funds into a refund contract.

This did not erase every block and replay the chain as if the exploit never occurred. Nodes installed new consensus rules that altered the state at a chosen block.

Most users, developers, miners, applications, and exchanges followed this branch, which retained the **ETH** symbol.

## Ethereum Classic

Some participants rejected the intervention and continued the original history without the refund state change. That network became **Ethereum Classic**, with asset symbol **ETC**.

Both chains shared all history before the split. Private keys from before the fork controlled corresponding accounts on both sides, while later transactions and state diverged.

## Why the event matters

The debate exposed two defensible values:

```text
immutability → executed history should stand
social recovery → catastrophic outcomes can justify intervention
```

“Code is law” describes predictable execution, but code cannot decide which client release people recognize after a crisis. Communities, infrastructure, and markets make that choice.

The fork also taught a security lesson: a valid transaction can still exploit unintended contract behavior. Consensus validity is not the same as application correctness.

## Primary sources

- [EIP-779: DAO Fork](https://eips.ethereum.org/EIPS/eip-779) — activation block and the irregular state change that moved balances to the withdrawal contract.
- [SEC report on The DAO](https://www.sec.gov/files/litigation/investreport/34-81207.pdf) — contemporaneous account of The DAO, the exploit, and the fork response.

Last verified: 2026-08-22.

## Check yourself

1. Was Ethereum's base protocol itself exploited by The DAO attacker?
2. What did the hard fork change?
3. Why did Ethereum Classic continue to exist?
4. What does the split reveal about the limits of “code is law”?
