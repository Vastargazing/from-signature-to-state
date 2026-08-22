# Light-Client Bridges and IBC

> **A light-client bridge verifies the counterparty chain's consensus and state proofs on-chain, so relayers transport evidence but do not decide truth.**

## The client

Chain A stores a compact light-client representation of chain B. Updates prove new finalized headers according to B's consensus rules.

Once a header is trusted, a Merkle proof can show that a packet commitment or state key existed under that header.

```text
B consensus proof → trusted B header on A
B state proof     → verified packet on A
```

## IBC

The Inter-Blockchain Communication protocol separates light clients, packet transport, and applications. Packets carry sequence numbers and move through send, receive, acknowledgement, or timeout states.

Relayers watch chains and submit proofs. They can delay service but cannot forge a packet that the on-chain client rejects. Anyone can normally relay the same evidence.

Token transfer is one IBC application; arbitrary data and contract calls can use the same authenticated channel model.

## Trust-minimized is not trust-free

If chain B's own consensus is compromised, its light client can accept the malicious finalized history because that history is valid under B's rules.

Clients also need correct validator-set updates, trusting periods, clock assumptions, proof formats, and misbehavior handling. If nobody updates a client before its trusting period expires, the connection may halt.

Implementing a different consensus light client on-chain can be expensive or complex. Some IBC clients therefore use alternative attestations, which changes their trust model even though the packet interface remains IBC.

## The contrast

An external committee says “we saw this event.” A light client checks “this event is included in a state finalized by the counterparty's consensus.” The relayer is courier, not judge.

## Check yourself

1. What two proofs connect a remote event to the destination?
2. Can an IBC relayer forge a packet by itself?
3. What happens if the source chain's own consensus is compromised?
4. Why can an expired light client stop communication?
