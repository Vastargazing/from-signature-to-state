# Mining, Hash Rate, and Difficulty

> **Hash rate is how many attempts miners make; difficulty controls how rarely an attempt succeeds.**

A miner repeatedly hashes candidate block headers. Each hash is like an independent lottery ticket.

Hash rate measures attempts per second. The target defines which hashes win. A lower target accepts fewer outputs and therefore means higher difficulty.

```text
more hash rate → more chances per second
higher difficulty → smaller chance per attempt
```

## Mining is probabilistic

A miner with 10% of total hash rate expects roughly 10% of blocks over a long period, not every tenth block on schedule. Short-term results can vary greatly.

Mining pools reduce that variance. Participants contribute work and share rewards according to pool rules. The pool coordinator often chooses block templates, so hash ownership and block-construction control are not identical measurements.

## Difficulty adjustment

If miners add hardware while difficulty stays fixed, blocks arrive faster. If miners leave, they arrive slower.

Bitcoin recalculates its proof-of-work target every 2,016 blocks from the timestamp span of the preceding adjustment period, with bounds on each adjustment. It aims to restore an average interval of about ten minutes. The response is delayed, so sudden hash-rate changes temporarily affect block times, and timestamps make the estimate imperfect.

## Estimating hash rate

The network cannot directly count every failed hash attempt. It estimates total hash rate from observed block production and current difficulty.

That estimate is noisy over short windows because block arrivals are random. Reported precision should not be mistaken for direct measurement.

## Security interpretation

High total hash rate does not by itself prove decentralization. Ask how it is distributed across miners, pools, hardware suppliers, energy regions, and template builders.

An attacker cares about relative share, available rented or idle hardware, duration, and the target chain's market value—not one large hash-rate number without context.

## Check yourself

1. How do hash rate and difficulty differ?
2. Why does 10% hash rate not win every tenth block exactly?
3. Why is network hash rate an estimate?
4. How can a pool concentrate power without owning all hardware?
