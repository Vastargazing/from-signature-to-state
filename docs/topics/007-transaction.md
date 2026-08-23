# A Transaction and Its Fields

> **The signed bytes of a transaction contain no “from” field. The sender is recovered from the signature; `from` in an RPC response is a derived field computed by the client.**

## The picture

The transaction commits to an action and carries a signature. For a native Ethereum transaction, the sender's address is **recovered** from that signature and the signed payload; it is not another field the sender may fill independently. The network then checks the recovered account's nonce and ability to cover the maximum transaction cost.

A formally valid signature recovers an address for the signed payload. Recovery alone does not authorize useful state: the resulting account must still satisfy nonce, balance, chain, and transaction rules.

A caveat for later: this is how **native** Ethereum transactions work. An ERC-4337 `UserOperation` includes an explicit `sender` field precisely because it is not a native transaction, and its signature-validation rules are defined by the wallet contract itself; [ERC-4337](169-erc-4337.md) builds that separate path.

## What is inside

A modern Ethereum transaction (type 2, EIP-1559):

| Field | What it is | Purpose |
|---|---|---|
| `chainId` | network number | prevents replaying the transaction on another network |
| `nonce` | sender's transaction counter | prevents replay and imposes order |
| `to` | recipient | an empty field means contract creation |
| `value` | amount in wei | transfers the native coin |
| `data` | arbitrary bytes | call data for a contract or initcode for contract creation |
| `gasLimit` | work ceiling | limits the sender's expenditure and network load |
| `maxFeePerGas` | maximum price per gas | protects against fee spikes |
| `maxPriorityFeePerGas` | maximum tip to the block producer | influences inclusion priority; the effective tip is also capped by `maxFeePerGas - baseFeePerGas` |
| `accessList` | addresses and slots declared in advance | pre-warms them for execution, but charges an upfront cost, so it does not always reduce the total fee (EIP-2930) |
| `yParity`, `r`, `s` | signature | used to recover the sender |

Legacy transactions (type 0) use one fee field, `gasPrice`, instead of two, and do not store `chainId` as a separate field at all.

No transaction type has a `from` field in this list. It appears in the result of `eth_getTransactionByHash` because the client recovers and displays the sender for convenience.

## Three fields against three vulnerabilities

Each blocks a different failure.

**`nonce`—prevents replay on the same network.** A signed transaction is just bytes: intercept it and broadcast it a hundred times. The nonce makes the signature single-use—the sender's counter increments, so a replay no longer passes.

There is a useful side effect: one sender's transactions execute in strict order. Leave a gap in the sequence, and later transactions wait until it is filled.

**`chainId`—prevents replay on another network.** History is specific. After the split into Ethereum and Ethereum Classic described in [Trustless](004-trustless.md), both networks shared earlier addresses and state. EIP-155 bound signatures to a network identifier. Protection still depends on the other network using a different identifier.

**`gasLimit`—prevents unbounded computation.** The sender declares a work ceiling. Execution that exhausts it stops instead of forcing every node to run forever. A high limit is not prepaid work: only gas actually consumed is charged, although the sender must be able to cover the declared maximum during validation.

Wire-format history and the exact failure cases live in [Ethereum Transaction Envelopes and Gas Failures](../deep-dives/ethereum-transaction-envelopes-and-gas-failures.md).

## What a transaction does not contain

- **The sender**—recovered from the signature.
- **The result**—success or revert is determined during execution and stored in the receipt, not the transaction.
- **The time**—the block determines when the transaction is included, not the sender.
- **A guarantee of inclusion**—signing and broadcasting does not mean it will enter a block.

## The cost

- nonce ordering means one stuck transaction holds up later transactions from the same sender. “Canceling” it means offering a replacement with the same nonce; nodes decide whether to retain that replacement under local mempool policy, and at most one candidate for the nonce can enter canonical history;
- `gasLimit` must be estimated in advance, before anything has executed;
- a signature covers fields, not intent. The protocol checks that you signed, not that you understood what you signed—see [Trustless](004-trustless.md);
- once in the public mempool, a transaction is visible to everyone before inclusion. This creates front-running (Part XVI). [Private submission channels](045-private-mempool.md) reduce exposure to public-mempool searchers, but do not guarantee protection: the relay or builder can still see, leak, censor, or reorder the transaction.

## Primary sources

- [EIP-2718: Typed Transaction Envelope](https://eips.ethereum.org/EIPS/eip-2718) — the type-prefixed envelope used by modern Ethereum transaction formats.
- [EIP-1559: Fee market change](https://eips.ethereum.org/EIPS/eip-1559) — dynamic-fee transaction fields, sender recovery, fee caps, and execution gas limit.
- [EIP-4844: Shard Blob Transactions](https://eips.ethereum.org/EIPS/eip-4844) — blob transaction fields and the separation between blob and execution gas.
- [EIP-7702: Set EOA account code](https://eips.ethereum.org/EIPS/eip-7702) — authorization tuples and delegated EOA execution.

Last verified: 2026-08-22.

## Check yourself

1. Why is there no “from” field in a transaction, and how does the network identify the sender?
2. Which kind of replay does `nonce` prevent, and which kind does `chainId` prevent?
3. **Deep dive:** Why did legacy transactions have to encode `chainId` in `v` rather than store it as a separate field?
4. What happens when execution exhausts `gasLimit`? What if the limit is much higher than required?
5. A transaction failed during execution. Where is that recorded if the transaction itself contains no result?

<!-- corepath:start -->

**Core Path 4/51** · [← State and the State Transition Function](006-state-transition.md) · [A Block and the Transactions Inside It →](008-block.md)

<!-- corepath:end -->
