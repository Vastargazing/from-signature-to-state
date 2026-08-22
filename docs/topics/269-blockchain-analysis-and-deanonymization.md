# Blockchain Analysis and Deanonymization

> **Blockchain analysis turns public transaction history into hypotheses about who controls which addresses.**

A block explorer shows individual records. Blockchain analysis connects those records into flows, clusters, and behavior over time. It combines on-chain evidence with information from exchanges, websites, seized devices, public posts, and network observations.

## Common signals

On UTXO chains, spending several inputs in one transaction often suggests that one wallet controlled their keys. Change-output patterns can reveal where the unspent remainder went. These are heuristics, not protocol facts, and collaborative transactions can break the assumption.

On account-based chains, analysts follow token transfers, bridge deposits, exchange addresses, contract calls, gas funding, and repeated transaction patterns. A fresh address is not isolated if its first gas came from an already identified account.

Timing and distinctive amounts can connect activity across a bridge or service even when no direct on-chain link exists.

## Labels make the graph meaningful

A cluster of addresses becomes useful when one point receives a label: exchange, bridge, protocol treasury, scam, merchant, or known person. KYC records and deposit addresses can connect blockchain activity to a customer under the applicable legal process.

Analysts then propagate evidence through the graph. Good analysis keeps confidence levels and competing explanations; weak analysis presents a probabilistic cluster as proven ownership.

## What the graph cannot prove alone

A transfer to an address does not prove its owner endorsed the payment. Tokens can be sent without consent. A smart contract may pool funds from thousands of users. Custodians act for customers, and compromised keys act for attackers.

Attribution therefore needs context, not only proximity:

```text
transaction link ≠ identity proof ≠ criminal intent
```

Privacy is also operational. Wallet behavior, RPC providers, browser tracking, IP logs, and exchange accounts may reveal more than the ledger itself.

## Check yourself

1. What turns an address cluster into an attributed identity?
2. Why is common-input ownership only a heuristic?
3. How can gas funding link a fresh Ethereum address?
4. Why does receiving funds not prove intent?
