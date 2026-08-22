# 51% Attack and Chain Reorganization

> **Majority consensus power can control ordering and reorganization; it cannot make invalid state transitions valid.**

In proof of work, “51%” means majority effective hash power. In proof of stake, thresholds and penalties differ, so the phrase is only a rough analogy.

With majority hash power, an attacker can build a private branch faster on average than honest miners and later reveal it as the chain with more accumulated work.

## What the attacker can do

- reverse the attacker's own recent payments through a reorg;
- censor selected transactions or blocks;
- capture a disproportionate share of canonical block rewards and potentially orphan many honest blocks while control lasts;
- disrupt confidence and delay confirmations.

The attacker cannot create coins beyond consensus rules, forge another user's signature, spend someone else's UTXO, or make nodes accept invalid EVM execution. Full nodes validate independently.

```text
majority hash power can dominate canonical ordering over time
it does not rewrite validation rules
```

## Why depth matters

Reversing a deeper payment requires replacing more accumulated work while competing with honest mining. That is why recipients wait for confirmations.

If the attacker has sustained majority power, confirmations provide much weaker protection: the private chain can eventually catch up. Economic cost, detection, exchange response, and asset-price damage may still deter the attack.

## Pool share is not always ownership

A mining pool may coordinate hash power supplied by many independent miners. A pool approaching majority creates real censorship and template risk, but miners may redirect hardware if the pool attacks.

Measure control over block construction, duration, switching ability, and available external hash power—not only one dashboard percentage.

The precise security question is: which resource selects the canonical chain, and how much can one actor coordinate long enough to violate the application's confirmation assumption?

## Check yourself

1. What does 51% refer to in proof of work?
2. Which attacks can majority hash power perform?
3. Which invalid actions do full nodes still reject?
4. Why is pool coordination different from hardware ownership?
