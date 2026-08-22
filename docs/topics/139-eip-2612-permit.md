# EIP-2612 Permit

> **Permit sets an ERC-20 allowance from an off-chain signature, so someone else can submit the approval transaction and pay gas.**

## The flow

The token owner signs typed data containing:

- owner and spender;
- allowance value;
- current owner nonce;
- deadline;
- token and chain domain.

A relayer or consuming contract submits `permit(...)`. The token verifies the signature, increments the nonce, and sets the allowance.

```text
owner signs off-chain → relayer submits on-chain → allowance changes
```

The owner does not need ETH for a separate approval transaction. An application can combine permit and a following `transferFrom` in one user flow.

## Replay protection

The nonce makes a successful permit signature single-use. The deadline limits how long an unused signature remains valid.

The EIP-712 domain separator binds the signature to the verifying token contract and normally the chain, preventing the same bytes from authorizing arbitrary other domains.

## What permit does not do

Permit does not transfer tokens by itself. It creates or replaces an allowance. The spender still calls `transferFrom` later.

It also does not remove approval risk. Signing an unlimited permit for a malicious spender is as dangerous as sending an unlimited `approve` transaction—just cheaper and easier to relay.

Anyone may submit a valid permit. Front-running its submission normally does not change the signed result, but integrations should tolerate “already used” nonces instead of assuming their own permit call must be first.

## Signature UX risk

Users may treat typed-data signing as free and harmless because no transaction fee appears. But a signature can authorize valuable on-chain state changes.

Wallets should display token, spender, amount, chain, and expiry clearly. “Sign to log in” must never hide a permit payload.

## Check yourself

1. Who may pay gas to submit a permit?
2. What prevents the same permit from being used repeatedly?
3. Does permit move tokens immediately?
4. Why can a gasless signature still be financially dangerous?
