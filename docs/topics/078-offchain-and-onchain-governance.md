# Off-Chain and On-Chain Governance

> **Blockchain governance decides which rules and software a community will treat as canonical. Code executes the outcome; it rarely chooses the outcome alone.**

## Off-chain governance

In off-chain governance, discussion and coordination happen outside protocol transactions:

- improvement proposals and research forums;
- developer and client-team meetings;
- miner or validator signaling;
- node-operator upgrades;
- decisions by wallets, exchanges, applications, and users.

Bitcoin and Ethereum rely heavily on this model. No single on-chain ballot can force every independent node to install new consensus rules.

The final signal is behavior: which software people run and which chain economic actors recognize.

## On-chain governance

On-chain governance encodes proposals, votes, and sometimes execution in smart contracts or the base protocol.

A typical flow is:

```text
proposal → token or stake vote → delay → automatic execution
```

This makes decisions transparent and operationally efficient. A treasury payment or parameter change can execute exactly as approved.

But the voting rule defines power. Token-weighted voting favors capital and delegation. Low participation lets a small active group dominate. Borrowed tokens, custodians, bribery, and governance capture can distort the result.

## No governance is fully on-chain

If an on-chain vote exploits a bug, steals a treasury, or changes unacceptable rules, people still decide whether to patch software, fork, list the asset, or walk away.

Social consensus remains the outer layer:

```text
smart contracts govern within rules
people govern which rules remain legitimate
```

## Separate protocol and application governance

A DeFi token vote may control one application's contracts. It does not govern Ethereum consensus. Likewise, Ethereum core developers coordinate protocol upgrades but cannot directly update every user's node.

Ask four questions:

1. Who can propose?
2. Who can vote and with what weight?
3. Who executes or can veto the result?
4. Can dissatisfied users exit or fork?

Those control paths matter more than the word “DAO.”

## Check yourself

1. What action ultimately expresses adoption in off-chain governance?
2. What advantage does automatic on-chain execution provide?
3. Why does on-chain governance still depend on social consensus?
4. Why is application governance not the same as base-layer governance?
