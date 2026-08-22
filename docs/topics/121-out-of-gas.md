# Out of Gas

> **Out of gas is an execution failure: the current call frame cannot pay for its next operation, so its state changes revert.**

## How it happens

Before an opcode runs, the EVM calculates its charge. If remaining gas is insufficient, execution stops exceptionally.

Common causes include:

- a transaction gas limit estimated too low;
- an unexpectedly large loop or input;
- expensive storage paths;
- memory expansion to a high offset;
- a child call receiving too little gas;
- state changes between estimation and inclusion.

An infinite loop does not run forever. It eventually consumes its finite gas budget.

## What reverts

If the top-level transaction runs out of gas, state writes, value transfers, contract creations, and logs from that transaction are reverted.

The sender's nonce still advances. A top-level out-of-gas halt consumes the transaction's full gas limit, so failure does not make the attempted execution free.

```text
application effects → reverted
gas fee and nonce    → retained
```

## Internal call boundaries

A contract can send only part of its remaining gas to a subcall. If that child runs out, the child's state changes revert and the low-level call returns failure.

The parent may still have gas and can handle the failure. High-level Solidity calls usually bubble failure unless caught with `try/catch`; low-level calls require checking the success flag.

This means “out of gas” can fail one branch without necessarily failing the complete transaction.

## Estimation is simulation

Wallets use `eth_estimateGas` to simulate execution and find a likely requirement. The future transaction may face different storage, ordering, sender balance, oracle values, or block context.

A safety margin handles small variation, not unbounded loops over growing state. Contracts should design bounded or paginated work rather than hope users set ever-larger limits.

## Check yourself

1. When does the EVM declare an out-of-gas failure?
2. Which transaction effects remain even after top-level out of gas?
3. Can a parent contract survive a child call running out of gas?
4. Why is gas estimation not a guarantee?
