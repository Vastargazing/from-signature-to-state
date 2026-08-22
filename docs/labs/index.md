# Labs

The notes explain the model. The labs make the model answer to evidence.

Every lab ends with an artifact: a decoded transaction, a failing test, a trace, a benchmark, or a small program. Reading command output without explaining it does not count as completion.

## Before you begin

The EVM labs use [Foundry](https://getfoundry.sh/). Rust labs will use a stable Rust toolchain and keep dependencies pinned in their own project directories.

Never paste a real private key into a command, shell history, `.env` file committed to Git, or screenshot. Keys printed by Anvil are deliberately public and safe only for local development.

## Track

1. [Inspect a Local Ethereum Transaction](01-inspect-local-transaction.md) — ready
2. [Decode Calldata and Compute a Function Selector](02-decode-calldata.md) — ready
3. [Read Storage, Receipts, and Logs](03-receipts-logs-and-storage.md) — ready
4. [Exploit and Repair Reentrancy](04-reentrancy-and-cei.md) — ready
5. [Turn Examples into Fuzz and Invariant Tests](05-fuzz-and-invariant-testing.md) — ready
6. [Make a Rust Indexer Survive a Reorg](06-reorg-safe-rust-indexer.md) — ready
7. [Execute and Trace a Transaction with `revm`](07-execute-and-trace-with-revm.md) — ready
8. [Make Hostile Anchor Accounts Fail Before the Handler](08-hostile-anchor-accounts.md) — ready

The first five form one progressive EVM track. Labs 6–7 form the Rust infrastructure track; Lab 8 moves the same hostile-input discipline to Solana. Project directories stay deliberately small so each lab can be built and understood independently.
