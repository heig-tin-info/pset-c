from __future__ import annotations

from pathlib import Path
import re

import yaml


ROOT = Path(__file__).resolve().parent
SERIES_DIR = ROOT / "series"


def _read_frontmatter(path: Path) -> dict:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        return {}
    end = text.find("\n---\n", 4)
    if end == -1:
        return {}
    data = yaml.safe_load(text[4:end]) or {}
    return data if isinstance(data, dict) else {}


def _sort_key(series_id: str) -> tuple[int, int | str]:
    if series_id.isdigit():
        return (0, int(series_id))
    match = re.match(r"^(\d+)-", series_id)
    if match:
        return (0, int(match.group(1)))
    return (1, series_id)


def build_series_entries() -> list[dict]:
    entries: list[dict] = []
    for path in sorted(SERIES_DIR.glob("series-*.md")):
        fm = _read_frontmatter(path)
        slug = path.stem
        series_id = slug.removeprefix("series-")
        entries.append(
            {
                "slug": slug,
                "id": series_id,
                "title": str(fm.get("title", slug)),
                "subtitle": str(fm.get("subtitle", "")),
                "tags": [str(x) for x in fm.get("tags", []) if str(x).strip()],
                "pset_pdf": f"pset-{series_id}.pdf",
                "solution_pdf": f"pset-{series_id}-solution.pdf",
                "source_md": f"{slug}.md",
            }
        )
    entries.sort(key=lambda e: _sort_key(e["id"]))
    return entries


AUTHOR = "HEIG-VD"
SITENAME = "Series"
SITEURL = ""

PATH = "pelican/content"
TIMEZONE = "Europe/Zurich"
DEFAULT_LANG = "fr"

THEME = "pelican/themes/pset"
DIRECT_TEMPLATES = ["index"]
TEMPLATE_PAGES = {}

ARTICLE_PATHS: list[str] = []
PAGE_PATHS: list[str] = []

FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

JINJA_GLOBALS = {
    "series_entries": build_series_entries(),
}
