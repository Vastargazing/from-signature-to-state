use reorg_indexer::{Block, Delta, Indexer, MemoryChain};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let genesis = Block::new(0, "g", "", vec![]);
    let mut chain = MemoryChain::default();

    for block in [
        genesis.clone(),
        Block::new(1, "a1", "g", vec![Delta::new("alice", 10)]),
        Block::new(
            2,
            "a2",
            "a1",
            vec![Delta::new("alice", -4), Delta::new("bob", 4)],
        ),
        Block::new(3, "a3", "a2", vec![Delta::new("bob", 3)]),
        Block::new(
            2,
            "b2",
            "a1",
            vec![Delta::new("alice", -2), Delta::new("carol", 2)],
        ),
        Block::new(3, "b3", "b2", vec![Delta::new("carol", 5)]),
        Block::new(4, "b4", "b3", vec![Delta::new("alice", 1)]),
    ] {
        chain.insert(block);
    }

    let mut indexer = Indexer::new(genesis)?;
    indexer.sync_to_head("a3", &chain)?;
    println!(
        "before reorg: tip={}, balances={:?}",
        indexer.tip().hash,
        indexer.balances()
    );

    let report = indexer.sync_to_head("b4", &chain)?;
    println!(
        "reorg: rolled_back={}, applied={}",
        report.rolled_back, report.applied
    );
    println!(
        "after reorg:  tip={}, balances={:?}",
        indexer.tip().hash,
        indexer.balances()
    );

    let restored = Indexer::from_checkpoint(&indexer.checkpoint()?)?;
    println!(
        "restart:      tip={}, balances={:?}",
        restored.tip().hash,
        restored.balances()
    );

    Ok(())
}
