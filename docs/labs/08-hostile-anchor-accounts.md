# Lab 8 — Make Hostile Anchor Accounts Fail Before the Handler

A friendly client sends the accounts named in your UI. An attacker sends any accounts the runtime will accept. This lab constructs those hostile `AccountInfo` values directly and proves that Anchor rejects them before instruction logic can mutate the vault.

The tests run on the Rust host and call the real generated `Accounts::try_accounts` implementation. No validator, wallet, TypeScript client, Anchor CLI, or SOL balance is required.

## You need

- stable Rust and Cargo;
- network access for the first dependency download;
- about thirty minutes.

The project pins `anchor-lang = 1.1.2` and commits its lockfile.

## 1. Start from the adversary's control

The caller chooses the account list. Anchor deserializes those accounts and runs generated constraints before the handler can mutate state; one failed constraint rejects the instruction. The handler is therefore not the first security boundary. If an account type or relationship is missing from `Withdraw`, the handler receives a lie wrapped in a convenient Rust field.

Run the suite:

```bash
cd projects/anchor-hostile-accounts
cargo test
```

Nine tests should pass: Anchor's generated program-ID test, one valid account set, six hostile substitutions, and one check that custom errors remain specific.

## 2. Read the account contract

Open `src/vault.rs`. `Withdraw` declares what must be true before `record_withdrawal` runs:

```rust
#[account(
    mut,
    seeds = [b"vault", vault.authority.as_ref(), vault.mint.as_ref()],
    bump = vault.bump,
    has_one = authority @ VaultError::WrongAuthority,
    has_one = mint @ VaultError::WrongMint,
)]
pub vault: Account<'info, Vault>,

pub authority: Signer<'info>,

#[account(owner = EXTERNAL_PROGRAM_ID @ VaultError::WrongExternalProgram)]
pub external_record: UncheckedAccount<'info>,
```

Each line proves a different fact:

| Declaration | Fact established |
|---|---|
| `Account<'info, Vault>` | correct discriminator, deserialization, and owner program |
| `mut` | transaction supplied the vault as writable |
| `seeds` + `bump` | vault address is the expected PDA for its stored authority and mint |
| `Signer<'info>` | the transaction contains this public key's signature |
| `has_one = authority` | signer address equals `vault.authority` |
| `has_one = mint` | supplied mint address equals `vault.mint` |
| `owner = EXTERNAL_PROGRAM_ID` | the named external program controls that account's data |

No single row replaces another. A signer can be the wrong signer; a correctly typed vault can belong to another user; a valid PDA can still contain bad business state.

## 3. Feed generated validation hostile accounts

The tests serialize a real `Vault`, build four host-side `AccountInfo` values, and call:

```rust
Withdraw::try_accounts(
    &ID,
    &mut remaining,
    &[],
    &mut bumps,
    &mut reallocs,
)
```

That is the same generated validation boundary Anchor uses before constructing `Context<Withdraw>`. The test is faster than a validator integration test and pinpoints which constraint rejected the input. It does not test transaction scheduling, CPI behavior, runtime compute limits, or deployment configuration.

## 4. Read the hostile matrix

Run individual cases with `--exact`:

```bash
cargo test tests::rejects_an_authority_that_did_not_sign -- --exact
cargo test tests::rejects_a_substituted_authority -- --exact
cargo test tests::rejects_a_lookalike_vault_at_the_wrong_pda -- --exact
cargo test tests::rejects_vault_data_owned_by_another_program -- --exact
cargo test tests::rejects_a_substituted_mint -- --exact
cargo test tests::rejects_an_external_record_owned_by_a_lookalike_program -- --exact
```

The expected failures are deliberately distinct:

```text
missing signature       → AccountNotSigner
wrong authority address → WrongAuthority
wrong vault address     → ConstraintSeeds
wrong vault owner       → AccountOwnedByWrongProgram
wrong mint address      → WrongMint
wrong external owner    → WrongExternalProgram
```

If every bad case merely returns “invalid account,” debugging and audit evidence become weaker. Custom errors identify the application relationship; framework errors identify the account primitive.

## 5. Mutation-test the constraints

Temporarily remove `has_one = authority`, then rerun:

```bash
cargo test tests::rejects_a_substituted_authority -- --exact
```

The test should fail because hostile validation now returns `Ok`: a signature still exists, but it belongs to an unrelated key.

Restore the constraint and rerun the focused test once more; it must pass after Cargo recompiles the protected version. Repeat the idea by removing `has_one = mint`, `seeds`, or the external `owner` constraint and running the corresponding hostile test. A security test is valuable when deleting the protection makes it fail.

## 6. Understand what `owner` does not prove

`owner = EXTERNAL_PROGRAM_ID` proves which program may modify the account data. Because `external_record` is an `UncheckedAccount`, it does **not** prove a discriminator, data layout, freshness, authority field, or relationship to the vault.

If the handler reads that data, replace the unchecked field with an appropriate typed account or interface and add semantic constraints. For SPL tokens, validate the token-account type, token program, mint, authority, and any required associated address; checking only the owner program is incomplete.

`UncheckedAccount` is acceptable only when the unchecked facts are irrelevant or verified manually. The `CHECK` comment should state the proof, not merely silence review tooling.

## 7. Keep unit and runtime tests complementary

These host tests are the fast account-validation layer. A production program should add LiteSVM, Mollusk, Surfpool, or validator-backed tests for:

- successful state serialization after the handler;
- CPI targets, signer seeds, token transfers, and returned errors;
- duplicate writable accounts and aliasing;
- compute-unit limits and transaction account metadata;
- initialization, close, realloc, and rent behavior.

The test pyramid is not “unit or integration.” Use host constraint tests for the hostile matrix and fewer runtime tests for behavior that only the Solana runtime can supply.

## Artifact

Save a short Markdown report containing:

- the attacker-controlled account list;
- the seven account facts from the constraint table;
- all six hostile cases and their exact error names;
- one removed constraint and the test that caught its absence;
- one fact that `owner` proves and three facts it does not;
- the smallest runtime integration test you would add next.

## Primary sources

- [Anchor account constraints](https://www.anchor-lang.com/docs/references/account-constraints) — signer, mutability, owner, seeds, address, and custom constraints.
- [Anchor PDA constraints](https://www.anchor-lang.com/docs/basics/pda) — deterministic addresses, seeds, bumps, and program IDs.
- [`anchor-lang` 1.1.2](https://docs.rs/anchor-lang/1.1.2/anchor_lang/) — exact pinned Rust API used by the lab.
- [Solana accounts](https://solana.com/docs/core/accounts) — owner, signer, writable, executable, lamports, and data fields.

Last verified: 2026-08-22.

## Check yourself

1. Why does `Signer<'info>` not prove that the correct authority signed?
2. What additional fact does `has_one = authority` establish?
3. Why must a PDA check include the intended seeds and program ID?
4. What does an external account's owner field prove—and what does it leave unchecked?
5. Which behaviors still require a Solana runtime integration test?
