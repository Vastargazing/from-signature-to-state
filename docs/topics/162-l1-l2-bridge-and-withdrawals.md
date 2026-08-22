# L1↔L2 Bridge and Withdrawals

> **A canonical bridge is a message path between two state machines: deposit on one side, prove the result, then release value on the other.**

## Depositing to L2

For an ERC-20 deposit, the L1 bridge usually locks tokens in a contract. A corresponding message enters the L2 inbox, where the L2 bridge credits or mints the representation.

ETH may follow a specialized path, but the accounting idea is the same:

```text
L1 asset locked → authenticated message → L2 balance credited
```

The L2 token is a claim governed by the bridge, not a second independent copy of the same asset.

## Withdrawing to L1

The user burns or debits the L2 representation and creates an L2-to-L1 message. L1 releases the locked asset only after that message becomes provable under the rollup's rules.

For an optimistic rollup, finalization normally waits through the challenge process. For a validity rollup, it waits for the relevant batch and proof to be accepted. Ethereum finality and protocol-specific delays may add more time.

## Fast withdrawals are different

A liquidity provider can pay the user on L1 immediately and later claim the canonical withdrawal. The user gets speed by accepting the provider's fees, liquidity limits, and routing risk.

That does not make the canonical bridge faster. It replaces waiting with a market transaction.

## Messages are the security surface

Bridges must authenticate the source chain, sender, destination, amount, token mapping, nonce, and message status. Replay protection matters: the same proven message must not release funds twice.

Also inspect upgrade keys and emergency controls. A bridge can inherit strong rollup proofs while an administrator still has power to change the contracts that custody assets.

## Check yourself

1. What backs a bridged ERC-20 representation on L2?
2. Why is an optimistic-rollup withdrawal delayed?
3. How does a fast bridge hide that delay?
4. Which fields stop a cross-layer message from being replayed?
