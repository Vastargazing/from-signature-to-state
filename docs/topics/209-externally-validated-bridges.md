# Trusted and Externally Validated Bridges

> **An externally validated bridge accepts a message because a separate signer set attested to it, not because the destination chain verified the source consensus itself.**

## The committee

Observers watch the source chain. After enough confirmations, they sign a deposit or message. A destination contract verifies that at least the configured threshold approved it.

For a 5-of-9 bridge, any five valid signing keys may be sufficient to release custody—even if the claimed event never happened.

The contract verifies signatures correctly; trust lives in who controls those keys and what software tells them to sign.

## Why teams use this model

Signature verification is cheap and works across chains with very different consensus systems. Adding a new chain does not require implementing its full light client on every destination.

The price is an additional consensus layer whose economic security may be much smaller than either connected chain.

## Real threshold versus advertised threshold

Nine signers are not nine failure domains if five keys run in one cloud account or one organization controls the machines. Shared code, RPC sources, deployment pipelines, and key-management systems create correlated compromise.

Governance that can instantly replace signers can also bypass the apparent threshold.

## Controls around the committee

Rate limits, delayed large withdrawals, per-token caps, hardware keys, independent operators, anomaly detection, and emergency pauses reduce blast radius.

They do not convert external validation into source-consensus verification. A pause key trades censorship power for incident response.

When reviewing one, count independent organizations and operational domains, identify the signing threshold and upgrade authority, and compare the value secured with the cost of corrupting the signer set.

The useful label is not “multisig bridge.” It is “destination contract trusts N-of-M external attestations under these operational controls.”

## Check yourself

1. What fact does the destination contract actually verify in this model?
2. Why can five keys in one organization be one failure domain?
3. What benefit makes external validation common?
4. Do rate limits change the fundamental trust root?
