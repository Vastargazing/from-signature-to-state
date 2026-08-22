# Bitcoin L2s, Ordinals, and Inscriptions

> **“Bitcoin L2” covers systems with very different trust: payment channels inherit Bitcoin dispute rules, while many sidechains rely on separate federations or consensus. Ordinals are not an L2 at all.**

## The L2 label is loose

Lightning channels lock BTC in Bitcoin transactions and enforce off-chain payment updates through Bitcoin scripts and timelocks.

Federated sidechains lock BTC under a signer set and issue a sidechain representation. They add execution features but withdrawals ultimately depend on that federation.

Rollup-like Bitcoin designs aim to post data or commitments and enforce state through Bitcoin, but Bitcoin's scripting and verification capabilities constrain what can be proven without protocol changes or extra assumptions.

Ask for the peg verifier, data availability, exit path, and source of finality—not the L2 label.

## Ordinal theory

Ordinal theory assigns an ordering and individual identity to satoshis using an off-chain indexing convention. Bitcoin consensus does not add a new `ordinal` field.

Wallets and indexers following the convention track which sat carries an inscription. A non-ordinal-aware wallet can accidentally spend that sat as ordinary fees or value.

## Inscriptions

An inscription places content and metadata in a Taproot script-path witness revealed by a Bitcoin transaction. The bytes are on-chain; the association with a particular sat follows ordinal indexing rules.

Larger content pays more transaction fees and consumes block space. No sidechain or separate token is required.

## Separate the concepts

Bitcoin scaling systems change how value or computation happens outside base-layer transactions. Inscriptions use base-layer transaction data to create indexed digital artifacts.

They share Bitcoin block space but solve unrelated problems.

## Check yourself

1. Which trust distinguishes Lightning from a federated sidechain?
2. What must a claimed Bitcoin L2 explain about exits?
3. Does Bitcoin consensus assign ordinal numbers to sats?
4. Where is inscription content stored?
