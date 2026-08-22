# Contributing

Corrections are the most valuable contribution this book can receive. A wrong claim about
finality, gas, or a proof system teaches a reader something they will act on.

## Reporting a problem

Open an issue with the file, the exact sentence, and — if the claim is technical — a primary
source that contradicts it. "This seems wrong" is hard to act on; "`docs/topics/033-merkle-patricia-trie.md`
says Ethereum is moving to Verkle trees, but EIP-6800 is stagnant" is a patch waiting to happen.

## Before opening a pull request

Read [the editorial standard](docs/editorial.md). It is not a style guide about commas — it
covers what every chapter must make clear, how to layer a dense topic, which sources count, and
what a good self-check question looks like. A technically correct chapter that ignores it will
still need rewriting.

Two rules matter most:

- **State where the guarantee ends.** Every mechanism in this book is introduced with the failure
  it prevents and the failure it does not.
- **Cite primary sources for anything that can change.** Specifications, EIPs and BIPs, official
  documentation, client code, and original postmortems — in that order. Add
  `Last verified: YYYY-MM-DD` when a chapter describes a current deployment, roadmap, law, or
  fee market.

## Checks

Both of these run in CI and must pass:

```bash
bash scripts/check_book.sh
mkdocs build --strict
```

If you add or renumber a reference note, regenerate the derived files rather than editing them
by hand:

```bash
python3 scripts/gen_nav.py        # site navigation, from the knowledge map in docs/index.md
python3 scripts/gen_corepath.py   # Core Path strips, from docs/core-path.md
```

The navigation block in `mkdocs.yml` and the `<!-- corepath:* -->` blocks inside chapters are
generated. Hand edits to them are overwritten and will fail CI.

## Labs

A lab must produce an artifact, include at least one adversarial or failing path, and run from a
clean clone. Pin the toolchain versions you tested with. Never put a real private key, API key,
or production address with authority into the book.

## Licensing

Contributions to the prose are accepted under [CC BY 4.0](LICENSE); contributions to
[`projects/`](projects/) are accepted under [MIT](projects/LICENSE). By opening a pull request
you agree to license your contribution under the terms that apply to the files you touched.
