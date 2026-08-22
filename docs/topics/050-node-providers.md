# Node Providers and Centralization

> **A hosted RPC provider removes node operations from your stack and inserts itself into your trust, privacy, and availability path.**

Services such as Infura and Alchemy run blockchain nodes behind managed APIs. They handle synchronization, upgrades, scaling, and geographic routing, so an application can start with one endpoint.

That convenience is real. So are the dependencies.

## What the provider can influence

A provider sees IP addresses, queried accounts, request timing, and submitted transactions. It can rate-limit, censor, return stale data, omit logs, experience an outage, or make a configuration mistake across many customers at once.

If many wallets and applications use the same company, one outage or policy decision affects a large part of the visible ecosystem even though the underlying chain remains live.

```text
decentralized settlement + centralized access = centralized application failure point
```

## Redundancy is not only two URLs

Two endpoints may share the same cloud, upstream software, or company. Useful redundancy varies provider, region, client implementation, and preferably includes a self-operated node for critical paths.

Where the RPC method supports it, applications should pin important reads to block hashes, detect head lag, compare results, retry safely, and define what happens when providers disagree.

Writes need careful failover. Broadcasting the same signed transaction twice is normally harmless, but independently generating replacements or nonces from two workers can conflict.

## Choose trust by function

A portfolio display can tolerate more provider trust than a bridge, oracle, or liquidation system. Some reads can be proof-verified; traces and broad historical queries often require stronger server trust.

Running your own node reduces dependence but adds operational risk: bad monitoring, missed upgrades, poor peer connectivity, or undersized hardware can also return stale service.

The goal is not “never use providers.” It is knowing which claims they supply and ensuring one provider cannot silently decide a security-critical result.

## Check yourself

1. Which metadata can an RPC provider observe?
2. Why is a provider outage a centralization problem?
3. What makes two endpoints weak redundancy?
4. When should an application verify or compare reads?
