# Private Mempool and Private Order Flow

> **Private submission hides a transaction from public gossip, but moves trust to the party carrying it to a builder.**

In the public path, a wallet sends a transaction to a node, and nodes gossip it across the network. Searchers can observe it before block inclusion.

In a private path, the wallet sends the transaction or bundle to a private RPC, relay, builder, or protected endpoint. The transaction may reach a block builder without entering the public mempool first.

## What privacy can provide

Private submission can reduce exposure to public frontrunning and sandwich bots. Private builder APIs can also support bundles with ordering or conditional-inclusion semantics. Those guarantees come from the bundle format and builder policy; ordinary Ethereum transactions in a block are not automatically atomic as a group.

The privacy is conditional. The operator can still see the order and may log, leak, simulate, censor, or fail to deliver it. Multiple downstream builders may receive it under different policies.

```text
hidden from public peers ≠ hidden from the private service
```

## Inclusion and fallback

A private endpoint cannot guarantee inclusion merely because it received the transaction. Its path must reach a builder whose payload is selected, and the transaction must remain eligible. It can expire, lose an auction, conflict with state, or be rejected.

Some services later broadcast to the public mempool if private inclusion fails. That improves liveness but eventually reveals the transaction. Users need to know the timeout and fallback policy.

Cancellation is also not magical. If a signed transaction has reached any builder, sending a replacement elsewhere may not stop the first copy from being included.

## The bigger market effect

Private order flow can protect users, but exclusive access also gives builders informational and competitive advantages. If most valuable transactions bypass public gossip, block construction can become more concentrated.

The right questions are: who sees the transaction, which builders receive it, what ordering promises exist, when public fallback occurs, and what happens to stored data.

## Check yourself

1. What does private submission hide?
2. Who can still inspect the transaction?
3. Why is inclusion not guaranteed?
4. How can private order flow increase centralization?
