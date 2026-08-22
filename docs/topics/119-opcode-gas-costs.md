# Opcode Costs and Where They Come From

> **Opcode gas costs are consensus prices chosen to limit real node resources and denial-of-service risk—not laws of nature.**

## A gas schedule

Each EVM revision defines a gas schedule. `ADD` has a small fixed cost. Other instructions depend on context:

- memory cost grows with the highest touched offset;
- `SSTORE` depends on the old, original, and new slot value;
- cold account or storage access costs more than warm repeated access;
- hashing and copying scale with byte length;
- calls add account access, memory, value-transfer, and child execution costs.

The interpreter and every other client must calculate exactly the same total.

## What the prices represent

Gas approximates several different burdens:

```text
CPU work
database reads and writes
bandwidth and block size
memory expansion
persistent state growth
```

These resources do not share one perfect unit. The schedule is an engineering model that makes attacks expensive enough while keeping useful computation affordable.

## Why costs change

An opcode can be underpriced if new measurements show it causes much more disk or CPU work than its gas charge suggests. Attackers can then pack blocks with that operation and slow nodes disproportionately.

Ethereum has repriced state access and introduced warm-versus-cold accounting through upgrades. Such changes preserve EVM behavior while changing transaction economics and sometimes breaking applications that hardcoded narrow gas assumptions.

## Refunds are policy too

Some state changes can earn gas refunds, but refunds are capped and their rules have changed. They incentivize useful cleanup or correct net accounting without letting one transaction create unlimited extra block work.

Do not treat deleting a storage value as a permanent guaranteed rebate amount. Gas policy evolves.

## Practical reading

When optimizing, inspect an execution trace. A source line may compile into many opcodes, and most cost may come from state access or external calls rather than visible arithmetic.

Always name the chain and fork when quoting an opcode cost.

## Check yourself

1. Why can one opcode have a context-dependent gas cost?
2. Which real resources does the gas schedule approximate?
3. Why does Ethereum sometimes reprice an existing opcode?
4. Why should code avoid depending on an exact future gas stipend?
