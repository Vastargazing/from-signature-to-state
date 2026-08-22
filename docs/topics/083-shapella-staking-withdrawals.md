# Shapella and Staking Withdrawals

> **Shapella completed Ethereum's staking lifecycle by letting validator balances move from the consensus layer to execution-layer addresses.**

## Why two names became one

Post-Merge Ethereum upgrades affect two layers:

- **Shanghai** upgraded the execution layer;
- **Capella** upgraded the consensus layer.

Activated together, they became **Shapella**.

## What EIP-4895 added

Validator balances live in consensus-layer accounting, while normal ETH accounts live in execution state. EIP-4895 defined withdrawals as system-level operations that bridge that boundary.

```text
Beacon validator balance → withdrawal operation → EVM address balance
```

This is not a user-signed EVM transaction. The consensus layer selects and validates withdrawals, and the execution payload carries them. The execution client applies unconditional balance increases after processing normal transactions. Withdrawals consume no user gas.

## Partial and full withdrawals

A **partial withdrawal** moves some eligible balance while the validator remains active. At Shapella activation, validators with `0x01` execution withdrawal credentials were automatically swept down to the 32 ETH maximum effective balance; this was not a user-chosen withdrawal of arbitrary active stake.

A **full withdrawal** happens after the validator exits voluntarily, is forced out, or is exited through a later authorized mechanism, and then passes the protocol's queues and withdrawability delay. Its remaining balance is transferred to the configured withdrawal address.

An exit request and receipt of funds are not instantaneous. Churn limits and withdrawal processing bound how much validator balance can leave and how many withdrawal records are swept, protecting consensus stability.

## Changes after Shapella

Pectra's EIP-7251 added `0x02` compounding credentials and variable effective balances up to 2,048 ETH. Such validators can compound above 32 ETH; automatic excess sweeps use their higher maximum, and queued partial-withdrawal requests can reduce balance without a full exit, subject to protocol limits.

EIP-7002 also added a fee-metered execution-layer request path. The address encoded in an execution withdrawal credential can request a full exit or eligible partial withdrawal without relying solely on the validator's active signing key. These are later additions, not features delivered by Shapella itself.

## What Shapella changed economically

Before Shapella, validators could deposit and earn rewards but could not withdraw through the completed protocol path. Enabling exits reduced that one-way liquidity risk and made staking a complete deposit-participate-exit lifecycle.

It did not make staking risk-free. Validators can still face penalties, slashing, queue delays, key mistakes, and operator or liquid-staking risks.

## The deeper architecture lesson

ETH exists across coordinated accounting domains. Consensus decides a legitimate withdrawal; execution applies the resulting account balance change. Neither layer invents the event independently.

Shapella is a clean example of why modern Ethereum cannot be understood as “just the EVM.”

## Primary sources

- [EIP-4895: Beacon chain push withdrawals](https://eips.ethereum.org/EIPS/eip-4895) — execution-payload withdrawals and unconditional balance increases.
- [EIP-7251: Increase the MAX_EFFECTIVE_BALANCE](https://eips.ethereum.org/EIPS/eip-7251) — compounding credentials and variable effective balances introduced with Pectra.
- [EIP-7002: Execution-layer triggerable exits](https://eips.ethereum.org/EIPS/eip-7002) — the fee-metered request path controlled by execution withdrawal credentials.

Last verified: 2026-08-22.

## Check yourself

1. Which layers do Shanghai and Capella name?
2. Why is a validator withdrawal not a normal EVM transaction?
3. How does a partial withdrawal differ from a full withdrawal?
4. Why are validator exits processed through queues?
