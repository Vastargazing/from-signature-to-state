# Why `block.timestamp` and `blockhash` Are Not Randomness

> **Block values are consensus inputs visible or influenceable by block producers. Hashing predictable data makes it look random, not become unpredictable.**

## `block.timestamp`

On post-Merge Ethereum, the timestamp is fixed by the beacon-chain slot; a proposer cannot choose an arbitrary second within a permitted range. It can still decide whether to publish its assigned block and whether to include or order a transaction in that slot. Other EVM chains may use different timestamp rules.

If a lottery boundary depends on a particular block time, an ordering actor may include a transaction only in a favorable slot or withhold its own block. The exact influence is protocol-specific, but the value is public block context rather than secret entropy.

Timestamps are useful for approximate deadlines. They are unsafe as secret entropy.

## `blockhash`

A previous block hash is already known when a transaction executes. Users can calculate whether it makes them win and submit only favorable transactions.

If a contract waits for a future block hash, a block producer may gain influence by withholding a block, reordering requests, or exploiting a reorganization. Old block hashes also become unavailable to the EVM after its limited lookup window.

```text
keccak256(predictable value) = unpredictable-looking, still predictable
```

## `prevrandao`

Ethereum exposes consensus randomness through `prevrandao`. It is stronger than using a timestamp or one recent block hash, but applications must still consider proposer influence, reveal timing, reorgs, and the value at stake.

It is not a universal replacement for a request-confirm-fulfill oracle when one outcome is worth enough to bias.

## Better patterns

Commit-reveal combines secrets from participants: commit hashes first, reveal later, then combine. It needs penalties or fallbacks for users who refuse to reveal after seeing others' values.

VRF provides an output with an on-chain-verifiable proof. Future block values can add entropy only when timing and confirmation assumptions are explicit.

The security question is: who learns or can influence the value before they become irreversibly committed to the game?

## Check yourself

1. Why does hashing a timestamp not make it random?
2. How can a user exploit a known previous block hash?
3. What weakness does commit-reveal need to handle?
4. Which party must be unable to choose after learning the outcome?
