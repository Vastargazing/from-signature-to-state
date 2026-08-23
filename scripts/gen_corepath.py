#!/usr/bin/env python3
"""Write the Core Path navigation strip into the fifty-one chapters it covers.

The Core Path order is not the numeric order of the reference notes, so it
cannot be expressed through MkDocs `nav` — a file may sit in `nav` only once.
Instead the sequence lives in the chapter files themselves, which also makes it
work when the book is read as raw Markdown on GitHub.

The block is delimited, so re-running replaces it instead of appending.
`--check` fails if any chapter disagrees with `docs/core-path.md`.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DOCS = ROOT / "docs"

START = "<!-- corepath:start -->"
END = "<!-- corepath:end -->"
EXPECTED_CHAPTERS = 51

CHAPTER = re.compile(r"^(\d+)\.\s\[([^\]]+)\]\((topics/[^)]+\.md)\)$", re.M)
BLOCK = re.compile(re.escape(START) + r".*?" + re.escape(END) + r"\n?", re.S)


def chapters() -> list[tuple[str, str]]:
    text = (DOCS / "core-path.md").read_text(encoding="utf-8")
    found = [(title, target) for _, title, target in CHAPTER.findall(text)]
    if len(found) != EXPECTED_CHAPTERS:
        raise SystemExit(
            f"ERROR: core-path.md lists {len(found)} chapters; expected {EXPECTED_CHAPTERS}"
        )
    return found


def strip_for(position: int, entries: list[tuple[str, str]]) -> str:
    total = len(entries)
    parts = [f"**Core Path {position + 1}/{total}**"]

    if position > 0:
        title, target = entries[position - 1]
        parts.append(f"[← {title}]({Path(target).name})")
    else:
        parts.append("[← The Core Path](../core-path.md)")

    if position + 1 < total:
        title, target = entries[position + 1]
        parts.append(f"[{title} →]({Path(target).name})")
    else:
        parts.append("[Choose a specialization →](../core-path.md#choose-a-specialization)")

    return f"{START}\n\n" + " · ".join(parts) + f"\n\n{END}\n"


def main() -> int:
    entries = chapters()
    check = "--check" in sys.argv
    stale: list[str] = []
    written = 0

    for position, (_, target) in enumerate(entries):
        path = DOCS / target
        text = path.read_text(encoding="utf-8")
        body = BLOCK.sub("", text).rstrip("\n")
        expected = body + "\n\n" + strip_for(position, entries)

        if text == expected:
            continue
        if check:
            stale.append(target)
        else:
            path.write_text(expected, encoding="utf-8")
            written += 1

    if check:
        for target in stale:
            print(f"  ERROR: {target} has a stale or missing Core Path strip")
        if not stale:
            print(f"  all {EXPECTED_CHAPTERS} Core Path strips match core-path.md")
        return 1 if stale else 0

    print(f"  Core Path strips written: {written} of {len(entries)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
