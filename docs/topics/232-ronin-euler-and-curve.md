# Incident Studies: Ronin, Euler, and Curve

> **Ronin lost signer authority, Euler missed an economic health invariant, and Curve inherited faulty compiler output. Security fails across operations, protocol logic, and tooling.**

## Ronin: operational compromise

The bridge accepted five-of-nine validator signatures. Attackers compromised enough keys to authorize false withdrawals.

The verification contract did what it was configured to do. The true weakness was concentrated operational control and a path to the signing threshold.

## Euler: one missing health check

Euler V1 allowed a borrower to donate position assets to reserves without checking that the action left the account healthy.

The attacker used leveraged accounting, made its own position liquidatable through the donation, then self-liquidated and captured a bonus larger than the economic loss created. The incident extracted roughly $197 million, later recovered.

The lesson is invariant coverage: every function that changes collateral or debt relationships needs the same solvency checks, even when a normal user would never choose the harmful action.

## Curve: compiler-level reentrancy failure

Several Curve pools compiled with affected Vyper versions had broken reentrancy locks. Attackers reentered vulnerable pools even though source code appeared to use a guard.

The lesson is supply-chain verification: audited source plus intended compiler semantics must match deployed bytecode.

## Three review layers

```text
operations: who controls the keys?
economics: which invariant covers every state transition?
toolchain: what bytecode did the compiler actually emit?
```

No single technique covers all three. Multisigs do not fix formulas; invariant tests do not protect signer laptops; source review does not prove a buggy compiler generated correct locks.

Incident study is useful only when it changes the threat model and tests, not when it becomes trivia about stolen amounts.

## Primary sources

- [Ronin: Securing Ronin](https://blog.roninchain.com/p/securing-ronin) — the response to concentrated validator-key compromise.
- [Euler Finance: exploit recovery retrospective](https://www.euler.finance/blog/war-peace-behind-the-scenes-of-eulers-240m-exploit-recovery) — the approximately $197 million exploit and recovery.
- [Vyper security advisory GHSA-5824-cm3x-3c38](https://github.com/vyperlang/vyper/security/advisories/GHSA-5824-cm3x-3c38) — affected compiler versions and incorrectly allocated reentrancy locks.

Last verified: 2026-08-22.

## Check yourself

1. Which security layer failed in Ronin?
2. What check was missing from Euler's donation path?
3. Why did Curve challenge trust in reviewed source code?
4. Which defense category applies to each incident?
