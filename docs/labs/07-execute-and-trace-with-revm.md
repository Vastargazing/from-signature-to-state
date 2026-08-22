# Lab 7 — Execute and Trace a Transaction with `revm`

Foundry showed the EVM from a smart-contract developer's side. This lab crosses the boundary: a Rust host supplies bytecode, accounts, calldata, gas, and a hard fork to an embedded EVM, then reads the execution result, state diff, and instruction trace separately.

## You need

- stable Rust and Cargo;
- network access for the first dependency download;
- about twenty-five minutes.

The project pins `revm = 42.0.1`; its lockfile pins the transitive graph tested with this book.

## 1. Run the transaction

```bash
cd projects/revm-trace
cargo test
cargo run --quiet
```

The first line should report a successful execution, `returned=42`, and `stored=42`. The exact gas figure belongs to the selected rules and transaction context, not to the Rust function itself.

## 2. Read the bytecode before the API

The 17-byte runtime in `src/lib.rs` implements one tiny program:

```text
PUSH1 0x00 · CALLDATALOAD   read the first 32 calldata bytes
PUSH1 0x00 · SSTORE         write the value to storage slot 0
PUSH1 0x00 · SLOAD          read slot 0
PUSH1 0x00 · MSTORE         copy the value to memory[0..32]
PUSH1 0x20 · PUSH1 0x00
RETURN                      return those 32 bytes
```

This is runtime bytecode, not contract creation code. The host inserts it directly into an in-memory account, so no deployment transaction is being simulated.

## 3. Name every input to execution

`simulate` constructs four different kinds of input:

- **database state:** a funded caller and a contract account containing bytecode;
- **transaction context:** caller, destination, gas limit, and 32 bytes of calldata;
- **protocol rules:** mainnet behavior pinned explicitly to `SpecId::PRAGUE`;
- **inspector:** a hook that records each instruction without becoming an opcode itself.

That is the practical meaning of:

```text
environment + transaction + database → revm → result + state diff
```

Changing the Rust library version, selected fork, block fields, or starting database can change execution. “I ran the same calldata” is not a complete reproducibility claim.

## 4. Follow the trace as stack movement

The demo prints program counter, opcode, and stack height before and after each instruction:

```text
0    PUSH1        0 → 1
2    CALLDATALOAD 1 → 1
3    PUSH1        1 → 2
5    SSTORE       2 → 0
6    PUSH1        0 → 1
8    SLOAD        1 → 1
9    PUSH1        1 → 2
11   MSTORE       2 → 0
12   PUSH1        0 → 1
14   PUSH1        1 → 2
16   RETURN       2 → 0
```

At `SSTORE`, the top stack item is the key and the next item is the value. A trace is useful because it exposes the machine's order rather than relying on a source-level guess.

## 5. Keep three outputs separate

The lab asserts all three:

- `ExecutionResult::is_success()` describes the receipt-like status;
- `output()` contains the 32 returned bytes;
- `state` contains the account and storage changes produced by execution.

The state diff is not automatically durable Ethereum state. This example asks `inspect_tx` to finalize and return changes, but it does not commit them into a node database or reach consensus. Simulation answers “what would this engine do under these supplied inputs?”

Run the focused tests:

```bash
cargo test tests::executes_bytecode_and_returns_the_written_value -- --exact
cargo test tests::trace_exposes_the_storage_write_and_read -- --exact
```

## 6. Break one assumption

Temporarily replace the `SSTORE` byte `0x55` with `POP` (`0x50`). The execution can still return successfully, but the state-diff assertion must fail because slot 0 was never written.

This is why “success” alone is a weak simulation result. A caller normally needs assertions about output, logs, balance changes, storage changes, or a protocol-specific invariant.

Restore `0x55`, then run:

```bash
cargo fmt --check
cargo clippy --all-targets -- -D warnings
cargo test
```

## Artifact

Save a short Markdown report containing:

- the bytecode annotated instruction by instruction;
- transaction, block/config, and database inputs;
- the full 11-step trace;
- success, gas used, returned word, and storage diff;
- the failure caused by replacing `SSTORE`;
- one sentence distinguishing returned state changes from committed canonical state.

## Primary sources

- [`revm` repository](https://github.com/bluealloy/revm) — current execution and inspection architecture.
- [`revm` 42.0.1 API](https://docs.rs/revm/42.0.1/revm/) — the exact pinned public API used by this lab.
- [`ExecuteEvm`](https://docs.rs/revm/42.0.1/revm/trait.ExecuteEvm.html) — execution, finalization, and returned state semantics.

Last verified: 2026-08-22.

## Check yourself

1. Why does this lab insert runtime bytecode without sending a deployment transaction?
2. Which inputs besides calldata can change an EVM simulation?
3. What does the stack transition at `SSTORE` tell you?
4. Why is a successful `ExecutionResult` weaker than a checked state diff?
5. What still has to happen before a returned diff becomes canonical Ethereum state?
