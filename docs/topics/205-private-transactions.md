# Private Transactions and Flashbots Protect

> **A private transaction avoids broadcasting intent to the public mempool and sends it to selected builders or relays under a stated inclusion policy.**

## Why users choose privacy

A public swap exposes its route, amount, gas settings, and slippage limit before execution. Searchers can simulate it and build a sandwich.

A private RPC such as Flashbots Protect forwards the signed transaction through a private path. Selected block builders can include it without first revealing it to every public-mempool observer.

## What it can improve

Private submission can reduce public frontrunning and failed bids. Some systems allow backrunning while sharing part of the resulting value with the user.

The transaction still receives normal on-chain execution and becomes public after inclusion.

## New assumptions

The private service and connected builders may see the transaction before inclusion. Users depend on their privacy policy, retention, access controls, and resistance to collusion.

Private transactions can also be delayed or never included. A wallet needs clear fallback rules: rebroadcasting publicly may restore liveness but expose the exact intent it was trying to hide.

Never send the same nonce through conflicting private and public paths without understanding replacement behavior.

## Privacy is not confidentiality

This mechanism hides pending intent from part of the network. It does not hide the final transaction, sender, calldata, logs, balances, or state changes from the blockchain.

It also cannot protect a trade whose own on-chain parameters are unsafe. A malicious router or unlimited slippage remains dangerous even with perfect mempool privacy.

The mental model: public mempool privacy narrows who can act before inclusion; cryptographic transaction privacy would hide what happened after inclusion too. They are different goals.

## Check yourself

1. Which information does private submission hide, and for how long?
2. Who may still see a private transaction before inclusion?
3. What liveness tradeoff appears if the private path fails?
4. Does Flashbots Protect hide the included transaction from the chain?
