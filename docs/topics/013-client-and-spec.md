# Client and Specification

> **The network executes code, not a specification. If implementations diverge, a fork results—and consensus weight, or ultimately the social layer, decides which branch becomes canonical, not numerical dominance alone.**

## The picture

A specification describes the rules. A client is a program that implements them. The distinction looks formal right up until they diverge.

Then an uncomfortable fact emerges: nodes, not documents, build the chain. Behavioral divergence does not resolve itself. Once a triggering block appears, incompatible nodes may follow different branches or some may simply stop; the specification cannot enforce which implementation the ecosystem will treat as canonical.

## The Bitcoin split of March 2013

On March 12, 2013, the Bitcoin network split in two, and no one planned it.

Versions before 0.8.0 used BerkeleyDB, which limited the number of simultaneous locks. Version 0.8.0 switched to LevelDB, removing that limit with it.

Block 225430 contained an unusually large number of transaction inputs—more than the network had seen before. Processing it required over ten thousand BerkeleyDB locks. Nodes running 0.8 accepted it without difficulty: LevelDB had no such limit. Nodes running 0.7 could not read it and rejected it.

The two networks ran in parallel for six hours and twenty-four blocks. At the peak, the 0.8 branch had around 60% of the hash rate. It was therefore heavier and, under the ordinary fork-choice rule, would have become canonical. Automation did not reverse the outcome; two mining pools did. BTC Guild and Slush **deliberately** rolled their nodes back to 0.7 and accepted lost revenue to restore a majority of the computational power to the old chain. The decision was coordinated on IRC. The postmortem is recorded in BIP-50.

Four lessons are worth taking away:

- **The limit appeared in no specification.** It was a side effect of a database library and was simply unknown. Under the test from [Consensus Rules and Policy Rules](012-consensus-vs-policy.md), however, it was consensus-critical: nodes judged the same block differently. Behavior, not its presence in a document, makes something a consensus rule.
- **The heavier branch did not win.** Version 0.8 had the hash-rate advantage, which is exactly why direct human coordination determined the outcome: left alone, the protocol's own fork-choice logic would have led elsewhere.
- **Both implementations believed they were right.** The dispute was not about who had broken a rule, but about a rule that turned out to have been incompletely recorded.
- **People, not the protocol, saved the situation**—the social layer from [Trustless](004-trustless.md): miners were asked to roll back, and they did.

## Why there should be multiple clients

[Trustless](004-trustless.md) introduced Ethereum's threshold ladder: one third stops finalization, around one half controls the chain head, and two thirds can finalize their own version.

The key observation:

> **The ladder does not distinguish malice from a bug.**

A consensus client used by more than two thirds of the stake can finalize a chain produced under the same implementation error. Correct clients may reject that chain rather than follow it, creating a severe split that requires coordinated recovery. No villain is needed—identical programs making the same mistake are enough.

Hence the rule:

> **A client's validator share determines which consensus thresholds an isolated bug in that client can cross. It is not a universal upper bound on damage.**

If a consensus-critical bug is isolated to a client used by less than one third of the active stake, the remaining validators can usually continue finalizing while affected validators drop out or incur penalties. Shared libraries, specification errors, and bugs spanning several clients can defeat this isolation assumption. This is the basis for the practical diversity target that no consensus client should approach one third.

Outside consensus, the calculation differs. If a major RPC provider relies on one client, its failure affects many users regardless of that client's validation share.

## Diversity is not free

- every new implementation creates a new surface for its own bugs;
- coordinating behavior among several teams costs more than coordinating one;
- the specification must be written so that it cannot be read in two ways—a separate and difficult task.

Diversity therefore rests not on good intentions but on tests: suites of reference vectors and identical scenarios run across all clients.

## How the specification is organized

**Bitcoin has no single normative specification.** Bitcoin Core's behavior is the de facto compatibility reference, but the rules are ultimately defined by the code that network participants agree to run; publishing a BIP changes nothing by itself. The 2013 split resulted not from the absence of a specification as such, but from a library's incidental limit silently becoming consensus-critical.

**Ethereum separates specifications from clients**, but no single document defines the whole modern system. The Yellow Paper describes the execution layer up to a particular fork; executable execution and consensus specifications track current fork behavior; EIPs describe proposed and adopted changes; API and networking specifications cover their own interfaces. There are multiple implementations in different languages: on the execution layer, Geth and Erigon in Go, Nethermind in C#, Besu in Java, and Reth in Rust; the consensus layer has its own set.

[Reth](259-reth-ethereum-execution-client.md) is the natural entry point for a Rust developer.

## The cost

- a document does not execute: divergence between code and specification may remain undetected until it reaches a live network. Tests reduce this risk but cannot eliminate it;
- diversity requires continuous effort, while systems tend to drift toward monoculture as the most convenient client wins;
- the stricter the specification, the slower protocol evolution becomes;
- the effects of a bug in a dominant client are indistinguishable from an attack.

## Primary sources

- [BIP-50: March 2013 Chain Fork Post-Mortem](https://bips.dev/50/) — the BerkeleyDB lock limit, competing branches, hash-power split, and coordinated downgrade.
- [Ethereum execution specifications](https://github.com/ethereum/execution-specs) — executable reference behavior and generated consensus fixtures for the execution layer.
- [Ethereum consensus specifications](https://github.com/ethereum/consensus-specs) — the consensus-layer specification implemented by independent clients.

Last verified: 2026-08-22.

## Check yourself

1. A client with most of the hash rate diverges from the specification. Must its branch become canonical? What determined the outcome in 2013?
2. Why can the 2013 split not be reduced to someone breaking the rules?
3. How does one client's share relate to the threshold ladder from [Trustless](004-trustless.md)?
4. Why is an implementation with more than two thirds dangerous?
5. What does client diversity provide, and what does it cost?
