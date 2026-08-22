# Access-Control Errors

> **Access control fails when a sensitive action checks the wrong authority, no authority, or an authority whose own administration is unsafe.**

## Authentication and authorization

Authentication asks who the caller is. Authorization asks whether that caller may perform this exact action.

Checking `msg.sender` correctly is insufficient if every authenticated user can call `mint()`. A role must match the capability.

## Common failures

- a public initializer lets the first caller become admin;
- an upgrade function lacks its authorization hook;
- `tx.origin` permits phishing through an intermediate contract;
- a role's admin role can grant itself every capability;
- ownership is transferred to the zero address accidentally;
- one broad owner controls mint, pause, oracle, and treasury;
- meta-transactions use the forwarder as caller incorrectly.

Inherited functions and internal call paths matter. A protected wrapper does not help if the same state-changing internal function is exposed elsewhere.

## Least privilege

Separate roles by job: minting, pausing, upgrading, parameter changes, and fund movement. Give each the smallest scope and duration it needs.

Emergency roles may pause quickly but should not also seize funds. Routine operators should not control upgrades.

## Administration is recursive

Who can grant the role? Who can replace that admin? Is the admin an EOA, multisig, timelock, governance contract, or cross-chain message?

```text
function privilege → role → role admin → wallet/signers → operational security
```

Review the whole chain, including default roles after deployment and the ability to renounce or recover them.

Good tests attempt every privileged function from unauthorized addresses and verify role transitions, not only happy-path owner calls.

## Check yourself

1. How does authorization differ from authentication?
2. Why is `tx.origin` unsafe for access control?
3. What does least privilege change about admin roles?
4. Why must a review follow the role's administrator recursively?
