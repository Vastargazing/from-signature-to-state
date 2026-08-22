# IBC

> **IBC is a standard for authenticated packets between blockchains. A configured on-chain client decides what proves counterparty state; relayers carry updates, proofs, and messages but do not define truth.**

## IBC Classic and IBC v2

In IBC Classic, each chain hosts a client representing the other's consensus. A connection binds the two clients, and application-specific channels carry ordered or unordered packets.

IBC v2, launched in 2025, keeps clients and the send/receive/acknowledge/timeout lifecycle but replaces the separate connection and channel handshakes with a simpler router-and-application model. Its packets identify source and destination clients and can carry versioned application payloads.

Both versions track packet commitments, sequences, acknowledgements, and timeouts so delivery and replay rules are explicit. They are different wire protocols and abstractions, so documentation must name which version an integration uses.

## Relayers are permissionless couriers

Relayers watch one chain and submit client updates and packet proofs to the other. If one relayer stops, another can deliver the same valid evidence.

A relayer can censor by refusing service temporarily, but cannot forge a transfer that the configured client and state-proof rules reject. A light client is the trust-minimized default; IBC v2 can also use multisignature or other client types with different trust assumptions.

## Token denomination traces

For an IBC Classic ICS-20 token transfer, the source asset is escrowed or a previously vouched representation is burned under the channel rules. The destination creates a voucher whose denomination records the port/channel path.

That trace distinguishes assets arriving through different channels. Two tokens displaying `ATOM` may represent different paths and trust histories.

Returning along the path unwinds the voucher and releases or recreates the prior representation.

## Failure assumptions

IBC inherits both chains' consensus, client correctness and trust model, application logic, and timeout rules. Classic deployments additionally depend on connection and channel state. A compromised source consensus can prove malicious state that an honest light client accepts; a weaker attestation client can fail under its own threshold assumptions.

Client expiry or incompatible upgrades can halt packets. Governance may need to recover a frozen connection, adding an explicit social trust path.

IBC standardizes verification and delivery; it does not make all connected chains equally secure or all tokens with the same symbol interchangeable.

## Primary sources

- [IBC v2 specification](https://docs.cosmos.network/ibc/latest/spec/IBC_V2/README) — client-addressed packets, routers, payload versions, acknowledgements, and timeouts.
- [ibc-go release notes](https://docs.cosmos.network/ibc/next/changelog/release-notes) — the 2025 IBC Eureka/v2 implementation release.

Last verified: 2026-08-22.

## Check yourself

1. Which component verifies the remote chain's state?
2. Can a relayer create a valid packet from nothing?
3. Why does an IBC token keep a denomination trace?
4. What happens when the source chain's consensus is compromised?
