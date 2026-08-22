# Transaction Gas Limit and Block Gas Limit

> **The transaction gas limit bounds one execution; the block gas limit bounds the sum of execution work in one block.**

## Transaction gas limit

The sender chooses the maximum gas units its transaction may consume.

```text
gas used ≤ transaction gas limit
```

The limit includes intrinsic transaction cost and all nested EVM execution. If the transaction finishes early, unused gas is not charged as executed work. If it needs more than the limit, it runs out of gas and fails.

Setting an enormous limit does not force the transaction to use all of it, but the sender must have enough balance to cover the transaction's maximum payment and value under validation rules.

## Block gas limit

Each block header defines a maximum total amount of execution gas. A block builder selects transactions whose cumulative gas used fits within it.

This limit controls throughput and node load:

```text
higher limit → more execution capacity
             → more CPU, state access, and propagation pressure
```

Validators reject a block whose gas used exceeds its allowed block limit.

## Reservation versus actual use

Builders must consider transaction gas limits when safely packing candidates because actual use is not known until execution in order. The final block records actual gas used.

Ethereum Mainnet now also caps one transaction's gas limit at `2^24`, or 16,777,216 gas, independently of the higher block gas limit. That cap arrived with Fusaka to prevent one transaction from dominating worst-case block validation. Other EVM chains may use different caps. Many simple transfers can still share one block, and a transaction below the cap may consume much less than it reserves.

## Gas target is another number

Under EIP-1559, Ethereum's execution gas target is below the maximum block gas limit. Blocks can temporarily grow above the target to absorb demand, while the base fee rises in response.

Do not confuse:

```text
transaction limit → sender's execution ceiling
block gas limit   → hard per-block ceiling
gas target        → fee market's desired average
```

## Primary sources

- [EIP-1559: Fee market change](https://eips.ethereum.org/EIPS/eip-1559) — block elasticity, gas target, gas limit, and base-fee adjustment.
- [EIP-7825: Transaction Gas Limit Cap](https://eips.ethereum.org/EIPS/eip-7825) — Ethereum's independent `2^24` per-transaction cap.
- [Ethereum.org: Fusaka](https://ethereum.org/roadmap/fusaka/) — Mainnet activation and the reason the transaction cap accompanied higher block limits.

Last verified: 2026-08-22.

## Check yourself

1. Who chooses a transaction's gas limit, and what additional ceiling does Ethereum Mainnet enforce?
2. Is unused transaction gas charged as if it were executed?
3. What resource does the block gas limit protect?
4. How does the EIP-1559 gas target differ from the block maximum?

<!-- corepath:start -->

**Core Path 40/50** · [← Gas as Computational Work](118-gas-as-computational-work.md) · [EIP-1559 Fees →](122-eip-1559-fees.md)

<!-- corepath:end -->
