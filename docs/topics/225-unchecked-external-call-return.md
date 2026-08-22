# Unchecked External-Call Return Value

> **A low-level call can fail without reverting the caller. If the contract ignores its boolean result, its accounting may record an action that never happened.**

## The silent failure

Solidity's low-level `call`, `delegatecall`, and `staticcall` return `(success, returndata)`. They do not automatically bubble a failure.

```solidity
(bool ok, ) = recipient.call{value: amount}("");
// ignoring ok is dangerous
paid[recipient] = true;
```

If the recipient reverts, the ETH stays in the sender while `paid` becomes true. The system's state now disagrees with reality.

## Token returns are inconsistent

Standard ERC-20 `transfer` returns a boolean, but historical tokens may return no value; broken or adversarial tokens may return false.

Calling the interface naively can either miss a false result or reject a successful no-return token. Safe token wrappers handle the expected variants and revert when the transfer cannot be confirmed.

They cannot make a fee-on-transfer token deliver the requested amount. Balance-difference checks may be required when exact receipt matters.

## Bubble or handle deliberately

If failure must cancel the operation, require success and propagate useful revert data. If failure is allowed, record it explicitly and leave a retry or withdrawal path.

Do not continue as if success happened.

External return data is untrusted. Decode it only after checking call success and expected length; otherwise malformed bytes can cause a different revert or false interpretation.

## The invariant

Every accounting effect must correspond to an observed external effect. “We attempted payment” and “payment completed” are separate states.

## Check yourself

1. What does low-level `call` return on recipient revert?
2. How can ignored failure corrupt payment accounting?
3. Why are ERC-20 return values awkward across real tokens?
4. When should a contract record a retryable failure instead of reverting?
