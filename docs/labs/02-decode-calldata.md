# Lab 2 — Decode Calldata and Compute a Function Selector

The goal is to stop seeing calldata as a mysterious hex string. You will assemble one contract call, mark its byte boundaries, decode it back, and explain what the selector can—and cannot—prove.

## You need

- `cast` from Foundry;
- no node, account, private key, or network;
- about ten minutes.

This lab does not send a transaction. It studies the bytes that *could* be placed in a transaction's `input` field.

## 1. Compute the selector

We will encode this Solidity function call:

```solidity
function transfer(address to, uint256 amount) external returns (bool);
```

Its canonical signature contains the function name and canonical input types. It does not contain parameter names, return types, spaces, or visibility:

```text
transfer(address,uint256)
```

Ask `cast` for the first four bytes of its Keccak-256 hash:

```bash
cast sig "transfer(address,uint256)"
```

Expected result:

```text
0xa9059cbb
```

That value is a dispatch hint, not a globally unique function identity. Four bytes provide only 32 bits, so different signatures can share a selector.

## 2. Encode one call

Use a local-development address and an integer amount:

```bash
export LAB_BOB=0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
export LAB_AMOUNT=1000000

export LAB_CALLDATA=$(cast calldata \
  "transfer(address,uint256)" \
  "$LAB_BOB" \
  "$LAB_AMOUNT")

echo "$LAB_CALLDATA"
```

The result has three regions:

```text
0xa9059cbb  0000000000000000000000003c44cdddb6a900fa2b585dd299e03d12fa4293bc  00000000000000000000000000000000000000000000000000000000000f4240
  selector                              address word                                      amount word
   4 bytes                                32 bytes                                          32 bytes
```

The spaces above are annotations; the real calldata is contiguous. The address occupies the rightmost 20 bytes of a 32-byte ABI word. The integer `1,000,000` is `0x0f4240`, left-padded to one word.

Confirm the total size. Remove the `0x` prefix, count hex characters, then divide by two:

```text
8 selector hex characters + 64 + 64 argument characters = 136
136 / 2 = 68 bytes
```

## 3. Separate selector from arguments

`cast abi-encode` encodes arguments but does not prepend the selector:

```bash
cast abi-encode \
  "transfer(address,uint256)" \
  "$LAB_BOB" \
  "$LAB_AMOUNT"
```

Compare that output with `LAB_CALLDATA`. It should equal everything after the first eight hex characters following `0x`.

This boundary matters when debugging proxies and fallback functions: the EVM receives bytes, while the contract's dispatcher decides how to interpret the first four.

## 4. Decode the bytes back

Decode the full calldata using the expected signature:

```bash
cast decode-calldata \
  "transfer(address,uint256)" \
  "$LAB_CALLDATA"
```

You should recover Bob's address and `1,000,000`.

Compare the selector of another function with the same input types:

```bash
cast sig "approve(address,uint256)"
```

Its selector is `0x095ea7b3`, not `0xa9059cbb`, although its two argument words follow the same static encoding rules. Raw calldata does not carry parameter names, return types, or a trusted ABI. A decoder needs a schema from somewhere else, and that schema can be wrong.

## 5. Tie the evidence to the model

Answer from the bytes you produced:

1. Why is the selector four bytes while each static argument occupies 32 bytes?
2. Which part changes if `LAB_AMOUNT` becomes `1`?
3. Which part changes if the function is renamed but its argument types stay the same?
4. Why does knowing a selector not prove which source-code function ran?
5. Why can an explorer decode verified contracts more confidently than an unknown address?
6. Where would these bytes live in a signed Ethereum transaction?

If any answer feels vague, revisit [ABI and Function Selectors](../topics/098-abi-and-function-selector.md) and [A Transaction and Its Fields](../topics/007-transaction.md).

## Artifact

Save a short Markdown note containing:

- the canonical function signature and selector;
- the complete calldata;
- a labeled selector/address/amount byte map;
- the decoded values;
- two sentences explaining why a selector is neither authentication nor a collision-free identifier.

## Primary sources

- [Solidity ABI specification](https://docs.soliditylang.org/en/latest/abi-spec.html)
- [Foundry Cast reference](https://getfoundry.sh/reference/cast/cast) — `cast sig`, `cast calldata`, and the rest of the current command surface.

Last verified: 2026-08-22.

## Check yourself

Without running a command, predict the calldata length for a function with a selector and three static ABI arguments. Then explain why a single dynamic `bytes` argument cannot be represented by “selector plus one self-contained word.”
