# Trustless — Operating Without Trust Between Participants

> **Trustless does not mean “I trust no one.” It means “I do not have to trust a particular participant”: trust has moved from people to verifiable assumptions.**

## The picture

In an ordinary bank transfer, you trust the bank. It tells you how much money you have and decides whether the payment goes through. If it decides otherwise, there is nothing you can do.

You run your own node. Now you do not take another server's answer on faith: you **verify the data yourself according to the protocol rules**. How the node established its starting state still matters; full and checkpoint-based synchronization make different starting assumptions.

And everything you use for verification rests on something too.

## What you still trust

There are four layers, each of which fails differently:

**1. Cryptographic assumptions.** That a hash cannot be inverted and a signature cannot be forged without the key. These are not theorems but assumptions supported by the fact that no one has broken them over decades. A breakthrough in cryptanalysis could invalidate them—and a sufficiently large quantum computer would also be enough for elliptic-curve signatures.

**2. Numerical consensus assumptions.** PoW assumes enough hash power follows the rules. PoS and BFT systems assume dishonest weight remains below thresholds that differ for liveness, fork choice, and finality. Crossing one does not “hack” the protocol; it takes the system beyond the conditions under which it made a particular guarantee.

**3. Code correctness.** A specification is one thing; a client is another. A bug can make software verify different rules from the intended protocol. Client diversity limits the reach of one implementation bug; a dominant client can turn it into a network-wide failure.

**4. The social layer.** When failures exceed the written rules, people decide which software and history to recognize. After The DAO hack, most of the Ethereum ecosystem adopted a fork with an irregular state change; dissenters continued the old rules as Ethereum Classic. This layer is invoked rarely, but it still exists.

Hence the precise formula:

> **Trustless removes the need to trust a particular participant or intermediary. Trust in explicit assumptions remains.**

Nor does it promise that the system has no center: permissioned networks and contracts with admin keys still exist.

The exact sync and stake thresholds are separated into [Trust Assumptions and Ethereum Stake Thresholds](../deep-dives/trust-assumptions-and-ethereum-stake-thresholds.md). Read that after the core model is stable.

## Trustless ≠ zero trust

The terms belong to different domains. **Zero trust** security refuses to grant access merely because a request came from a trusted network location. **Trustless** protocols reduce reliance on a counterparty or operator by making results independently verifiable.

Both remove implicit trust, but one governs access and the other governs shared state. Neither term determines who ultimately controls the system.

## Trustless ≠ secure

Three ways to lose everything without breaking a single assumption:

- **You do not verify.** Your wallet asks one RPC provider for balances and transaction status. The protocol may be independently verifiable while your interface still trusts that provider's answers.
- **You signed it yourself.** The protocol will faithfully execute a malicious transaction: it checks your signature, not your intent.
- **You introduced another trust domain.** A custodial exchange or bridge requires trust in its operator. A trust-minimized bridge may avoid a custodian but still adds assumptions about proofs, validators, upgrade keys, or challenge periods.

“Trust-minimized” is often the more useful engineering claim because it invites the next question: which trust remains?

## The cost

- Verifying independently is expensive: it requires a node, synchronization, disk space, and network traffic. Most people do not pay this price—and silently return to trust.
- Base-layer rules in public networks usually change slowly and require broad adoption: trust rests on their predictability. The other side of that bargain is difficult protocol evolution. Permissioned systems and upgradeable applications may concentrate this authority more narrowly.
- A final transaction has no built-in chargeback. Funds can be returned only through a new operation or extraordinary intervention by the social layer.

## Primary sources

- [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf) — simplified payment verification, and what a client takes on faith when it does not validate the chain itself.
- [EIP-779: Hardfork Meta: DAO Fork](https://eips.ethereum.org/EIPS/eip-779) — the irregular state change the fork adopted, and the split that left the original rules running as Ethereum Classic.
- [NIST SP 800-207: Zero Trust Architecture](https://csrc.nist.gov/pubs/sp/800/207/final) — the access-control definition of zero trust that this chapter separates from trustless protocols.

## Check yourself

1. Name four things you continue to trust after running your own node.
2. **Deep dive:** What becomes possible at one third, 34%, more than one half, and two thirds of Ethereum's stake?
3. How does “the protocol was hacked” differ from “the assumption about the honest share was violated”?
4. Why are zero trust and trustless not the same thing, and why does neither term alone determine political centralization?
5. You use a wallet through a public RPC endpoint. Which answers now depend on that provider, and what could you still verify independently?

<!-- corepath:start -->

**Core Path 16/51** · [← Digital Signature of a Transaction](020-digital-signature.md) · [P2P Network, Gossip, and Discovery →](038-p2p-gossip-discovery.md)

<!-- corepath:end -->
