# Slashing

> **Slashing deducts validator stake and forces exit for specific, objectively provable violations that threaten consensus safety.**

Ethereum does not slash every mistake. Missing duties causes lost rewards and possibly inactivity penalties. Slashing is reserved for specific consensus contradictions.

Important examples include proposing two blocks for one slot and making conflicting attestation votes, such as double votes or surround votes.

## Why evidence matters

The offense must be provable from signed messages. Anyone can submit the evidence, and the protocol can verify it without guessing the validator's intention.

```text
two incompatible signed messages → objective evidence → protocol penalty
```

The validator is marked slashed, forced toward exit, and penalized over time. Ethereum's correlation penalty grows when much validator balance is slashed in the surrounding window, because correlated violations are more dangerous to consensus; a whistleblower reward also goes to the block proposer that includes the evidence.

## Slashing versus downtime

An offline validator usually fails to sign. A slashable validator signs something contradictory.

This distinction lets the protocol tolerate ordinary outages without treating them as attacks, while strongly discouraging equivocation.

During extended failure to finalize, inactivity penalties increase pressure on offline stake so the active majority can eventually recover finality.

## Operational risk

Slashing can happen through bad operations rather than malicious intent: running the same validator keys on two machines, restoring an old signer database, or misconfiguring failover.

High availability is therefore not “start a duplicate validator.” Safe failover must guarantee that only one active signer can use a key for a duty and preserve slashing-protection history.

Custodians and staking services create correlated risk when many validators share software, infrastructure, or deployment procedures. One mistake can trigger many related penalties.

Slashing protects the protocol's safety incentives. It does not reimburse users for application losses or punish every form of censorship.

## Check yourself

1. What kind of behavior is slashable?
2. Why is downtime normally not slashing?
3. Why do correlated slashings cost more?
4. How can careless failover create a slashable offense?
