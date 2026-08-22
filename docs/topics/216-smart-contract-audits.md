# Smart Contract Audits

> **An audit is an expert review of a defined code snapshot under stated assumptions. It reduces uncertainty; it does not certify that the deployed system cannot fail.**

## What an audit can provide

Reviewers reconstruct architecture and invariants, inspect trust boundaries, test attack paths, run analysis tools, and report concrete findings with severity and remediation guidance.

A good report also documents centralization, upgrade, oracle, token, and operational assumptions that may be intentional rather than code bugs.

The team's response matters: fixed, acknowledged, disputed, or out of scope are different outcomes.

## The scope boundary

An audit covers exact repositories, commits, contracts, chains, and time. It may exclude deployment scripts, frontend signing, off-chain bots, governance, external protocols, or later upgrades.

Changing one storage layout, initializer, compiler setting, or integration after review can invalidate conclusions.

## What it cannot promise

An audit cannot exhaust every input and economic state in a composable adversarial system. Review time is finite; documentation may be wrong; dependencies and market conditions change.

An “audited” badge says almost nothing without the report, commit hash, scope, unresolved findings, and deployed bytecode match.

## Security is a pipeline

Strong projects combine threat modeling, simple design, tests, fuzzing, invariant testing, static analysis, independent reviews, deployment verification, monitoring, rate limits, incident response, and bug bounties.

Auditors find more when the team supplies clear invariants and mature tests. They should not be the first people to discover what the protocol is supposed to do.

## Reading a report

Focus on assumptions and high-impact paths, not finding count. Ten informational notes can be less important than one acknowledged admin key able to replace all logic instantly.

The audit is evidence in a security argument—not the argument itself.

## Check yourself

1. What exact artifact does an audit review?
2. Why can a later upgrade invalidate an audit?
3. Which report fields matter more than an “audited” badge?
4. Why should a team define invariants before reviewers arrive?
