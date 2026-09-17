# Problem sets for Info1/Info2 C course

C exercise series (INFO1/INFO2), written in Markdown and rendered to PDF with TeXSmith and the `exam` template.

Two rendering backends are available from the same Markdown sources: **Typst** (default) and **LaTeX**.

## Repository Layout

- `series/`: Markdown sources (`series-*.md`) with frontmatter config.
- `series/common.yml`: shared TeXSmith config.
- `assets/`: shared assets used by series.
- `pelican/` + `pelicanconf.py`: static site generation for `dist/index.html`.

Temporary build outputs:

- `build/`: local build output (`build/series/<group>/<series>/<format>/<variant>/`).
- `dist/`: static distribution folder (PDFs + site).

## Tooling

- `uv` for Python environment and dependency management.
- `texsmith[typst]` + `texsmith-exam` for Markdown -> LaTeX/Typst -> PDF.
- `pelican` for static index page generation.
- `make` for build orchestration.

## Prerequisites

- `uv`
- `make` (recommended)

## Install Dependencies

```bash
make deps
```

Equivalent command:

```bash
uv sync --extra dev
```

### Optional: draw.io diagrams

`series-21` embeds a `.drawio` diagram, which TeXSmith converts with a headless
Chromium. Install it once:

```bash
PLAYWRIGHT_BROWSERS_PATH=~/.cache/texsmith/playwright/browsers \
  uv run --no-sync playwright install --only-shell chromium
```

If your distribution is not officially supported by Playwright, add
`PLAYWRIGHT_HOST_PLATFORM_OVERRIDE=ubuntu24.04-x64` to download a fallback
build. Without this browser the diagram is skipped with a warning; everything
else still builds.

## Build PDFs

Build everything (pset + light + solution for all series) with the default
backend, Typst:

```bash
make all
```

Choose the backend explicitly:

| Target | Result |
| --- | --- |
| `make typst` | all series via Typst (`build/series/<group>/<series>/typst/...`) |
| `make latex` | all series via LaTeX/Tectonic (`build/series/<group>/<series>/latex/...`) |

Any target also accepts `FORMAT=latex` or `FORMAT=typst`:

```bash
make solution FORMAT=latex
```

Build one series, by full name or short name:

```bash
make info2/series-20
make series-20            # alias
make pset-series-20       # a single variant
make light-series-20
make solution-series-20
```

Aggregate variant targets: `make pset`, `make light`, `make solution`.

Outputs, for `FORMAT=typst`:

- `build/series/<group>/<series>/typst/pset/pset.pdf`
- `build/series/<group>/<series>/typst/light/light.pdf`
- `build/series/<group>/<series>/typst/solution/solution.pdf`

Copies with friendly names land next to them in
`build/series/<group>/<series>/`.

List available series:

```bash
make list
```

Check that the C++ assets of every series still compile:

```bash
make check-code
```

## Build Distribution

```bash
make dist
```

This command:

- Builds all series (with `FORMAT`, Typst by default).
- Copies PDFs to `dist/`.
- Copies source Markdown files (`series-*.md`) to `dist/`.
- Regenerates `dist/index.html` using Pelican.

## Cleanup

```bash
make clean      # remove build/
make mrproper   # clean + remove dist/*.pdf
```

## Development for `texsmith-exam`

Default behavior uses the released `texsmith-exam` from PyPI, pinned in
`pyproject.toml` and `uv.lock`.

To work in debug mode (editable local checkout, useful for Agent work):

1. Clone `texsmith-exam` next to this repository:

```bash
git clone git@github.com:yves-chevallier/texsmith-exam.git ../texsmith-exam
```

2. Enable editable override:

```bash
make deps-dev-template
```

This installs `../texsmith-exam` in editable mode into this repo's `.venv`, so
local changes are picked up immediately.

3. When finished, publish your changes in `texsmith-exam`, then reset this repo
to pinned dependency behavior:

```bash
make deps-reset-template
```

Tip: if your local checkout path differs, pass it explicitly:

```bash
make deps-dev-template TEMPLATE_EXAM_PATH=/path/to/texsmith-exam
```

After releasing a new `texsmith-exam`:

1. Bump the specifier in `pyproject.toml` if needed.
2. Run `uv lock --upgrade-package texsmith-exam`.
3. Commit `pyproject.toml` and `uv.lock` in this repository.
