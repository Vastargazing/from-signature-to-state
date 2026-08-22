# Anchor

> **Anchor is a Rust framework that generates Solana instruction plumbing, account validation, serialization, and client interfaces. It reduces boilerplate, not the need to model accounts correctly.**

## The account context

An Anchor instruction receives a `Context<T>`. The `T` struct lists required accounts with typed wrappers and constraints.

```rust
#[derive(Accounts)]
pub struct Update<'info> {
    #[account(mut, has_one = authority)]
    pub position: Account<'info, Position>,
    pub authority: Signer<'info>,
}
```

Before handler code runs, generated logic checks deserialization, ownership, signer status, mutability, and declared relationships.

Constraints such as `seeds`, `bump`, `has_one`, `owner`, `address`, `init`, and `close` make security assumptions visible near the account list.

## Discriminators and IDL

Anchor prefixes instruction and account data with discriminators that identify expected types. It generates an IDL describing instructions, accounts, arguments, and types so clients can encode calls consistently.

The IDL is an interface artifact, not an authorization mechanism. The on-chain program must enforce every constraint.

## What Anchor cannot infer

It cannot know that an oracle is fresh, a vault matches a market, two accounts must be distinct, a CPI target is trustworthy, or a liquidation formula is sound unless the developer expresses and tests those rules.

Using `UncheckedAccount` or broad remaining-account lists deliberately leaves validation manual.

## Why Rust developers like it

Anchor turns much raw account parsing into typed code and provides testing, deployment, CPI, error, and client-generation conventions.

The right attitude is: framework constraints are executable documentation. Review the generated checks and the gaps between declared account types and business invariants.

Run [Lab 8 — Make Hostile Anchor Accounts Fail Before the Handler](../labs/08-hostile-anchor-accounts.md) to invoke Anchor's generated account validation directly against missing signatures, substituted authorities and mints, a look-alike PDA, and wrong owner programs.

## Primary sources

- [Anchor account constraints](https://www.anchor-lang.com/docs/references/account-constraints) — constraint syntax and the fact checked by each constraint.
- [Anchor program structure](https://www.anchor-lang.com/docs/basics/program-structure) — account types, generated validation, instructions, and handlers.

Last verified: 2026-08-22.

## Check yourself

1. What happens before an Anchor instruction handler runs?
2. Which constraint validates a stored authority relationship?
3. Does an IDL enforce on-chain permissions?
4. Why is `UncheckedAccount` a visible review boundary?
