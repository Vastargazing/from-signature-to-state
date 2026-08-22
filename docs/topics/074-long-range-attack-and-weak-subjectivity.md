# Long-Range Attacks and Weak Subjectivity

> **An offline PoS node needs a recent trusted checkpoint because old validator keys can sign an alternative history at little present-day cost.**

In proof of work, rebuilding years of history requires reproducing enormous accumulated work. In proof of stake, validators who exited long ago may no longer have stake at risk.

If their old keys are sold or stolen, an attacker can use them to sign a fabricated chain beginning far in the past. Creating those signatures is computationally cheap.

## Why current nodes are safe

Online nodes already know which checkpoints finalized as the chain progressed. They reject an alternative that conflicts with finalized history.

The ambiguity appears for a new node—or one offline for a very long time—that sees two internally consistent histories and has no recent trusted context.

Signatures alone show that historical keys signed each branch. They do not reveal which branch the live community continued using.

## Weak subjectivity

The node starts from a sufficiently recent checkpoint obtained through a trusted source, distribution channel, or comparison of independent sources. From there it verifies consensus updates normally.

```text
recent trusted checkpoint + protocol verification → secure current view
```

“Weak” means trust is limited in time and scope. Users do not trust a server for every balance; they trust one recent finalized anchor and verify forward.

The required freshness depends on the protocol's validator-exit and slashing assumptions. Client software and community channels help publish suitable checkpoints.

## The honest description

Weak subjectivity is not a defect hidden behind mathematics. It is an explicit bootstrapping assumption in long-lived proof-of-stake systems.

The comparable question for every chain is how a brand-new node distinguishes the canonical history: accumulated work, recent checkpoint, validator set, social consensus, or another external anchor.

## Check yourself

1. Why are old PoS signatures cheap to create?
2. Why are continuously online nodes less exposed?
3. What does a weak-subjectivity checkpoint provide?
4. What does the node verify after the checkpoint?
