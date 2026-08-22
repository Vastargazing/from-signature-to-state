# EIP and BIP Process

> **An EIP or BIP is a public specification and coordination artifact—not a command that automatically changes a network.**

## What the documents do

An **Ethereum Improvement Proposal** or **Bitcoin Improvement Proposal** describes a change precisely enough to discuss, review, test, and implement.

Depending on the proposal, it may specify:

- consensus rules;
- networking or client behavior;
- application standards such as token interfaces;
- process or informational guidance.

The document creates a stable number and shared vocabulary. “EIP-1559” is easier to review than an idea scattered across chats and code patches.

## A repository is not a parliament

Editors check structure, clarity, licensing, and process requirements. Merging a document into the repository does not mean editors endorse it or the network adopted it.

```text
published specification ≠ implemented code ≠ activated rule
```

Authors must build technical and social support. Client teams implement the proposal, reviewers test it, stakeholders debate tradeoffs, and an activation mechanism coordinates deployment.

An EIP marked **Final** is the final standard under EIP-1 and should receive only errata or non-normative clarification. Core EIPs need client implementations to reach that status, but the status alone still does not prove Mainnet activation or unanimous support.

Bitcoin's current process is BIP-3, which replaced BIP-2 and uses the statuses **Draft**, **Complete**, **Deployed**, and **Closed**. “Complete” means the authors recommend adoption and regard the specification as ready; “Deployed” additionally requires evidence of active use or activation. Neither repository publication nor a status label substitutes for checking the software and network in question.

## Different coordination cultures

Ethereum protocol changes are discussed through EIPs, research forums, client teams, and AllCoreDevs coordination before inclusion in a named network upgrade.

Bitcoin uses BIPs, mailing-list discussion, implementations, miner signaling in some activations, node adoption, and broader economic coordination. Under BIP-3, editors apply publication and process criteria but do not decide whether the ecosystem adopts a proposal.

Neither process reduces governance to one formal vote. Running software, accepting assets, producing blocks, operating infrastructure, and building applications all express adoption.

## How to read a proposal

Start with:

1. status and type;
2. motivation and exact specification;
3. backwards compatibility;
4. security considerations;
5. implementation and activation status.

Do not quote an old draft as current protocol behavior. The proposal number stays stable while details and status may evolve.

## Primary sources

- [EIP-1: EIP Purpose and Guidelines](https://eips.ethereum.org/EIPS/eip-1) — Ethereum proposal types, statuses, and editor responsibilities.
- [BIP-3: Updated BIP process](https://bips.dev/3/) — current Bitcoin proposal statuses and adoption boundaries.

Last verified: 2026-08-22.

## Check yourself

1. What useful role does a numbered improvement proposal play?
2. Does repository acceptance activate a consensus change?
3. What does an EIP's Final status actually say?
4. Why must you separately verify implementation and network activation?
