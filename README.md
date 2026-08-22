# From Signature to State

A developer's guide to blockchains, smart contracts, L2s, security, and Rust infrastructure.

**Read it at [vastargazing.github.io/from-signature-to-state](https://vastargazing.github.io/from-signature-to-state/).**

This book explains the machinery instead of the vocabulary. It follows one signed transaction
into canonical state, then takes that pipeline apart: consensus, the EVM, gas, rollups, data
availability, account abstraction, DeFi, MEV, bridges, security, zero-knowledge proofs, Solana,
and the Rust systems the industry runs on.

- **[The Core Path](docs/core-path.md)** — fifty chapters that build one working mental model.
- **[The knowledge map](docs/index.md)** — 274 reference notes to look things up in.
- **[The labs](docs/labs/index.md)** — eight reproducible exercises that produce traces, failing
  tests, and small programs.
- **[The answer key](docs/answers/core-path.md)** — reasoning, not phrases to memorize.

Every chapter states what a mechanism does, which problem forced it to exist, and where its
guarantee ends. Where a claim can change, it carries a primary source and a verification date.

## Running the labs

The EVM labs need [Foundry](https://getfoundry.sh/); the Rust labs need a stable toolchain.
Project sources live in [`projects/`](projects/) and each lab tells you which one to enter.

```bash
cd projects/reentrancy
forge test --match-contract ReentrancyTest -vvvv
```

Nothing in the labs touches a public network. Keys printed by Anvil are deliberately public and
safe only on a disposable local chain.

## Building the site

```bash
pip install -r requirements.txt
mkdocs serve
```

## Checking the book

```bash
bash scripts/check_book.sh   # structure, links, answers, labs, generated navigation
mkdocs build --strict        # anchors, unresolved links, pages missing from navigation
```

`scripts/gen_nav.py` derives the site navigation from the knowledge map, and
`scripts/gen_corepath.py` writes the Core Path sequence into the fifty chapters it covers. Both
run with `--check` in CI, so the map, the navigation, and the reading order cannot drift apart.

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md) first, then the
[editorial standard](docs/editorial.md) it points to. The standard is what keeps a new chapter
sounding like the rest of the book.

## License

© 2026 Vastargazing.

The book text is licensed under [CC BY 4.0](LICENSE): copy, translate, adapt, and redistribute
it, including commercially, as long as you give credit.

The lab code in [`projects/`](projects/) is licensed under [MIT](projects/LICENSE): reuse,
modify, and redistribute it in your own projects, keeping the copyright and license notice.
