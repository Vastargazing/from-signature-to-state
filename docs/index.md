# From Signature to State

> An engineering guide to blockchains—from signed transactions and state transitions to Ethereum, scaling, security, and infrastructure built in Rust.

## Why This Matters

This book is for developers who want to understand the machinery instead of memorizing crypto vocabulary.

It should leave you able to:

- reconstruct the path from a signed transaction to canonical state;
- explain which authority and state boundaries change between a conventional Web2 application and a Web3 application;
- explain why each layer exists and which failure it prevents;
- inspect the trust assumptions hidden behind words such as *decentralized*, *trustless*, *final*, and *ZK-secured*;
- enter the industry through contracts or through Rust infrastructure: nodes, execution engines, indexers, ZK, Solana, and Polkadot SDK.

Learn the EVM regardless. Even if you write Rust, the EVM is the industry's common language: everything else is explained in relation to it.

## Start Here

Do not begin by reading 274 definitions in numerical order.

1. Read [One Transaction, End to End](topics/000-one-transaction.md). It gives you the whole machine before the book takes it apart.
2. Follow [The Core Path](core-path.md): fifty-one chapters that build one working mental model.
3. Check your reasoning against the [Core Path answer key](answers/core-path.md).
4. Use the [Labs](labs/index.md) to turn the model into traces, tests, and programs.
5. Return here when you need the complete knowledge map or want to choose a specialization.

The atomic notes are the reference layer. The Core Path is the book.

## Optional Deep Dives

Four early chapters keep their core models readable by moving protocol history and exact limits into optional extensions:

- [State Commitments, Proofs, and Synchronization](deep-dives/state-commitments-proofs-and-synchronization.md)
- [Ethereum Transaction Envelopes and Gas Failures](deep-dives/ethereum-transaction-envelopes-and-gas-failures.md)
- [Ethereum Block Layers, Roots, and Limits](deep-dives/ethereum-block-layers-roots-and-limits.md)
- [Trust Assumptions and Ethereum Stake Thresholds](deep-dives/trust-assumptions-and-ethereum-stake-thresholds.md)

Open one when a chapter marks a question **Deep dive**. They are optional precision layers, not hidden prerequisites for continuing the Core Path.

## How the Notes Work

Each item below maps to an atomic note in `Atom/`.

A note earns its place when it answers three questions:

1. What is it mechanically?
2. Why does it exist—what problem does it solve?
3. What breaks if it does not exist / what is the trade-off?

The third question matters most. Without it, the result is a glossary rather than understanding.

Numbers identify notes; they are not the recommended reading order.

## Legend

- ★ — **core.** You should be able to explain it at a whiteboard on the spot, including the “why?”
- ▸ — **important.** You should be able to explain it in your own words.
- (no marker) — **overview.** Know that it exists and why; learn the details as needed.

## Reading Modes

| If you want to… | Read… |
|---|---|
| translate client-server experience into a Web3 architecture | [Web2, Web3, and the Architecture of a Dapp](topics/101-decentralized-application.md) |
| understand the system from first principles | [The Core Path](core-path.md) |
| look up one term while working | the numbered knowledge map below |
| build smart contracts | Sections VII–IX, XI, XVIII |
| work on nodes, execution, or MEV infrastructure | Sections IV, V, VII, XVI, XXI |
| understand modern Ethereum scaling | Sections XII, XIII, XVII, XIX |
| compare ecosystems | Sections III, V, XX |
| learn by producing traces and breaking assumptions | [The eight labs](labs/index.md) |

---

## I. Models and Core Concepts

1. ★ [Distributed Ledger — DLT](topics/001-dlt.md)
2. ▸ [Blockchain as a Special Case of DLT](topics/002-blockchain-as-dlt.md)
3. ★ [Centralization, Distribution, and Decentralization](topics/003-centralization-decentralization.md)
4. ★ [Trustless — Operating Without Trust Between Participants](topics/004-trustless.md)
5. ▸ [Permissionless — Participation Without Permission](topics/005-permissionless.md)
6. ★ [State and the State Transition Function](topics/006-state-transition.md)
7. ★ [A Transaction and Its Fields](topics/007-transaction.md)
8. ★ [A Block and the Transactions Inside It](topics/008-block.md)
9. ★ [Linking Blocks with Hashes](topics/009-hash-linking.md)
10. ★ [Immutability and Rewriting History](topics/010-immutability.md)
11. [The Genesis Block](topics/011-genesis.md)
12. ▸ [Network Protocol: Consensus Rules and Policy Rules](topics/012-consensus-vs-policy.md)
13. ▸ [Client and Specification](topics/013-client-and-spec.md)

## II. Cryptography

14. ★ [Cryptographic Hash Function](topics/014-hash-properties.md)
15. ▸ [SHA-256, Keccak-256, and BLAKE3](topics/015-sha-keccak-blake.md)
16. ★ [Merkle Tree and Merkle Proof](topics/016-merkle-tree.md)
17. ★ [Asymmetric Cryptography](topics/017-asymmetric-crypto.md)
18. ★ [Private and Public Keys](topics/018-private-public-key.md)
19. ★ [Address Derivation](topics/019-address-derivation.md)
20. ★ [Digital Signature of a Transaction](topics/020-digital-signature.md)
21. ★ [ECDSA on secp256k1](topics/021-ecdsa-secp256k1.md)
22. ▸ [Ed25519](topics/022-ed25519.md)
23. [Schnorr Signatures and Taproot](topics/023-schnorr-taproot.md)
24. ▸ [BLS Signatures and Aggregation](topics/024-bls-aggregation.md)
25. ▸ [Deterministic Wallets: BIP-32, BIP-39, and BIP-44](topics/025-hd-wallets.md)
26. ★ [Seed Phrase](topics/026-seed-phrase.md)
27. ★ [Custodial and Non-Custodial Storage](topics/027-custodial-noncustodial.md)
28. ▸ [Hardware Wallet](topics/028-hardware-wallet.md)
29. ▸ [Multisig and Threshold Signatures](topics/029-multisig-threshold.md)

## III. Data and State Models

30. ★ [UTXO Model](topics/030-utxo-model.md)
31. ★ [Account Model](topics/031-account-model.md)
32. ★ [UTXO Model versus Account Model](topics/032-utxo-vs-accounts.md)
33. ▸ [Merkle Patricia Trie](topics/033-merkle-patricia-trie.md)
34. ★ [Ethereum World State](topics/034-ethereum-world-state.md)
35. ▸ [State Root](topics/035-state-root.md)
36. ▸ [State Bloat](topics/036-state-bloat.md)
37. ▸ [Current State versus Historical State](topics/037-current-vs-historical-state.md)

## IV. Network and Nodes

38. ▸ [P2P Networking: Discovery and Gossip](topics/038-p2p-gossip-discovery.md)
39. ★ [Full Node](topics/039-full-node.md)
40. ▸ [Archive Node](topics/040-archive-node.md)
41. ▸ [Light Client](topics/041-light-client.md)
42. ▸ [Execution and Consensus Clients](topics/042-execution-consensus-clients.md)
43. ▸ [Engine API](topics/043-engine-api.md)
44. ★ [Mempool](topics/044-mempool.md)
45. ▸ [Private Mempool and Private Order Flow](topics/045-private-mempool.md)
46. ★ [Transaction Lifecycle](topics/046-transaction-lifecycle.md)
47. ★ [Probabilistic Finality](topics/047-probabilistic-finality.md)
48. ★ [Economic Finality in Proof of Stake](topics/048-economic-finality.md)
49. ★ [JSON-RPC and Node Access](topics/049-json-rpc.md)
50. ▸ [Node Providers and Centralization](topics/050-node-providers.md)
51. ▸ [Indexers, The Graph, and Reading Blockchain Data](topics/051-indexers-the-graph.md)
52. ▸ [Throughput, Block Time, and Block Capacity](topics/052-throughput-block-time-size.md)

## V. Consensus

53. ★ [The Role of Consensus](topics/053-role-of-consensus.md)
54. ★ [The Byzantine Generals Problem](topics/054-byzantine-generals.md)
55. ▸ [FLP and CAP](topics/055-flp-and-cap.md)
56. ★ [Sybil Resistance](topics/056-sybil-resistance.md)
57. ★ [Nakamoto Consensus](topics/057-nakamoto-consensus.md)
58. ★ [Proof of Work](topics/058-proof-of-work.md)
59. ★ [Mining, Hash Rate, and Difficulty](topics/059-mining-hashrate-difficulty.md)
60. ▸ [Block Reward and Halving](topics/060-block-reward-halving.md)
61. ★ [Proof of Stake](topics/061-proof-of-stake.md)
62. ▸ [Ethereum PoS: Slots, Epochs, and Attestations](topics/062-ethereum-pos-slots-epochs-attestations.md)
63. ▸ [LMD-GHOST and Casper FFG](topics/063-lmd-ghost-and-casper-ffg.md)
64. ★ [Slashing](topics/064-slashing.md)
65. ▸ [Liquid Staking: Lido and stETH](topics/065-liquid-staking-lido-steth.md)
66. ▸ [Restaking and EigenLayer](topics/066-restaking-and-eigenlayer.md)
67. ▸ [Proof of History in Solana](topics/067-proof-of-history-solana.md)
68. ▸ [Tendermint and CometBFT](topics/068-tendermint-cometbft.md)
69. [Proof of Space and Time: Chia](topics/069-proof-of-space-and-time-chia.md)
70. ★ [Double-Spending](topics/070-double-spending.md)
71. ★ [Sybil Attack](topics/071-sybil-attack.md)
72. ★ [51% Attack and Chain Reorganization](topics/072-51-percent-attack-and-reorganization.md)
73. ★ [Fork-Choice Rule](topics/073-fork-choice-rule.md)
74. ▸ [Long-Range Attacks and Weak Subjectivity](topics/074-long-range-attack-and-weak-subjectivity.md)

## VI. Protocol Evolution

75. ★ [Network Fork vs Code Fork](topics/075-network-fork-vs-code-fork.md)
76. ★ [Soft Fork and Hard Fork](topics/076-soft-fork-and-hard-fork.md)
77. ▸ [EIP and BIP Process](topics/077-eip-and-bip-process.md)
78. ▸ [Off-Chain and On-Chain Governance](topics/078-offchain-and-onchain-governance.md)
79. [SegWit, the Block Size Wars, and Bitcoin Cash](topics/079-segwit-block-size-wars-bitcoin-cash.md)
80. ▸ [The DAO Hack and the ETH/ETC Split](topics/080-dao-hack-eth-etc-split.md)
81. [The Difficulty Bomb](topics/081-difficulty-bomb.md)
82. ★ [The Merge](topics/082-the-merge.md)
83. ▸ [Shapella and Staking Withdrawals](topics/083-shapella-staking-withdrawals.md)
84. ★ [Dencun and EIP-4844](topics/084-dencun-and-eip-4844.md)
85. ▸ [Reading the Ethereum Roadmap](topics/085-reading-the-ethereum-roadmap.md)

## VII. Ethereum and the EVM

86. ▸ [A Network's Native Coin](topics/086-native-coin.md)
87. ★ [Externally Owned Account](topics/087-externally-owned-account.md)
88. ★ [Contract Account](topics/088-contract-account.md)
89. ★ [The EVM: A 256-Bit Stack Machine](topics/089-evm-stack-machine.md)
90. ▸ [EVM Opcodes](topics/090-evm-opcodes.md)
91. ★ [Deterministic Execution](topics/091-deterministic-execution.md)
92. ★ [Turing Completeness and Gas](topics/092-turing-completeness-and-gas.md)
93. ★ [Calldata, Memory, Storage, and Stack](topics/093-evm-data-areas.md)
94. ★ [CALL, DELEGATECALL, and STATICCALL](topics/094-call-delegatecall-staticcall.md)
95. ▸ [CREATE and CREATE2](topics/095-create-and-create2.md)
96. ▸ [Logs and Events](topics/096-logs-and-events.md)
97. ▸ [Precompiles](topics/097-precompiles.md)
98. ★ [ABI and Function Selectors](topics/098-abi-and-function-selector.md)
99. ▸ [revm: An EVM in Rust](topics/099-revm-rust-evm.md)

## VIII. Smart Contracts

100. ★ [Smart Contract](topics/100-smart-contract.md)
101. ★ [Web2, Web3, and the Architecture of a Dapp](topics/101-decentralized-application.md)
102. ★ [Solidity](topics/102-solidity.md)
103. [Vyper](topics/103-vyper.md)
104. ★ [Creation Code and Runtime Code](topics/104-creation-code-and-runtime-code.md)
105. ▸ [Contract Deployment](topics/105-contract-deployment.md)
106. ▸ [Calling a Contract Function Through a Transaction](topics/106-function-call-transaction.md)
107. ▸ [Interactions Between Multiple Contracts](topics/107-multiple-contract-interactions.md)
108. ★ [State Storage and Storage Layout](topics/108-storage-layout.md)
109. ★ [Contract Ownership and Access Control](topics/109-ownership-and-access-control.md)
110. ★ [Proxies and Upgradeability: Transparent and UUPS](topics/110-proxies-and-upgradeability.md)
111. ▸ [Storage Collision During an Upgrade](topics/111-storage-collision.md)
112. ▸ [Source-Code Verification on Etherscan](topics/112-source-code-verification.md)
113. [Bytecode Decompilation](topics/113-bytecode-decompilation.md)
114. ★ [Foundry: The Primary EVM Toolbelt](topics/114-foundry.md)
115. ★ [Unit, Fuzz, and Invariant Tests](topics/115-unit-fuzz-and-invariant-tests.md)
116. ▸ [Fork Tests Against Real Network State](topics/116-fork-tests.md)
117. [Formal Verification](topics/117-formal-verification.md)

## IX. Gas and Fees

118. ★ [Gas as a Measure of Computational Work](topics/118-gas-as-computational-work.md)
119. ▸ [Opcode Costs and Where They Come From](topics/119-opcode-gas-costs.md)
120. ★ [Transaction Gas Limit and Block Gas Limit](topics/120-transaction-and-block-gas-limits.md)
121. ★ [Out of Gas](topics/121-out-of-gas.md)
122. ★ [EIP-1559: Base Fee, Priority Fee, and Burning](topics/122-eip-1559-fees.md)
123. ★ [How the Base Fee Responds to Block Utilization](topics/123-base-fee-and-block-utilization.md)
124. ▸ [Blob Gas as a Separate Market](topics/124-blob-gas-market.md)
125. ▸ [Wei, Gwei, and ETH Units](topics/125-wei-gwei-and-eth-units.md)
126. ▸ [Calldata Cost and Why L2s Reduce It](topics/126-calldata-cost-and-l2s.md)

## X. Economics

127. ▸ [Issuance](topics/127-issuance.md)
128. ▸ [Bitcoin's Capped Supply](topics/128-bitcoin-capped-supply.md)
129. ★ [Inflationary and Deflationary Models](topics/129-inflationary-and-deflationary-models.md)
130. ▸ [Coin Burning](topics/130-coin-burning.md)
131. ▸ [“Ultrasound Money”: Thesis and Limits](topics/131-ultrasound-money-thesis.md)
132. ▸ [Market Capitalization, FDV, and Trading Volume](topics/132-market-cap-fdv-and-volume.md)
133. ★ [Tokenomics: Allocations, Vesting, and Unlocks](topics/133-tokenomics-allocations-vesting-unlocks.md)
134. [Crypto Winter and Market Cycles](topics/134-crypto-winter-and-market-cycles.md)

## XI. Tokens and Standards

135. ▸ [Coin Versus Token](topics/135-coin-vs-token.md)
136. ★ [ERC-20](topics/136-erc-20.md)
137. ▸ [Mint, Burn, Transfer, and Balance](topics/137-mint-burn-transfer-balance.md)
138. ★ [Approve, Allowance, and Unlimited Approval](topics/138-approve-allowance-unlimited-approval.md)
139. ▸ [EIP-2612 Permit](topics/139-eip-2612-permit.md)
140. ▸ [ERC-721](topics/140-erc-721.md)
141. ▸ [ERC-1155](topics/141-erc-1155.md)
142. ▸ [ERC-4626: Tokenized Vaults](topics/142-erc-4626.md)
143. [ERC-165 Interface Detection](topics/143-erc-165.md)
144. ★ [Fiat-Backed Stablecoins: USDT and USDC](topics/144-fiat-backed-stablecoins.md)
145. ▸ [Overcollateralized Stablecoins: DAI](topics/145-overcollateralized-stablecoins-dai.md)
146. ★ [Algorithmic Stablecoins and the UST/LUNA Collapse](topics/146-algorithmic-stablecoins-ust-luna.md)
147. [ICOs, IDOs, and Modern Crypto Fundraising](topics/147-ico-ido-and-modern-fundraising.md)
148. ★ [Scam Tokens: Honeypots, Hidden Logic, and Backdoors](topics/148-scam-tokens.md)

## XII. Scaling and L2s

149. ★ [The Scalability Trilemma](topics/149-scalability-trilemma.md)
150. ▸ [Vertical and Horizontal Scaling](topics/150-vertical-and-horizontal-scaling.md)
151. ★ [What an L2 Is—and What It Is Not](topics/151-what-is-an-l2.md)
152. ★ [Optimistic Rollup](topics/152-optimistic-rollup.md)
153. ▸ [Fraud Proof and Challenge Period](topics/153-fraud-proof-and-challenge-period.md)
154. ★ [ZK-Rollup](topics/154-zk-rollup.md)
155. ▸ [Validity Proof](topics/155-validity-proof.md)
156. ★ [Sequencer and Its Centralization](topics/156-sequencer-and-centralization.md)
157. ▸ [Forced Inclusion and Escape Hatches](topics/157-forced-inclusion-and-escape-hatch.md)
158. ★ [Data Availability](topics/158-data-availability.md)
159. ▸ [Blobs and EIP-4844](topics/159-blobs-and-eip-4844.md)
160. ▸ [External DA: Celestia and EigenDA](topics/160-external-da-celestia-and-eigenda.md)
161. ▸ [Validium and Volition](topics/161-validium-and-volition.md)
162. ▸ [L1↔L2 Bridge and Withdrawals](topics/162-l1-l2-bridge-and-withdrawals.md)
163. ▸ [Arbitrum, Optimism, Base, zkSync, and Starknet](topics/163-major-rollup-families.md)
164. ▸ [OP Stack and the Superchain](topics/164-op-stack-and-superchain.md)
165. ★ [Sidechain versus Rollup](topics/165-sidechain-vs-rollup.md)
166. ▸ [State Channels and the Lightning Network](topics/166-state-channels-and-lightning.md)
167. ▸ [Sharding and Why Ethereum Chose Rollups](topics/167-sharding-and-ethereum-rollups.md)

## XIII. Account Abstraction

168. ★ [Limitations of EOAs](topics/168-eoa-limitations.md)
169. ★ [ERC-4337: UserOperation, Bundler, and EntryPoint](topics/169-erc-4337.md)
170. ▸ [Paymaster](topics/170-paymaster.md)
171. ▸ [Session Keys and Social Recovery](topics/171-session-keys-and-social-recovery.md)
172. ▸ [EIP-7702](topics/172-eip-7702.md)
173. ▸ [Safe and Smart Wallets in Production](topics/173-safe-and-smart-wallets.md)

## XIV. DeFi

174. ▸ [DeFi and the Removal of Financial Intermediaries](topics/174-defi-and-intermediaries.md)
175. ★ [Protocol Composability](topics/175-protocol-composability.md)
176. ▸ [Decentralized Exchange](topics/176-decentralized-exchange.md)
177. ★ [AMM and the Constant-Product Formula](topics/177-constant-product-amm.md)
178. ★ [Liquidity Pool and LP Positions](topics/178-liquidity-pool-and-lp-positions.md)
179. ▸ [Slippage](topics/179-slippage.md)
180. ★ [Impermanent Loss](topics/180-impermanent-loss.md)
181. ▸ [Concentrated Liquidity: Uniswap v3 and v4](topics/181-concentrated-liquidity.md)
182. ▸ [Swap Routing and Aggregators](topics/182-swap-routing-and-aggregators.md)
183. ▸ [On-Chain Order Books and Solana](topics/183-onchain-order-books-on-solana.md)
184. ▸ [Lending Protocols: Aave and Compound](topics/184-aave-and-compound.md)
185. ★ [Overcollateralization and Liquidations](topics/185-overcollateralization-and-liquidations.md)
186. ▸ [Liquidation Cascades](topics/186-liquidation-cascades.md)
187. ★ [Flash Loans](topics/187-flash-loans.md)
188. ★ [Flash-Loan Attacks](topics/188-flash-loan-attacks.md)
189. ▸ [Yield Farming and Liquidity Mining](topics/189-yield-farming.md)
190. ▸ [Stablecoin Swaps and Curve](topics/190-curve-and-stableswaps.md)
191. [Perpetuals and On-Chain Derivatives](topics/191-perpetuals-and-derivatives.md)
192. [Regulation and Taxation](topics/192-regulation-and-taxation.md)

## XV. Oracles

193. ★ [The Oracle Problem](topics/193-oracle-problem.md)
194. ▸ [Price Feeds: Chainlink](topics/194-chainlink-price-feeds.md)
195. ▸ [Push and Pull Oracles: Pyth](topics/195-push-and-pull-oracles.md)
196. ★ [TWAP and Manipulation](topics/196-twap.md)
197. ★ [Oracle Manipulation as an Attack Class](topics/197-oracle-manipulation.md)
198. ▸ [VRF and Verifiable Randomness](topics/198-vrf.md)
199. ★ [Why `block.timestamp` and `blockhash` Are Not Randomness](topics/199-block-values-are-not-random.md)

## XVI. MEV

200. ★ [Maximal Extractable Value](topics/200-mev.md)
201. ★ [Frontrunning, Backrunning, and Sandwich Attacks](topics/201-frontrunning-backrunning-and-sandwiches.md)
202. ▸ [Arbitrage and Liquidations as Beneficial MEV](topics/202-beneficial-mev.md)
203. ▸ [Searcher, Builder, Relay, and Proposer](topics/203-mev-supply-chain.md)
204. ▸ [Proposer-Builder Separation and MEV-Boost](topics/204-pbs-and-mev-boost.md)
205. ▸ [Private Transactions and Flashbots Protect](topics/205-private-transactions.md)
206. ▸ [Time-Bandit Attacks](topics/206-time-bandit-attacks.md)

## XVII. Bridges and Cross-Chain

207. ▸ [Blockchain Bridges](topics/207-bridges.md)
208. ★ [Lock-and-Mint and Burn-and-Mint](topics/208-lock-mint-and-burn-mint.md)
209. ▸ [Trusted and Externally Validated Bridges](topics/209-externally-validated-bridges.md)
210. ▸ [Light-Client Bridges and IBC](topics/210-light-client-bridges-and-ibc.md)
211. ★ [Ronin, Wormhole, and Nomad](topics/211-ronin-wormhole-and-nomad.md)
212. ▸ [WBTC: Custodial Wrapped Bitcoin](topics/212-wbtc.md)
213. ▸ [LayerZero and CCIP](topics/213-layerzero-and-ccip.md)
214. ▸ [Cross-Chain versus Multichain](topics/214-crosschain-vs-multichain.md)

## XVIII. Security

215. ▸ [Smart Contract Threat Model](topics/215-smart-contract-threat-model.md)
216. ▸ [Smart Contract Audits](topics/216-smart-contract-audits.md)
217. ★ [Reentrancy](topics/217-reentrancy.md)
218. ★ [Checks–Effects–Interactions](topics/218-checks-effects-interactions.md)
219. ▸ [Read-Only Reentrancy](topics/219-read-only-reentrancy.md)
220. ★ [Integer Overflow, Underflow, and Solidity 0.8](topics/220-integer-overflow-and-solidity-0-8.md)
221. ★ [Access-Control Errors](topics/221-access-control-errors.md)
222. ▸ [Unprotected Initialization and the Parity Multisig](topics/222-unprotected-initialization-and-parity.md)
223. ▸ [`delegatecall` to Untrusted Code](topics/223-untrusted-delegatecall.md)
224. ★ [Denial of Service: Unbounded Loops and Gas Exhaustion](topics/224-dos-and-gas-exhaustion.md)
225. ▸ [Unchecked External-Call Return Value](topics/225-unchecked-external-call-return.md)
226. ▸ [Signature Replay: Nonce, Chain ID, and Domain](topics/226-signature-replay.md)
227. ▸ [Frontrunning in Contract Logic](topics/227-application-frontrunning.md)
228. ★ [Privileged Functions: Mint, Pause, and Upgrade](topics/228-privileged-functions.md)
229. ▸ [Timelocks and Multisigs for Administration](topics/229-timelocks-and-multisigs.md)
230. ▸ [Rug-Pull Mechanics](topics/230-rug-pull-mechanics.md)
231. ▸ [The DAO Hack](topics/231-the-dao-hack.md)
232. ▸ [Incident Studies: Ronin, Euler, and Curve](topics/232-ronin-euler-and-curve.md)
233. ▸ [Bug Bounties and Immunefi](topics/233-bug-bounties-and-immunefi.md)
234. ▸ [Keeping Funds on an Exchange: The FTX Lesson](topics/234-exchange-custody-and-ftx.md)
235. ★ [Not Your Keys, Not Your Coins](topics/235-not-your-keys.md)
236. ▸ [Phishing, Wallet Drainers, and Blind Signing](topics/236-phishing-and-wallet-drainers.md)

## XIX. Zero-Knowledge

237. ★ [What Exactly a ZK Proof Proves](topics/237-what-a-zk-proof-proves.md)
238. ▸ [Completeness, Soundness, and Zero-Knowledge](topics/238-completeness-soundness-and-zero-knowledge.md)
239. ★ [SNARK versus STARK](topics/239-snark-vs-stark.md)
240. ▸ [Trusted Setup](topics/240-trusted-setup.md)
241. ▸ [Arithmetization and Circuits](topics/241-arithmetization-and-circuits.md)
242. ▸ [zkEVM and Equivalence Levels](topics/242-zkevm-equivalence.md)
243. [Proof Recursion and Aggregation](topics/243-proof-recursion-and-aggregation.md)
244. ▸ [ZK for Privacy versus ZK for Scaling](topics/244-zk-privacy-vs-scaling.md)

## XX. Alternative Ecosystems

This is where the Rust jobs are.

245. ★ [Solana: The Account Model](topics/245-solana-account-model.md)
246. ★ [SVM and Sealevel: Parallel Execution](topics/246-svm-and-sealevel.md)
247. ★ [Programs Instead of Contracts, and PDAs](topics/247-solana-programs-and-pdas.md)
248. ▸ [Rent and Account Size on Solana](topics/248-solana-rent-and-account-size.md)
249. ▸ [Anchor](topics/249-anchor.md)
250. ▸ [Local Fee Markets and Priority Fees on Solana](topics/250-solana-fees-and-local-contention.md)
251. ★ [Cosmos: SDK, Zones, Hubs, and Sovereignty](topics/251-cosmos-sdk-zones-and-hubs.md)
252. ▸ [IBC](topics/252-ibc-in-cosmos.md)
253. ▸ [CosmWasm](topics/253-cosmwasm.md)
254. ▸ [Polkadot and Substrate](topics/254-polkadot-and-substrate.md)
255. ▸ [Move: Aptos, Sui, and Resource-Oriented State](topics/255-move-aptos-and-sui.md)
256. [Bitcoin L2s, Ordinals, and Inscriptions](topics/256-bitcoin-l2s-and-ordinals.md)
257. [TON and NEAR](topics/257-ton-and-near.md)

## XXI. Rust in Blockchain

258. ★ [Why Rust Took Over Blockchain Infrastructure](topics/258-why-rust-in-blockchain-infrastructure.md)
259. ★ [reth: an Ethereum Execution Client in Rust](topics/259-reth-ethereum-execution-client.md)
260. ▸ [revm](topics/260-revm.md)
261. ▸ [Alloy and ethers-rs](topics/261-alloy-and-ethers-rs.md)
262. ▸ [Foundry Internals](topics/262-foundry-internals.md)
263. ★ [Solana Programs in Rust](topics/263-solana-programs-in-rust.md)
264. ▸ [Substrate: Pallets and Runtime](topics/264-substrate-pallets-and-runtime.md)
265. ▸ [CosmWasm Contracts](topics/265-cosmwasm-contracts.md)
266. ▸ [The ZK Stack in Rust](topics/266-zk-stack-in-rust.md)
267. ★ [Where the Rust Blockchain Jobs Actually Are](topics/267-rust-blockchain-jobs.md)

## XXII. Privacy and Regulation

268. ★ [Pseudonymity versus Anonymity](topics/268-pseudonymity-vs-anonymity.md)
269. ▸ [Blockchain Analysis and Deanonymization](topics/269-blockchain-analysis-and-deanonymization.md)
270. ▸ [Mixers, Tornado Cash, and OFAC Sanctions](topics/270-mixers-tornado-cash-and-ofac.md)
271. ▸ [Monero and Zcash](topics/271-monero-and-zcash.md)
272. [KYC, AML, and the Travel Rule](topics/272-kyc-aml-and-the-travel-rule.md)
273. [Central Bank Digital Currencies](topics/273-cbdcs.md)
274. [MiCA and the Regulatory Landscape](topics/274-mica-and-the-regulatory-landscape.md)
