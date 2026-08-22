# Restaking and EigenLayer

> **Restaking reuses staked-asset security for additional services, so one pool of capital can secure more systems—and share more failure modes.**

Ethereum staking secures Ethereum consensus. Restaking lets stakers opt into extra conditions for other services, often called actively validated services.

EigenLayer coordinates this model through smart contracts for depositing or restaking supported assets, delegating to operators, and allocating slashable stake to services. Native restaking, liquid-staking tokens, EIGEN-based staking, and service-specific configurations do not all have identical custody or penalty paths.

```text
restaked assets → delegation/allocation → operator → service-specific duties
```

A native restaker may also control an Ethereum validator, but an EigenLayer operator is not necessarily the entity performing the underlying Ethereum consensus duties for every delegated asset.

The service may use this economic commitment for bridges, data availability, oracles, coprocessors, or other infrastructure instead of bootstrapping its own validator token.

## What is actually reused

Ethereum's consensus does not automatically validate the external service. The service defines extra tasks, software, payments, and penalty conditions. Restaking reuses economic collateral and operators, not Ethereum's full consensus guarantee.

Participants may earn additional rewards for accepting extra software, operator, contract, and slashing risk; neither rewards nor losses are guaranteed to be uniform across services.

## Correlated risk

One operator may serve many systems. A bug, key compromise, bad update, or cloud outage can affect several services and positions at once.

Other risks include smart contracts, governance, delegation, withdrawal delays, unclear penalty conditions, and complex dependencies on liquid-staking tokens.

More capital advertised as “secured” also does not equal that much independent security. The same collateral may back several obligations, and an attacker compares the real slashable value with the profit from corruption.

## The right questions

Ask what behavior is verified, who detects failure, who can impose penalties, how disputes work, whether operators can exit, and which assets actually bear loss.

The concise model is:

```text
restaking lowers the cost of recruiting economic security
but couples the failure domains of participating systems
```

## Check yourself

1. What does restaking reuse?
2. Why does Ethereum not automatically validate an external service?
3. How can one operator create correlated risk?
4. Why can advertised restaked value overstate independent security?
