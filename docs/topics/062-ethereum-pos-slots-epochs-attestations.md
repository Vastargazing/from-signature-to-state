# Ethereum PoS: Slots, Epochs, and Attestations

> **Slots schedule block opportunities; epochs group slots for validator duties and finality accounting.**

Ethereum time is divided into 12-second slots. One validator is selected to propose a beacon block for each slot, though a slot can remain empty.

Thirty-two slots form an epoch. Validators are assigned to committees and attest during scheduled slots.

## What an attestation says

An attestation combines two votes:

- a fork-choice vote for the validator's view of the chain head;
- a source-and-target checkpoint vote used by Casper FFG finality.

The head vote feeds LMD-GHOST. The checkpoint vote helps justify and finalize epochs when enough stake agrees.

```text
proposal → candidate block
attestations → head support + checkpoint support
```

Attestations from compatible validators can be aggregated with BLS signatures, reducing network data while retaining participation information.

## Missing versus conflicting

An offline validator misses rewards and may receive inactivity penalties. A validator that signs contradictory proposals or votes can be slashed.

These are deliberately different. Temporary downtime harms liveness and earns smaller penalties; equivocation threatens safety and receives severe punishment.

## Execution still has its own client

Beacon blocks carry execution payloads. The consensus client verifies consensus duties and asks the execution client to validate the payload through the Engine API.

A slot is therefore not simply “an EVM block timer.” It is a consensus-layer opportunity whose block may include an execution-layer payload.

Network delays, missed proposers, or insufficient participation can produce empty slots or delay finality even though the clock continues advancing.

A slot is one proposal opportunity. An epoch groups 32 slots into the rhythm used for validator duties and checkpoints. An attestation is the weighted vote that connects the live head to that slower finality process.

## Primary sources

- [Ethereum consensus specification: Beacon Chain](https://github.com/ethereum/consensus-specs/blob/master/specs/phase0/beacon-chain.md) — slots, epochs, committees, attestations, rewards, penalties, and slashable votes.
- [Ethereum consensus specification: Bellatrix](https://github.com/ethereum/consensus-specs/blob/master/specs/bellatrix/beacon-chain.md) — execution payloads carried by beacon blocks after the Merge.

Last verified: 2026-08-22.

## Check yourself

1. How many slots form an epoch?
2. What two claims does an attestation carry?
3. Why is downtime treated differently from equivocation?
4. Which client validates the execution payload?
5. More than one-third of active stake goes offline while proposers still appear. Can slots and blocks continue, and what happens to checkpoint finality?

<!-- corepath:start -->

**Core Path 25/50** · [← Proof of Stake](061-proof-of-stake.md) · [LMD-GHOST and Casper FFG →](063-lmd-ghost-and-casper-ffg.md)

<!-- corepath:end -->
