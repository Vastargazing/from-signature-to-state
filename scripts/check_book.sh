#!/usr/bin/env bash
#
# Structural gate for the book. Runs before the site build in CI.
#
# It checks what a Markdown renderer cannot: that the knowledge map, the Core
# Path, the answer key, the labs, and the generated navigation all describe the
# same book.

set -uo pipefail

book_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
errors=0

fail() {
  printf 'ERROR: %s\n' "$1"
  errors=$((errors + 1))
}

for required in rg realpath python3; do
  if ! command -v "$required" >/dev/null 2>&1; then
    printf 'ERROR: %s is required but not installed\n' "$required"
    exit 2
  fi
done

printf 'Checking local Markdown links...\n'
while IFS=: read -r source_file source_line source_token; do
  link_target=${source_token#*](}
  link_target=${link_target%)}

  case "$link_target" in
    http://*|https://*|mailto:*|'#'*|'') continue ;;
  esac

  if [[ "$link_target" == /* ]]; then
    fail "$source_file:$source_line uses a machine-local absolute link: $link_target"
    continue
  fi

  link_file=${link_target%%#*}
  resolved_target=$(realpath -m "$(dirname "$source_file")/$link_file")
  if [[ ! -e "$resolved_target" ]]; then
    fail "$source_file:$source_line links to missing file: $link_target"
  fi
done < <(rg -n -o --no-heading '\]\([^)]*\)' "$book_root" --glob '*.md')

printf 'Checking the complete knowledge map...\n'
map_count=$(
  awk '/^## I\./ { in_map=1 } in_map' "$book_root/docs/index.md" |
    rg -c '^\d+\. (★ |▸ )?\[[^]]+\]\(topics/[^)]+\.md\)'
)
if [[ "$map_count" -ne 274 ]]; then
  fail "docs/index.md contains $map_count linked notes; expected 274"
fi

for expected_number in $(seq 1 274); do
  if ! rg -q "^${expected_number}\\. (★ |▸ )?\\[[^]]+\\]\\(topics/" "$book_root/docs/index.md"; then
    fail "docs/index.md is missing knowledge-map item $expected_number"
  fi
done

printf 'Checking the Core Path...\n'
core_count=$(rg -c '^[0-9]+\. \[[^]]+\]\(topics/[^)]+\.md\)$' "$book_root/docs/core-path.md")
if [[ "$core_count" -ne 50 ]]; then
  fail "docs/core-path.md contains $core_count numbered chapters; expected 50"
fi

for expected_number in $(seq 1 50); do
  if ! rg -q "^${expected_number}\\. \\[[^]]+\\]\\(topics/" "$book_root/docs/core-path.md"; then
    fail "docs/core-path.md is missing chapter $expected_number"
  fi
done

printf 'Checking the Core Path answer key...\n'
answer_count=$(rg -c '^## [0-9]+\.' "$book_root/docs/answers/core-path.md")
if [[ "$answer_count" -ne 50 ]]; then
  fail "docs/answers/core-path.md contains $answer_count chapter answers; expected 50"
fi

for expected_number in $(seq 1 50); do
  if ! rg -q "^## ${expected_number}\\. " "$book_root/docs/answers/core-path.md"; then
    fail "docs/answers/core-path.md is missing chapter $expected_number"
  fi

  core_line=$(rg "^${expected_number}\\. \\[[^]]+\\]\\(topics/" "$book_root/docs/core-path.md")
  topic_path=$(sed -E 's/.*\((topics\/[^)]+)\).*/\1/' <<< "$core_line")
  question_count=$(
    awk '
      /^## Check yourself$/ { in_check=1; next }
      in_check && /^## / { exit }
      in_check && /^<details>/ { exit }
      in_check && /^[0-9]+\./ { count++ }
      END { print count + 0 }
    ' "$book_root/docs/$topic_path"
  )
  chapter_answer_count=$(
    awk -v chapter="$expected_number" '
      $0 ~ "^## " chapter "\\. " { in_section=1; next }
      in_section && /^## [0-9]+\./ { exit }
      in_section && /^[0-9]+\./ { count++ }
      END { print count + 0 }
    ' "$book_root/docs/answers/core-path.md"
  )

  if [[ "$question_count" -eq 0 ]]; then
    fail "$topic_path has no numbered Check yourself questions"
  elif [[ "$question_count" -ne "$chapter_answer_count" ]]; then
    fail "Core Path chapter $expected_number has $question_count questions but $chapter_answer_count answers"
  fi
done

printf 'Checking topic structure...\n'
topic_count=$(find "$book_root/docs/topics" -maxdepth 1 -type f -name '*.md' | wc -l)
if [[ "$topic_count" -ne 275 ]]; then
  fail "docs/topics contains $topic_count notes; expected chapter 0 plus 274 reference notes"
fi

while IFS= read -r source_file; do
  if ! head -n 1 "$source_file" | rg -q '^# '; then
    fail "$source_file does not begin with an H1 title"
  fi
  if ! rg -q '^## Check yourself$' "$source_file"; then
    fail "$source_file has no Check yourself section"
  fi
done < <(find "$book_root/docs/topics" -maxdepth 1 -type f -name '*.md' | sort)

printf 'Checking deep dives...\n'
deep_dive_count=$(find "$book_root/docs/deep-dives" -maxdepth 1 -type f -name '*.md' | wc -l)
if [[ "$deep_dive_count" -ne 4 ]]; then
  fail "docs/deep-dives contains $deep_dive_count notes; expected 4"
fi
while IFS= read -r source_file; do
  if ! head -n 1 "$source_file" | rg -q '^# '; then
    fail "$source_file does not begin with an H1 title"
  fi
  if ! rg -q '^## Primary sources$' "$source_file"; then
    fail "$source_file has no Primary sources section"
  fi
  if ! rg -q '^## Check yourself$' "$source_file"; then
    fail "$source_file has no Check yourself section"
  fi
done < <(find "$book_root/docs/deep-dives" -maxdepth 1 -type f -name '*.md' | sort)

printf 'Checking source-sensitive notes...\n'
source_sensitive_notes=(
  docs/topics/000-one-transaction.md
  docs/topics/007-transaction.md
  docs/topics/008-block.md
  docs/topics/010-immutability.md
  docs/topics/011-genesis.md
  docs/topics/012-consensus-vs-policy.md
  docs/topics/013-client-and-spec.md
  docs/topics/015-sha-keccak-blake.md
  docs/topics/022-ed25519.md
  docs/topics/033-merkle-patricia-trie.md
  docs/topics/038-p2p-gossip-discovery.md
  docs/topics/039-full-node.md
  docs/topics/044-mempool.md
  docs/topics/048-economic-finality.md
  docs/topics/062-ethereum-pos-slots-epochs-attestations.md
  docs/topics/063-lmd-ghost-and-casper-ffg.md
  docs/topics/067-proof-of-history-solana.md
  docs/topics/077-eip-and-bip-process.md
  docs/topics/079-segwit-block-size-wars-bitcoin-cash.md
  docs/topics/080-dao-hack-eth-etc-split.md
  docs/topics/082-the-merge.md
  docs/topics/083-shapella-staking-withdrawals.md
  docs/topics/084-dencun-and-eip-4844.md
  docs/topics/085-reading-the-ethereum-roadmap.md
  docs/topics/087-externally-owned-account.md
  docs/topics/088-contract-account.md
  docs/topics/091-deterministic-execution.md
  docs/topics/102-solidity.md
  docs/topics/114-foundry.md
  docs/topics/120-transaction-and-block-gas-limits.md
  docs/topics/124-blob-gas-market.md
  docs/topics/128-bitcoin-capped-supply.md
  docs/topics/146-algorithmic-stablecoins-ust-luna.md
  docs/topics/151-what-is-an-l2.md
  docs/topics/152-optimistic-rollup.md
  docs/topics/154-zk-rollup.md
  docs/topics/158-data-availability.md
  docs/topics/159-blobs-and-eip-4844.md
  docs/topics/160-external-da-celestia-and-eigenda.md
  docs/topics/163-major-rollup-families.md
  docs/topics/164-op-stack-and-superchain.md
  docs/topics/167-sharding-and-ethereum-rollups.md
  docs/topics/169-erc-4337.md
  docs/topics/172-eip-7702.md
  docs/topics/194-chainlink-price-feeds.md
  docs/topics/195-push-and-pull-oracles.md
  docs/topics/203-mev-supply-chain.md
  docs/topics/204-pbs-and-mev-boost.md
  docs/topics/211-ronin-wormhole-and-nomad.md
  docs/topics/220-integer-overflow-and-solidity-0-8.md
  docs/topics/222-unprotected-initialization-and-parity.md
  docs/topics/231-the-dao-hack.md
  docs/topics/232-ronin-euler-and-curve.md
  docs/topics/234-exchange-custody-and-ftx.md
  docs/topics/245-solana-account-model.md
  docs/topics/246-svm-and-sealevel.md
  docs/topics/249-anchor.md
  docs/topics/250-solana-fees-and-local-contention.md
  docs/topics/252-ibc-in-cosmos.md
  docs/topics/253-cosmwasm.md
  docs/topics/254-polkadot-and-substrate.md
  docs/topics/259-reth-ethereum-execution-client.md
  docs/topics/260-revm.md
  docs/topics/261-alloy-and-ethers-rs.md
  docs/topics/270-mixers-tornado-cash-and-ofac.md
  docs/topics/272-kyc-aml-and-the-travel-rule.md
  docs/topics/274-mica-and-the-regulatory-landscape.md)

for relative_path in "${source_sensitive_notes[@]}"; do
  source_file="$book_root/$relative_path"
  if [[ ! -f "$source_file" ]]; then
    fail "$relative_path is listed as source-sensitive but does not exist"
    continue
  fi
  if ! rg -q '^## Primary sources$' "$source_file"; then
    fail "$relative_path has no Primary sources section"
  fi
  if ! rg -q '^Last verified: [0-9]{4}-[0-9]{2}-[0-9]{2}' "$source_file"; then
    fail "$relative_path has no machine-readable Last verified date"
  fi
done

printf 'Checking ready labs...\n'
for expected_lab in \
  01-inspect-local-transaction \
  02-decode-calldata \
  03-receipts-logs-and-storage \
  04-reentrancy-and-cei \
  05-fuzz-and-invariant-testing \
  06-reorg-safe-rust-indexer \
  07-execute-and-trace-with-revm \
  08-hostile-anchor-accounts; do
  lab_file="$book_root/docs/labs/${expected_lab}.md"
  if [[ ! -f "$lab_file" ]]; then
    fail "missing ready lab: docs/labs/${expected_lab}.md"
    continue
  fi
  if ! rg -q '^## Artifact$' "$lab_file"; then
    fail "$lab_file has no Artifact section"
  fi
  if ! rg -q '^## Primary sources$' "$lab_file"; then
    fail "$lab_file has no Primary sources section"
  fi
  if ! rg -q '^Last verified: [0-9]{4}-[0-9]{2}-[0-9]{2}' "$lab_file"; then
    fail "$lab_file has no machine-readable Last verified date"
  fi
done

printf 'Checking lab project paths referenced by labs...\n'
while IFS=: read -r source_file source_line project_path; do
  project_dir=${project_path#cd }
  if [[ ! -d "$book_root/$project_dir" ]]; then
    fail "$source_file:$source_line points at missing project: $project_dir"
  fi
done < <(rg -n -o --no-heading '^cd projects/\S+' "$book_root/docs/labs" --glob '*.md')

for indexer_file in Cargo.toml Cargo.lock src/lib.rs src/main.rs; do
  if [[ ! -f "$book_root/projects/reorg-indexer/$indexer_file" ]]; then
    fail "Lab 6 is missing projects/reorg-indexer/$indexer_file"
  fi
done

for revm_file in Cargo.toml Cargo.lock src/lib.rs src/main.rs; do
  if [[ ! -f "$book_root/projects/revm-trace/$revm_file" ]]; then
    fail "Lab 7 is missing projects/revm-trace/$revm_file"
  fi
done

for anchor_file in Cargo.toml Cargo.lock src/lib.rs src/vault.rs; do
  if [[ ! -f "$book_root/projects/anchor-hostile-accounts/$anchor_file" ]]; then
    fail "Lab 8 is missing projects/anchor-hostile-accounts/$anchor_file"
  fi
done

if [[ ! -f "$book_root/projects/receipts-storage/src/StateProbe.sol" ]]; then
  fail 'Lab 3 is missing its StateProbe.sol project'
fi

if [[ ! -f "$book_root/projects/reentrancy/test/SafeVaultProperties.t.sol" ]]; then
  fail 'Lab 5 is missing projects/reentrancy/test/SafeVaultProperties.t.sol'
fi

for security_file in \
  src/VulnerableVault.sol \
  src/SafeVault.sol \
  src/ReentrancyAttacker.sol \
  test/Reentrancy.t.sol; do
  if [[ ! -f "$book_root/projects/reentrancy/$security_file" ]]; then
    fail "Lab 4 is missing projects/reentrancy/$security_file"
  fi
done

duplicate_numbers=$(
  find "$book_root/docs/topics" -maxdepth 1 -type f -name '[0-9]*-*.md' -printf '%f\n' |
    sed 's/-.*//' |
    sed 's/^0*//' |
    sed 's/^$/0/' |
    sort -n |
    uniq -d
)
if [[ -n "$duplicate_numbers" ]]; then
  fail "duplicate topic numbers: $duplicate_numbers"
fi

printf 'Checking code fences...\n'
while IFS= read -r source_file; do
  fence_count=$(rg -c '^```' "$source_file" || true)
  if (( fence_count % 2 != 0 )); then
    fail "$source_file has an odd number of fenced-code markers"
  fi
done < <(find "$book_root/docs" -type f -name '*.md' | sort)

if rg -q '\[\[[^]]+\]\]' "$book_root/docs" --glob '*.md'; then
  fail 'Obsidian-style wikilinks remain; use portable Markdown links'
fi

printf 'Checking topics, knowledge map, and nav agree...\n'
python3 "$book_root/scripts/check_structure.py" || errors=$((errors + 1))

printf 'Checking the generated nav is current...\n'
python3 "$book_root/scripts/gen_nav.py" --check || errors=$((errors + 1))

printf 'Checking the Core Path navigation strips...\n'
python3 "$book_root/scripts/gen_corepath.py" --check || errors=$((errors + 1))

if [[ "$errors" -ne 0 ]]; then
  printf '\nBook check failed with %d error(s).\n' "$errors"
  exit 1
fi

printf '\nBook check passed: 274 mapped notes, 50 Core Path chapters and answers, %d topic files, %d deep dives, 8 ready labs.\n' \
  "$topic_count" \
  "$deep_dive_count"
