# Interactions Between Multiple Contracts

> **One Ethereum transaction can execute a whole call tree across many contracts, and the tree commits atomically unless failures are handled.**

## Message calls, not new transactions

Suppose a user calls a router:

```text
user transaction
└── router
    ├── token.transferFrom
    ├── pool.swap
    └── token.transfer
```

Only the outer transaction has a signature and account nonce. Contract-to-contract interactions are EVM message calls inside that transaction.

Each external call gets a new frame with its own stack, memory, calldata, gas allocation, and return data. Persistent state is shared through the accounts touched by the complete execution.

## Atomicity

If an uncaught failure reaches the top, all state writes, ETH transfers, and logs produced by EVM execution revert. Transaction-level effects such as consuming the sender's nonce and paying gas fees still remain.

Low-level calls return a success flag, so a caller can intentionally handle a failed subcall and continue. In that case, changes inside the failed frame revert, while earlier or later changes in successful frames may remain.

Atomicity therefore depends on error propagation, not merely on “one transaction.”

## Reentrancy

An external call transfers control before the caller finishes. The callee can call back into the original contract or another part of the system.

```text
A starts update → calls B → B calls A again
```

Checks-effects-interactions, reentrancy guards, pull payments, and carefully designed invariants reduce this risk. Trusting a token contract because its function is named `transfer` is unsafe; callback-capable or malicious contracts can execute arbitrary behavior.

## Context changes across frames

With ordinary `CALL`, `msg.sender` becomes the immediate caller. Deep contract C sees B, not the original user, unless the system forwards and verifies user authorization explicitly.

`DELEGATECALL` is different: target code runs in the caller's context and preserves the incoming sender and value.

## Composability's tradeoff

Contracts can combine permissionlessly because their interfaces are public. The same property creates dependency risk: one pause, upgrade, oracle failure, or revert can break the complete path.

## Check yourself

1. How many signed transactions exist in a multi-contract call tree?
2. When can a failed subcall be prevented from reverting the outer transaction?
3. Why can an external call create reentrancy?
4. What does contract C see as `msg.sender` after ordinary calls A → B → C?
