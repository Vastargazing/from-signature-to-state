# FLP and CAP

> **FLP explains why deterministic agreement may wait forever in a fully asynchronous system; CAP explains what a replicated service sacrifices during a partition.**

They are related reminders about distributed systems, but they are not the same theorem and should not be collapsed into “you cannot have everything.”

## FLP

The FLP result considers deterministic consensus in a completely asynchronous message-passing system, where delay has no known bound but messages to non-faulty processes are eventually delivered. With even one possible crash fault, every partially correct consensus protocol has an admissible execution that never decides: deterministic consensus cannot guarantee termination in every execution while retaining its agreement and validity requirements.

It does not say consensus never works. Real protocols add something outside the model, such as partial-synchrony assumptions, randomized choices, or failure detectors. Leader rotation or economic incentives alone do not escape FLP unless they change a relevant timing, fault, or determinism assumption.

Many blockchain protocols assume eventual synchrony: delays may be unpredictable for a while, but eventually the network behaves within useful bounds.

## CAP

CAP concerns a replicated data service during a network partition. When two groups cannot communicate, a system cannot guarantee both:

- **atomic consistency:** operations appear to occur in one real-time-compatible total order;
- **availability:** every request to a non-failing node eventually receives a response.

A safety-first blockchain may stop finalizing rather than let both sides finalize conflicting histories. It may still produce tentative blocks, so the exact meaning of “available” matters.

Outside a partition, CAP does not force a permanent choice between consistency and availability. Latency and normal operating tradeoffs belong to broader models.

## Why this matters

These results force protocols to state assumptions instead of promising perfect agreement under all failures.

Ask:

```text
When can progress stop?
Which decisions may be rolled back?
What network behavior is assumed?
```

That explains a protocol better than attaching “CAP” to a marketing diagram.

## Check yourself

1. What network model does FLP assume?
2. How do practical protocols escape that model?
3. What choice appears during a CAP partition?
4. Why are FLP and CAP not interchangeable?
