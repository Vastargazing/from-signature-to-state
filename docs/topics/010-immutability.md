# Immutability and Rewriting History

> **Immutability is not a property of data but a price. History can be rewritten; the only question is how much it costs and what currency pays for it.**

## The picture

A safe is not labeled “impossible to crack.” It is assigned a resistance rating: so many minutes against a particular tool. Protection is measured by the attacker's cost, not in absolutes.

A blockchain works the same way. The right question is not “can this block be rewritten?” but “how much would it cost to make the network accept a rewritten version?”

## Three ways to change history

The mechanisms differ, as does the currency in which their price is paid.

**1. Reorganization—normal operation, but not everywhere.** Two producers find a block at nearly the same time; part of the network accepts one and part accepts the other. As more consensus weight accumulates, the branch that loses fork choice is discarded. In protocols that permit it, such a reorg **before finality** is an ordinary consequence of network latency rather than necessarily an attack, though deliberate [time-bandit attacks](206-time-bandit-attacks.md) also exist. A reorg of an already finalized block, however, is never normal operation: it is either a critical failure or an attack.

**2. Attack—paid for with money.** Acquire enough computational power or stake and offer the network your own chain. In PoW, this means outpacing honest participants. In PoS, it means risking collateral according to the ladder from [Trustless](004-trustless.md): one third can stop finalization; two thirds can finalize its own version.

**3. Social fork—paid for with coordination.** People change the rules: node operators, block producers, exchanges, and infrastructure providers must run the new client version. The price is coordination effort, a divided community, and lost legitimacy for one branch; someone must still secure whichever chain continues. This is how The DAO hard fork implemented its irregular state change (see [State and the State Transition Function](006-state-transition.md)).

> **In PoW, an attacker spends computational resources. In PoS, they acquire a voting share and put capital at risk. In a social fork, they persuade the ecosystem.**

In PoS, two cases must not be confused: a provable violation such as double-voting leads to slashing, while one third of the stake can stop finalization simply by doing nothing. The inactivity leak applies there, and it is a different mechanism.

## The price is not calculated as you might expect

Every network has a security budget—the recurring payments to honest block producers. It is tempting to treat this as the price tag of an attack, but they are different things.

> **A security budget sustains honest participation. It is not the direct price of an attack.**

The cost of a particular attack depends on other factors: whether computational power can be rented, the price of hardware and energy, whether enough stake can realistically be bought or borrowed, what portion is slashable, and how the market and social layer respond. PoW rewards are related to miners' costs, but rented hash power bypasses that relationship. In PoS, the value of the attacking stake may be many times the annual rewards.

This leads to an often-missed consequence:

> **Immutability is not a general property of blockchains but a characteristic of a particular network.** It is expensive on a large network and quite affordable on a small one.

There is a concrete and ironic example. Ethereum Classic was born from a dispute over immutability: part of the community refused to accept The DAO hard fork because it considered rewriting fundamentally unacceptable.

In August 2020, that chain was attacked three times in one month. Contemporary reports count roughly 3,600–3,700 blocks in the first reorg, about 4,000–4,400 in the second, and more than 7,000 in the third—the last representing about two days of mining. Exact counts differ slightly by source and by how the replaced range is measured.

The first attack's estimates speak for themselves: on-chain analysts estimated that renting the required hash power would have cost about 17.5 BTC, roughly $192,000 at the time, while about 807,000 ETC—then worth approximately $5.6 million—was double-spent. The rental cost and use of NiceHash are estimates from observed market data, not expenses proven directly on-chain.

Two hundred thousand dollars in cost for five and a half million in proceeds. The cryptography did not break: the price was affordable and only weakly related to the network's security budget.

## What immutability does not promise

Several things are routinely mistaken for violations even though they are not:

- a **short reorg** is normal network operation;
- a **hard fork that changes future rules** leaves the past intact. [A Block and the Transactions Inside It](008-block.md) shows this clearly: the Proof-of-Work fields were frozen, not rewritten;
- a **contract upgrade through a proxy** changes state under the rules already in force;
- **blob expiry** means the protocol stops requiring nodes to retain and serve old blob data after a defined availability window. Individual archives may keep copies indefinitely.

Real violations look different: a deep reorg beyond the accepted security threshold—the number of confirmations in PoW, where the network itself declares nothing final, or explicit finality in PoS—and a state change outside the transition function.

## The cost

- you cannot reverse your own mistake under the rules: funds can be returned only by a new operation or intervention by the social layer;
- immutability is limited by the network's attack economics and social response, so it may be nominal on a small chain even when honest participation is continuously rewarded;
- data that cannot be erased also cannot be erased when the law requires it—a direct conflict with the right to deletion (Part XXII);
- “code is law” holds only until the harm exceeds the cost of a social fork. The DAO showed where that boundary lies.

## Primary sources

- [Bitquery: 807K ETC stolen in the July 2020 attack](https://bitquery.io/blog/attacker-stole-807k-etc-in-ethereum-classic-51-attack) — reconstructed transactions, double-spend amount, and estimated rented-hash cost.
- [ETC Cooperative: 2020 retrospective](https://etccooperative.org/ETC-Cooperative-Retrospective-2020.pdf) — the three Q3 2020 attacks and the ecosystem response.

Last verified: 2026-08-22.

## Check yourself

1. Why is “can a block be rewritten?” the wrong question?
2. What are the three ways to change history, and what pays for each?
3. Why can immutability not be discussed independently of a particular network?
4. Is a two-block reorg an attack?
5. Ethereum Classic was rolled back by thousands of blocks. What broke, and what did not?
