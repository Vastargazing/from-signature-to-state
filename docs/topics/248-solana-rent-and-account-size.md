# Rent and Account Size on Solana

> **Solana state accounts allocate byte capacity explicitly and hold lamports tied to that storage. Persistent state has a visible capital and design cost.**

## Space is chosen at creation

When a program creates a data account, it requests a byte length and funds it through the system program. Current Solana accounts are normally funded to the rent-exempt minimum for that size; this is an upfront balance requirement, not a periodic storage charge being deducted from a persistent account.

Serialization must fit inside the allocated space. Adding a field to the Rust struct does not automatically enlarge old on-chain accounts.

## Count the bytes

Developers must include discriminators or version tags, fixed fields, vector length prefixes, and maximum dynamic content.

A `Vec<T>` has variable serialized size. Allocating only the empty size makes later pushes fail. Reserving an enormous maximum locks unnecessary lamports and increases data costs.

## Reallocation and migration

Programs can reallocate accounts under runtime rules, with a payer funding additional storage. Shrinking or closing can return excess lamports to a chosen recipient.

Closing must clear authority and data safely so an account cannot be revived or reused with stale assumptions.

Versioned account layouts make upgrades explicit. Zero-copy techniques reduce serialization overhead for large fixed layouts but demand careful alignment and compatibility.

## Who pays matters

The user, protocol, or sponsor may fund state creation. A design that creates one account per tiny action can become economically or operationally expensive even if execution fees are low.

Garbage collection is therefore application logic: define who may close expired orders, how remaining lamports return, and how references to closed accounts behave.

The mental model is closer to allocating a persistent typed byte buffer than writing an unbounded mapping entry.

## Check yourself

1. Why can a new Rust field break existing account instances?
2. What costs are hidden inside a dynamic vector's allocation?
3. Who funds account growth during reallocation?
4. Why must a protocol design account-closing authority?
