# Denial of Service: Unbounded Loops and Gas Exhaustion

> **A function that must process every growing item eventually becomes uncallable when its required gas exceeds the block limit.**

## The growing-list trap

A contract stores every participant, then distributes rewards with one loop. It works for 100 users and fails for 100,000.

Raising the caller's gas limit does not help once the transaction needs more gas than a block permits. Funds can become permanently stuck behind valid but unreachable logic.

## User-controlled growth

Attackers may cheaply add entries, create dust positions, or force expensive cleanup. If deletion leaves holes and the loop scans them forever, apparent state removal does not restore bounded cost.

Storage reads and writes dominate cost, and protocol gas repricing can make an already marginal path worse after an upgrade.

## Reverting recipients

A push-payment loop can also fail because one recipient reverts. If all transfers are atomic, one malicious address blocks everyone.

Record claims and let users withdraw individually. One failure then affects one user, and each transaction has bounded work.

## Design for progress

Use pagination, per-user claims, accumulative reward indexes, queues processed in bounded batches, and resumable state machines.

Every public maintenance function should have a maximum cost independent of total historical users—or a permissionless way to process the work incrementally.

Avoid relying on an off-chain keeper as the only fix. If any caller can advance a bounded batch and receive a reward, liveness survives one operator disappearing.

The invariant is not just “correct result.” It is “there always exists an affordable transaction sequence that reaches the result.”

## Check yourself

1. Why can increasing transaction gas not rescue an unbounded loop forever?
2. How can an attacker grow cleanup cost cheaply?
3. Why do pull payments isolate reverting recipients?
4. What liveness property should a batched state machine preserve?
