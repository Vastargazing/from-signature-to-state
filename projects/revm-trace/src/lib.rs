use revm::{
    Context, InspectEvm, MainBuilder, MainContext,
    context::TxEnv,
    database::InMemoryDB,
    inspector::{InspectorEvent, TestInspector},
    primitives::{Address, Bytes, TxKind, U256, hardfork::SpecId, keccak256},
    state::{AccountInfo, Bytecode},
};
use std::error::Error;

pub const CALLER: Address = Address::new([0x11; 20]);
pub const CONTRACT: Address = Address::new([0x22; 20]);

// calldata[0..32] -> storage[0] -> return storage[0]
pub const RUNTIME: &[u8] = &[
    0x60, 0x00, 0x35, 0x60, 0x00, 0x55, 0x60, 0x00, 0x54, 0x60, 0x00, 0x52, 0x60, 0x20, 0x60, 0x00,
    0xf3,
];

#[derive(Debug, PartialEq, Eq)]
pub struct TraceStep {
    pub pc: usize,
    pub opcode: String,
    pub stack_before: usize,
    pub stack_after: usize,
}

#[derive(Debug)]
pub struct Simulation {
    pub success: bool,
    pub gas_used: u64,
    pub returned: U256,
    pub stored: U256,
    pub trace: Vec<TraceStep>,
}

pub fn simulate(value: U256) -> Result<Simulation, Box<dyn Error>> {
    let code = Bytes::copy_from_slice(RUNTIME);
    let mut db = InMemoryDB::default();
    db.insert_account_info(
        CALLER,
        AccountInfo {
            balance: U256::MAX,
            ..Default::default()
        },
    );
    db.insert_account_info(
        CONTRACT,
        AccountInfo {
            code_hash: keccak256(&code),
            code: Some(Bytecode::new_raw(code)),
            ..Default::default()
        },
    );

    let calldata = value.to_be_bytes::<32>();
    let tx = TxEnv::builder()
        .caller(CALLER)
        .kind(TxKind::Call(CONTRACT))
        .gas_limit(100_000)
        .data(Bytes::copy_from_slice(&calldata))
        .build()?;

    let context = Context::mainnet()
        .modify_cfg_chained(|cfg| cfg.set_spec_and_mainnet_gas_params(SpecId::PRAGUE))
        .with_db(db);
    let mut evm = context.build_mainnet_with_inspector(TestInspector::new());
    let outcome = evm.inspect_tx(tx)?;

    let output = outcome
        .result
        .output()
        .ok_or("execution halted without output")?;
    if output.len() != 32 {
        return Err(format!("expected 32 output bytes, got {}", output.len()).into());
    }
    let returned = U256::from_be_slice(output);
    let stored = outcome
        .state
        .get(&CONTRACT)
        .and_then(|account| account.storage.get(&U256::ZERO))
        .map(|slot| slot.present_value)
        .ok_or("state diff has no contract storage slot 0")?;

    let trace = evm
        .inspector
        .events
        .iter()
        .filter_map(|event| match event {
            InspectorEvent::Step(step) => Some(TraceStep {
                pc: step.before.pc,
                opcode: step.opcode_name.clone(),
                stack_before: step.before.stack_len,
                stack_after: step
                    .after
                    .as_ref()
                    .map_or(step.before.stack_len, |after| after.stack_len),
            }),
            _ => None,
        })
        .collect();

    Ok(Simulation {
        success: outcome.result.is_success(),
        gas_used: outcome.result.tx_gas_used(),
        returned,
        stored,
        trace,
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn executes_bytecode_and_returns_the_written_value() {
        let simulation = simulate(U256::from(42)).unwrap();

        assert!(simulation.success);
        assert_eq!(simulation.returned, U256::from(42));
        assert_eq!(simulation.stored, U256::from(42));
    }

    #[test]
    fn trace_exposes_the_storage_write_and_read() {
        let simulation = simulate(U256::from(7)).unwrap();
        let opcodes: Vec<_> = simulation
            .trace
            .iter()
            .map(|step| step.opcode.as_str())
            .collect();

        assert_eq!(opcodes.len(), 11);
        assert!(opcodes.contains(&"SSTORE"));
        assert!(opcodes.contains(&"SLOAD"));
        assert_eq!(opcodes.last(), Some(&"RETURN"));
    }

    #[test]
    fn different_calldata_produces_a_different_state_diff() {
        let first = simulate(U256::from(1)).unwrap();
        let second = simulate(U256::from(1_000_000)).unwrap();

        assert_eq!(first.stored, U256::from(1));
        assert_eq!(second.stored, U256::from(1_000_000));
        assert_ne!(first.returned, second.returned);
    }
}
