# Network Fork vs Code Fork

> **A code fork copies software development; a network fork creates competing blockchain histories. They can happen independently.**

## Code fork

On GitHub, forking a repository means copying it into another namespace. Developers can experiment, change priorities, or maintain a new product from the same starting code.

```text
one codebase → two development lines
```

No blockchain has to split. Bitcoin Core forks can power private test networks, alternative clients, or unrelated coins. Two teams may also maintain different client implementations that follow exactly the same protocol and stay on one network.

## Network fork

A network fork exists when competing block histories are followed by different nodes. During an ordinary temporary fork, both branches may be valid under one rule set; during a contentious protocol split, each branch may be valid only under its side's rules:

```text
shared history → branch A
               → branch B
```

This can be temporary. Network latency may let two honest producers publish blocks at nearly the same time. Fork choice later selects one branch and the other becomes stale.

A fork can also be deliberate. Some nodes install rules that disagree with other nodes. If both groups keep producing and accepting blocks, the split can become permanent, creating two networks with a shared past.

## Protocol fork

People also call a rule change a **fork**, even when the whole community upgrades and only one chain survives.

A protocol fork defines the activation point for new consensus rules. Whether it creates a lasting network split depends on adoption:

- coordinated upgrade: new rules, one continuing network;
- contentious upgrade: different rules and two surviving networks;
- failed adoption: proposed branch may disappear.

## Why the distinction matters

“The project was forked” is incomplete. Ask what changed:

```text
repository ownership?
consensus rules?
canonical history?
community and economic support?
```

Ethereum clients such as Geth, Nethermind, Besu, and reth have separate codebases but implement one protocol. Ethereum and Ethereum Classic share old history but now operate as separate networks. These are different kinds of divergence.

## Check yourself

1. Can a repository be forked without splitting a blockchain?
2. Why do temporary network forks occur under normal operation?
3. Does every protocol upgrade create two lasting coins?
4. What must you clarify when someone says “the chain forked”?
