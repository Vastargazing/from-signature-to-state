# State Commitments, Proofs, and Synchronization

A node can know state by computing it, verifying evidence about it, or trusting another server's answer. These routes are not equivalent.

## Ethereum commits to post-state

An Ethereum execution header contains `stateRoot`, a commitment to the world state after applying the block. It does not contain the accounts, contract code, or storage values themselves.

A proof such as the one returned by `eth_getProof` supplies encoded trie nodes connecting an account or storage value to a particular `stateRoot`. Local verification answers:

> Does this value occur at the claimed path in the state committed to by this root?

It does not establish that the root is canonical. Header and consensus verification supply that separate guarantee.

## Bitcoin has a different boundary

A Bitcoin header commits to its ordered transactions through the transaction Merkle root. It does not contain a consensus commitment to the current UTXO set.

Full nodes derive the UTXO set by validating accepted transactions. Without a UTXO root in the header, Bitcoin does not offer the direct equivalent of an Ethereum account proof authenticated against a native block-header state root.

This does not make Bitcoin state unverifiable. It changes which compact proofs the base protocol exposes.

## Three ways to learn a balance

1. **Execute accepted history.** Maintain state by applying valid transitions from an accepted starting point.
2. **Verify a proof.** Check a value against an authenticated state commitment already accepted through consensus verification.
3. **Trust an RPC response.** Ask a server for the value without verifying a proof.

Synchronization modes combine these techniques differently. A full-from-genesis sync reproduces all transitions. Snapshot-based modes begin from recent authenticated state and verify forward. Light clients verify headers and consensus evidence, then request proofs for particular values instead of maintaining full execution state.

The phrase “I read it from the blockchain” hides the most important question: which evidence connected the returned value to canonical history?

## Primary sources

- [EIP-1186: `eth_getProof`](https://eips.ethereum.org/EIPS/eip-1186) — account and storage proofs connected to a block's state root.
- [Ethereum JSON-RPC specification](https://ethereum.github.io/execution-apis/) — current account, storage, block, and proof RPC methods.

Last verified: 2026-08-22.

## Check yourself

1. What does `stateRoot` contain, and what does it merely commit to?
2. Why is a valid Merkle proof insufficient without an authenticated canonical root?
3. Which native state commitment is absent from Bitcoin headers?
4. How does verifying an RPC proof differ from trusting the RPC value?
