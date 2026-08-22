# Fork Tests Against Real Network State

> **A fork test runs local EVM transactions against state copied from a real chain at a chosen block.**

## How it works

Foundry connects to an RPC endpoint and creates a local view of a network:

```text
real chain state at block N
        +
local simulated transactions
        =
isolated fork state
```

State is commonly fetched lazily as execution touches accounts and slots, then cached locally. Writes affect only the test fork; nothing is broadcast to the real network.

Pinning a block number makes the starting state reproducible. Testing against “latest” can change whenever balances, implementations, pools, or oracle values move.

## What fork tests catch

They expose integration assumptions that mocks miss:

- real deployed bytecode and proxy implementations;
- actual token decimals and return behavior;
- live storage and pool liquidity;
- current permissions and allowances;
- real call paths across protocols.

They are valuable for upgrade rehearsals, liquidation paths, governance proposals, and incident reproductions.

## What they do not prove

A fork is a snapshot plus your simulated future. It does not predict:

- transaction ordering and MEV;
- future oracle values or liquidity;
- governance changes;
- bridge messages;
- behavior of off-chain services;
- blocks after the pinned point.

Cheatcodes can impersonate an address locally. That proves code behavior under that caller; it does not prove you can obtain the caller's real signature.

## RPC and historical assumptions

The provider must serve the state needed at the selected block. Old fork points may require archive-capable historical access.

Record chain ID, block number, RPC expectations, and any locally replaced code or storage. A fork test becomes misleading when hidden test powers differ from production.

Use unit tests for isolated logic and fork tests for realistic integration. Neither replaces the other.

## Check yourself

1. Do writes in a fork test reach the real network?
2. Why should important fork tests pin a block number?
3. What integration errors can real state reveal that mocks hide?
4. Why does address impersonation not prove real authority?
