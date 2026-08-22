# JSON-RPC and Node Access

> **JSON-RPC exposes a node's view of the chain; it does not make that view trustworthy.**

A normal JSON-RPC 2.0 request contains a method, optional parameters, an ID, and the `"2.0"` protocol marker. A notification omits the ID and expects no response, although support depends on the Ethereum API and client. HTTP and WebSocket are common transports.

Ethereum methods commonly read state, fetch blocks and receipts, simulate calls, submit signed transactions, or subscribe to new data.

## Read, simulate, submit

`eth_call` executes locally against a chosen block state. It does not create a transaction, spend on-chain gas, or persist changes. It answers what the call would return under those assumptions.

`eth_sendRawTransaction` submits already signed bytes. The provider does not need the private key and cannot change signed fields without invalidating the signature. It can still observe, delay, or censor the transaction.

## Every answer has a block context

Where the method supports a block parameter, a state query should identify `latest`, `safe`, `finalized`, a block number, or preferably an EIP-1898 block-hash object for an exact view. `latest` can change after a reorg. `pending` reflects one node's local transaction pool and pending-state construction and may differ between providers.

Batching requests reduces network round trips. It does not create an atomic snapshot. Pin related queries to the same block hash and, when required, request that the block remain canonical.

## The trust boundary

A hosted endpoint can lie, omit logs, lag, censor submissions, or follow another fork. TLS proves which server answered; it does not prove the blockchain result.

For critical reads, pin block hashes, compare independent sources, verify proofs, or run a node. Sign writes locally and monitor canonical inclusion separately.

Administrative, debug, signing, and Engine API methods must not be exposed publicly. Even read APIs need limits because wide log scans and traces can exhaust a node.

Rust libraries such as Alloy add typed calls. Types prevent many encoding mistakes, not dishonest data or weak finality assumptions.

## Check yourself

1. Why is `eth_call` not a transaction?
2. Why can `latest` change?
3. What does local signing prevent?
4. Why is a request batch not automatically one snapshot?
