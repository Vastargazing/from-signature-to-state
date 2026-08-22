# Pseudonymity versus Anonymity

> **A blockchain address hides your name, but it usually exposes a durable history that can later be tied to you.**

Pseudonymity means actions appear under an identifier rather than a legal identity. On Ethereum, that identifier is usually an address. Anyone can create many addresses without registering a name.

Anonymity is stronger: observers cannot reliably connect an action to a particular person. A public blockchain does not provide this merely because addresses look random.

## The permanent trail

Public chains expose transactions, amounts, timing, counterparties, contract calls, and current balances. Reusing one address links all of that activity immediately.

Even with several addresses, behavior can reconnect them. A user may fund both from the same exchange, consolidate their balances, interact with the same rare contract sequence, or reveal an address in a public profile.

The chain provides a graph:

```text
address history + behavioral clues + off-chain identity = possible attribution
```

Once one point is identified, old transactions can be reexamined. Pseudonymity can therefore disappear retroactively.

## Privacy has layers

Transaction privacy is not one switch. Different systems may hide different fields:

- sender;
- recipient;
- amount;
- asset or application;
- network origin and timing.

Hiding an amount does not hide the IP address that broadcast the transaction. Hiding the network origin does not erase an exchange's KYC records. A private transfer can also become linkable when funds later enter a transparent application.

## The practical lesson

Never describe Bitcoin or Ethereum as anonymous by default. “Public but pseudonymous” is the accurate baseline.

Privacy-focused protocols can weaken graph analysis through cryptography and larger anonymity sets, but user behavior, wallet defaults, bridges, exchanges, and network metadata still affect the real result.

The right question is not “Is this chain private?” Ask exactly which fields are hidden, from whom, and under which usage assumptions.

## Check yourself

1. How is a pseudonym different from anonymity?
2. Why can identity attribution happen years later?
3. Which transaction fields can a privacy system hide separately?
4. Why does address reuse weaken privacy?
