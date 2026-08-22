#!/usr/bin/env python3
"""One-shot migration from the flat BLOCKCHAIN/ working tree into this repository.

Kept in the repository as an audit record of how paths and links were rewritten.

It does three things and refuses to guess:

1. builds a bijective old-path -> new-path map for every Markdown file;
2. parses every Markdown link outside fenced and inline code, resolves its
   target against the *old* location, and rewrites it relative to the *new*
   location, preserving any ``#fragment``;
3. asserts that the number of links in equals the number of links out and that
   every target resolved.

Usage: migrate.py SOURCE_DIR DEST_DIR
"""

from __future__ import annotations

import re
import shutil
import sys
from collections import Counter
from pathlib import Path

LINK = re.compile(r"\[[^\]]*\]\(([^)\s]+)\)")
FENCE = re.compile(r"^```.*?^```", re.S | re.M)
INLINE_CODE = re.compile(r"`[^`\n]*`")

# Paths inside lab shell commands that move with the projects.
LAB_CD = re.compile(r"\bcd BLOCKCHAIN/Labs/projects/")

PROJECT_SOURCE_SUFFIXES = {".rs", ".sol", ".toml", ".lock"}
PROJECT_SKIP_DIRS = {"target", "out", "cache", "broadcast"}


def slugify(stem: str) -> str:
    """`98_ABI_and_Function_Selector` -> `abi-and-function-selector`."""
    return stem.lower().replace("_", "-")


def numbered_name(stem: str, width: int) -> str:
    """`98_ABI_and_Function_Selector` -> `098-abi-and-function-selector`.

    Splits on the first underscore only, so `72_51_Percent_Attack` keeps its
    `51` inside the title rather than losing it to the number.
    """
    number, _, rest = stem.partition("_")
    return f"{int(number):0{width}d}-{slugify(rest)}"


def build_file_map(src: Path) -> dict[Path, Path]:
    """Map every source Markdown file to its destination, relative to each root."""
    mapping: dict[Path, Path] = {
        Path("README.md"): Path("docs/index.md"),
        Path("Core_Path.md"): Path("docs/core-path.md"),
        Path("EDITORIAL.md"): Path("docs/editorial.md"),
        Path("Answers/Core_Path.md"): Path("docs/answers/core-path.md"),
        Path("Labs/README.md"): Path("docs/labs/index.md"),
    }

    for path in sorted((src / "Atom").glob("*.md")):
        mapping[Path("Atom") / path.name] = Path("docs/topics") / (
            numbered_name(path.stem, 3) + ".md"
        )

    for path in sorted((src / "Deep_Dives").glob("*.md")):
        mapping[Path("Deep_Dives") / path.name] = Path("docs/deep-dives") / (
            slugify(path.stem) + ".md"
        )

    for path in sorted((src / "Labs").glob("*.md")):
        if path.name == "README.md":
            continue
        mapping[Path("Labs") / path.name] = Path("docs/labs") / (
            numbered_name(path.stem, 2) + ".md"
        )

    return mapping


def code_spans(text: str) -> list[tuple[int, int]]:
    """Character ranges that a link rewriter must not touch."""
    return [(m.start(), m.end()) for m in FENCE.finditer(text)] + [
        (m.start(), m.end()) for m in INLINE_CODE.finditer(text)
    ]


def rewrite_links(
    text: str,
    old_source: Path,
    new_source: Path,
    file_map: dict[Path, Path],
    stats: Counter,
    problems: list[str],
) -> str:
    spans = code_spans(text)
    out: list[str] = []
    cursor = 0

    for match in LINK.finditer(text):
        target = match.group(1)
        start = match.start(1)

        if any(a <= match.start() < b for a, b in spans):
            stats["skipped_in_code"] += 1
            continue
        if re.match(r"^(https?:|mailto:|#)", target):
            stats["external_or_anchor"] += 1
            continue

        stats["local"] += 1
        path_part, _, fragment = target.partition("#")

        resolved = (old_source.parent / path_part).as_posix()
        resolved = Path(re.sub(r"[^/]+/\.\./", "", resolved))
        if resolved not in file_map:
            problems.append(f"{old_source}: unresolved link target {target!r}")
            continue

        new_target = file_map[resolved]
        rewritten = relative_path(new_source, new_target)
        if fragment:
            rewritten += "#" + fragment

        out.append(text[cursor:start])
        out.append(rewritten)
        cursor = match.end(1)
        stats["rewritten"] += 1

    out.append(text[cursor:])
    return "".join(out)


def relative_path(source: Path, target: Path) -> str:
    """POSIX relative path from the directory holding `source` to `target`."""
    source_parts = source.parent.parts
    target_parts = target.parts
    common = 0
    while (
        common < len(source_parts)
        and common < len(target_parts) - 1
        and source_parts[common] == target_parts[common]
    ):
        common += 1
    ups = [".."] * (len(source_parts) - common)
    return "/".join(ups + list(target_parts[common:]))


def copy_projects(src: Path, dst: Path) -> int:
    copied = 0
    for path in sorted((src / "Labs" / "projects").rglob("*")):
        if not path.is_file():
            continue
        if any(part in PROJECT_SKIP_DIRS for part in path.parts):
            continue
        if path.suffix not in PROJECT_SOURCE_SUFFIXES and path.name != ".gitignore":
            continue
        relative = path.relative_to(src / "Labs" / "projects")
        destination = dst / "projects" / relative
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, destination)
        copied += 1
    return copied


def main() -> int:
    src, dst = Path(sys.argv[1]).resolve(), Path(sys.argv[2]).resolve()
    file_map = build_file_map(src)

    expected = len(list(src.rglob("*.md")))
    if len(file_map) != expected:
        print(f"ERROR: mapped {len(file_map)} files, found {expected}")
        return 1

    stats: Counter = Counter()
    problems: list[str] = []

    for old_relative, new_relative in sorted(file_map.items()):
        text = (src / old_relative).read_text(encoding="utf-8")
        text = rewrite_links(text, old_relative, new_relative, file_map, stats, problems)
        text = LAB_CD.sub("cd projects/", text)
        destination = dst / new_relative
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(text, encoding="utf-8")

    copied = copy_projects(src, dst)

    print(f"  markdown files migrated : {len(file_map)}")
    print(f"  project source files    : {copied}")
    print(f"  local links found       : {stats['local']}")
    print(f"  local links rewritten   : {stats['rewritten']}")
    print(f"  links left inside code  : {stats['skipped_in_code']}")
    print(f"  external / bare anchors : {stats['external_or_anchor']}")

    if stats["local"] != stats["rewritten"]:
        problems.append(
            f"link count mismatch: {stats['local']} in, {stats['rewritten']} out"
        )
    for problem in problems:
        print(f"  ERROR: {problem}")
    return 1 if problems else 0


if __name__ == "__main__":
    raise SystemExit(main())
