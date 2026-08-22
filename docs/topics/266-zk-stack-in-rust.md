# The ZK Stack in Rust

> **Rust ZK tools sit at different levels: some build proofs from algebra, others prove that an ordinary-looking program ran correctly.**

“A ZK library” can mean very different things. The first question is whether the project wants a custom circuit or a general virtual machine.

## Custom-circuit tools

arkworks is an ecosystem of Rust crates for finite fields, elliptic curves, polynomials, constraint systems, and proof systems. It gives cryptographers reusable components for constructing protocols. The flexibility is high, but the developer must understand what is constrained and which values are public.

halo2 is a circuit framework built around a PLONK-style arithmetization. Developers describe columns, gates, lookups, and witness assignments. It is useful when the application needs tight control over circuit structure and proving cost.

In both cases, the circuit proves only its constraints. If a necessary check was never encoded, a perfectly valid proof can certify the wrong statement.

## zkVM tools

RISC Zero and SP1 take another route. A guest program compiles to a RISC-V instruction set, and the zkVM proves that this program executed with particular inputs and outputs.

This lets teams reuse normal Rust control flow and libraries instead of expressing everything directly as gates. Public outputs are committed through a journal or equivalent interface; private inputs must not be accidentally exposed there.

The tradeoff is overhead. A specialized circuit can be much more efficient for one fixed computation, while a zkVM buys easier development and broader code reuse.

## The engineering boundary

The host prepares inputs and requests a proof. The deterministic guest performs the computation being proven. Profiling focuses on cycles, memory, hashing, and data movement—not only wall-clock time.

The core choice is:

```text
custom circuit → more control, more circuit expertise
zkVM program   → more familiar code, more general execution overhead
```

## Check yourself

1. What level of the stack does arkworks provide?
2. What does a halo2 developer define?
3. How does a zkVM make ZK development more familiar?
4. Why can a valid proof still certify the wrong application claim?
