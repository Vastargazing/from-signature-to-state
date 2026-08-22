# Linking Blocks with Hashes

> **A hash chain provides two things: an indivisible past and an order. It provides neither validity, uniqueness, nor time—other mechanisms are responsible for those.**

## What is linked to what

`parentHash` is the hash of the previous block's **header**, not of the entire block.

This looks like an optimization but works as leverage. In Ethereum, the header carries tree roots for transactions, receipts, and state; Bitcoin has a transaction Merkle root but no receipt or state root (see [A Block and the Transactions Inside It](008-block.md)). In either case, commitments in the header bind it to the relevant body data: change a transaction, and the transaction root changes; then the header hash changes; then the child's parent link no longer matches.

> **The header is a compact representative of the entire block. The chain is built from these representatives.**

## What linking provides

**Indivisibility.** Block 100 cannot be changed independently: it is glued to 101, which is glued to 102, and so on to the head. Editing one element creates an obligation to rebuild the entire tail.

**Order.** For any two blocks on one chain, it is unambiguous which came first. This is exactly the order from which [State and the State Transition Function](006-state-transition.md) derives state.

**A measure of distance.** The chain tells us how far a block is from the head. What that distance **means**, however, is a matter of consensus, not hashes.

In PoW, depth serves as a security heuristic: the more confirmations there are, the harder it is to catch up with the honest chain; [Probabilistic Finality](047-probabilistic-finality.md) develops that model. In Proof-of-Stake Ethereum, status rather than depth matters—a block becomes justified and then finalized. More than one third of the stake can prevent finality; conflicting finalization implies that at least one third violated slashable rules, while an attacker controlling about two thirds can finalize a preferred history without honest votes. Recovery from conflicting finality ultimately also requires social coordination.

## What linking does not provide

Four things are wrongly attributed to it.

**It does not provide cost.** Recomputing links is ordinary hashing and is cheap. Something else is expensive: in PoW, a suitable hash must be searched for again for every rebuilt header, and this work is what costs money. This is the distinction from [Blockchain as a Special Case of DLT](002-blockchain-as-dlt.md).

**It does not provide validity.** A perfectly linked chain of garbage remains a perfectly linked chain. Hashes say that “the contents have not changed,” but say nothing about whether those contents were valid. This is why a PoW light client must **assume** that the heaviest chain was built on valid blocks.

**It does not provide uniqueness.** Nothing prevents two different blocks from referring to the same parent. A fork results, with both branches linked correctly. Hashes cannot choose one chain; that is the job of the [fork-choice rule](073-fork-choice-rule.md), while a [51% attack](072-51-percent-attack-and-reorganization.md) changes which branch can accumulate weight.

**It does not provide time.** A chain proves sequence, not a moment in time. A block timestamp is a claim made by the block's producer and constrained by separate consensus rules that differ by network. In Bitcoin, the timestamp must exceed the median of the previous eleven and not be too far in the future—a broad range. In Proof-of-Stake Ethereum, it is tied to a slot and therefore strict. But this comes from validation rules, not hash linking.

> **A chain orders. It does not date.**

## Chains and trees are different tools

Both structures use hashes, but they solve different problems:

| | Block chain | Merkle tree |
|---|---|---|
| Answers the question | what came earlier | is an item in the set |
| Operates | between blocks | inside a block |
| Provides | order and indivisibility | proof of membership |
| Verification cost | linear in chain length | logarithmic in set size |

Each half works on its own, but does not provide everything. A chain without a tree preserves block order but offers no short proof for a single transaction. A [Merkle tree](016-merkle-tree.md) without a chain proves membership relative to a chosen root but says nothing about whether that root is canonical or current.

## What it rests on

It rests on the strength of the hash function—the first layer of trust from [Trustless](004-trustless.md). But there are two threats, and their significance differs.

**Second preimage.** Take an existing header and find a different one that produces the same hash. This is what “rewriting the past” means: the child still refers to the same `parentHash`, the link formally survives, but the contents differ. It is the hardest task for an attacker—and the most destructive if solved.

**Collision.** Find two headers of **your own** with the same hash. This cannot rewrite history, but a block builder could prepare the pair in advance and substitute one after the other was accepted. The task is considerably easier than finding a second preimage, and it is the first property of a hash function to break.

Both properties matter, but for different reasons: the integrity of an already accepted block depends primarily on second-preimage resistance, while collision resistance prevents a creator from preparing two contents for the same hash in advance.

One caveat: finding a collision does not automatically let someone replace an accepted block—its contents may also be bound by signatures and consensus rules. Even so, changing the hash function of a live network is not cosmetic surgery but open-heart surgery.

## The cost

- rebuilding one old block means rebuilding the entire tail; this is both the protection and the reason an honest mistake cannot simply be corrected;
- using depth as a security measure means waiting: a payment must accumulate confirmations before it is considered reliable;
- the chain is linear in meaning, but not in verification: header hashes and links can be checked independently, and therefore in parallel. State transitions remain sequential because each depends on the preceding result;
- hash security is necessary but not the only protection behind immutability: consensus work or stake, signatures, checkpoints, and social recovery also matter. For an accepted block, second-preimage resistance is the directly relevant hash property; finding an arbitrary collision alone does not rewrite the chain.

## Check yourself

1. Why hash the header instead of the whole block, and why is that enough?
2. A chain is perfectly linked. What does that prove, and what does it not prove?
3. Why does hash linking not prevent a fork?
4. How does a chain's job differ from a Merkle tree's job?
5. How does a collision threat differ from a second-preimage threat, and which one means “rewriting the past”?
