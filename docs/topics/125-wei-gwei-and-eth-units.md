# Wei, Gwei, and ETH Units

> **Wei is Ethereum's integer base unit; gwei is the convenient unit for gas prices; ETH is the human-scale unit.**

## The conversion

```text
1 ETH  = 1,000,000,000 gwei = 10^18 wei
1 gwei = 1,000,000,000 wei  = 10^9 wei
```

Ethereum protocol balances are integers measured in wei. There are no floating-point ETH balances in the EVM.

Wallets display decimals by choosing a human-readable denomination.

## Why gas prices use gwei

A gas price of `20 gwei` is easier to read than `20,000,000,000 wei` or `0.000000020 ETH` per gas.

For a transaction using 21,000 gas at 20 gwei:

```text
21,000 × 20 gwei = 420,000 gwei = 0.00042 ETH
```

Always multiply gas units by price per gas before converting the resulting wei amount to ETH.

## Solidity denomination suffixes

Solidity accepts literals such as `1 wei`, `1 gwei`, and `1 ether` and converts them at compile time. The runtime value remains an integer number of wei.

ERC-20 decimals are unrelated. A token contract may define 6, 8, 18, or another number of display decimals. That metadata tells interfaces how to render integer token units; it does not change Ethereum's wei conversion.

## Avoid floating-point mistakes

Applications should parse user-facing decimal strings into integer base units and perform accounting with integers. Binary floating point can round monetary values unexpectedly.

```text
display amount “1.23 ETH” → parse → 1,230,000,000,000,000,000 wei
```

Validate excess decimal places instead of silently rounding. When APIs return large quantities as hexadecimal or decimal strings, keep them as big integers until final formatting.

## Check yourself

1. How many wei are in one ETH?
2. Why are gas prices commonly shown in gwei?
3. Does an ERC-20 with 18 decimals use wei internally?
4. Why should applications avoid floating-point balance arithmetic?
