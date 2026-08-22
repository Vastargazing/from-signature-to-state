# Mint, Burn, Transfer, and Balance

> **A token is a ledger: mint creates units, transfer moves them, burn destroys them, and balances record current ownership.**

## The accounting identities

A plain transfer should preserve total supply:

```text
balance[from] -= amount
balance[to]   += amount
```

Minting increases both a recipient balance and total supply:

```text
balance[to] += amount
totalSupply += amount
```

Burning decreases a holder balance and total supply:

```text
balance[from] -= amount
totalSupply   -= amount
```

These are conceptual rules. Real implementations add checks, hooks, fees, caps, access control, and rounding.

## Events mirror state changes

ERC-20 convention emits `Transfer(address(0), to, amount)` for mint and `Transfer(from, address(0), amount)` for burn.

The event is evidence produced by execution. It does not itself modify balances. A malicious contract can emit misleading events without correct storage updates.

## Who may perform each action

Holders normally transfer their own units. Approved spenders can use `transferFrom` within allowance.

Mint and burn policy is contract-specific:

- fixed supply minted once at deployment;
- admin or bridge-controlled minting;
- emissions according to time or staking;
- user redemption that burns a claim token;
- unrestricted minting in a scam.

Read access control and upgrade paths instead of inferring policy from the function name.

## Balance is not always static ownership

Rebasing tokens can change displayed balances without individual transfer calls. Share-based tokens may keep internal shares constant while conversion to visible units changes.

Fee-on-transfer tokens can reduce the sender by one amount and credit the recipient with less, sending or burning the difference.

The safest integration measures actual balance changes when exact receipts matter.

## Check yourself

1. Which operation should leave total supply unchanged in a plain token?
2. How are mint and burn commonly represented in `Transfer` events?
3. Why does a mint function name not reveal who can use it?
4. How can a balance change without a normal transfer event?
