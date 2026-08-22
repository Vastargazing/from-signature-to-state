# ZK for Privacy versus ZK for Scaling

> **Privacy uses proofs to hide a witness. Scaling uses proofs to avoid repeating computation. The same cryptography can serve either goal, both, or neither fully.**

## Privacy

A private payment can prove that the sender owns an unspent note, conserves value, and creates valid new commitments without revealing which note or exact amount.

The circuit hides selected witness data. Public inputs still reveal roots, nullifiers, commitments, and whatever the application needs for double-spend prevention.

Privacy also depends on anonymity-set size, transaction timing, funding links, network metadata, and wallet behavior.

## Scaling

A validity rollup executes thousands of transactions off-chain and proves their combined state transition. Ethereum verifies one proof instead of executing every instruction.

The rollup usually publishes transaction or state-difference data so users can reconstruct state. Accounts and calls may remain public. “ZK-rollup” therefore does not mean a private rollup.

## Both goals can combine

A system can batch private transactions and prove the batch valid. It then needs both:

- efficient proof compression for scaling;
- carefully designed commitments, nullifiers, encryption, and metadata handling for privacy.

These requirements can conflict. Publishing data improves availability but may expose metadata; hiding more data makes independent reconstruction and compliance harder.

## The naming trap

Many scaling systems use validity proofs without using the zero-knowledge property to hide user data. Industry language still calls the area “ZK” because the proof-system family supports it.

Ask two separate questions: what computation does L1 avoid, and which exact information does the proof or application hide?

If neither answer is explicit, “powered by ZK” communicates almost nothing.

## Check yourself

1. What does a scaling proof save L1 from doing?
2. Why does a ZK-rollup usually still publish transaction data?
3. Which components beyond the proof affect privacy?
4. What two questions expose vague “ZK-powered” claims?
