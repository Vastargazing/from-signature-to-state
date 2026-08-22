# Integer Overflow, Underflow, and Solidity 0.8

> **Solidity 0.8 checks normal integer arithmetic and reverts on overflow or underflow. It did not make every numeric operation safe.**

## The old behavior

Fixed-width integers wrap modulo their range. For a `uint8`, `255 + 1` becomes `0`; `0 - 1` becomes `255`.

Before Solidity 0.8, ordinary arithmetic used this wrapping behavior silently. Balance and allowance checks could therefore be bypassed when code assumed mathematical integers.

## Checked by default

In Solidity 0.8+, overflow and underflow in normal arithmetic trigger a panic and revert. Developers no longer need SafeMath for those basic operations.

An `unchecked` block explicitly restores wrapping:

```solidity
unchecked { ++i; }
```

This can save gas when a preceding bound proves overflow impossible. That proof is now part of the security argument.

## The remaining edges

Explicit casts can truncate without the same range check. Converting a large `uint256` to `uint64` keeps only the low bits. Inline assembly follows lower-level EVM behavior.

Division rounds toward zero. Multiplying before dividing may overflow where a safer full-precision routine would not; dividing first may lose precision. Signed minimum values, negation, exponentiation, and unit conversions need care.

Most modern numeric bugs are business-logic errors: wrong decimals, rounding in the attacker's favor, share inflation, or inconsistent units. Checked arithmetic cannot know the intended formula.

## The mental model

Solidity 0.8 protects the machine range for ordinary operators. The developer still protects meaning: precision, scale, casting, rounding direction, and economic invariants.

## Primary sources

- [Solidity 0.8 breaking changes](https://docs.soliditylang.org/en/latest/080-breaking-changes.html) — checked arithmetic, panic reverts, and explicit casts.
- [Checked and unchecked arithmetic](https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic) — the exact boundary of `unchecked` blocks.

Last verified: 2026-08-22.

## Check yourself

1. What did `uint8(255) + 1` do before Solidity 0.8?
2. How can a developer deliberately restore wrapping?
3. Why can a narrowing cast still lose value silently?
4. Which numeric errors are outside overflow checking?
