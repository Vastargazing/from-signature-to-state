# Ethereum Transaction Envelopes and Gas Failures

The durable transaction model is simple: fields are encoded, a key signs a type-specific payload, and clients recover a sender. The wire formats and gas failure boundaries carry the historical detail.

## Legacy and typed envelopes

Legacy transactions predate explicit transaction types. They carry `nonce`, `gasPrice`, `gasLimit`, `to`, `value`, `data`, and the signature values conventionally called `v`, `r`, and `s`.

When EIP-155 added replay protection, the legacy list had no separate `chainId` field. The identifier was incorporated into the signed payload and reflected in `v`:

```text
v = recovery_id + chain_id × 2 + 35
```

For Ethereum Mainnet this produced 37 or 38 instead of the earlier 27 or 28 convention.

Typed transaction envelopes later created an explicit namespace for new formats. A type-2 EIP-1559 transaction carries `chainId`, fee caps, and an access list directly in its typed payload rather than pretending the legacy list gained fields.

The signature still covers a protocol-defined encoding. “Transaction fields” is a conceptual table; exact bytes depend on the envelope type.

## `chainId` has a boundary

The identifier prevents replay only when the other network uses a different identifier. Two forks retaining the same chain ID and compatible account state can still accept the same signed transaction.

Domain separation works because domains differ, not because the field has a special name.

## Three gas-limit failures

| Condition | Result |
|---|---|
| Limit below intrinsic gas | Invalid transaction; it cannot enter a block and nothing is charged |
| Enough intrinsic gas, but top-level execution exhausts the remaining budget | State changes revert and all remaining transaction gas is consumed |
| Limit is higher than execution needs | Only gas used is charged; the unused ceiling is released |

Overestimating still has constraints. The sender must be able to cover the maximum upfront cost during validation, and the transaction limit cannot exceed the gas available in the block.

An explicit `REVERT` differs from top-level out-of-gas: it returns unused gas. At an internal call boundary, out-of-gas consumes the gas forwarded to that call; the caller can observe failure and may continue with its own remaining gas.

These distinctions explain why “the transaction failed” is incomplete. Preliminary invalidity, top-level out-of-gas, an explicit revert, and a caught internal-call failure affect inclusion, receipts, remaining gas, and state differently.

## Primary sources

- [EIP-155: Simple replay attack protection](https://eips.ethereum.org/EIPS/eip-155) — legacy signing payload and chain-ID encoding in `v`.
- [EIP-2718: Typed Transaction Envelope](https://eips.ethereum.org/EIPS/eip-2718) — the type-byte and opaque-payload transaction namespace.
- [EIP-1559: Fee market change](https://eips.ethereum.org/EIPS/eip-1559) — type-2 transaction fields and fee semantics.

## Check yourself

1. Why could EIP-155 not add an ordinary `chainId` field to the existing legacy list?
2. What does a typed envelope add beyond another RLP list convention?
3. When does a too-low gas limit prevent inclusion entirely?
4. How does top-level out-of-gas differ from an explicit revert and an internal-call out-of-gas failure?
