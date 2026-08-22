# Proof of Space and Time: Chia

> **Chia replaces continuous hash racing with stored plot data, then uses verifiable delay functions to establish time between blocks.**

In proof of space, participants called farmers create large plot files containing structured precomputed data. For each signage-point challenge, plot filters eliminate most files and eligible plots fetch small quality data before a full proof is read when needed; implementations do not simply read every byte of every plot for each challenge.

More plotted space gives more chances of finding a strong proof, much as more hash rate gives more proof-of-work chances.

```text
allocated plot space → probability of winning a challenge
```

## Why time is separate

Disk space alone does not provide a reliable chain clock. Chia uses verifiable delay functions, or VDFs, computed by timelords.

A VDF requires sequential computation, so one evaluation cannot be sped up simply by adding parallel machines, although faster hardware can improve the sequential rate. Its output is much faster to verify than to produce. The proof certifies a number of sequential iterations; interpreting that as elapsed wall-clock time depends on the calibrated fastest honest VDF rate and protocol timing assumptions.

Farmers provide proofs of space; timelords advance and prove the time sequence. One participant can perform both roles, but the functions are distinct.

## The resource trade

Proof of space reduces the need for continuous general hash computation, but it is not costless. Plotting consumes computation and disk writes, farming needs storage and reads, and specialized hardware or economies of scale can concentrate participation.

Unused storage capacity is the intended scarce resource, yet market incentives may cause people to buy drives specifically for farming. The real environmental cost depends on hardware production, reuse, lifetime, and electricity—not the label alone.

## Security view

An attacker's ability to build a heavier alternative depends on both its fraction of effective netspace and any advantage over the fastest honest VDF. These resources are not interchangeable in a simple one-number threshold. Nodes still validate blocks; winning a proof does not permit invalid transactions.

The mental split is:

```text
space → scarce lottery weight
time  → sequential ordering evidence
```

## Check yourself

1. What does a Chia plot store?
2. Why are VDFs needed beside proof of space?
3. How do farmers and timelords differ?
4. Why is proof of space not resource-free?
