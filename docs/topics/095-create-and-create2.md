# CREATE and CREATE2

> **CREATE derives a contract address from deployment order; CREATE2 derives it from a chosen salt and the initialization code.**

## Creation runs code

A deployment does not place constructor bytecode permanently at an address. The EVM executes **initialization code**, which may read constructor arguments, write initial storage, and finally return the **runtime code** stored in the account.

If initialization reverts or returns invalid code, deployment fails.

## CREATE

The traditional `CREATE` address is derived from:

```text
creator address + creator nonce
```

Changing how many contracts the creator made earlier changes the next address. The address can still be predicted if the nonce is known.

For a top-level contract-creation transaction, the sender and its transaction nonce play the corresponding role.

## CREATE2

`CREATE2` uses:

```text
last20(keccak256(0xff ++ creator ++ salt ++ keccak256(init_code)))
```

The same creator, salt, and initialization code produce the same address, independent of the creator's deployment nonce.

This supports counterfactual addresses, deterministic factories, and contracts that can receive assets or approvals before deployment.

## What the commitment guarantees

The address commits to the **initialization code hash**, not merely to the final runtime bytecode. Constructor arguments are part of initialization code, so changing them changes the address.

The salt is not secret and does not provide randomness or access control. Anyone can calculate the future address.

Deployment fails if the destination already has nonempty code or a nonzero nonce. Modern `SELFDESTRUCT` rules also make old “destroy and redeploy different code at the same address” patterns far less generally available than many tutorials suggest.

## CREATE2 is not an upgrade mechanism

Deterministic address generation tells you where code may appear. It does not let arbitrary code replace an occupied contract. Upgradeable behavior normally comes from proxies or explicit indirection.

## Check yourself

1. What code remains after successful deployment: init code or runtime code?
2. Which changing value makes ordinary CREATE addresses order-dependent?
3. Which inputs determine a CREATE2 address?
4. Why is a CREATE2 salt not an authorization secret?
