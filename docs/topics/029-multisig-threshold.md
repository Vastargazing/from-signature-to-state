# Multisig and Threshold Signatures

> **Both spread signing power across parties, but multisig shows several approvals while a threshold signature produces one ordinary-looking signature.**

An `m-of-n` policy requires at least `m` approvals from `n` possible signers. A 2-of-3 setup can tolerate one lost key and stop one stolen key from moving funds alone.

The security gain comes from independent failure domains. Three keys on the same laptop are not meaningfully independent.

## On-chain multisig

In a traditional multisig, the blockchain or smart contract verifies several signatures and enforces the threshold.

Bitcoin can encode multisignature spending conditions. Ethereum commonly uses a smart-contract wallet such as Safe, because EOAs natively authorize with one key.

In explicit script or contract multisig, the policy and approvals are generally visible on-chain, and each approval consumes data or gas. Taproot key-path threshold signing or MuSig-style aggregation can instead look like an ordinary single-key spend; a Taproot script-path spend reveals only the executed branch and its commitment proof. Contract wallets can add owners, limits, modules, and recovery, but they also add contract and upgrade risk.

## Threshold signatures

In a threshold signature scheme, parties hold shares of one signing capability. They run an interactive protocol and produce one signature that verifies under one public key.

```text
multisig:  several public keys + several signatures + on-chain threshold
threshold: one public key + one final signature + off-chain cooperation
```

Threshold signing can reduce on-chain footprint and hide the internal policy. It is not automatically simpler: secure share generation, nonce handling, networking, backups, participant replacement, and liveness all matter.

MPC is a broader technique for jointly computing without revealing private inputs. Threshold signing is one important use of MPC; the terms are not exact synonyms.

## Design the failure policy

Ask who can sign, who can block signing, how lost participants are replaced, whether keys share one location or vendor, and what happens when communication fails.

For unforgeability, an `m-of-n` threshold scheme is intended to withstand fewer than `m` compromised shares, assuming the protocol and implementation are sound. Liveness has a different bound: enough missing or refusing participants can block signing, and some malicious participants can abort a signing round. Threshold cryptography does not protect against `m` parties colluding or all signers approving the same malicious transaction.

## Check yourself

1. What does 2-of-3 tolerate?
2. How does on-chain multisig differ from a threshold signature?
3. Why are three keys on one laptop weak separation?
4. What liveness problem can shared custody create?
