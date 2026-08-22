# Lab 3 — Read Storage, Receipts, and Logs

The goal is to observe one contract call through three different lenses: the transaction requests work, the receipt records its execution, and storage exposes the resulting state.

## You need

- `anvil`, `cast`, and `forge` from Foundry;
- two terminal windows;
- about twenty minutes.

Everything runs on a disposable local chain. The contract has no external dependencies, and its Solidity compiler version is pinned in the lab project.

## 1. Start a fresh chain

In the first terminal:

```bash
anvil
```

In the second terminal:

```bash
export LAB_RPC_URL=http://127.0.0.1:8545
export LAB_ALICE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

This is Anvil's public development key. It is safe only on disposable local chains.

## 2. Build and deploy the probe

From the repository root:

```bash
cd projects/receipts-storage
forge build
```

Deploy the contract:

```bash
forge create \
  --rpc-url "$LAB_RPC_URL" \
  --private-key "$LAB_ALICE_KEY" \
  --broadcast \
  src/StateProbe.sol:StateProbe
```

Copy the `Deployed to` address printed by Forge:

```bash
export LAB_PROBE=0xREPLACE_WITH_DEPLOYED_ADDRESS
```

Do not type the placeholder literally. Check that code exists at the chosen address:

```bash
cast code "$LAB_PROBE" --rpc-url "$LAB_RPC_URL"
```

The result must be longer than `0x`.

## 3. Read the same value two ways

Call the public getter:

```bash
cast call \
  "$LAB_PROBE" \
  "number()(uint256)" \
  --rpc-url "$LAB_RPC_URL"
```

Then read storage slot zero directly:

```bash
cast storage "$LAB_PROBE" 0 --rpc-url "$LAB_RPC_URL"
```

Both represent zero, but at different abstraction levels. `cast call` executes getter bytecode locally against node state and ABI-decodes the return value. `cast storage` asks the node for a raw 32-byte slot.

## 4. Send a state-changing call

Submit `setNumber(42)` and retain its transaction hash:

```bash
export LAB_TX_HASH=$(cast send \
  "$LAB_PROBE" \
  "setNumber(uint256)" \
  42 \
  --rpc-url "$LAB_RPC_URL" \
  --private-key "$LAB_ALICE_KEY" \
  --async)

echo "$LAB_TX_HASH"
```

Inspect the request:

```bash
cast tx "$LAB_TX_HASH" --rpc-url "$LAB_RPC_URL"
```

Find the recipient and input. The first four input bytes select `setNumber(uint256)`; the next word encodes `42`.

## 5. Inspect the receipt and event

```bash
cast receipt "$LAB_TX_HASH" --rpc-url "$LAB_RPC_URL"
```

Find:

- `status` and `gasUsed`;
- the emitting contract address;
- `topics[0]`, `topics[1]`, and `data` for the log.

Compute the event signature topic:

```bash
cast sig-event "NumberChanged(address,uint256,uint256)"
```

It must match `topics[0]`. In this contract, `caller` is indexed, so its padded address appears in `topics[1]`. The non-indexed `previousValue` and `newValue` are ABI-encoded into `data` as two consecutive 32-byte words.

The event is evidence produced by execution, not contract storage. Another contract cannot read historical logs during EVM execution.

## 6. Verify the resulting state

Repeat both reads:

```bash
cast call \
  "$LAB_PROBE" \
  "number()(uint256)" \
  --rpc-url "$LAB_RPC_URL"

cast storage "$LAB_PROBE" 0 --rpc-url "$LAB_RPC_URL"
```

The getter should return `42`; slot zero should end in `2a`. Then call `setNumber(7)` and compare the new receipt, new log, and current slot. The old log remains in chain history while the storage slot contains only the latest value.

## 7. Tie the evidence to the model

Answer from your transaction:

1. Which object proves that execution succeeded?
2. Which object contains the call request, and which contains the emitted log?
3. Why does `topics[0]` identify an event schema but not prove that the contract told the truth?
4. Why is `caller` searchable as a topic while the old and new values are in `data`?
5. Why can a node answer a historical-log query without those logs living in contract storage?
6. What would a chain reorganization change about this receipt and log?

If any answer feels vague, revisit [Transaction Lifecycle](../topics/046-transaction-lifecycle.md), [Logs and Events](../topics/096-logs-and-events.md), and [Calldata, Memory, Storage, and Stack](../topics/093-evm-data-areas.md).

## Artifact

Save a short Markdown note containing:

- the contract address and transaction hash;
- the transaction input split into selector and argument;
- the receipt status, gas used, and block hash;
- a labeled event topic/data map;
- storage slot zero before and after the call;
- one paragraph distinguishing current state from historical execution evidence.

## Primary sources

- [Ethereum JSON-RPC methods](https://ethereum.org/developers/docs/apis/json-rpc/)
- [Solidity events](https://docs.soliditylang.org/en/latest/contracts.html#events)
- [Foundry `cast receipt`](https://getfoundry.sh/cast/reference/receipt/)
- [Foundry Cast reference](https://getfoundry.sh/reference/cast/cast) — including `cast storage`.

Last verified: 2026-08-22.

## Check yourself

Suppose `setNumber(42)` emits its event and then reverts. Predict the transaction status, surviving log count, and final value in slot zero. Explain all three with one execution rule.
