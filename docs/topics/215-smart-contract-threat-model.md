# Smart Contract Threat Model

> **A threat model names what must stay true, who may try to break it, and which powers or dependencies make that possible.**

The Core Path ends here because every mechanism introduced so far—keys, contracts, L2s, data publication, sequencers, and privileged upgrades—becomes part of an application's security boundary.

## Start from assets and invariants

Do not begin with a checklist of famous bugs. Begin with what the system protects:

- deposited tokens;
- correct share accounting;
- permission to mint or upgrade;
- solvency of loans;
- availability of withdrawals;
- fairness of an auction.

Turn each into an invariant: total claims cannot exceed backing; only a verified message can mint; one withdrawal can execute once.

## Name the actors

Assume any public caller is adversarial. Also model privileged actors, token issuers, oracle operators, sequencers, governance voters, keepers, signers, and integrators.

For each actor, ask what happens if it is malicious, compromised, offline, or merely wrong.

`onlyOwner` does not remove a threat. It moves the threat to the owner key and its operating process.

## Follow every trust boundary

External calls cross into code whose behavior may change. Oracles cross from on-chain verification to off-chain facts. Proxies cross from current logic to future logic. Bridges cross into another consensus system.

```text
user input → contract logic → external dependency → privileged control
```

The effective system includes every component able to violate an invariant, even if it lives outside the repository.

## Separate safety and liveness

Safety means a forbidden state never occurs: no unauthorized mint, no double withdrawal. Liveness means valid users can eventually act: withdraw, repay, or exit.

A pause may preserve safety while breaking liveness. An emergency key may restore liveness while becoming a safety risk.

## Make assumptions testable

Write concrete limits: maximum oracle age, signer threshold, admin delay, token behaviors, chain finality, supported decimals, maximum loop size.

“The oracle is secure” cannot be tested. “No price older than 30 minutes can authorize borrowing” can.

## Check yourself

1. Why begin with invariants rather than vulnerability names?
2. How does `onlyOwner` move the threat boundary?
3. What is the difference between safety and liveness?
4. Which kind of assumption is useful in a test?
5. A lending protocol pauses borrowing whenever its oracle is stale. Which property does the pause protect, which property does it weaken, and what additional path should the threat model examine?

<!-- corepath:start -->

**Core Path 51/51** · [← ERC-4337](169-erc-4337.md) · [Choose a specialization →](../core-path.md#choose-a-specialization)

<!-- corepath:end -->
