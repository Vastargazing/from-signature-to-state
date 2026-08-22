# Programs Instead of Contracts, and PDAs

> **A Solana program is reusable code; a PDA is a deterministic account address that the program can authorize without owning a private key.**

## Programs

Deployed Solana programs identify executable sBPF bytecode. Under the common upgradeable loader, the executable program account points to a ProgramData account that stores the bytes and upgrade metadata. Users invoke an instruction by naming the program, supplying accounts, and encoding input data.

One program can manage thousands of separate state accounts. Deploying a new user position does not deploy a new copy of the code.

Programs can call other programs through cross-program invocation, or CPI. Signer and writable privileges cannot be escalated arbitrarily inside the call stack.

## Program-derived addresses

A PDA is derived from seeds plus a program ID. Derivation deliberately finds an address outside the normal Ed25519 public-key curve, so no private key exists for it.

```text
PDA = derive(seeds, bump, program_id)
```

During execution, the program whose ID was used in the derivation can supply the same seeds and bump to `invoke_signed`. The runtime treats the PDA as a signer for that CPI; the PDA account does not have to be owned by that program for the signer derivation itself to work.

## What PDAs enable

PDAs give deterministic addresses to vaults, configuration, user positions, mint authorities, and escrow state. A client can find them without a registry.

They are not autonomous contracts. A PDA is an address and account; the program defines its behavior.

## Seed design is access control

The program must reproduce and validate seeds. A position PDA derived only from a predictable market ID may omit the user's identity and let accounts collide.

Seeds need stable encoding, domain separation, bounded length, and the intended authority fields. Stored bump values are a convenience; the address must still match derivation, and programs should enforce the canonical bump when their design assumes one unique PDA for a seed tuple.

When reviewing a CPI, follow which PDAs sign, what authority the callee grants them, and whether attacker-controlled seeds can select a more privileged address.

## Check yourself

1. Does a PDA have a private key?
2. How can a program authorize a CPI on a PDA's behalf?
3. Why can clients locate PDA state without a registry?
4. How can incomplete seeds become an access-control bug?
