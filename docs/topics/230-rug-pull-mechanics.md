# Rug-Pull Mechanics

> **A rug pull uses an authorized or intentionally hidden control path to extract value after users supply liquidity or buy the asset.**

## Common extraction paths

The deployer may:

- mint unlimited tokens and sell them into liquidity;
- withdraw protocol-owned liquidity;
- upgrade a proxy to transfer user funds;
- change fees to nearly 100%;
- blacklist buyers or allow only privileged selling;
- drain a treasury or collateral reserve;
- manipulate an oracle or redemption rule;
- abandon a system whose promised off-chain backing never existed.

The transaction can be valid under the contract. The deception lies in what users believed the admin could or would do.

## Liquidity lock is one narrow signal

Locking LP tokens prevents one method of withdrawing that LP position until expiry. It does not disable minting, proxy upgrades, fee changes, secondary pools, or control of token transfers.

Ownership “renounced” on one contract may leave admin power in another module or hard-coded privileged address.

## Honeypots

A token can allow purchases but make normal sales revert or charge a confiscatory sell fee. Simulation helps, but privileged code may switch behavior after users buy.

Source verification is useful only when the deployed bytecode and proxy implementation match, and the code's control graph is understood.

## Economic rugs

Not every rug requires a backdoor. Insiders can own most supply, market aggressively, then sell into shallow liquidity. Unlock schedules, market-maker loans, and treasury control matter alongside code.

The review habit is concrete: list every way insiders can create supply, move backing, alter selling, replace logic, or remove liquidity—and when that power expires.

## Check yourself

1. Can a rug pull execute through fully authorized contract functions?
2. What does locking LP tokens fail to protect?
3. How does a token honeypot trap buyers?
4. Which off-chain ownership facts can create an economic rug without a code bug?
