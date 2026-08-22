# UTXO Model

> **A UTXO chain consumes whole outputs and creates new ones; it does not subtract from an account balance.**

Ethereum's world state is not the only way to represent ownership. Bitcoin uses unspent transaction outputs: independent notes that can be consumed once. Each output contains:

```text
value + spending condition
```

It is identified by the transaction that created it and its output index. A new transaction input points to that output and provides the signature or script data needed to spend it.

Once the spending transaction is in the canonical ledger, the old output is no longer in the UTXO set. Before sufficient confirmation or finality, a reorganization can still remove that transaction and make the output unspent again.

## Spending means replacement

Suppose Alice controls one 10-unit UTXO and wants to pay Bob 3:

```text
input:   10 → consumed
outputs: 3 → Bob
         6.9 → Alice's change
fee:     0.1
```

Alice cannot remove only 3 from the old output. Her wallet spends the whole note and creates a new note for the change.

The fee is usually implicit:

```text
fee = sum(inputs) - sum(outputs)
```

If a wallet forgets the change output, the remainder becomes a fee.

## Where the balance comes from

The protocol maintains a set of unspent outputs, not an aggregate field saying “Alice has 12.” A wallet identifies outputs whose conditions it can satisfy and adds their values.

This makes conflicts concrete: two transactions double-spend when they try to consume the same output.

It also creates coin selection. The wallet chooses which outputs to spend, affecting transaction size, fees, privacy, change, and future fragmentation.

## Tradeoff

Independent UTXOs declare their input dependencies and can often be checked in parallel, subject to the chain's scripts and other validation rules. For an ordinary value-transfer transaction, outputs cannot exceed inputs; coinbase or other protocol-defined issuance is the exception.

The cost is bookkeeping: wallets manage many notes, change, different scripts, and small outputs that may cost more to spend than they are worth.

Remember:

> **A UTXO is a spendable note. A transaction destroys notes and creates new notes.**

## Primary sources

- [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf) — transactions as chains of authorized outputs, double-spend prevention, and transaction fees.
- [Bitcoin Core transaction validation](https://github.com/bitcoin/bitcoin/blob/master/src/consensus/tx_verify.cpp) — executable checks for spent outputs, values, scripts, and fees.

## Check yourself

1. Where is a user's UTXO balance stored?
2. Why does a partial payment need change?
3. How is the fee represented?
4. What makes two UTXO transactions conflict?

<!-- corepath:start -->

**Core Path 7/50** · [← Ethereum World State](034-ethereum-world-state.md) · [Account Model →](031-account-model.md)

<!-- corepath:end -->
