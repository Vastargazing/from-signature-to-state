# Storage Collision During an Upgrade

> **A storage collision happens when new code interprets an existing proxy slot as a different variable. The bytecode is valid; the meaning of state is corrupted.**

## Proxy and implementation share slots

With `DELEGATECALL`, implementation code executes against proxy storage. Suppose version one uses:

```text
slot 0 → owner
slot 1 → totalSupply
slot 2 → balances mapping seed
```

If version two inserts a new variable first:

```text
slot 0 → paused
slot 1 → owner
slot 2 → totalSupply
slot 3 → balances mapping seed
```

the old owner bits are now read as `paused`, old supply bits as an address, and mapping entries use another seed. Nothing in the EVM knows this is wrong.

## Two collision classes

The proxy's own bookkeeping can collide with application variables. ERC-1967 avoids this by placing implementation and admin addresses in special hash-derived slots.

The more common upgrade collision occurs between implementation versions when variables are reordered, removed, inserted, or change type.

## Usually safe changes

For traditional linear layouts:

- keep existing variables in the same order and type;
- append new variables after old ones;
- preserve inherited contract ordering;
- consume planned storage gaps carefully;
- validate layouts using compiler output and upgrade tools.

Renaming a source variable without changing its type or position normally does not change the slot. Changing a struct or packed field can.

Namespaced storage patterns place a module's struct at an explicit hash-derived root, reducing accidental collisions between modules. They still require compatible evolution inside each namespace.

## Why tests must use old state

A fresh deployment of version two starts with a clean layout and may pass every unit test. The bug appears only when new code reads storage created by version one.

An upgrade test should:

1. deploy and initialize version one;
2. create meaningful state;
3. upgrade to version two;
4. assert old state and permissions remain correct;
5. exercise new writes and rollback paths.

## Check yourself

1. Why can the EVM not detect a storage collision automatically?
2. What problem do ERC-1967 slots solve?
3. Why is appending a variable safer than inserting it first?
4. Why can a fresh version-two deployment miss an upgrade bug?
