# Protocol Composability

> **Composability means one contract can use another contract's state and functions as building blocks inside the same transaction.**

## Money legos

A new protocol does not need to recreate tokens, exchanges, loans, and price feeds. It can call existing contracts through public interfaces.

One transaction might:

1. borrow an asset;
2. swap it on a DEX;
3. deposit the result as collateral;
4. repay the original loan.

If the last step fails and that failure propagates to the top-level call, all application-level changes in the sequence revert. A caller can deliberately catch some subcall failures, so the all-or-nothing property depends on the composed contract's error handling. This atomic execution lets contracts coordinate without trusting an off-chain operator to finish the sequence.

## More than code reuse

A library copies reusable code into an application. A composed protocol depends on another live state machine with its own balances, parameters, governance, and failures.

That creates network effects: deep liquidity and established collateral become useful infrastructure. It also creates dependency risk.

## Failure travels through the graph

If an oracle reports a bad price, every lending market using it may liquidate incorrectly. If a token adds transfer restrictions, integrations may break. If a governance vote changes collateral factors, leveraged positions built across several protocols can unwind together.

```text
protocol A → protocol B → oracle C
                         → token D
```

Auditing A alone is insufficient. The trust graph includes every external call, asset, approval, and upgrade authority it relies on.

## Cross-chain limits

Synchronous composability is strongest inside one atomic execution environment. Calls across L1 and L2 or between chains require messages that finalize later. They cannot generally share one all-or-nothing transaction.

That latency creates partial-completion and bridge risk. “The protocols are composable” should always be followed by “on which chain and under which finality?”

## Check yourself

1. What does atomic composition guarantee when the final call fails?
2. How does composition differ from importing a code library?
3. Why must an audit include dependency contracts and assets?
4. Why is cross-chain composition usually asynchronous?
