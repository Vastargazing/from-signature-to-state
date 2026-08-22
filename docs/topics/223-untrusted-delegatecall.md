# `delegatecall` to Untrusted Code

> **`delegatecall` executes someone else's code with your contract's storage, address, balance, and caller context. Choosing the target is equivalent to choosing your logic.**

## The execution context

With a normal `call`, contract B changes B's storage. With `delegatecall`, B's bytecode runs as if it were contract A:

```text
code: B
storage and balance: A
address(this): A
msg.sender: A's original caller
```

This is the basis of proxies and reusable libraries. It is also why an arbitrary target can take full control.

## What malicious code can do

Delegated code can overwrite ownership and implementation slots, approve or transfer assets, corrupt accounting, or make future calls unusable.

A function selector allowlist does not make an unknown implementation safe; the selected function still executes arbitrary opcodes in the caller's context.

## Storage layout

Even honest code can corrupt state if layouts disagree. If A's slot 0 stores `owner` but delegated B treats slot 0 as `totalSupply`, an ordinary write changes ownership.

Upgradeable proxies need stable storage ordering and protected implementation slots. New versions append or use structured namespaced storage instead of rearranging existing variables.

## Plugins and modules

Wallet modules, diamond facets, routers, and governance executors may intentionally delegate. Their installation process is therefore equivalent to granting deep administrative power.

Pin code hashes or approved implementations, validate upgrade authorization, test storage compatibility, and minimize the surface callable through delegation.

The key distinction: `call` trusts another contract to return a result; `delegatecall` trusts its code to become your contract for the duration of the call.

## Check yourself

1. Whose storage changes during `A.delegatecall(B)`?
2. Why can honest delegated code corrupt ownership?
3. What authority does installing a wallet module effectively grant?
4. How does the trust required by `delegatecall` exceed normal `call`?
