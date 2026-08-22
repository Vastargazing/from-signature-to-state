# Fork-Choice Rule

> **When several valid chain tips exist, the fork-choice rule tells a node which one to treat as canonical now.**

Temporary forks are normal. Blocks propagate with delay, so two producers may extend the same parent before learning about each other.

Validation removes branches known to violate protocol rules. Fork choice compares eligible candidates; some protocols allow an optimistic candidate to be followed temporarily while a separate execution check is still pending, but a known-invalid branch must be excluded.

## Different chains use different weight

Bitcoin chooses the valid branch with the greatest accumulated proof of work—not simply the most blocks.

Ethereum proof of stake uses LMD-GHOST, which follows branches supported by validators' latest stake-weighted attestations, while finalized checkpoints constrain how far the choice may move.

Other BFT chains finalize through explicit quorum votes and normally do not use a longest-chain competition after commitment.

```text
validity/viability → may this branch remain a candidate?
fork choice        → which eligible branch is the head?
finality           → how far back may normal choice reverse?
```

## Local information matters

Nodes may briefly choose different heads because they have received different blocks and votes. As messages arrive, honest nodes should converge under the protocol assumptions.

A reorganization occurs when the chosen branch changes and previously canonical blocks are removed. Their transactions may return to the mempool, appear later, or become invalid under the new state.

## Not a governance vote

Fork choice runs automatically during normal operation. It is different from people choosing new software rules during a protocol upgrade or contentious social fork.

A node must not retain a branch known to be invalid merely because it has greater weight. Optimistic processing may defer a check, but later invalidation removes that branch. If client implementations disagree about validity or fork choice, they can split the network, which is why conformance testing is consensus-critical.

For applications, the head is a moving answer. Use safe or finalized references when the consequence of reorg is high.

## Check yourself

1. Which branches does fork choice compare?
2. What weight does Bitcoin use?
3. How does finality constrain fork choice?
4. Why is fork choice different from protocol governance?
