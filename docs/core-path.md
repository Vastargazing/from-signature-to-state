# The Core Path

This is the book inside the knowledge base: fifty chapters that build one working model from a signed transaction to modern Ethereum.

Read them in order. Do not stop to chase every cross-reference. The atomic notes are there when a question becomes interesting enough to open.

## Before you start

You do not need prior blockchain experience. You should be comfortable with ordinary programming concepts: state, functions, APIs, bytes, and client-server systems.

Three rules make the path work:

1. Answer each chapter's **Check yourself** questions without looking back.
2. Keep a list of claims you cannot yet explain mechanically.
3. At each checkpoint, reconstruct the system from memory before continuing.

Use the [Core Path answer key](answers/core-path.md) only after committing to an answer. It explains the causal boundary; it is not a list of phrases to memorize.

Questions marked **Deep dive** point to an optional extension linked from the chapter itself. The four extensions are also collected under [Optional Deep Dives](index.md#optional-deep-dives); they are not prerequisites for the next chapter.

## Stage 0 — See the whole machine

Start with the pipeline before learning its parts.

1. [One Transaction, End to End](topics/000-one-transaction.md)

When you finish, you should be able to name the boundaries between signing, mempool admission, inclusion, execution, and finality.

## Stage 1 — State, transactions, and blocks

What is the machine actually doing?

2. [State and the State Transition Function](topics/006-state-transition.md)
3. [A Transaction and Its Fields](topics/007-transaction.md)
4. [A Block and the Transactions Inside It](topics/008-block.md)
5. [Transaction Lifecycle](topics/046-transaction-lifecycle.md)
6. [Ethereum World State](topics/034-ethereum-world-state.md)
7. [UTXO Model](topics/030-utxo-model.md)
8. [Account Model](topics/031-account-model.md)
9. [UTXO Model versus Account Model](topics/032-utxo-vs-accounts.md)

### Checkpoint: reconstruct a payment

Explain a Bitcoin payment and an Ethereum transfer without saying “the coin moves.” Describe the old state, the authorized input, the validity checks, and the new state.

**Practice:** complete [Labs 1–3](labs/index.md) as one sequence: submit a local transaction, decode its calldata, then connect its receipt and logs to the resulting storage.

## Stage 2 — What a node can verify

Why can a node reject a forged history without asking a central operator?

10. [Cryptographic Hash Function](topics/014-hash-properties.md)
11. [Merkle Tree and Merkle Proof](topics/016-merkle-tree.md)
12. [Asymmetric Cryptography](topics/017-asymmetric-crypto.md)
13. [Private and Public Keys](topics/018-private-public-key.md)
14. [Digital Signature of a Transaction](topics/020-digital-signature.md)
15. [Trustless](topics/004-trustless.md)

### Checkpoint: draw the trust boundary

For a transaction, list what a signature proves, what a Merkle proof proves, and what neither proves. Then name the assumptions that still remain.

## Stage 3 — How strangers agree on one history

Verification tells a node whether a candidate is valid. Consensus tells it which valid history to follow.

The next three chapters include a short **Rust lens** because networking, node validation, and transaction pools are direct infrastructure entry points. Later stages return to protocol mechanics; the language-specific thread resumes where implementation details make it useful.

16. [P2P Network, Gossip, and Discovery](topics/038-p2p-gossip-discovery.md)
17. [Full Node](topics/039-full-node.md)
18. [Mempool](topics/044-mempool.md)
19. [The Role of Consensus](topics/053-role-of-consensus.md)
20. [Byzantine Generals Problem](topics/054-byzantine-generals.md)
21. [Sybil Resistance](topics/056-sybil-resistance.md)
22. [Nakamoto Consensus](topics/057-nakamoto-consensus.md)
23. [Proof of Work](topics/058-proof-of-work.md)
24. [Proof of Stake](topics/061-proof-of-stake.md)
25. [Ethereum PoS: Slots, Epochs, and Attestations](topics/062-ethereum-pos-slots-epochs-attestations.md)
26. [LMD-GHOST and Casper FFG](topics/063-lmd-ghost-and-casper-ffg.md)
27. [Probabilistic Finality](topics/047-probabilistic-finality.md)
28. [Economic Finality](topics/048-economic-finality.md)

### Checkpoint: separate four decisions

For one proposed block, identify who checks validity, who earns the right to propose, which rule chooses the head, and what makes an older checkpoint final. If those answers collapse into “consensus,” repeat this stage.

## Stage 4 — Turn the chain into a computer

Now the shared state can hold code, and a transaction can request arbitrary deterministic execution.

29. [Externally Owned Account](topics/087-externally-owned-account.md)
30. [Contract Account](topics/088-contract-account.md)
31. [The EVM: A 256-Bit Stack Machine](topics/089-evm-stack-machine.md)
32. [Deterministic Execution](topics/091-deterministic-execution.md)
33. [EVM Data Areas](topics/093-evm-data-areas.md)
34. [ABI and Function Selector](topics/098-abi-and-function-selector.md)
35. [Smart Contract](topics/100-smart-contract.md)
36. [Creation Code and Runtime Code](topics/104-creation-code-and-runtime-code.md)
37. [Contract Deployment](topics/105-contract-deployment.md)
38. [State Storage and Storage Layout](topics/108-storage-layout.md)
39. [Gas as Computational Work](topics/118-gas-as-computational-work.md)
40. [Transaction and Block Gas Limits](topics/120-transaction-and-block-gas-limits.md)
41. [EIP-1559 Fees](topics/122-eip-1559-fees.md)
42. [Foundry](topics/114-foundry.md)
43. [Unit, Fuzz, and Invariant Tests](topics/115-unit-fuzz-and-invariant-tests.md)

### Checkpoint: follow a contract call

Start with a Solidity function call in a wallet. Follow its selector and arguments into calldata, through EVM execution, into storage changes, gas accounting, receipt, and logs.

**Practice:** use [Lab 4](labs/04-reentrancy-and-cei.md) to observe nested execution, then [Lab 5](labs/05-fuzz-and-invariant-testing.md) to replace a few examples with properties over inputs and call sequences.

## Stage 5 — The system developers meet today

The base model is no longer enough. Production applications inherit scaling, account, and security boundaries.

44. [The Scalability Trilemma](topics/149-scalability-trilemma.md)
45. [What an L2 Is—and What It Is Not](topics/151-what-is-an-l2.md)
46. [Optimistic Rollup](topics/152-optimistic-rollup.md)
47. [ZK-Rollup](topics/154-zk-rollup.md)
48. [Data Availability](topics/158-data-availability.md)
49. [ERC-4337](topics/169-erc-4337.md)
50. [Smart Contract Threat Model](topics/215-smart-contract-threat-model.md)

### Final checkpoint: draw the dependency stack

Choose one application on an L2. Draw every layer that can change its outcome: wallet, account rules, contracts, sequencer, proof or challenge system, data availability, L1 contracts, Ethereum execution, and Ethereum consensus. Mark which failures threaten safety, liveness, censorship resistance, or only user experience.

If you can do that without treating “the blockchain” as one trusted box, the core path has done its job.

### Return to Alice

Alice sends one more payment, this time from a smart account on a rollup. Her wallet may produce a `UserOperation` instead of a native transaction. A bundler packages it, a sequencer orders it, the L2 executes it, and the rollup publishes the data and proof or dispute commitment that Ethereum needs.

Bob sees a balance quickly, but “received” now spans several boundaries: wallet authorization, L2 inclusion, successful execution, data availability, rollup settlement, and Ethereum finality. Each layer answers a different question and can fail without every other layer failing with it.

That is the whole book in one habit: stop asking whether *the blockchain* can be trusted. Name the components, the evidence each one produces, and the guarantee that ends at every boundary.

## Choose a specialization

The rest of the knowledge base is not a longer mandatory path. Choose a branch and build something.

### Smart contracts and security

[Ownership and Access Control](topics/109-ownership-and-access-control.md) → [Proxies and Upgradeability](topics/110-proxies-and-upgradeability.md) → [Reentrancy](topics/217-reentrancy.md) → [Checks–Effects–Interactions](topics/218-checks-effects-interactions.md) → [Access-Control Errors](topics/221-access-control-errors.md) → [Privileged Functions](topics/228-privileged-functions.md)

### DeFi and MEV

[DeFi and Intermediaries](topics/174-defi-and-intermediaries.md) → [Constant-Product AMM](topics/177-constant-product-amm.md) → [Overcollateralization and Liquidations](topics/185-overcollateralization-and-liquidations.md) → [Oracle Problem](topics/193-oracle-problem.md) → [MEV](topics/200-mev.md) → [MEV Supply Chain](topics/203-mev-supply-chain.md)

### Zero-knowledge

[What a ZK Proof Proves](topics/237-what-a-zk-proof-proves.md) → [Completeness, Soundness, and Zero Knowledge](topics/238-completeness-soundness-and-zero-knowledge.md) → [SNARK versus STARK](topics/239-snark-vs-stark.md) → [Arithmetization and Circuits](topics/241-arithmetization-and-circuits.md) → [Proof Recursion and Aggregation](topics/243-proof-recursion-and-aggregation.md)

### Solana and parallel execution

[Solana Account Model](topics/245-solana-account-model.md) → [SVM and Sealevel](topics/246-svm-and-sealevel.md) → [Programs and PDAs](topics/247-solana-programs-and-pdas.md) → [Anchor](topics/249-anchor.md) → [Local Fee Markets](topics/250-solana-fees-and-local-contention.md)

Practice: [make hostile Anchor accounts fail before the handler](labs/08-hostile-anchor-accounts.md).

### Rust infrastructure

[Why Rust in Blockchain Infrastructure](topics/258-why-rust-in-blockchain-infrastructure.md) → [reth](topics/259-reth-ethereum-execution-client.md) → [revm](topics/260-revm.md) → [Alloy](topics/261-alloy-and-ethers-rs.md) → [Where the Jobs Are](topics/267-rust-blockchain-jobs.md)

Practice: build the [reorg-safe indexer](labs/06-reorg-safe-rust-indexer.md), then [execute and trace bytecode with `revm`](labs/07-execute-and-trace-with-revm.md).
