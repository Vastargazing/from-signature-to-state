# Network Protocol: Consensus Rules and Policy Rules

> **Consensus rules decide what is valid. Policy rules decide what a node accepts before confirmation, relays, or proposes for inclusion. A consensus disagreement can split the chain—or leave incompatible nodes stuck—once a triggering block appears. Policy remains local.**

## The picture

The law decides whether a ride is legal. A taxi company decides whom it will carry.

A passenger refused by one car does not become an outlaw—another may pick them up. Conversely, a taxi company's approval does not legalize a ride prohibited by law.

The same applies here. Your node may refuse to accept a transaction into its mempool or relay it. But if that transaction nevertheless enters a block, your node cannot reject the block **because of it**: the transaction is valid under consensus rules.

This does not mean that “the block will become canonical.” A node can accept a block as valid, place it on a side branch, and not select it as the chain head. Fork choice, not validation, makes that decision (see [Linking Blocks with Hashes](009-hash-linking.md)).

## Three layers of rules

People usually speak of two, but there are three, and the first two are confused most often.

| Layer | Answers the question | What if a peer acts differently? |
|---|---|---|
| **Consensus** | what is valid | the same block is judged differently; incompatible nodes may split or stop following the chain |
| **Policy** | what I accept, relay, and put in my block | nothing: different mempools, different block contents |
| **Network protocol** | how nodes communicate | compatible versions negotiate; incompatible peers may fail to exchange messages or disconnect |

**Consensus rules:** signature correctness, absence of double-spending, compliance with the block gas limit, correct state transition, reward amount.

**Policy rules:** minimum relay fee, transaction size and “standardness” limits, mempool memory ceiling, transaction-replacement conditions, willingness to accept transactions from private channels.

**Network protocol:** message formats, capability negotiation, and network identification. In Ethereum's `eth` protocol, the initial status message includes the protocol version, network identifier, genesis hash, and fork identifier from [The Genesis Block](011-genesis.md).

## How to tell: one question

> **Could the difference cause nodes to judge the same block or state transition differently?**

If yes, the rule is consensus-critical. If no, it is policy.

There is an important timing caveat: different consensus rules do not cause a visible failure at the moment the software diverges. The disagreement appears when a block arrives that one implementation accepts and another rejects. If both rule sets retain producers and followers, the result can be a persistent split; otherwise the incompatible minority may simply stop at the last commonly accepted block.

Apply the test to examples already encountered:

- **replacing a transaction with the same nonce and a higher fee** ([A Transaction and Its Fields](007-transaction.md)) is policy. Cancellation does not exist at the consensus layer; nodes merely decide differently whether to accept the replacement;
- **private transaction-submission channels** are policy. The delivery method does not affect validity;
- **refusing to connect when genesis differs** ([The Genesis Block](011-genesis.md)) is the network protocol;
- **rejecting a block with an incorrect `stateRoot`** ([State and the State Transition Function](006-state-transition.md)) is consensus.

## Policy does not make a transaction invalid

This is the key consequence, and it must be stated carefully.

> **Policy cannot strip a transaction of validity. Whether the transaction enters a block, however, depends on whether at least one producer is willing to include it.**

Usually, **one** block producer is enough. Everyone else may refuse to relay the transaction; it can reach that producer directly, and all nodes will accept the resulting block as valid.

A second caveat: “valid” is not a property of a transaction in isolation, but of a transaction in the context of state. While it waits, its nonce may be consumed, its balance may become insufficient, or the base fee may rise above `maxFeePerGas`. Policy does not make it invalid, but time and other transactions certainly can.

This happened with Bitcoin inscriptions: part of the community proposed filtering them during relay, but such filters operate at the policy layer and the transactions remained valid under consensus. Anyone who wanted to could include them.

The opposite case shows the boundary of this rule. When block producers began filtering transactions against sanctions lists, the protocol did not change: transactions that were otherwise consensus-valid remained so, but were not included by those producers. Policy did not take away validity, but coordinated filtering restricted access to block space.

There is a further step. One willing producer is enough to build a block, but the block must still survive fork choice. If producers and validators act in concert and refuse to build on inconvenient blocks, the issue ceases to be pure policy and starts affecting chain canonicity. This is precisely why inclusion lists are discussed: they move inclusion requirements into protocol rules. [Private transactions](205-private-transactions.md) and the treatment of [sanctioned mixers](270-mixers-tornado-cash-and-ofac.md) expose that boundary in practice.

## Why the distinction matters in practice

**Policy can be changed unilaterally.** Neither network agreement nor a fork is needed: raise your node's minimum fee, and that is all.

**A rule is sometimes tested as policy before being enshrined in consensus.** Strict DER encoding of Bitcoin signatures became a relay rule in version 0.8.0 and only later a consensus rule through BIP-66 in 2015. This is not a mandatory stage, but it is a common technique: divergence in policy is safe, while divergence in consensus means a split.

**Policy divergence is normal.** Different nodes have different mempools. This is not a failure but the network's ordinary state.

## The cost

- policy cannot be relied upon: something your node refuses to relay may still enter a block;
- “this is a protocol change” more often hides a policy change than a consensus change, and you must distinguish them yourself;
- much censorship occurs through relay and block-construction policy, but economic coordination and protocol rules can also influence inclusion; preventing it requires mechanisms designed specifically for inclusion;
- policy strongly affects whether and how quickly a transaction enters a block, but unlike consensus validity it may be bypassed by reaching a producer with different policy.

## Primary sources

- [BIP-66: Strict DER signatures](https://bips.dev/66/) — a policy rule later activated as a Bitcoin consensus rule.
- [Bitcoin Core policy sources](https://github.com/bitcoin/bitcoin/tree/master/src/policy) — local standardness and fee policy kept separate from consensus validation code.

Last verified: 2026-08-22.

## Check yourself

1. State the question that distinguishes a consensus rule from policy.
2. A transaction is valid, but your node does not relay it. Can it enter the canonical chain? What conditions must align?
3. Why is “valid” a property of a transaction in context rather than of the transaction alone?
4. What exactly can policy do to a transaction, and what can it not do? Analyze censorship as an example.
5. Is nonce-based transaction replacement consensus or policy? What about rejecting a block with an incorrect `stateRoot`?
6. Why does policy divergence not by itself split validity, while consensus divergence can split the chain or halt incompatible nodes?
