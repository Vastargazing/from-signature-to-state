use std::collections::{BTreeMap, HashMap, HashSet};
use std::error::Error;
use std::fmt::{self, Display};

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Delta {
    pub account: String,
    pub amount: i64,
}

impl Delta {
    pub fn new(account: &str, amount: i64) -> Self {
        Self {
            account: account.to_owned(),
            amount,
        }
    }
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Block {
    pub number: u64,
    pub hash: String,
    pub parent_hash: String,
    pub deltas: Vec<Delta>,
}

impl Block {
    pub fn new(number: u64, hash: &str, parent_hash: &str, deltas: Vec<Delta>) -> Self {
        Self {
            number,
            hash: hash.to_owned(),
            parent_hash: parent_hash.to_owned(),
            deltas,
        }
    }
}

#[derive(Default)]
pub struct MemoryChain {
    blocks: HashMap<String, Block>,
}

impl MemoryChain {
    pub fn insert(&mut self, block: Block) {
        self.blocks.insert(block.hash.clone(), block);
    }

    pub fn block(&self, hash: &str) -> Option<&Block> {
        self.blocks.get(hash)
    }
}

#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct SyncReport {
    pub rolled_back: usize,
    pub applied: usize,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub enum IndexerError {
    InvalidGenesis,
    UnknownBlock(String),
    NoCommonAncestor(String),
    BrokenLink {
        child: String,
        expected_parent: String,
        actual_parent: String,
    },
    WrongHeight {
        hash: String,
        expected: u64,
        actual: u64,
    },
    ArithmeticOverflow(String),
    InvalidCheckpoint(String),
}

impl Display for IndexerError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::InvalidGenesis => write!(formatter, "genesis must be block 0 with no parent"),
            Self::UnknownBlock(hash) => write!(formatter, "chain source has no block {hash}"),
            Self::NoCommonAncestor(hash) => {
                write!(
                    formatter,
                    "branch ending at {hash} has no known common ancestor"
                )
            }
            Self::BrokenLink {
                child,
                expected_parent,
                actual_parent,
            } => write!(
                formatter,
                "block {child} expected parent {expected_parent}, got {actual_parent}"
            ),
            Self::WrongHeight {
                hash,
                expected,
                actual,
            } => write!(
                formatter,
                "block {hash} expected height {expected}, got {actual}"
            ),
            Self::ArithmeticOverflow(account) => {
                write!(formatter, "balance overflow for account {account}")
            }
            Self::InvalidCheckpoint(reason) => write!(formatter, "invalid checkpoint: {reason}"),
        }
    }
}

impl Error for IndexerError {}

#[derive(Clone, Debug)]
pub struct Indexer {
    canonical: Vec<Block>,
    balances: BTreeMap<String, i64>,
}

impl Indexer {
    pub fn new(genesis: Block) -> Result<Self, IndexerError> {
        if genesis.number != 0 || !genesis.parent_hash.is_empty() {
            return Err(IndexerError::InvalidGenesis);
        }

        let mut indexer = Self {
            canonical: Vec::new(),
            balances: BTreeMap::new(),
        };
        indexer.apply(&genesis)?;
        indexer.canonical.push(genesis);
        Ok(indexer)
    }

    pub fn tip(&self) -> &Block {
        self.canonical
            .last()
            .expect("an indexer always retains genesis")
    }

    pub fn balance(&self, account: &str) -> i64 {
        self.balances.get(account).copied().unwrap_or_default()
    }

    pub fn balances(&self) -> &BTreeMap<String, i64> {
        &self.balances
    }

    pub fn canonical_hash(&self, number: u64) -> Option<&str> {
        self.canonical
            .get(number as usize)
            .filter(|block| block.number == number)
            .map(|block| block.hash.as_str())
    }

    pub fn sync_to_head(
        &mut self,
        head_hash: &str,
        source: &MemoryChain,
    ) -> Result<SyncReport, IndexerError> {
        if self.tip().hash == head_hash {
            return Ok(SyncReport::default());
        }

        let positions: HashMap<&str, usize> = self
            .canonical
            .iter()
            .enumerate()
            .map(|(position, block)| (block.hash.as_str(), position))
            .collect();

        let mut cursor = head_hash.to_owned();
        let mut visited = HashSet::new();
        let mut new_branch = Vec::new();

        let ancestor_position = loop {
            if let Some(position) = positions.get(cursor.as_str()) {
                break *position;
            }
            if !visited.insert(cursor.clone()) {
                return Err(IndexerError::NoCommonAncestor(head_hash.to_owned()));
            }

            let block = source
                .block(&cursor)
                .ok_or_else(|| IndexerError::UnknownBlock(cursor.clone()))?
                .clone();
            cursor = block.parent_hash.clone();
            new_branch.push(block);

            if cursor.is_empty() {
                return Err(IndexerError::NoCommonAncestor(head_hash.to_owned()));
            }
        };

        let mut expected_parent = self.canonical[ancestor_position].hash.clone();
        let expected_numbers = self.canonical[ancestor_position].number + 1..;

        for (expected_number, block) in expected_numbers.zip(new_branch.iter().rev()) {
            if block.parent_hash != expected_parent {
                return Err(IndexerError::BrokenLink {
                    child: block.hash.clone(),
                    expected_parent,
                    actual_parent: block.parent_hash.clone(),
                });
            }
            if block.number != expected_number {
                return Err(IndexerError::WrongHeight {
                    hash: block.hash.clone(),
                    expected: expected_number,
                    actual: block.number,
                });
            }
            expected_parent = block.hash.clone();
        }

        // Stage the whole transition so an overflow or malformed block cannot leave half a reorg.
        let mut staged = self.clone();
        let rolled_back = staged.canonical.len() - ancestor_position - 1;
        while staged.canonical.len() > ancestor_position + 1 {
            staged.rollback_tip()?;
        }
        for block in new_branch.iter().rev() {
            staged.apply(block)?;
            staged.canonical.push(block.clone());
        }

        let report = SyncReport {
            rolled_back,
            applied: new_branch.len(),
        };
        *self = staged;
        Ok(report)
    }

    pub fn checkpoint(&self) -> Result<String, IndexerError> {
        let mut output = String::from("reorg-indexer 1\n");

        for block in &self.canonical {
            ensure_token(&block.hash)?;
            let parent = if block.parent_hash.is_empty() {
                "-"
            } else {
                ensure_token(&block.parent_hash)?;
                &block.parent_hash
            };
            output.push_str(&format!(
                "block {} {} {} {}\n",
                block.number,
                block.hash,
                parent,
                block.deltas.len()
            ));
            for delta in &block.deltas {
                ensure_token(&delta.account)?;
                output.push_str(&format!("delta {} {}\n", delta.account, delta.amount));
            }
        }

        Ok(output)
    }

    pub fn from_checkpoint(checkpoint: &str) -> Result<Self, IndexerError> {
        let mut lines = checkpoint.lines();
        if lines.next() != Some("reorg-indexer 1") {
            return Err(IndexerError::InvalidCheckpoint(
                "unsupported or missing version".to_owned(),
            ));
        }

        let mut blocks = Vec::new();
        while let Some(header) = lines.next() {
            let fields: Vec<_> = header.split_whitespace().collect();
            if fields.len() != 5 || fields[0] != "block" {
                return Err(IndexerError::InvalidCheckpoint(format!(
                    "bad block header: {header}"
                )));
            }

            let number = parse_field(fields[1], "block number")?;
            let hash = fields[2];
            let parent_hash = if fields[3] == "-" { "" } else { fields[3] };
            let delta_count: usize = parse_field(fields[4], "delta count")?;
            let mut deltas = Vec::with_capacity(delta_count);

            for _ in 0..delta_count {
                let line = lines.next().ok_or_else(|| {
                    IndexerError::InvalidCheckpoint("missing delta line".to_owned())
                })?;
                let delta_fields: Vec<_> = line.split_whitespace().collect();
                if delta_fields.len() != 3 || delta_fields[0] != "delta" {
                    return Err(IndexerError::InvalidCheckpoint(format!(
                        "bad delta line: {line}"
                    )));
                }
                let amount = parse_field(delta_fields[2], "delta amount")?;
                deltas.push(Delta::new(delta_fields[1], amount));
            }

            blocks.push(Block::new(number, hash, parent_hash, deltas));
        }

        let genesis = blocks
            .first()
            .cloned()
            .ok_or_else(|| IndexerError::InvalidCheckpoint("missing genesis".to_owned()))?;
        let mut indexer = Self::new(genesis)?;

        for block in blocks.into_iter().skip(1) {
            let tip = indexer.tip();
            if block.parent_hash != tip.hash {
                return Err(IndexerError::BrokenLink {
                    child: block.hash,
                    expected_parent: tip.hash.clone(),
                    actual_parent: block.parent_hash,
                });
            }
            if block.number != tip.number + 1 {
                return Err(IndexerError::WrongHeight {
                    hash: block.hash,
                    expected: tip.number + 1,
                    actual: block.number,
                });
            }
            indexer.apply(&block)?;
            indexer.canonical.push(block);
        }

        Ok(indexer)
    }

    fn apply(&mut self, block: &Block) -> Result<(), IndexerError> {
        for delta in &block.deltas {
            self.add_balance(&delta.account, delta.amount)?;
        }
        Ok(())
    }

    fn rollback_tip(&mut self) -> Result<(), IndexerError> {
        let block = self
            .canonical
            .pop()
            .expect("rollback never removes genesis");
        for delta in block.deltas.iter().rev() {
            let inverse = delta
                .amount
                .checked_neg()
                .ok_or_else(|| IndexerError::ArithmeticOverflow(delta.account.clone()))?;
            self.add_balance(&delta.account, inverse)?;
        }
        Ok(())
    }

    fn add_balance(&mut self, account: &str, delta: i64) -> Result<(), IndexerError> {
        let current = self.balance(account);
        let next = current
            .checked_add(delta)
            .ok_or_else(|| IndexerError::ArithmeticOverflow(account.to_owned()))?;
        if next == 0 {
            self.balances.remove(account);
        } else {
            self.balances.insert(account.to_owned(), next);
        }
        Ok(())
    }
}

fn ensure_token(value: &str) -> Result<&str, IndexerError> {
    if value.is_empty() || value.chars().any(char::is_whitespace) {
        return Err(IndexerError::InvalidCheckpoint(format!(
            "{value:?} is not a single token"
        )));
    }
    Ok(value)
}

fn parse_field<T>(value: &str, name: &str) -> Result<T, IndexerError>
where
    T: std::str::FromStr,
{
    value
        .parse()
        .map_err(|_| IndexerError::InvalidCheckpoint(format!("bad {name}: {value}")))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn fixture() -> (MemoryChain, Indexer) {
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
            Block::new(
                5,
                "b5",
                "b4",
                vec![Delta::new("carol", -3), Delta::new("alice", 3)],
            ),
        ] {
            chain.insert(block);
        }
        let indexer = Indexer::new(genesis).unwrap();
        (chain, indexer)
    }

    #[test]
    fn indexes_a_linear_chain() {
        let (chain, mut indexer) = fixture();

        let report = indexer.sync_to_head("a3", &chain).unwrap();

        assert_eq!(
            report,
            SyncReport {
                rolled_back: 0,
                applied: 3
            }
        );
        assert_eq!(indexer.tip().hash, "a3");
        assert_eq!(indexer.balance("alice"), 6);
        assert_eq!(indexer.balance("bob"), 7);
    }

    #[test]
    fn rolls_back_the_old_branch_before_applying_the_new_one() {
        let (chain, mut indexer) = fixture();
        indexer.sync_to_head("a3", &chain).unwrap();

        let report = indexer.sync_to_head("b4", &chain).unwrap();

        assert_eq!(
            report,
            SyncReport {
                rolled_back: 2,
                applied: 3
            }
        );
        assert_eq!(indexer.canonical_hash(1), Some("a1"));
        assert_eq!(indexer.canonical_hash(2), Some("b2"));
        assert_eq!(indexer.tip().hash, "b4");
        assert_eq!(indexer.balance("alice"), 9);
        assert_eq!(indexer.balance("bob"), 0);
        assert_eq!(indexer.balance("carol"), 7);
    }

    #[test]
    fn syncing_the_same_head_is_idempotent() {
        let (chain, mut indexer) = fixture();
        indexer.sync_to_head("b4", &chain).unwrap();
        let before = indexer.balances().clone();

        let report = indexer.sync_to_head("b4", &chain).unwrap();

        assert_eq!(report, SyncReport::default());
        assert_eq!(indexer.balances(), &before);
    }

    #[test]
    fn resumes_from_a_checkpoint_and_keeps_syncing() {
        let (chain, mut indexer) = fixture();
        indexer.sync_to_head("b4", &chain).unwrap();

        let checkpoint = indexer.checkpoint().unwrap();
        let mut restored = Indexer::from_checkpoint(&checkpoint).unwrap();
        let report = restored.sync_to_head("b5", &chain).unwrap();

        assert_eq!(
            report,
            SyncReport {
                rolled_back: 0,
                applied: 1
            }
        );
        assert_eq!(restored.tip().hash, "b5");
        assert_eq!(restored.balance("alice"), 12);
        assert_eq!(restored.balance("carol"), 4);
    }

    #[test]
    fn rejects_a_branch_with_no_known_ancestor_without_mutating_state() {
        let (mut chain, mut indexer) = fixture();
        indexer.sync_to_head("a3", &chain).unwrap();
        let before = indexer.checkpoint().unwrap();
        chain.insert(Block::new(9, "orphan", "missing", vec![]));

        let error = indexer.sync_to_head("orphan", &chain).unwrap_err();

        assert_eq!(error, IndexerError::UnknownBlock("missing".to_owned()));
        assert_eq!(indexer.checkpoint().unwrap(), before);
    }
}
