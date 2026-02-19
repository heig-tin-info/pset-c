# pset-c

C exercise series (INFO1/INFO2), written in Markdown and rendered to PDF with TeXSmith and the `exam` template.

## Repository Layout

- `series/`: Markdown sources (`series-*.md`) with frontmatter config.
- `series/common.yml`: shared TeXSmith config.
- `assets/`: shared assets used by series.
- `build/`: local build output (`build/series/<id>/...`).
- `dist/`: static distribution folder (PDFs + site).
- `pelican/` + `pelicanconf.py`: static site generation for `dist/index.html`.

## Tooling

- `uv` for Python environment and dependency management.
- `texsmith` + `texsmith-template-exam` for Markdown -> LaTeX -> PDF.
- `pelican` for static index page generation.
- `make` for build orchestration.

## Prerequisites

- `uv`
- `make` (recommended)
- `tectonic` available in `PATH` (required by TeXSmith for PDF builds)

## Install Dependencies

```bash
make deps
```

Equivalent command:

```bash
uv sync --extra dev
```

## Build PDFs

Build everything (pset + solution for all series):

```bash
make all
```

Build one series (example `series-20`):

```bash
make series-20
```

Outputs:

- `build/series/<id>/pset/pset.pdf`
- `build/series/<id>/solution/solution.pdf`

## Build Distribution

```bash
make dist
```

This command:

- Builds all series.
- Copies PDFs to `dist/`.
- Copies source Markdown files (`series-*.md`) to `dist/`.
- Regenerates `dist/index.html` using Pelican.

## Cleanup

```bash
make clean      # remove build/
make mrproper   # clean + remove dist/*.pdf
```

## Codex Dev Mode for `template-exam`

Default behavior uses the pinned GitHub revision of `texsmith-template-exam` from `pyproject.toml`.

To work in debug mode (editable local checkout, useful for Codex iterations):

1. Clone `template-exam` next to this repository:

```bash
git clone git@github.com:yves-chevallier/template-exam.git ../template-exam
```

2. Enable editable override:

```bash
make deps-dev-template
```

This installs `../template-exam` in editable mode into this repo's `.venv`, so local changes are picked up immediately.

3. When finished, publish your changes in `template-exam`, then reset this repo to pinned dependency behavior:

```bash
make deps-reset-template
```

Tip: if your local checkout path differs, pass it explicitly:

```bash
make deps-dev-template TEMPLATE_EXAM_PATH=/path/to/template-exam
```

## Updating the `template-exam` Pin

After pushing changes to `template-exam`:

1. Update the `rev` under `[tool.uv.sources]` in `pyproject.toml`.
2. Run `uv lock`.
3. Commit `pyproject.toml` and `uv.lock` in this repository.
