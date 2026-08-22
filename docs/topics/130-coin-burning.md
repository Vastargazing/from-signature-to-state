# Coin Burning

> **Burning permanently removes spendable units according to protocol or contract rules. Sending to a famous address is only as strong as its unspendability.**

## Protocol burn

Ethereum destroys the EIP-1559 base fee during transaction processing. No account receives that ETH; clients calculate supply with those units removed.

Slashing penalties and other protocol rules can also reduce balances without transferring the full loss to another participant.

This is the strongest form: the state transition explicitly defines destruction.

## Token burn

An ERC-20 contract can reduce an account balance and `totalSupply` through its own burn function:

```text
balance[user] -= amount
totalSupply   -= amount
```

An emitted `Transfer` to the zero address is a standard signal, but the actual supply change comes from contract storage logic, not the event alone.

## Sending to a burn address

Projects sometimes send tokens or native coins to an address believed to have no known private key.

The coins may become practically unspendable, but the protocol may still count them in account or UTXO supply. A zero address can also have special behavior depending on the token contract.

Verify the code and chain semantics instead of trusting a dashboard label.

## Why burn

Burns can:

- price scarce block resources;
- offset issuance;
- remove redeemed wrapped or stablecoin units;
- penalize misbehavior;
- reduce token supply by policy.

A burn does not automatically create value. If a project mints 1 billion tokens and burns 100 million, the relevant supply still grew by 900 million. Burns can be marketing around a much larger issuance path.

## Ask who can mint again

Supply credibility depends on the complete authority model. A permanent burn is economically weak if an admin can mint unlimited replacement tokens tomorrow.

```text
net policy = issuance powers + burn rules + governance
```

## Check yourself

1. How does a protocol burn differ from a transfer to an address?
2. What storage fields should an ERC-20 burn normally change?
3. Why is emitting a burn-looking event insufficient?
4. Why must burn analysis include future mint authority?
