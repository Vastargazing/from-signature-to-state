# Soft Fork and Hard Fork

> **A soft fork narrows the set accepted by upgraded nodes while keeping upgraded blocks acceptable to old nodes; a hard fork introduces blocks or transitions old nodes do not accept.**

## Soft fork

A soft fork introduces rules whose accepted block set is a subset of the old rules:

```text
new-valid blocks ⊂ old-valid blocks
```

Old nodes do not understand the new restriction, but blocks following it still look valid under their broader rules. This is why a soft fork can be backward-compatible from an old validating node's perspective.

The catch is enforcement. If enough block producers ignore the new rule, upgraded nodes can reject their blocks while old nodes accept them. Compatibility does not remove activation and coordination risk.

Bitcoin's SegWit and Taproot were activated as soft forks.

## Hard fork

A hard fork makes a backward-incompatible consensus change. It may allow a larger block or change state-transition behavior in a way old nodes reject; the complete old and new validity sets need not be simple supersets of one another.

```text
valid under new rules + invalid under old rules
```

Nodes must upgrade by the activation point to follow the new network. If almost everyone coordinates, the old branch can simply stop. If both rule sets retain producers and users, two permanent chains emerge.

Ethereum regularly calls coordinated protocol upgrades “hard forks” even though they normally do not create a rival asset.

## Not a quality label

“Soft” does not mean safe or minor. A soft fork can make deep consensus changes and leave old nodes unable to enforce the new rules fully.

“Hard” does not mean hostile. It describes compatibility, not social conflict. A planned hard fork can be routine.

## Think in sets, then in people

The technical question is which blocks old and new software accept. The governance question is who installs and enforces each version.

Both determine the outcome:

```text
rule compatibility + adoption + economic support → one chain or a split
```

## Check yourself

1. How does a soft fork change the set of valid blocks?
2. Why can old nodes appear compatible without enforcing new rules?
3. Does a hard fork necessarily create a second lasting chain?
4. Why are “soft” and “hard” not measures of upgrade importance?
