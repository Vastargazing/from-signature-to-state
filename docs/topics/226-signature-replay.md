# Signature Replay: Nonce, Chain ID, and Domain

> **A signature authorizes bytes, not intent. If those bytes do not bind where, when, and how often they may be used, someone can replay the same authorization.**

## The replay

Alice signs “transfer 100 tokens to Bob.” A contract verifies her signature and transfers funds. If no nonce is consumed, Bob submits the same signature again.

If the signed data omits chain ID and verifying contract, the same signature may work on another chain or clone contract with the same format.

## Bind the full domain

A robust signed message includes:

- action type and all arguments;
- nonce or unique identifier;
- deadline when appropriate;
- chain ID;
- verifying contract address;
- protocol name and version or equivalent domain data.

EIP-712 provides structured hashing and a domain separator for this purpose. It improves clarity but remains safe only if every security-relevant field is actually included.

## Consume before external interaction

Mark the nonce used before calling untrusted code. Otherwise a callback may reuse the signature inside the same transaction.

Sequential nonces enforce order; bitmap or random nonces allow independent authorizations. Cancellation rules must be explicit.

## Signer type matters

EOAs use elliptic-curve recovery. Smart-contract wallets may validate signatures through ERC-1271 and can change owners or policy over time.

Never assume `ecrecover` returning a nonzero address is enough. Enforce canonical signature rules, expected signer, correct domain, and used-nonce state.

The mental model: a signature proves who approved one exact message; replay protection defines the message's lifetime and universe.

## Check yourself

1. Why can a valid signature authorize more than the user intended?
2. Which two fields prevent cross-chain and cross-contract reuse?
3. Why consume the nonce before an external call?
4. How can a smart-contract wallet validate signatures differently from an EOA?
