use revm::primitives::U256;
use revm_trace_lab::simulate;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let simulation = simulate(U256::from(42))?;

    println!(
        "success={} gas_used={} returned={} stored={}",
        simulation.success, simulation.gas_used, simulation.returned, simulation.stored
    );
    println!("pc   opcode       stack before → after");
    for step in simulation.trace {
        println!(
            "{:<4} {:<12} {} → {}",
            step.pc, step.opcode, step.stack_before, step.stack_after
        );
    }

    Ok(())
}
