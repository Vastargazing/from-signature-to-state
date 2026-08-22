# Data Availability

> **Data availability means the inputs needed to verify and continue a state machine were published when consensus accepted its commitment. A hash alone is not enough.**

## The dependency both rollup designs share

Optimistic and ZK-rollups establish correctness differently, but both require published data. An operator can publish a state root or proof while withholding the underlying transactions.

Other users may know the commitment is valid but cannot:

- reconstruct balances;
- verify an optimistic claim;
- create Merkle withdrawal proofs;
- produce the next state independently;
- take over when the operator disappears.

```text
commitment proves data was fixed
availability proves participants could obtain it
```

## Rollups and L1

Ethereum rollups publish compressed transaction or state-difference data in calldata or blobs. Ethereum consensus guarantees that data was available to nodes during its protocol window.

Optimistic rollups require it for challengers to replay execution. ZK-rollups require it so users can reconstruct state and exit even though correctness already has a validity proof.

## Availability is not permanent retrieval

Blob data may be pruned after the required window. This does not mean it was unavailable when accepted.

Long-term historical retrieval can be supplied by archives and other storage services. The protocol security requirement is that enough participants obtained the data at the time needed to verify and continue.

## External DA changes the trust boundary

A system can use a committee or another DA network instead of Ethereum. It may gain capacity and lower cost, but users now depend on that system not withholding data.

Ask what threshold can withhold, whether light clients can verify availability, how long data remains retrievable, and what exit path survives failure.

## The key sentence

Validity answers “was the transition correct?” Availability answers “can anyone else know and continue the state?” Scalable systems need explicit answers to both.

## Primary sources

- [Ethereum.org: Data availability](https://ethereum.org/developers/docs/data-availability/) — availability versus retrievability and the rollup failure boundary.
- [EIP-4844: Shard Blob Transactions](https://eips.ethereum.org/EIPS/eip-4844) — blob commitments, sidecars, separate blob gas, and consensus-layer availability duties.

Last verified: 2026-08-22.

## Check yourself

1. Why is a state-root commitment insufficient by itself?
2. Why do ZK-rollups need data availability despite validity proofs?
3. How does availability differ from permanent retrievability?
4. What trust changes when a rollup uses external DA?

<!-- corepath:start -->

**Core Path 48/50** · [← ZK-Rollup](154-zk-rollup.md) · [ERC-4337 →](169-erc-4337.md)

<!-- corepath:end -->
