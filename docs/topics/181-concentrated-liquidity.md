# Concentrated Liquidity: Uniswap v3 and v4

> **Concentrated liquidity lets an LP place capital inside chosen price ranges instead of supporting every possible price.**

## The range

In full-range constant-product liquidity, much capital sits at prices the market may never reach. Uniswap v3 lets an LP choose a lower and upper price.

Inside that range, the position behaves like deeper liquidity and can earn more fees per unit of capital. As price crosses the range, its token mix changes. Outside the range, it becomes entirely one asset and stops earning swap fees until price returns.

Each range and fee choice creates a distinct position, so ownership is not represented by one universal fungible LP token.

## Efficiency is not free yield

A narrow range concentrates fee exposure but is crossed more easily. The LP must choose ranges, rebalance, pay transaction costs, and accept stronger inventory shifts.

Professional market making moves from “deposit and forget” toward active position management.

## What v4 changes

Uniswap v4 keeps concentrated-liquidity ideas but puts many pools in a singleton contract. Flash accounting tracks net balance changes during an operation and settles them at the end, reducing repeated token transfers.

Hooks are contracts called at selected points in a pool's lifecycle. They can add dynamic fees, custom curves, limit-order-like behavior, oracle logic, or other policies.

This makes pools more programmable, not uniformly safer. A hook is extra code with its own permissions and bugs; two v4 pools using different hooks can have very different behavior.

## The mental model

v3 makes liquidity programmable by price range. v4 also makes the pool lifecycle programmable through hooks and shared settlement infrastructure.

## Check yourself

1. What happens when price leaves an LP's selected range?
2. Why can a narrow range earn more fees per unit of capital?
3. What does the v4 singleton reduce?
4. Why must users inspect a pool's hook code?
