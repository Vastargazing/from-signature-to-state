# Ethereum Block Layers, Roots, and Limits

After the Merge, “Ethereum block” can refer to related objects at two protocol layers. Their roots and resource limits must not be mixed.

## A beacon block contains an execution payload

The consensus client processes a beacon block. Its body can contain an `execution_payload`, the execution-layer block data handled by an execution client.

The two layers have similarly named commitments:

- the beacon block header's `state_root` commits to consensus-layer `BeaconState`;
- the execution payload's `stateRoot` commits to EVM world state after execution.

The beacon block root transitively commits to the execution payload, but the two state roots describe different state machines and are not interchangeable.

## Execution-layer roots

An execution block header groups several commitments:

- `parentHash` links to the previous execution header;
- `stateRoot` commits to the post-execution world state;
- `transactionsRoot` commits to the ordered transaction list;
- `receiptsRoot` commits to transaction outcomes and logs;
- `withdrawalsRoot` commits to consensus-triggered staking withdrawals represented in the execution payload.

Ethereum execution roots use protocol-defined Merkle Patricia Trie encodings. The consensus layer uses SSZ merkleization for beacon-chain objects. A proof is meaningful only with the correct encoding rules and root.

## Frozen proof-of-work fields

Execution headers retained fields such as `difficulty`, `nonce`, and the uncle-list hash after the transition to proof of stake. Their old mining meanings were disabled and their values constrained by the post-Merge rules.

Keeping the format reduced ecosystem breakage. The presence of a field does not prove the current protocol still uses its historical semantics.

## More than one block limit

Ethereum meters separate resources:

- **execution gas** bounds EVM computation and state work;
- **blob gas** bounds temporary rollup data availability in blob sidecars;
- **encoded execution-block size** bounds serialized execution data independently of gas.

Since Fusaka, EIP-7934 places an 8 MiB limit on the RLP-encoded execution block, leaving room within the consensus layer's larger gossip bound. Blob data is transmitted separately and follows its own per-block limits.

Bitcoin instead uses block weight, a serialization-volume measure that discounts witness data. It does not expose a general EVM-like computation market.

No single “block size” number compares these systems. The unit—gas, bytes, blob gas, or weight—states which resource the protocol is bounding.

## Primary sources

- [Ethereum consensus specifications](https://ethereum.github.io/consensus-specs/) — beacon-state, beacon-block, execution-payload, and fork-specific container definitions.
- [EIP-7934: RLP Execution Block Size Limit](https://eips.ethereum.org/EIPS/eip-7934) — independent encoded-size cap and safety margin.

Last verified: 2026-08-22.

## Check yourself

1. Which object contains the execution payload?
2. What does each layer's state root commit to?
3. Why do `difficulty` and `nonce` still exist in post-Merge execution headers?
4. Why can a block satisfy its execution-gas limit but violate another limit?
