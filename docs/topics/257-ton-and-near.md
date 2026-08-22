# TON and NEAR

> **TON and NEAR both scale through sharding and message passing, but their accounts, execution flow, and developer environments are different.**

## TON: actors and messages

On TON, accounts—including wallets—are smart contracts that behave like actors. Each processes incoming messages one at a time, updates its own persistent state, and emits outgoing messages.

Workchains can split dynamically into shardchains. Cross-account and cross-shard interaction is naturally message-oriented, so multi-contract workflows must handle partial progress and bounced messages rather than assume one EVM-style synchronous call stack.

Contract addresses derive from initial code and data, making deployment state part of identity.

## NEAR: accounts, access keys, and receipts

NEAR supports human-readable and implicit account IDs. An account can hold contract code plus multiple access keys with full or function-call-limited permissions.

Contracts commonly compile to Wasm, with Rust as a mature production path. Cross-contract calls create asynchronous receipts. A callback handles the later result; the original function cannot treat remote execution as an immediate return value.

NEAR's sharding routes account state and receipts across shards while the runtime presents account-oriented execution.

## The shared design consequence

Asynchronous composition improves horizontal scaling but complicates invariants:

```text
debit locally → send message → destination may fail later → handle refund/callback
```

Developers need explicit state machines, replay protection, idempotent callbacks, timeout or bounce behavior, and accounting for messages that never complete as expected.

## Rust lens

NEAR has a direct Rust-to-Wasm contract workflow. TON's core contract ecosystem uses its own VM and languages/tooling rather than Rust as the default contract path.

Do not group chains only by throughput. Ask whether calls are synchronous, how accounts authorize actions, how shards exchange messages, and what finality the application observes.

## Check yourself

1. Why are TON accounts compared to actors?
2. What can a limited NEAR access key authorize?
3. Why do asynchronous calls need callbacks and idempotency?
4. Which chain has the more direct Rust contract workflow?
