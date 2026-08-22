# Timelocks and Multisigs for Administration

> **A multisig requires several approvals; a timelock requires time. Together they reduce key compromise and surprise, but neither proves an action is safe.**

## Multisig: distribute approval

A 3-of-5 wallet needs three owner signatures to execute. One stolen key is insufficient.

Real independence matters. Five keys held by one employee on one cloud service do not create five strong failure domains. Signer rotation, device separation, transaction simulation, and an incident quorum are operational parts of the design.

Multisigs can still approve malicious calldata by mistake or collusion.

## Timelock: expose intent before execution

A timelock separates scheduling from execution. An upgrade is announced on-chain, then becomes executable only after a minimum delay.

Users and monitors can inspect it, challenge governance, revoke approvals, or exit before the change takes effect.

The delay helps only if the exit path remains available and the proposal is understandable. A two-day delay is not meaningful for assets that take seven days to withdraw.

## Combined flow

```text
multisig proposes → timelock waits → anyone or an executor executes
```

The timelock should control the target contract directly. If a separate admin can bypass it, the visible delay is cosmetic.

## Emergency paths

A pause guardian may act instantly while upgrades remain delayed. Define exactly what it can pause, who can unpause, and whether the emergency role can change the timelock itself.

Recovery from lost signers also needs care: an easy recovery path becomes the threshold's weakest link.

Multisig answers “how many approvals?” Timelock answers “how much warning?” A full model needs both answers plus who can bypass them.

## Check yourself

1. What risks do multisigs and timelocks address separately?
2. Why can co-located signer keys defeat the multisig idea?
3. When is a timelock delay too short to protect users?
4. Which ownership arrangement makes the delay cosmetic?
