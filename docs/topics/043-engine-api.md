# Engine API

> **The Engine API is the private control channel between Ethereum's consensus and execution clients.**

JSON-RPC serves wallets and applications. The Engine API serves a different caller: the local consensus client.

It lets consensus submit payloads for execution validation, update the execution client's head, safe, and finalized references, and initiate and retrieve a candidate payload for local block production.

## The core exchange

Conceptually, three actions repeat:

```text
newPayload          → validate this execution payload
forkchoiceUpdated   → update head/safe/finalized; optionally start building
getPayload          → return the candidate payload for a build ID
```

During validation, the execution client runs transactions and returns a status such as valid, invalid, or syncing. Consensus must treat those states correctly; “I do not have enough data yet” is not the same as “the block is invalid.”

During local proposal, consensus supplies the parent via fork choice and passes fork-specific payload attributes. Execution starts a build, returns a payload ID, and later returns the corresponding candidate when requested.

## Why authentication matters

The Engine API can change the execution client's canonical view and block-building work. It is authenticated with a shared JWT secret and should not be exposed to the public internet.

If an attacker controls this channel, ordinary wallet signatures do not protect node operation. The attacker may feed fake fork-choice updates, disrupt payload production, or exhaust resources.

## Versioning follows forks

Ethereum upgrades add payload fields and Engine API method versions. Both clients must support compatible fork rules at the activation point. A mismatch can leave an otherwise healthy node unable to validate or propose blocks.

For operators, the debugging checklist is short: both clients synced, same network and fork schedule, correct shared JWT secret, reachable private endpoint, compatible method versions, and sufficiently accurate system clocks.

The boundary is:

```text
Engine API carries coordination
it does not replace either client's validation
```

## Check yourself

1. Which two programs use the Engine API?
2. Why is `SYNCING` different from `INVALID`?
3. Why must the endpoint stay private?
4. How can a protocol fork break client compatibility?
