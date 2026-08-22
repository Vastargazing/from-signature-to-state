# Lab 1 — Inspect a Local Ethereum Transaction

The goal is not merely to send ETH. The goal is to connect transaction fields, sender recovery, execution, receipt data, fees, and state changes to one transaction you created yourself.

## You need

- `anvil` and `cast` from Foundry;
- two terminal windows;
- about fifteen minutes.

Everything runs on a disposable local chain. The private key below is Anvil's first well-known development key. Never fund or reuse it on a public network.

## 1. Start the chain

In the first terminal:

```bash
anvil
```

Leave it running. Anvil prints prefunded accounts, their private keys, the chain ID, and the local RPC endpoint.

In the second terminal, define the lab values:

```bash
export LAB_RPC_URL=http://127.0.0.1:8545
export LAB_ALICE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
export LAB_BOB=0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

export LAB_ALICE=$(cast wallet address --private-key "$LAB_ALICE_KEY")
```

Confirm the network and starting state:

```bash
cast chain-id --rpc-url "$LAB_RPC_URL"
cast nonce "$LAB_ALICE" --rpc-url "$LAB_RPC_URL"
cast balance "$LAB_ALICE" --ether --rpc-url "$LAB_RPC_URL"
cast balance "$LAB_BOB" --ether --rpc-url "$LAB_RPC_URL"
```

Record Alice's nonce and both balances. You will need them later.

## 2. Create the transaction

Send `0.05 ETH` and retain the returned transaction hash:

```bash
export LAB_TX_HASH=$(cast send \
  --rpc-url "$LAB_RPC_URL" \
  --private-key "$LAB_ALICE_KEY" \
  --value 0.05ether \
  --async \
  "$LAB_BOB")

echo "$LAB_TX_HASH"
```

`--async` asks `cast` to return after submission instead of presenting the mined receipt. On Anvil the transaction is normally mined immediately, so a receipt may already exist by the next command.

## 3. Separate transaction from receipt

Inspect the signed transaction:

```bash
cast tx "$LAB_TX_HASH" --rpc-url "$LAB_RPC_URL"
```

Find these fields:

- `chainId`;
- `nonce`;
- `to`;
- `value`;
- `input`;
- `gas` and fee fields;
- signature values;
- the displayed `from` address.

The RPC response displays `from`, but the serialized native transaction does not carry it as an ordinary field. The execution client recovers it from the signature.

Now inspect the execution result:

```bash
cast receipt "$LAB_TX_HASH" --rpc-url "$LAB_RPC_URL"
```

Find:

- block number and block hash;
- transaction index;
- status;
- gas used;
- logs.

The transaction described the request. The receipt describes what happened when that request executed in one block.

## 4. Reconcile state and fees

Query the state again:

```bash
cast nonce "$LAB_ALICE" --rpc-url "$LAB_RPC_URL"
cast balance "$LAB_ALICE" --ether --rpc-url "$LAB_RPC_URL"
cast balance "$LAB_BOB" --ether --rpc-url "$LAB_RPC_URL"
```

Bob's balance should increase by exactly `0.05 ETH`. Alice's balance should fall by more than `0.05 ETH` because she also paid the transaction fee. Her nonce should advance by one.

Use the transaction and receipt data to calculate:

```text
fee paid = gas used × effective gas price
```

Then verify:

```text
Alice decrease = value transferred + fee paid
```

Do the arithmetic in wei first. Decimal ETH display is for humans; protocol accounting uses integers.

## 5. Tie the evidence to the model

Answer without using the words “because Anvil says so”:

1. Which values existed before Alice signed?
2. Why does changing `to` after signing invalidate the signature?
3. Where do you see inclusion, and where do you see execution success?
4. Why is `input` empty for this transfer?
5. Which state changes remain after execution?
6. Why is the receipt tied to a block hash rather than only to a transaction hash?

If any answer feels vague, revisit [A Transaction and Its Fields](../topics/007-transaction.md), [Digital Signature of a Transaction](../topics/020-digital-signature.md), and [Transaction Lifecycle](../topics/046-transaction-lifecycle.md).

## Artifact

Save a short Markdown note containing:

- the transaction hash;
- the relevant transaction fields;
- the relevant receipt fields;
- the fee calculation in wei;
- one paragraph explaining why a transaction and a receipt are different objects.

Do not commit the private key, even though this one is public and disposable. Building the correct habit is part of the lab.

## Primary sources

- [Ethereum JSON-RPC API](https://ethereum.org/developers/docs/apis/json-rpc/) — transaction, receipt, balance, and nonce methods.
- [Foundry Anvil](https://www.getfoundry.sh/anvil/index.html) — disposable local Ethereum node and development accounts.
- [Foundry `cast receipt`](https://getfoundry.sh/cast/reference/receipt/) — receipt fields and confirmation behavior.

Last verified: 2026-08-22.
