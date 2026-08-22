# Solana: The Account Model

> **On Solana, programs contain code while separate accounts contain all mutable state. Every instruction receives the exact accounts it may read or write.**

## What an account contains

A Solana account is addressed by a 32-byte public key and stores:

- lamports;
- arbitrary data bytes;
- an owner program ID;
- an executable flag;
- storage-related metadata.

Only the owner program may modify an account's data or debit its lamports under runtime rules. Ownership here means which program controls data—not which user has a private key.

## Code and state are separate

An executable program account identifies deployed sBPF code. With the widely used upgradeable loader, the program account stores metadata and points to a separate ProgramData account that holds the executable bytes and upgrade authority; other loaders package deployment state differently. Application programs are effectively stateless: counters, markets, positions, and configuration live in data accounts passed to them.

```text
instruction = program ID + account list + input bytes
```

The transaction marks each account as signer or non-signer and writable or read-only. The program must verify that the caller supplied the correct accounts and relationships.

## Tokens are accounts too

An SPL token balance is usually stored in a token account owned by a token program. The token account records a mint, authority, and amount.

The user's wallet address is not one universal mapping containing every token balance. A user can have several token accounts for one mint.

## The security habit

A malicious caller chooses the account list. Rust types do not stop them from passing another user's position, a fake mint, or a look-alike program.

Validate account owner, address or PDA seeds, signer status, writable status, stored authority fields, and cross-account relationships before mutation.

Ethereum contracts discover much state by address from their own storage. Solana programs receive state explicitly, which enables parallelism but moves more validation into every instruction.

## Primary sources

- [Solana accounts](https://solana.com/docs/core/accounts) — account fields, addresses, ownership, modification rules, and size limits.
- [Solana instructions](https://solana.com/docs/core/instructions) — program ID, caller-supplied account metadata, and opaque instruction data.

Last verified: 2026-08-22.

## Check yourself

1. Where does mutable application state live on Solana?
2. What does an account's owner field mean?
3. Why is a wallet address not itself every SPL token balance?
4. Which caller-controlled input makes account validation critical?
