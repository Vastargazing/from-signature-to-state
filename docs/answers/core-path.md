# Core Path — Answer Key

Use this after answering in your own words. A matching phrase is not the goal; the causal chain is.

## 1. One Transaction, End to End

1. Alice authorizes the protocol-defined signing payload when her wallet or signing device creates the signature.
2. No. Admission is local to one node; the transaction can be evicted, replaced, invalidated, censored, or simply never selected.
3. Every validating execution node computes the balance change. The proposer supplies an ordered candidate, not an authoritative database result.
4. It can pass transaction-level validity, enter a block, and then revert or exhaust gas during EVM execution.
5. Finality means reversal would require violating stronger consensus assumptions. It does not make reversal mathematically impossible.

## 2. Web2, Web3, and the Architecture of a Dapp

1. A Web2 operator makes its database authoritative by controlling the server code, write policy, and administrative access. For an on-chain write, canonical state follows from an authorized input that the network includes and validates under protocol and contract rules; the frontend cannot commit the result by itself.
2. It has gained wallet-based authentication or proof that a key authorized a message. It has not gained shared, independently verifiable state or protocol-controlled transitions if the private database remains the final authority over balances and permissions.
3. Contract execution can remain independently verifiable while DNS, hosting, the default frontend, RPC provider, or indexer becomes unavailable. The chain may be live even though the product's only convenient access path has failed.
4. The signature proves that the relevant key or account logic authorized the encoded request. It does not prove that the interface displayed those bytes honestly or that the user understood their effect, so a compromised frontend can induce a valid but harmful authorization.
5. Put authority-critical shared state on-chain when independent parties must verify and act on it without one operator's permission. Private, high-volume, inexpensive-to-recompute, or non-critical presentation data usually belongs in an ordinary database unless a specific protocol guarantee requires it on-chain.

## 3. State and the State Transition Function

1. Consensus chooses one ordered history of valid inputs. Given that history, deterministic transition rules derive balances and the rest of state; nodes do not vote on each balance separately.
2. An Ethereum execution header contains `stateRoot`, a commitment to the post-state, not the state itself. A Bitcoin header has no consensus commitment to the current UTXO set.
3. Nodes could receive different API responses or receive them at different times, breaking deterministic replay. An oracle turns the external fact into agreed on-chain input.
4. An irregular state change is not produced by an ordinary transaction under the old transition rules. Clients implemented The DAO change as special fork-boundary logic, and the network adopted those new rules.
5. Execute accepted history, verify a proof against an authenticated state root, or trust an RPC response. Bitcoin lacks the second native path for UTXO state because its headers contain no UTXO-set root.
6. `PREVRANDAO` is shared, so replay stays deterministic, but a producer can anticipate it and influence outcomes by withholding a block. Shared does not mean unbiasable.

## 4. A Transaction and Its Fields

1. A native Ethereum transaction does not serialize `from`; the client recovers the public key and sender address from the signed payload and signature.
2. The account nonce prevents reuse on the same chain and imposes sender order. `chainId` prevents reuse on a compatible chain with a different identifier.
3. The legacy transaction format already existed, so EIP-155 folded the chain identifier into the signed `v` calculation instead of changing the serialized field list. Typed transactions later added an explicit field.
4. Below intrinsic gas, the transaction is invalid. Enough to start but not finish produces out-of-gas and reverts execution while consuming the remaining transaction gas. A high limit is only a ceiling: unused gas is not charged, although the sender must be able to cover the maximum upfront.
5. The receipt records execution status. The transaction contains the request, not its future result.

## 5. A Block and the Transactions Inside It

1. PoW headers prove linkage, header validity, and accumulated work under the checked rules. They do not by themselves prove transaction execution or body availability.
2. A beacon block is the consensus-layer object and may contain an execution payload. Its `state_root` commits to `BeaconState`; the execution payload's `stateRoot` commits to EVM world state.
3. They are cryptographic commitments that let a verifier bind proofs to exact data sets. Unlike an ordinary field, each root summarizes a structured collection without containing the collection itself.
4. The post-Merge format retained those fields for compatibility and froze them to protocol-defined values rather than redesigning every dependent encoding and interface.
5. Transactions read and write shared state. Reordering them can change validity, prices, contract output, MEV, and the final state root.
6. Execution gas bounds EVM work, blob gas prices temporary data availability, and encoded-size limits bound serialized execution data. Bitcoin block weight accounts for serialized transaction data with a discount for witness data.

## 6. Transaction Lifecycle

1. Every field covered by the signing payload is fixed before signing: recipient, value, nonce, chain context, fee settings, gas limit, call data, and any type-specific fields.
2. Inclusion only means the transaction passed block-level validity. Its contract execution can still revert or run out of gas, producing a failed receipt.
3. It offers another transaction for the same sender nonce under local pool replacement rules. Only the version eventually included has consensus effect.
4. A receipt describes execution in one block. That block can still be removed by fork choice until the relevant confirmation or finality threshold is reached.

## 7. Ethereum World State

1. An Ethereum account has a nonce, native balance, code hash, and storage root; an EOA has no contract code or application storage.
2. Transactions can read values written by earlier transactions, so changing order can change validity and output.
3. ERC-20 balances live in storage owned by the token contract, usually in a mapping keyed by holder address.
4. History is the accepted sequence of blocks and protocol inputs. World state is the current result of applying those inputs.

## 8. UTXO Model

1. It is not stored as one account number. A wallet finds unspent outputs it can authorize and sums their values.
2. An output is consumed whole. A partial payment creates a new output returning the remainder to a change condition controlled by the spender.
3. The fee is implicit: total input value minus total output value.
4. They conflict when both try to consume the same previous output.

## 9. Account Model

1. An Ethereum EOA has a native balance and transaction nonce; code and storage are empty.
2. The nonce prevents replay of an already used sequence number and imposes order among that sender's transactions.
3. Contract calls can discover and mutate shared state dynamically, making independent access sets difficult to know before execution.
4. Token balances, LP positions, NFTs, and protocol claims live in contract state, not in the EOA's native-balance field.

## 10. UTXO Model versus Account Model

1. UTXO transactions consume immutable outputs and create new ones. Account transactions mutate fields in a shared address-indexed state.
2. In UTXO, two transactions conflict by spending the same output. In an account model, sender nonce and state validity prevent two conflicting transitions from both applying.
3. Inputs cannot be partially consumed, so the unused value must become a new output.
4. Calls can touch shared or dynamically discovered contract state, creating dependencies not visible from the sender alone.

## 11. Cryptographic Hash Function

1. A preimage attack starts with only a target hash and seeks any matching input. A second-preimage attack also starts with a particular existing input and seeks a different input with the same hash.
2. For an ideal `n`-bit hash, the birthday effect finds any collision in about `2^(n/2)` work, while targeting one output needs about `2^n` work.
3. The PIN space is tiny. An attacker can hash every candidate and compare results, so a fast hash does not add entropy.
4. No. A practical collision attack finds specially constructed pairs; replacing an arbitrary existing file requires a second preimage.
5. A match binds data to an independently trusted expected hash under the hash assumptions. It does not prove who produced the data, whether it is true, or whether the expected hash is canonical.

## 12. Merkle Tree and Merkle Proof

1. Twelve sibling hashes for a balanced binary tree, because `log₂(4096) = 12`.
2. Hash concatenation is ordered. The verifier must know whether the current value goes to the left or right at every level.
3. It proves membership at the claimed path in the structure committed to by that root. It does not prove the root belongs to a canonical block.
4. Bitcoin's duplicate-last-leaf construction allowed two lists to produce the same root without finding a hash collision. The ambiguity was in tree construction rules, not SHA-256.
5. The structure must define verifiable gaps: ordering, explicit empty leaves, or a trie path whose termination proves no key exists there.

## 13. Asymmetric Cryptography

1. The private key remains secret while anyone can obtain the public key and verify signatures; verifiers do not need a shared secret with the signer.
2. Scalar multiplication is efficient, while recovering `x` from `P = xG` requires solving the elliptic-curve discrete-logarithm problem.
3. Encryption provides confidentiality for a recipient. A signature provides integrity and evidence that the matching private key authorized exact bytes.
4. Verification establishes a valid signature for a message and public key. Protocol rules still decide authorization, and nothing cryptographic identifies the human or proves when and why they signed.
5. The protocol sees valid key authority, not the circumstances under which the key was used. Theft does not make the mathematics invalid.

## 14. Private and Public Keys

1. A public key verifies signatures and can be shared. A private key creates them and must remain secret.
2. There is no server that receives or resets it. Possession usually grants direct signing authority, while loss cannot be repaired from the public key.
3. It proves that someone with access to the matching private key signed the exact verified message, assuming the scheme is secure.
4. Protocols may hash a public key, encode a spending script, or derive another identifier. Solana commonly exposes public-key bytes directly; Ethereum and Bitcoin do not.

## 15. Digital Signature of a Transaction

1. The nonce is inside the signed payload. Changing it changes the signing digest, so the old signature no longer authorizes the modified bytes.
2. Signing proves authorization for bytes, not balance, current nonce, inclusion, sufficient gas, or successful contract execution.
3. A signature can be replayed wherever the same message remains valid. A nonce, chain ID, recent block reference, deadline, or domain separator can narrow that validity domain.
4. The signature protects bytes, while the screen describes them. A dishonest interface can obtain a perfect signature over malicious bytes.

## 16. Trustless

1. Cryptographic assumptions, honest-weight or quorum assumptions, code correctness, and the social response layer remain. A full-from-genesis sync verifies more history locally; checkpoint or snapshot sync also needs an authenticated starting point.
2. Around one third can stop finalization; roughly 34% can attempt slashable double finality with carefully split honest votes; more than half can dominate fork choice; two thirds can finalize its preferred checkpoints.
3. A protocol bug violates implemented rules or their intended specification. Excess dishonest weight takes the system outside the assumptions under which those rules promised safety or liveness.
4. Zero trust is an access-control model that avoids implicit network-location trust. Trustless systems minimize reliance on particular intermediaries. Either can still be politically centralized.
5. Unverified balances, gas estimates, transaction status, and submitted RPC responses depend on that provider. The underlying chain remains independently verifiable through a node, an authenticated light-client view, or appropriate proofs; using one trusted interface does not erase that distinction.

## 17. P2P Network, Gossip, and Discovery

1. Discovery answers which peers exist and how to contact enough of them to join the overlay network.
2. Redundant paths tolerate slow, offline, censored, or malicious peers and improve eventual propagation.
3. Admission, eviction, topology, timing, and policy differ per node, so each sees a different pending set.
4. It tries to surround a node with attacker-controlled peers so the attacker can filter or fabricate the node's view of propagation and chain tips.
5. Peer diversity and independent network visibility have failed even though message framing has not. The attacker can delay or suppress transactions and blocks, bias the apparent chain tip, and isolate the node from honest propagation; valid syntax does not make that view complete or honest.

## 18. Full Node

1. It independently checks blocks and state transitions required by the protocol rather than accepting another server's validity verdict.
2. Validation needs current state and enough recent data, not every historical state version. Old states may be pruned.
3. A full node validates; a validator also has consensus duties and signing authority. A full node can operate without proposing or attesting.
4. Cryptography, software correctness, network visibility, synchronization anchors where used, hardware, and social consensus remain trust dependencies.

## 19. Mempool

1. Each node applies local admission, pricing, eviction, and topology rules; consensus does not maintain a single pending set.
2. It may propagate, wait, be replaced, be evicted, become invalid, or enter a block.
3. A sender's later nonce cannot execute before the missing earlier nonce, so builders normally cannot include the later transaction alone.
4. It should remove the losing same-nonce transaction and then revalidate Alice's later queued transactions against the new canonical nonce, balance, and fee conditions. Local admission was never a reservation of that nonce in canonical state.

## 20. The Role of Consensus

1. Consensus selects an ordered canonical history of valid protocol inputs.
2. Safety means honest participants do not finalize conflicting results. Liveness means the system continues making decisions under its stated conditions.
3. Otherwise one actor can create unlimited identities and dominate identity-counted votes at negligible cost.
4. It cannot guarantee that an oracle is truthful, a contract is bug-free, an asset is valuable, or a human intended what a valid key signed.

## 21. Byzantine Generals Problem

1. A crashed process stops or becomes unavailable. A Byzantine process can lie, equivocate, and send different valid-looking messages to different peers.
2. Signatures identify who sent conflicting messages, but they do not choose between competing valid proposals or guarantee enough messages arrive for agreement.
3. Intersecting quorums ensure two conflicting decisions cannot both gather sufficient support without some participant appearing in both and violating the rules.
4. The protocol must prevent cheap fake identities from manufacturing quorum weight, which requires Sybil resistance.
5. Two sets larger than two-thirds must overlap in more than one-third of the validator weight. That overlap contains signers who supported conflicting decisions, providing evidence that the assumed Byzantine bound was exceeded and, in an accountable protocol, evidence for punishment.

## 22. Sybil Resistance

1. One actor can generate unlimited keys, turning one-key-one-vote into one-machine-many-votes.
2. It makes economic stake—the capital exposed to protocol rewards and penalties—the scarce source of consensus weight.
3. It assigns costly weight but does not by itself specify proposals, voting, fork choice, finality, timing, or validity.
4. It can eclipse nodes, consume connections, delay propagation, censor messages from a victim's local view, or distort timing observations. The identities do not by themselves choose the canonical chain because consensus weight still comes from the protocol's scarce resource.

## 23. Nakamoto Consensus

1. Proof of work supplies scarce weight, a fork-choice rule selects the chain with greatest accumulated work, and incentives reward extending accepted history.
2. Propagation takes time, so two valid blocks can be discovered before all nodes see either one and local views temporarily differ.
3. Identities carry no chain weight; only valid accumulated work does.
4. They reject the block as invalid and do not extend it, regardless of its accumulated work. Majority hash power can reorder or censor within valid rules, but it cannot make an inflation rule violation valid for nodes enforcing the existing protocol.

## 24. Proof of Work

1. Finding a nonce requires repeated unpredictable trials, while verification hashes the candidate once and checks the target.
2. It commits to the exact header fields being hashed, including the block's link and data commitments.
3. Miners choose among valid candidates but full nodes enforce consensus rules and reject blocks that violate them regardless of work.
4. Before adjustment, valid blocks arrive faster on average because each target attempt is unchanged but more attempts occur per second. The next adjustment should make the target harder so the long-run average interval returns toward the protocol target; individual arrival times remain random.

## 25. Proof of Stake

1. Consensus weight comes from locked economic value, so generating extra keys does not create extra weight.
2. Protocol-defined evidence such as equivocation or conflicting finality votes can trigger slashing; ordinary downtime is usually penalized differently.
3. One operator can control many validators, while pools, custodians, and correlated infrastructure concentrate effective authority.
4. Both histories can contain mathematically valid signatures from keys whose stake is no longer slashable, so signatures alone do not identify the socially accepted recent chain. The node needs a sufficiently recent trusted checkpoint—obtained out of band or from an already trusted view—to anchor synchronization.
5. PoW makes consensus weight costly through specialized hardware and continuing energy expenditure; PoS makes it costly through controlled capital and protocol penalties for specified violations. PoS still needs protocol-specific proposer selection, fork choice, finality, and sometimes weak-subjectivity bootstrapping, so it changes rather than removes the security assumptions.

## 26. Ethereum PoS: Slots, Epochs, and Attestations

1. Thirty-two slots form an epoch.
2. An attestation supports a current fork-choice head and votes for a source-to-target checkpoint link used by finality.
3. Downtime harms liveness but does not prove malicious intent. Equivocation creates cryptographic evidence of incompatible claims and threatens safety.
4. The execution client validates the execution payload; the consensus client validates and coordinates the consensus-layer object.
5. Slots continue with time and available proposers may still produce blocks, so fork choice can keep selecting heads. Without more than two-thirds participating weight, new checkpoint links cannot reach the finality threshold, so finality stalls until participation recovers or protocol recovery mechanisms take effect.

## 27. LMD-GHOST and Casper FFG

1. LMD-GHOST chooses the current head.
2. Counting only the latest relevant message prevents old repeated votes from multiplying one validator's weight and reflects its current branch support.
3. Casper FFG finalizes epoch checkpoints through qualifying supermajority links.
4. Fork choice can continue selecting new heads with less participation than finality requires, so blocks can accumulate while checkpoint finalization stalls.

## 28. Probabilistic Finality

1. Another valid branch can overtake the branch containing that block, removing the transaction from canonical history.
2. Reversal requires replacing an increasing amount of accumulated work while the honest chain continues growing, so probability and cost worsen with depth.
3. Network delay can produce near-simultaneous valid blocks. Fork choice resolves them without implying an attack.
4. Required confidence depends on value at risk, attack incentives, network security, and the cost of handling reversal.

## 29. Economic Finality

1. Conflicting finalized checkpoints require slashable violations by a large share of stake, giving reversal an attributable economic cost.
2. Withholding votes can prevent a supermajority link and halt new finality without producing a conflicting finalized checkpoint.
3. Cryptographic assumptions, client correctness, stake distribution, and social recovery still exist; extreme failures can trigger a fork.
4. A UI update, exchange deposit, rollup bridge, and large settlement expose different values and recovery costs, so they rationally wait for different guarantees.

## 30. Externally Owned Account

1. A valid secp256k1 transaction signature whose recovered address matches the EOA authorizes a traditional top-level transaction.
2. It prevents replay on the same chain and orders that account's transactions.
3. An EOA is derived locally from key material; no on-chain state or deployment transaction is required until it is used or funded.
4. EIP-7702 lets an EOA authorize a delegation designator so calls can execute delegated code while the account still participates in the native transaction model.

## 31. Contract Account

1. Its deployed bytecode and current storage determine behavior; calls arrive because another transaction or contract invokes it.
2. No. A normal contract has no protocol private key and cannot originate a native top-level signed transaction.
3. Immutable proxy code can delegate every call to an implementation address stored in mutable proxy state.
4. If its code has no path to transfer or approve those tokens, no private key exists to bypass the code and recover them.

## 32. The EVM: A 256-Bit Stack Machine

1. Opcodes pop operands from the top of the stack and push results back.
2. One stack item is 256 bits wide.
3. Solidity type rules insert checks and masking, but the underlying EVM stack word remains 256 bits.
4. Calldata supplies input, memory provides temporary mutable bytes, storage persists state, and transient storage lasts for one transaction.
5. The attempted push causes stack overflow, an exceptional halt of the current frame. Its state changes revert according to call semantics; the caller may observe failure or itself revert depending on how the call was made and handled.

## 33. Deterministic Execution

1. The previous state, ordered transactions, block context, protocol version, and all other consensus-defined inputs must match.
2. It is supplied as a shared block input, so every validating node executes with the same value.
3. Deterministic replay holds: validators agree on the result for the block that was actually proposed. Unpredictability or manipulation resistance fails because the proposer can choose whether the transaction sees this slot's value or a later context; agreement after selection is not fair randomness before selection.
4. External APIs are not shared deterministic inputs. Oracles submit an authenticated claim through a transaction the chain can order and replay.

## 34. EVM Data Areas

1. Calldata contains ABI-encoded external function input.
2. Memory exists only for the current call frame and disappears when that call ends.
3. It expands long-lived global state that nodes must maintain and read across transactions, so writes are priced heavily.
4. `DELEGATECALL` preserves the proxy's contract context, so the implementation observes the proxy address's transient lock. It remains available to frames in that context for the rest of the transaction and is cleared when the transaction ends.

## 35. ABI and Function Selector

1. The canonical function signature, such as `transfer(address,uint256)`, without spaces or return types.
2. Four bytes: the first four bytes of the Keccak-256 hash.
3. It comes from compiler artifacts, verified source metadata, or an interface supplied by a developer; bytecode does not contain the full human-readable JSON ABI.
4. The first four bytes of the two canonical-signature hashes have collided; the full signatures have not necessarily done so. The proxy must not infer unique intent or authorization from the selector alone and needs unambiguous routing plus normal access checks.

## 36. Smart Contract

1. Deployed code, current state, call input, caller/value context, block context, gas, and any nested call results determine execution.
2. No. A web response would not be a deterministic shared protocol input; an oracle must bring the claim on-chain.
3. Determinism reproduces the code's behavior, including incorrect authorization, accounting, or economic assumptions.
4. A stable proxy address can delegate to a replaceable implementation whose address is stored in proxy state.

## 37. Creation Code and Runtime Code

1. Creation code executes during deployment.
2. The bytes returned by creation-code execution become the deployed runtime code.
3. They live in the new contract account's storage, written during construction.
4. CREATE2 includes the deployer, salt, and hash of the full initcode; different constructor arguments can change initcode while returning identical runtime bytes.

## 38. Contract Deployment

1. Its `to` field is empty, and its data contains initcode.
2. The successful creation frame's returned bytes become the account's runtime code.
3. The proxy lacks initializer-written state such as its owner, roles, or configuration because the implementation constructor touched a different account's storage. An attacker can call the exposed initializer first and assign those privileges or parameters to itself.
4. The same address can exist on several chains with unrelated code or state, so chain ID is part of deployment identity and verification.

## 39. State Storage and Storage Layout

1. Adjacent values smaller than 32 bytes can pack into one slot when Solidity's layout rules and declaration order allow it.
2. A mapping value is stored at a slot derived by hashing the encoded key with the mapping's declared base slot.
3. No. The layout gives a value location for a known key but stores no iterable key list automatically.
4. It reads whatever old value already occupies slot 1 and interprets those bytes as `owner`; the original owner bytes remain stranded in slot 0 under a new meaning. Access checks and writes can therefore authorize the wrong address or corrupt unrelated state even though the new code is valid in isolation.

## 40. Gas as Computational Work

1. Gas used counts metered operations; gas price converts each unit into a native-currency fee.
2. Hardware speeds differ and improve over time. Consensus needs deterministic protocol costs that every node computes identically.
3. Every transaction has a finite gas budget. Non-terminating or unexpectedly expensive execution stops when that budget is exhausted.
4. An optimization can harm readability, security, upgradeability, or correctness. Gas is one design constraint, not the whole objective.

## 41. Transaction and Block Gas Limits

1. The sender chooses the transaction gas limit, usually with wallet or RPC estimation. Ethereum Mainnet additionally rejects a transaction whose limit exceeds the protocol cap introduced by EIP-7825; that ceiling is separate from the block gas limit.
2. No. The sender pays for gas actually consumed, subject to refund and fee rules; the unused ceiling is released.
3. It caps the EVM work all validating nodes may be forced to perform for one block.
4. The target is the utilization level around which the base fee adjusts. The maximum is the hard execution-gas capacity of a block and is higher than the target.

## 42. EIP-1559 Fees

1. `maxFeePerGas` caps the total price per gas; `maxPriorityFeePerGas` caps the proposer tip within that total.
2. The base-fee portion is burned; the effective priority fee goes to the block's fee recipient.
3. No. The effective price is the base fee plus the smaller of the priority cap and the remaining room under the total cap.
4. The base fee rises from block to block because utilization stays above the target. EIP-1559 makes the congestion price adjust predictably; it does not create extra capacity, so persistent demand can still make execution expensive.

## 43. Foundry

1. Forge builds projects and runs Solidity tests.
2. Cast encodes, signs, sends, decodes, and queries Ethereum data from the command line.
3. Cheatcodes are testing powers supplied by the Forge environment; no production EVM contract can invoke that host interface.
4. It is performance-sensitive developer tooling: compilation orchestration, EVM execution, fuzzing, tracing, RPC, and test infrastructure implemented largely in Rust.

## 44. Unit, Fuzz, and Invariant Tests

1. A unit test documents one intentional scenario with exact setup and expected output, making known behavior easy to understand and debug.
2. It checks a meaningful property over a deliberate input domain rather than merely asserting that execution did not revert.
3. They explore sequences across actors and intermediate states, checking that properties survive transitions rather than one isolated call.
4. It tracks model or accounting state inside the test so observed contract behavior can be compared with an independent expectation.

## 45. The Scalability Trilemma

1. More data and computation per block raise bandwidth, CPU, storage, and synchronization requirements, excluding some independent operators.
2. No. It is a design lens for recurring trade-offs, not a theorem with one universal quantitative bound.
3. They execute transactions outside L1, then make L1 verify compact commitments, proofs or challenges, and required data rather than every user instruction.
4. Ask which layer, hardware, workload, finality threshold, data-availability assumption, decentralization level, and sustained period the number describes.

## 46. What an L2 Is—and What It Is Not

1. Its state correctness is enforced by contracts and evidence anchored to the L1, allowing users to recover or challenge without trusting only the L2 operator.
2. A root is only a commitment to whatever history the sidechain claims. Without transaction data plus an enforceable proof or dispute mechanism, Ethereum cannot determine that the committed transition was valid, so correctness still depends on the sidechain's validator set.
3. Upgrade keys, pause powers, proof-system controls, sequencer censorship, allowlists, or mutable bridge contracts can weaken the deployed trust model.
4. They consume L1 data availability, verification computation, contract storage, settlement transactions, and bridge operations.

## 47. Optimistic Rollup

1. It publishes transaction data or an equivalent reconstruction input and proposes commitments such as a new L2 state root through L1 contracts.
2. A challenger must reconstruct execution to demonstrate that a claimed transition is invalid; withheld data prevents that check.
3. At least one honest, able, timely challenger plus a correct and enforceable fault-proof system replaces an upfront validity proof.
4. A liquidity provider can pay the user immediately and later claim the canonical withdrawal, taking liquidity and protocol risk in exchange for a fee.

## 48. ZK-Rollup

1. It proves that applying the encoded batch relation to an accepted old root produces the claimed new root.
2. The proof compresses evidence of a large computation into a verification procedure designed to cost far less than replaying every step on L1.
3. No. “ZK-rollup” commonly refers to validity-proof scaling; transaction data and state may remain public.
4. Users and new nodes still need enough data to reconstruct balances, create future proofs, and exit. Correctness of a hidden state root is not availability of its state.

## 49. Data Availability

1. A commitment binds to some data but does not deliver it. A producer can publish a valid root while withholding the preimage needed to reconstruct state.
2. The proof establishes a valid transition, but users still need transaction or state-diff data to know their state and continue or exit independently.
3. Availability asks whether enough participants can obtain data during the protocol's required window. Permanent retrievability asks whether someone serves it indefinitely.
4. Safety or liveness now also depends on the external DA network, committee, sampling design, reconstruction threshold, and bridge integration instead of Ethereum alone.

## 50. ERC-4337

1. No. A `UserOperation` is an application-layer object handled through a separate pool and EntryPoint contract.
2. A bundler submits and initially pays for the ordinary outer Ethereum transaction, then receives reimbursement from account deposits or a paymaster path.
3. The shared EntryPoint coordinates account and paymaster validation, execution, and gas accounting.
4. A deterministic factory scheme lets the future address be known and funded before deployment; the first operation can deploy the account and then execute through it.

## 51. Smart Contract Threat Model

1. Invariants state what value or authority must remain protected. Vulnerability names are only possible ways those properties may fail and can miss system-specific paths.
2. It makes the owner key, ownership-transfer path, multisig policy, signer security, and any upgrade path part of the trusted computing and operational boundary.
3. Safety means forbidden outcomes do not occur, such as theft or insolvency. Liveness means required progress remains possible, such as withdrawals or liquidations.
4. A useful assumption can be turned into a setup constraint or adversarial test—for example, oracle age, signer threshold, collateralization, or bounded loop size.
5. The pause protects safety by preventing loans against an untrustworthy price, but it weakens liveness because legitimate borrowing stops. The model should also examine how users repay, add collateral, get liquidated, or exit during the pause—and who can restore the oracle or unpause the system.
