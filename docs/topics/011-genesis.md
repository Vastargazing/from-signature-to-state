# The Genesis Block

> **Genesis defines initial conditions that cannot be derived from a parent. The client computes the state root from them itself, just as it does for every other block.**

## Why it is special

The formula from [State and the State Transition Function](006-state-transition.md) is `state′ = f(state, block)`. Applying it requires a previous state. The first block has none.

Genesis is therefore the exception to the rule on which the whole design rests:

- there is no parent, and `parentHash` is filled with zeroes;
- the input state cannot be obtained from anywhere, so it is enumerated in the `alloc` section, where each account may be assigned not only a balance but also a nonce, code, and storage contents;
- there is nothing against which to check the result: no previous root exists.

Notice the boundary. `stateRoot` itself is computed in the completely ordinary way—the client builds a tree from `alloc` and takes its root. What is unusual is not the computation but the fact that **the input came from nowhere**.

The ordinary transition rules can later be amended with an exceptional state mutation, as happened in The DAO fork (see [Immutability and Rewriting History](010-immutability.md)). That mutation was encoded in the fork rules and executed by upgraded clients; it did not occur outside the software. At genesis, supplying the initial state directly is not an emergency exception but the normal starting condition.

Ethereum's format makes this explicit: initial balances live in the `alloc` section of the genesis file. The genesis block contains no transactions at all.

## The block and configuration are different things

A `genesis.json` specification contains three kinds of input that are constantly confused: header inputs, the initial allocation, and chain configuration.

**Header inputs** include values such as `timestamp`, `gasLimit`, `difficulty`, and `extraData`. **`alloc` is not a block-header field**: the client turns it into the initial state and places the resulting `stateRoot` in the header. The encoded header—including that root—is what determines the genesis-block hash.

**The `config` section** contains `chainId` (the value that prevents replay on another network; see [A Transaction and Its Fields](007-transaction.md)) and the fork schedule—at which block or time each rule update activates. These configuration values are not themselves encoded in the block header. There is one caveat: activating a fork at genesis can change which header fields the client constructs—for example `baseFeePerGas` or an empty withdrawals root—and thereby indirectly change the genesis hash.

The practical difference:

| What changed | Result |
|---|---|
| `alloc`, `timestamp`, `gasLimit`, or other block fields | a different genesis hash—a different chain |
| the schedule of future forks in `config` | a rule update on the same chain, if participants accept it |

A live network can therefore schedule another fork without touching its initial state. This is also why launching a test network is not “forking the code,” but using a different genesis file with the same client.

## Genesis is the network's identity card

Two nodes running identical code but different genesis blocks will join different networks. In Ethereum, they will not even connect: during the handshake, nodes compare the network identifier, genesis hash, and fork identifier and disconnect on a mismatch.

The converse is not true: an identical genesis is insufficient. Network identity consists of genesis **together with** network and protocol configuration; everything must match.

The practical consequence is that a live network's genesis cannot be changed. That would be a new launch, not an upgrade.

There is another, less pleasant consequence. A client validates the file format, constructs state, and computes the genesis hash. For a built-in network or an already initialized database it can compare that hash with the known value; for a new private network, the supplied specification defines the expected value. What the client cannot do is derive genesis from earlier history, because no such history exists.

> **Genesis is verified for consistency but accepted as an external trust anchor.**

This is another layer from [Trustless](004-trustless.md): the first chronologically and the easiest to overlook.

## Two details worth knowing

**Bitcoin.** The genesis block's coinbase contains a newspaper line: “The Times 03/Jan/2009 Chancellor on brink of second bailout for banks.” It serves both as evidence that the block was not created **before** that date and as a statement of intent. It does not prove the converse: the text does not show that the block was created on that exact date rather than later.

The 50 BTC reward for this block cannot be spent: due to a peculiarity of the original source code, the genesis payout was never added to the unspent-output database.

**Ethereum.** This refers to the execution layer's genesis; the Beacon Chain has its own separate initial state (see [A Block and the Transactions Inside It](008-block.md) on the two layers).

Genesis distributed 72,009,990.5 ETH among 8,893 addresses: about 60.1 million went to participants in the 2014 crowdsale, and the remainder went to the foundation and early contributors. No transaction was executed—the balances were simply declared.

## The cost

- the initial distribution cannot be challenged from inside the system: it precedes all of the system's rules;
- an error in genesis cannot be corrected by ordinary means; the options are to restart the network or resort to an emergency measure;
- trust in genesis cannot be reduced to verification: its source is always external.

## Primary sources

- [EIP-7949: Genesis File Format](https://eips.ethereum.org/EIPS/eip-7949) — header, allocation, and chain-configuration fields in an Ethereum genesis specification.
- [Bitcoin Core chain parameters](https://github.com/bitcoin/bitcoin/blob/master/src/kernel/chainparams.cpp) — construction of Bitcoin's genesis block, coinbase text, and initial output.
- [go-ethereum mainnet genesis allocation](https://github.com/ethereum/go-ethereum/blob/master/core/genesis_alloc.go) — the allocation embedded by Geth for Ethereum Mainnet.

Last verified: 2026-08-22.

## Check yourself

1. Why is genesis an exception to the state-transition formula?
2. What happens if a node starts with a different genesis file?
3. Where are Ethereum's initial balances stored, and why are they not transactions?
4. You changed the future fork schedule in `genesis.json`. Is it now a different chain? What if you changed `alloc`?
5. What does the newspaper line in Bitcoin's genesis prove, and what does it not prove?
