# CosmWasm Contracts

> **A CosmWasm contract changes its own state and returns messages; the chain performs the external actions.**

CosmWasm is a Rust smart-contract platform used in the Cosmos ecosystem. Contracts compile to Wasm and expose entry points such as instantiate, execute, and query.

Messages are normally Rust enums. The framework serializes them at the boundary, while contract logic works with typed variants inside.

## The execution shape

An execute call receives dependencies, environment data, sender information, and a message. The contract validates the request, updates storage, and returns a `Response`.

That response may contain attributes for events and Cosmos messages for token transfers or calls into other contracts and chain modules:

```text
incoming message → validate → update local state → return outgoing messages
```

The contract does not open a socket or directly mutate another module's database. The host chain interprets its returned messages under chain rules.

## Submessages and replies

A normal outgoing message participates in the surrounding transaction. A submessage can request a reply after the nested action succeeds, fails, or always completes. The reply entry point lets the contract react to that result.

This is useful for multi-step workflows, but reply handling needs explicit IDs, state tracking, authorization, and failure behavior. A clever callback structure can still violate an economic invariant.

## Rust lens

Common tools provide typed storage helpers, schema generation, standard token interfaces, and multi-contract tests. `cw-multi-test` can simulate chain-like interactions quickly, but integration tests on the target chain remain important because modules, gas, and configuration differ.

Rust prevents many memory errors inside the Wasm code. It does not prove that the sender is authorized, prices are fresh, messages are economically safe, or migrations preserve old state.

The main design task is therefore not syntax. It is defining a small message protocol and making every state transition explicit.

## Check yourself

1. What does a CosmWasm contract return after execution?
2. Who performs the returned external messages?
3. Why are submessage replies useful?
4. Which contract bugs remain possible in safe Rust?
