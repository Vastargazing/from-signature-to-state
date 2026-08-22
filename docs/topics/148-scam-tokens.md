# Scam Tokens: Honeypots, Hidden Logic, and Backdoors

> **A scam token can look like a standard ERC-20 while privileged or conditional logic prevents selling, drains approvals, changes supply, or removes liquidity.**

## Honeypot

A honeypot lets victims buy but blocks or punishes selling. Transfer logic may:

- reject transfers to a DEX pair;
- allow only whitelisted sellers;
- apply a near-100% sell fee;
- change behavior after enough buyers arrive;
- detect simulation addresses and behave honestly for them.

The presence of `transfer` and a liquid-looking chart proves nothing about exit ability.

## Privileged backdoors

Owner or hidden roles may:

- mint unlimited supply;
- change fees and limits;
- blacklist holders;
- pause transfers;
- replace router or pair addresses;
- upgrade implementation code;
- seize balances or redirect transfers.

“Ownership renounced” can be theater if another role, proxy admin, external controller, or hardcoded privileged address remains.

## Liquidity trap

Even honest-looking token code cannot prevent deployers from removing liquidity when they control LP positions. A “locked” LP claim is only meaningful if the locker contract, unlock date, ownership, and amount are real.

Artificial volume and wash trading can create a market-cap number with almost no executable sell depth.

## Approval and signature scams

The token itself may be ordinary while the website asks for an unlimited approval, NFT operator permission, Permit2 signature, or malicious transaction to another contract.

Verify the spender and decoded authority, not only the token address shown by the page.

## A practical screen

Inspect source match, proxy slots, roles, mint cap, transfer branches, fee setters, blacklist logic, holders, LP control, and real sell simulation from an ordinary address.

Simulation reduces risk but is not proof: logic can depend on block, caller, allowlists, or later admin changes.

```text
can buy + can quote ≠ can sell + can recover value
```

## Check yourself

1. How can a honeypot preserve buying while blocking selling?
2. Why can renounced ownership be misleading?
3. What risk exists outside token code when deployers control liquidity?
4. Why does one successful simulation not prove future sellability?
