# Cross-Chain versus Multichain

> **Multichain means an application exists on several chains. Cross-chain means those deployments exchange authenticated messages or shared assets.**

## Multichain deployment

A protocol can deploy separate contracts on Ethereum, Arbitrum, and Solana. Each instance may have its own liquidity, governance parameters, users, and state.

If the deployments never communicate, the product is multichain but not cross-chain at the protocol level. A frontend merely showing all balances does not unify them.

## Cross-chain operation

A cross-chain application sends messages between state machines. One chain may instruct another to mint, vote, release collateral, or execute a call.

Because chains finalize independently, this is usually asynchronous:

```text
source transaction → finality → verification → destination transaction
```

There is no general atomic rollback across both chains. The source can succeed while destination delivery waits or fails.

## Shared state is an illusion built by rules

An omnichain token may maintain one intended global supply through burn-and-mint messages. That global invariant is only as strong as every chain deployment, verifier path, mint authority, and decimal conversion.

A governance system controlling several chains must define which chain is authoritative and what happens when messages arrive out of order.

## Different architectures, different blast radii

Independent multichain deployments isolate some failures but fragment liquidity and operations. Cross-chain coordination improves user experience and capital efficiency while connecting failure domains.

A compromised deployment should not automatically control every other chain unless that power is explicitly intended and protected.

## The language test

Ask whether the same protocol was copied to several chains or whether state transitions on one chain can authorize actions on another. The first is multichain presence; the second is cross-chain behavior.

Many real products are both.

## Check yourself

1. Can a multichain application have no bridge at all?
2. Why is a cross-chain call normally asynchronous?
3. What secures an omnichain token's global supply invariant?
4. How does cross-chain coordination change the blast radius?
