# Paymaster

> **A paymaster is an ERC-4337 contract that agrees to cover a UserOperation's gas when its own policy accepts the user.**

## Why it exists

A new user may own tokens but no ETH. A game may want to sponsor its first ten actions. An application may accept payment in a stablecoin while Ethereum validators still require native gas.

A paymaster bridges this gap. The bundler submits the transaction in ETH; the EntryPoint charges an accepted paymaster's deposit.

## The decision

The UserOperation carries paymaster data. During validation, the EntryPoint asks the paymaster whether it will sponsor this exact operation.

Its policy can check:

- an off-chain service's signature or coupon;
- the target contract and function;
- a user's token balance or allowance;
- rate limits, time windows, or an allowlist.

After execution, a post-operation hook can settle token payment or update accounting based on the gas actually used.

## Sponsorship is not free gas

Someone always pays. The business may absorb the cost, charge the user in another token, bundle it into a subscription, or subsidize only selected actions.

The paymaster needs enough EntryPoint deposit, and often a stake to discourage validation behavior that can waste bundler resources.

## Security boundary

Bundlers simulate validation because a malicious or buggy paymaster can make operations fail after consuming work. Paymaster logic must resist replay, forged quotes, price manipulation, draining approvals, and unbounded validation cost.

A centralized sponsor can also censor users or disappear. The smart account should ideally retain a path to submit operations without that paymaster.

The mental model: a paymaster changes who reimburses gas and under what policy; it does not change the native asset validators receive.

## Check yourself

1. Who actually pays validators in the native gas asset?
2. Where does the EntryPoint take sponsored gas funds from?
3. How can a paymaster charge a user in a stablecoin?
4. Why should an account work without one specific paymaster?
