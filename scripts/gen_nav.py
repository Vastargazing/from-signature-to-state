#!/usr/bin/env python3
"""Generate the MkDocs `nav` block from the knowledge map in `docs/index.md`.

The map is the single source of truth for how the 274 reference notes are
grouped and ordered. Keeping `nav` derived from it means a note cannot exist in
one place and be classified in another.

`--check` regenerates the block and fails if `mkdocs.yml` is out of date, which
is what CI runs.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DOCS = ROOT / "docs"
CONFIG = ROOT / "mkdocs.yml"

START = "# nav:generated:start"
END = "# nav:generated:end"

SECTION = re.compile(r"^## ([IVX]+\.\s.+)$", re.M)
ENTRY = re.compile(r"^(\d+)\.\s(?:★\s|▸\s)?\[([^\]]+)\]\((topics/[^)]+\.md)\)$", re.M)
H1 = re.compile(r"^#\s+(.+)$", re.M)


def yaml_scalar(value: str) -> str:
    return "'" + value.replace("'", "''") + "'"


def title_of(path: Path) -> str:
    match = H1.search(path.read_text(encoding="utf-8"))
    if not match:
        raise SystemExit(f"ERROR: {path} has no H1 title")
    return match.group(1).strip()


def knowledge_base() -> list[tuple[str, list[tuple[str, str]]]]:
    text = (DOCS / "index.md").read_text(encoding="utf-8")
    sections = list(SECTION.finditer(text))
    if not sections:
        raise SystemExit("ERROR: no roman-numeral sections found in docs/index.md")

    grouped: list[tuple[str, list[tuple[str, str]]]] = []
    for index, section in enumerate(sections):
        end = sections[index + 1].start() if index + 1 < len(sections) else len(text)
        body = text[section.end() : end]
        entries = [
            (f"{number} {title}", target)
            for number, title, target in ENTRY.findall(body)
        ]
        grouped.append((section.group(1).strip(), entries))
    return grouped


def build_nav() -> str:
    lines = [START, "nav:", "  - Home: index.md", "  - Start Here:"]
    lines.append("      - The Core Path: core-path.md")
    first = DOCS / "topics" / "000-one-transaction.md"
    lines.append(f"      - {yaml_scalar(title_of(first))}: topics/000-one-transaction.md")

    lines.append("  - Knowledge Base:")
    total = 0
    for section, entries in knowledge_base():
        lines.append(f"      - {yaml_scalar(section)}:")
        for label, target in entries:
            lines.append(f"          - {yaml_scalar(label)}: {target}")
            total += 1
    if total != 274:
        raise SystemExit(f"ERROR: knowledge map yielded {total} entries; expected 274")

    lines.append("  - Deep Dives:")
    for path in sorted((DOCS / "deep-dives").glob("*.md")):
        lines.append(f"      - {yaml_scalar(title_of(path))}: deep-dives/{path.name}")

    lines.append("  - Labs:")
    lines.append("      - Overview: labs/index.md")
    for path in sorted((DOCS / "labs").glob("*.md")):
        if path.name == "index.md":
            continue
        lines.append(f"      - {yaml_scalar(title_of(path))}: labs/{path.name}")

    lines.append("  - Answer Key: answers/core-path.md")
    lines.append("  - Editorial Standard: editorial.md")
    lines.append(END)
    return "\n".join(lines) + "\n"


def main() -> int:
    nav = build_nav()
    config = CONFIG.read_text(encoding="utf-8")

    if START not in config or END not in config:
        raise SystemExit(f"ERROR: {CONFIG.name} has no {START} / {END} markers")

    pattern = re.compile(re.escape(START) + r".*?" + re.escape(END) + r"\n", re.S)
    updated = pattern.sub(nav, config)

    if "--check" in sys.argv:
        if updated != config:
            print("ERROR: mkdocs.yml nav is out of date; run scripts/gen_nav.py")
            return 1
        print("  nav is in sync with docs/index.md")
        return 0

    CONFIG.write_text(updated, encoding="utf-8")
    print(f"  nav written: {nav.count(chr(10))} lines")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
