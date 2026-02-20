from __future__ import annotations

import re
import sys
from pathlib import Path


PAGE_BREAK_RE = re.compile(r"^\s*---\s*$")
PAGE_BREAK_FORCE_RE = re.compile(r"^\s*---\s*\{\s*force\s*\}\s*$", re.IGNORECASE)
SOLUTION_DIRECTIVE_RE = re.compile(r"^(\s*)!!!\s+solution\b.*$", re.IGNORECASE)
HEADING_RE = re.compile(r"^(#{1,6})\s+(.*)$")
WIDTH_FILLIN_RE = re.compile(r"\[(.*?)\]\{[^}]*\bwidth\s*=\s*[^}]+\}")


def _split_frontmatter(text: str) -> tuple[str, str]:
    if not text.startswith("---\n"):
        return "", text
    end = text.find("\n---\n", 4)
    if end == -1:
        return "", text
    frontmatter = text[: end + 5]
    body = text[end + 5 :]
    return frontmatter, body


def _ensure_compact_frontmatter(frontmatter: str) -> str:
    if not frontmatter:
        return "---\ncompact: true\n---\n"
    if re.search(r"(?m)^compact\s*:\s*", frontmatter):
        return frontmatter
    lines = frontmatter.splitlines(keepends=True)
    if len(lines) >= 2 and lines[-1].strip() == "---":
        lines.insert(-1, "compact: true\n")
        return "".join(lines)
    return frontmatter


def _is_mcq_heading(title: str) -> bool:
    lower = title.lower()
    return "choix multiples" in lower or "qcm" in lower or "multiple choice" in lower


def transform_light_body(body: str) -> str:
    out: list[str] = []
    in_mcq_section = False

    for line in body.splitlines(keepends=True):
        if PAGE_BREAK_FORCE_RE.match(line):
            out.append("---\n")
            continue
        if PAGE_BREAK_RE.match(line):
            continue

        heading = HEADING_RE.match(line.rstrip("\n"))
        if heading:
            in_mcq_section = _is_mcq_heading(heading.group(2).strip())

        solution = SOLUTION_DIRECTIVE_RE.match(line.rstrip("\n"))
        if solution:
            out.append(f"{solution.group(1)}!!! solution\n")
            continue

        if in_mcq_section:
            line = WIDTH_FILLIN_RE.sub(r"\1", line)

        out.append(line)

    return "".join(out)


def main() -> int:
    if len(sys.argv) != 3:
        print("Usage: prepare_light.py <input.md> <output.md>", file=sys.stderr)
        return 2

    src = Path(sys.argv[1])
    dst = Path(sys.argv[2])

    text = src.read_text(encoding="utf-8")
    frontmatter, body = _split_frontmatter(text)
    frontmatter = _ensure_compact_frontmatter(frontmatter)
    compact_body = transform_light_body(body)

    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(frontmatter + compact_body, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
