# Monero and Zcash

> **Monero makes privacy the default transaction shape; Zcash offers shielded privacy alongside transparent activity.**

Both systems aim to reveal less than Bitcoin or Ethereum, but they use different models and make different product choices.

## Monero

Monero combines several techniques:

- stealth addresses hide the recipient's public address on-chain;
- ring signatures make the real spender indistinguishable from decoy inputs;
- Ring Confidential Transactions hide transferred amounts;
- one-time output keys reduce direct address reuse on the ledger.

These protections are part of normal Monero transfers, so private-looking activity is not a special minority mode. The shared anonymity set is still affected by wallet behavior, statistical assumptions, exchange records, and network metadata.

## Zcash

Zcash supports transparent addresses and shielded pools. A shielded transaction uses zero-knowledge proofs to show that value is conserved and spending is authorized without publicly exposing the protected sender, recipient, or amount.

Privacy depends on which transaction path is used. Transparent activity resembles Bitcoin's public UTXO model. Transfers into or out of shielded pools can reveal amounts or timing relationships, while shielded-to-shielded use keeps more information private.

Viewing keys can selectively reveal transaction information without granting spending power. That supports auditing or disclosure when the holder chooses it.

## What neither system promises

Cryptographic transaction privacy does not automatically hide IP addresses, compromised endpoints, exchange identity records, malware, or a user's own disclosures. Supply verification and wallet correctness also depend on the protocol's design and implementation, not the word “ZK.”

The clean comparison is:

```text
Monero: privacy is the standard transaction model
Zcash: transparent and shielded models coexist
```

Neither is “invisible money.” Ask which data is protected, how large the effective anonymity set is, and what information leaks outside the chain.

## Check yourself

1. What does each major Monero privacy technique hide?
2. How do transparent and shielded Zcash activity differ?
3. What is a viewing key useful for?
4. Which metadata remains outside transaction cryptography?
