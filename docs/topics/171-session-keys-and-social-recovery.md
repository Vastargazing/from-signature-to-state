# Session Keys and Social Recovery

> **Session keys limit everyday authority; social recovery replaces lost authority. They solve different wallet problems.**

## Session keys

A smart account can authorize a temporary key with narrow permissions. For example:

- call only one game contract;
- spend at most 20 USDC per day;
- remain valid for two hours;
- never transfer the wallet's main assets.

The user signs one high-trust authorization, then the session key handles routine actions without constant wallet pop-ups.

If the session key leaks, the attacker should be trapped inside its limits. The contract—not the wallet UI—must enforce those limits on-chain.

## Social recovery

A smart account can name guardians or recovery methods. If the main key is lost, enough guardians authorize replacing it with a new owner key.

Recovery does not reveal or reconstruct the old private key. It changes the account's authorization policy while keeping the same on-chain address and assets.

Good designs use a threshold and delay so one compromised guardian cannot instantly take over. The original owner may cancel a fraudulent recovery during the delay.

## The tradeoffs

Session policies can contain bypasses: a permitted contract may call an unpermitted one, token approvals may outlive the session, or spending can be disguised through another asset.

Recovery adds collusion, availability, and governance risk. Guardians who all use the same cloud account are not truly independent. A long delay is safer but painful during a real loss.

## One account, several authority levels

The useful design is layered:

```text
owner key → full control
session key → limited routine actions
guardians → delayed owner replacement
```

This is programmable authorization: convenience does not need to receive the same power as recovery or custody.

## Check yourself

1. What limits the damage from a stolen session key?
2. Does social recovery reconstruct the lost private key?
3. Why use both a guardian threshold and a delay?
4. Which layer must enforce session permissions—the UI or the contract?
