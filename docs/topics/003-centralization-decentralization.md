# Centralization, Distribution, and Decentralization

> **In the framework used here, architectural distribution is about machines and failure domains, while political decentralization is about independent owners and control. These are different questions, and they are constantly confused.**

## The picture

Consider a large company's cluster: a thousand servers in fifty data centers across three continents. Any machine can burn down and the service will not notice. It is distributed to the fullest extent.

Yet it is also completely centralized: a single decision by the owner changes the data in all thousand copies at once.

Now consider the opposite: four independent organizations, each with one server. There are fewer replicas and limited architectural fault tolerance—the failure of one may be immediately noticeable. But altering a record requires compromising as many independent organizations as the protocol's threshold demands: a majority in one system, two thirds in another. Their interests differ, and that alone provides protection.

Hence the rule:

> **As a rough mnemonic: architectural distribution protects against accidents; political decentralization protects against unilateral decisions.**

## Three axes

Vitalik Buterin separated the confusion into three independent questions:

| Axis | Question |
|---|---|
| Architectural | How many machines make up the system, and how many can fail? |
| Political | How many independent people and organizations control them? |
| Logical | Does the system appear as one shared object or as a swarm of independent ones? |

He suggests testing the third axis like this: **split the system in half together with its providers and users—can both halves continue to function fully as independent units?**

The first two axes provide different things: the architectural axis provides resilience to accidents, while the political axis provides resilience to collusion and external pressure. The third directly measures neither. Logically decentralized systems, however, survive network partitions more easily: the halves continue to operate on their own.

## The paradox: blockchain is logically centralized

Buterin states it plainly in his framework: blockchains are politically decentralized (no single party controls them) and architecturally decentralized (there is no single infrastructural point of failure), but **logically centralized**.

He offers no caveats, though he should. This describes public networks such as Bitcoin and Ethereum. A permissioned blockchain controlled by one organization is politically centralized: a chain of blocks does not create decentralization by itself.

At the ledger level, a conventional blockchain is logically centralized: it aims to maintain one canonical history and, for state-machine chains, one canonical state. During a network partition, both halves may continue temporarily, but they cannot both remain the canonical continuation once communication is restored without becoming separate networks.

This is not a flaw but the point of the design. A single state can be verified in full, and smart contracts can refer to one another because they live in the same world.

This also contributes to the ceiling described in [Blockchain as a Special Case of DLT](002-blockchain-as-dlt.md): shared state constrains how freely validation and execution can be divided. Parallel execution and sharding are possible, but dependencies must still be coordinated and the canonical result agreed. L2s commonly create **separate state domains**, so applications on different L2s do not interact natively as synchronously as applications within one chain, although interoperability mechanisms can narrow the gap. At the same time, an L2 may be centralized along other axes—for example, it may have a single sequencer. The axes move independently.

## Where the confusion came from

In 1964, while designing communications resilient to the destruction of nodes, Paul Baran described three topologies: centralized (a star), decentralized (several hubs), and distributed (a mesh without hubs).

For Baran, “decentralized” and “distributed” are **two points on one scale** of connectivity. For Buterin, “distribution” and “decentralization” are **two different scales**: machines and owners.

The same words carry two incompatible meanings. If another person uses them differently, you are most likely following different traditions rather than disagreeing on substance.

## How it is measured

A feeling that “it is decentralized” is worth nothing. One proposed metric is the **minimum Nakamoto coefficient**: for a specified subsystem, attack objective, and failure threshold, the minimum number of independent entities whose combined control crosses that threshold.

It can be estimated separately for essential subsystems—consensus power, clients, development, exchanges, ownership, or infrastructure—and the lowest result used as a warning about the weakest concentration point. The result is not a universal decentralization score: it depends on the chosen threat model, threshold, subsystem, and correct grouping of addresses or nodes into real controlling entities. Even with those limits, it exposes imbalances: a network may have thousands of validators but only three pool operators that control a decisive share.

## The cost

In practice, the axes are not independent—pull one and the others move:

- raise node requirements to gain speed → there may be fewer nodes and independent operators → architectural decentralization falls, and political decentralization may eventually fall as well;
- move the workload to L2s → state is no longer a single whole → synchronous composability breaks (Part XIV);
- add machines under one owner → distribution increases, while decentralization does not change at all.

The last point is the most common way to pass one off as the other.

## Check yourself

1. A company has a cluster of a thousand servers: is it distributed? Is it decentralized? Why are the answers different?
2. Apply the partition test to a blockchain and to a torrent network. Can both halves continue independently, and can both blockchain halves remain canonical after reconnection?
3. Why is a blockchain's logical centralization not a flaw?
4. What does the Nakamoto coefficient measure, which assumptions must be specified, and why is it calculated per subsystem rather than for the system as a whole?
5. A network raises node hardware requirements to increase throughput. Along which axis does it move first, and why not immediately along the political axis?
