# SegWit, the Block Size Wars, and Bitcoin Cash

> **Bitcoin's scaling dispute was not only about bytes. It was about which layer should scale and who gets to change consensus rules.**

## The pressure

Bitcoin did not launch with a one-megabyte limit; that consensus limit was added in 2010. By the scaling dispute, pre-SegWit blocks were limited to 1,000,000 serialized bytes, and growing demand produced fee pressure and delayed low-fee transactions.

One camp favored substantially larger blocks so more payments could settle directly on-chain. Another emphasized keeping node requirements modest and scaling through batching and layers such as Lightning.

The technical parameter carried a governance question: who could legitimately decide the new rule?

## What SegWit changed

Segregated Witness introduced a separate witness serialization for signatures and related data. A witness Merkle root is committed through an output in the coinbase transaction, which is itself committed by the block header's ordinary transaction Merkle root.

It introduced **block weight**, discounting witness bytes. This increased effective capacity without a simple hard-fork limit increase.

For transactions whose inputs use the SegWit rules, witness signature data no longer affects the legacy `txid`, removing the major source of involuntary third-party malleability. It did not eliminate every intentional or non-SegWit form of malleability, but it made dependable unconfirmed dependency chains and Lightning-style protocols practical.

It was designed as a soft fork: old nodes could accept SegWit blocks while upgraded nodes enforced the new witness rules.

## Why the conflict became a war

Participants disagreed over activation, miner signaling, development influence, node costs, and Bitcoin's direction.

SegWit activated on Bitcoin in 2017. Around the same period, supporters of larger base-layer blocks launched an incompatible hard fork.

## Bitcoin Cash

Bitcoin Cash continued from Bitcoin's existing transaction history under changed consensus rules, most visibly a larger block-size limit. It became a separate network and asset, **BCH**.

Anyone controlling keys before the split could control corresponding unspent coins on both chains, subject to later spending, each chain's rules, and wallet support. Bitcoin Cash's mandatory fork-ID signature scheme gave post-split transactions replay separation, but users still needed to handle pre-split keys and software carefully.

## The lasting lesson

The chain with more hash power at one moment does not alone define the social meaning of “Bitcoin.” Nodes enforce rules, miners produce blocks, businesses provide liquidity, developers ship software, and users assign value.

Protocol governance is the coordination of all these groups—not a maintainer merge button or a miner poll.

## Primary sources

- [BIP-141: Segregated Witness](https://bips.dev/141/) — witness commitment, block weight, and soft-fork validation rules.
- [Bitcoin Cash UAHF technical specification](https://upgradespecs.bitcoincashnode.org/uahf-technical-spec/) — the incompatible rule changes and fork-ID replay protection used at the split.

Last verified: 2026-08-22.

## Check yourself

1. What two technical benefits did SegWit provide besides a simple capacity increase?
2. Why could SegWit be deployed as a soft fork?
3. What made Bitcoin Cash a separate network?
4. Why was the block-size dispute also a governance dispute?
