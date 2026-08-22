# Flash Loans

> **A flash loan is uncollateralized only across one transaction: borrow, use, and repay before that transaction ends—or its application-level effects revert.**

## Atomic credit

A lending contract transfers assets to the borrower, then calls the borrower's code. Before returning, it verifies that principal plus fee has come back.

```text
borrow → arbitrary calls → repay
        one atomic transaction
```

If repayment is missing, the EVM reverts the whole transaction, including the initial transfer. The lender never accepts an outstanding loan after the block transition.

## Why no collateral is needed

Normal credit carries time risk: the borrower may disappear tomorrow. A flash loan has no tomorrow. Ethereum's atomic execution guarantees either a fully repaid final state or no state change.

Someone still has to pay the transaction's native gas fee, whether that is the borrower, a relayer, or a sponsorship mechanism. A failed attempt consumes gas and the outer transaction sender's nonce even though the loan transfer and strategy state changes revert.

## Legitimate uses

Flash liquidity can fund:

- arbitrage across DEXs;
- refinancing debt between protocols;
- replacing collateral without closing a position manually;
- liquidations whose seized collateral repays the loan;
- complex atomic migrations.

It lets a strategy use capital based on the transaction's correctness rather than the operator's wealth.

## Limits

The entire strategy must fit inside one transaction and find enough liquidity. Price impact, fees, gas, and MEV can erase profit between simulation and inclusion.

A flash loan cannot finance a position held overnight or across asynchronous bridge messages. It also cannot make an unprofitable sequence profitable; it only removes the upfront-capital constraint.

## Rust lens

A Rust simulation or searcher should execute the exact callback path against current forked state, then calculate profit after loan fees, DEX fees, gas, and worst-case inclusion changes.

## Check yourself

1. Why can a flash loan be uncollateralized?
2. What happens if repayment is one wei short?
3. Which time horizon can a flash loan finance?
4. Why does a profitable simulation not guarantee on-chain profit?
