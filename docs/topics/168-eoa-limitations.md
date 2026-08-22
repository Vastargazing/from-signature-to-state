# Limitations of EOAs

> **An EOA's root authority is still its key: even when EIP-7702 delegates execution to code, the key can replace or clear that delegation.**

## Key equals authority

An externally owned account is controlled at protocol level by a private key. Ethereum checks the relevant signatures, nonces, balances, and transaction rules. It does not know whether a valid signer is the owner, a thief, a hardware wallet, or a recovery service.

This creates a harsh choice:

- one key is simple but one compromise loses everything;
- several devices improve availability but enlarge the attack surface;
- seed backups help recovery but become another secret to protect.

The base EOA authorization rule cannot require two signatures, impose a daily limit, or replace a lost key. Delegated code can enforce such policy for calls routed through it, but the original key remains able to change or clear the delegation.

## Legacy flow and EIP-7702

A conventional EOA signs a native Ethereum transaction, normally pays gas in ETH, and consumes its sequential transaction nonce.

Since Pectra, EIP-7702 authorization tuples let an EOA designate contract code whose logic runs in the EOA's context. That code can add batching, sponsorship flows, session permissions, and other smart-account behavior. The authorization is persistent, but it does not rotate the EOA key or make the delegated policy the protocol's final authority.

## Why wallets feel more capable

A wallet application can simulate transactions, label addresses, use hardware signers, and warn about approvals. Those are off-chain protections. Delegated code can add on-chain checks, but a valid key signature can still authorize native transactions and replace that code.

Contract accounts and EIP-7702-delegated EOAs move policy into executable code. They can define owners, thresholds, recovery, session permissions, fee payment, and call batching. That flexibility adds contract bugs, delegate-upgrade risk, and more complex validation; a delegated EOA additionally retains its original key as root authority.

## The mental model

An EOA is not a wallet app. It is a protocol account whose root authorization remains tied to one cryptographic key, even if delegated code makes its day-to-day behavior programmable.

Account abstraction asks a broader question: what if authentication and transaction policy were programmable?

## Check yourself

1. Why can Ethereum not distinguish an owner from a key thief?
2. Which recovery rule exists natively in an EOA?
3. Why are wallet warnings not changes to EOA authorization?
4. What new risks appear when policy moves into smart-contract code?
