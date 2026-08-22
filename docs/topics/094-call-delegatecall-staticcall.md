# CALL, DELEGATECALL, and STATICCALL

> **All three execute another address's code, but they differ in whose state is used and whether state changes are allowed.**

## CALL

`CALL` creates a new execution frame in the callee's context.

```text
code      → callee's code
storage   → callee's storage
address   → callee
msg.sender→ caller contract
msg.value → value supplied by caller
```

This is the normal contract-to-contract call. ETH can be transferred with it, and the callee may update its own state.

## DELEGATECALL

`DELEGATECALL` loads code from the target but runs it as the caller:

```text
code      → target's code
storage   → caller's storage
address   → caller
msg.sender→ preserved from caller's current frame
msg.value → preserved from caller's current frame
```

This powers proxy contracts and reusable libraries. The implementation code operates directly on the proxy's storage and balance.

That power is dangerous. Incompatible storage layouts, malicious implementation code, or a bad upgrade can overwrite ownership and drain assets. `DELEGATECALL` is not a sandbox.

## STATICCALL

`STATICCALL` behaves like a call under a **static flag**. The callee may read state and perform computation but cannot make state-changing operations such as storage writes, logs, contract creation, or value-transferring calls.

It is the EVM basis for Solidity external `view` calls made from contracts. The restriction is enforced during that execution tree, not merely promised by source-code syntax.

## Shared behavior

All three return a success flag and return bytes at the opcode level. A failed low-level call does not automatically revert its caller; the caller decides whether to bubble the error, handle it, or ignore it.

They also forward a controlled amount of gas. `CALL` and `DELEGATECALL` can trigger state-changing reentrancy before the original caller finishes updating state; callbacks reached through `STATICCALL` inherit the static restriction for that execution tree.

## Check yourself

1. Whose storage changes during a normal `CALL`?
2. Whose storage changes during `DELEGATECALL`?
3. Why is `DELEGATECALL` essential for proxies and dangerous for upgrades?
4. Does a failed low-level call automatically revert its caller?
