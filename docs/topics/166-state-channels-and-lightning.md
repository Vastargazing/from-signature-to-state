# State Channels and the Lightning Network

> **A state channel moves repeated interaction off-chain by letting participants sign newer states and use L1 only to open, close, or dispute.**

## The channel pattern

Participants lock assets in an on-chain contract or funding transaction. They then exchange signed updates directly:

```text
state 1 → state 2 → state 3 → latest signed state
```

Only the latest valid state should determine the final payout. If someone broadcasts an older favorable state, the other participant gets a dispute window to present the newer one or apply a penalty, depending on the protocol.

This makes many updates fast and cheap because global consensus sees only the channel lifecycle.

## Lightning Network

Bitcoin's Lightning Network connects payment channels into a routing network. A payer can reach someone without a direct channel by forwarding value through intermediate channels.

Hash time-locked contracts link the hops: either the payment secret completes the route, or timelocks let funds unwind. Intermediaries do not need to trust the payer or recipient, but each route needs sufficient inbound and outbound liquidity.

## The costs hidden by “instant payments”

Users need channels, locked capital, a working route, and awareness of disputes. A user who stays offline too long can employ a watchtower to react to an outdated close.

Channels work best for repeated interactions among known participants. They do not naturally provide the global shared state and open composability of an L1 or rollup.

## The distinction

A rollup batches many users under a common off-chain state whose results settle on L1. A channel keeps most state private to its participants and touches L1 mainly on entry or exit.

## Check yourself

1. Why must channel updates be signed?
2. What happens when someone tries to close with an old state?
3. What constraint can prevent a Lightning route from working?
4. Why are channels less globally composable than rollups?
