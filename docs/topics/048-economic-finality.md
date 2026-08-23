# Economic Finality in Proof of Stake

> **A finalized PoS block can be reversed only by violating consensus and exposing large amounts of stake to destruction.**

Proof-of-work confidence grows gradually with depth. Ethereum proof of stake adds a distinct event: explicit checkpoint finality through Casper FFG.

Validators attest not only to the current head but also to checkpoint links. When enough stake supports the required links, a checkpoint becomes justified and then finalized.

## What finality means

A normal short reorg can replace recent blocks before finality. Replacing a finalized checkpoint would require a large set of validators to produce conflicting votes.

Those votes are publicly provable slashable offenses. The protocol can destroy stake and eject offenders.

```text
finality = consensus evidence + economic penalty for contradiction
```

This is economic, not mathematical, irreversibility. Software can contain bugs, social coordination can choose an exceptional recovery fork, and an attacker may value disruption more than the burned stake.

## Safety and liveness fail differently

More than one-third of active stake can prevent a two-thirds supermajority by refusing or failing to vote correctly. The chain may keep producing blocks, but checkpoints stop finalizing; Ethereum's inactivity leak can eventually reduce the inactive stake's effective weight and restore finality.

Two conflicting finalized checkpoints imply that at least one-third of the relevant validator weight violated Casper's slashing conditions, under the accountable-safety assumptions and validator set in scope. Merely going offline can delay finality without immediately creating slashable equivocation evidence, whereas conflicting finalization requires provable contradictory votes and an out-of-band recovery choice.

## Application consequence

Ethereum exposes several confidence levels:

- **head/latest:** current fork-choice tip, easiest to reorg;
- **safe:** strongly supported but not fully finalized;
- **finalized:** protected by the finality mechanism.

Wallets may show recent transactions quickly. Bridges, exchanges, and high-value systems often wait for a stronger level.

A provider's `finalized` label is still a report. Critical systems should obtain it from a trusted node or verified consensus data.

## Primary sources

- [Ethereum consensus specification: Beacon Chain](https://github.com/ethereum/consensus-specs/blob/master/specs/phase0/beacon-chain.md) — checkpoint justification, finalization, rewards, inactivity penalties, and slashing.
- [Casper the Friendly Finality Gadget](https://arxiv.org/abs/1710.09437) — accountable safety and the economic meaning of conflicting finalized checkpoints.

Last verified: 2026-08-22.

## Check yourself

1. What makes PoS finality economic?
2. How can stake stop finality without rewriting it?
3. Why is finalized not mathematically immutable?
4. Why do applications use different confidence levels?

<!-- corepath:start -->

**Core Path 29/51** · [← Probabilistic Finality](047-probabilistic-finality.md) · [Externally Owned Account →](087-externally-owned-account.md)

<!-- corepath:end -->
