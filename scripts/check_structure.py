#!/usr/bin/env python3
"""Assert that topic files, the knowledge map, and the generated nav agree.

Three sets have to line up, and they are not the same set:

* `docs/topics/001..274` — the reference notes, which the knowledge map indexes;
* `docs/topics/000-one-transaction.md` — chapter zero, which opens the Core Path
  and deliberately does *not* appear in the numbered map;
* every topic file — all 275 of which must appear in nav exactly once.

Parsing nav with a regex rather than a YAML loader is deliberate: the block is
written by `gen_nav.py`, so its shape is known, and the check stays runnable
without installing MkDocs.
"""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DOCS = ROOT / "docs"

MAP_ENTRY = re.compile(r"^\d+\.\s(?:★\s|▸\s)?\[[^\]]+\]\((topics/[^)]+\.md)\)$", re.M)
NAV_BLOCK = re.compile(r"# nav:generated:start\n(.*?)# nav:generated:end", re.S)
NAV_TARGET = re.compile(r":\s*(topics/[^\s]+\.md)\s*$", re.M)
CHAPTER_ONE = re.compile(r"^1\.\s\[[^\]]+\]\((topics/[^)]+\.md)\)$", re.M)

FIRST_CHAPTER = "topics/000-one-transaction.md"

errors: list[str] = []


def fail(message: str) -> None:
    errors.append(message)


def main() -> int:
    on_disk = {f"topics/{p.name}" for p in (DOCS / "topics").glob("*.md")}
    numbered = {t for t in on_disk if not t.endswith("000-one-transaction.md")}

    mapped = set(MAP_ENTRY.findall((DOCS / "index.md").read_text(encoding="utf-8")))

    config = (ROOT / "mkdocs.yml").read_text(encoding="utf-8")
    block = NAV_BLOCK.search(config)
    if not block:
        fail("mkdocs.yml has no generated nav block")
        return report()
    nav = NAV_TARGET.findall(block.group(1))

    # 1. numbered topics == knowledge map
    if len(numbered) != 274:
        fail(f"docs/topics holds {len(numbered)} numbered notes; expected 274")
    for target in sorted(numbered - mapped):
        fail(f"{target} exists but is missing from the knowledge map")
    for target in sorted(mapped - numbered):
        fail(f"knowledge map lists {target}, which has no file")

    # 2. chapter zero is special: outside the map, but opening the Core Path
    if FIRST_CHAPTER not in on_disk:
        fail(f"{FIRST_CHAPTER} is missing")
    if FIRST_CHAPTER in mapped:
        fail(f"{FIRST_CHAPTER} must not appear in the numbered knowledge map")
    opener = CHAPTER_ONE.search((DOCS / "core-path.md").read_text(encoding="utf-8"))
    if not opener:
        fail("core-path.md has no chapter 1")
    elif opener.group(1) != FIRST_CHAPTER:
        fail(f"Core Path opens with {opener.group(1)}, expected {FIRST_CHAPTER}")

    # 3. every topic appears in nav exactly once
    seen: dict[str, int] = {}
    for target in nav:
        seen[target] = seen.get(target, 0) + 1
    for target, count in sorted(seen.items()):
        if count > 1:
            fail(f"{target} appears {count} times in nav; a file may appear once")
    for target in sorted(on_disk - set(nav)):
        fail(f"{target} is not reachable from nav")
    for target in sorted(set(nav) - on_disk):
        fail(f"nav points at {target}, which does not exist")

    return report()


def report() -> int:
    for message in errors:
        print(f"ERROR: {message}")
    if errors:
        print(f"\nStructure check failed with {len(errors)} error(s).")
        return 1
    print("  topics, knowledge map, and nav agree; chapter 0 handled separately")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
