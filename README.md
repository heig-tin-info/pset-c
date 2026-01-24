# pset-c

Séries d'exercices C (INFO1/INFO2) converties en Markdown et rendues en PDF avec TeXSmith et le template **exam**.

## Contenu

- Sources Markdown dans `series/<id>/` (ex: `series/07/series-07.md`).
- Configuration par série dans `series/<id>/config.yml`.
- PDFs générés dans `build/series/<id>/`.
- Site statique de téléchargement dans `dist/` (GitHub Pages).

## Technologies

- **TeXSmith** (renderer Markdown → LaTeX → PDF)
- **texsmith-template-exam** (template d'examen)
- **Tectonic** (compilation LaTeX via TeXSmith)
- **uv** pour l'environnement Python et les dépendances
- **Makefile** pour automatiser les builds
- **Tailwind CSS (CDN)** pour la page `dist/index.html`

## Prérequis

- `uv` installé
- (optionnel) `make`

## Installation

```bash
uv sync
```

## Construire les PDFs

### Tout construire (pset + solution)

```bash
make all
```

### Construire une série précise

```bash
make -C series/07 pset
make -C series/07 solution
```

Les PDFs sont générés dans `build/series/<id>/pset/` et `build/series/<id>/solution/`.

## Générer le dossier de distribution (GitHub Pages)

```bash
make dist
```

Cela copie tous les PDFs dans `dist/` et utilise `dist/index.html` comme page d'accueil.

## Mettre à jour l'index HTML

`dist/index.html` est un fichier statique listant toutes les séries avec liens de téléchargement.
Si vous modifiez les titres ou ajoutez de nouvelles séries, régénérez l'index via le script interne (ou demandez à Codex de le faire).

## Structure du dépôt

```
series/           # sources Markdown + config par série
assets/           # images utilisées dans les séries
build/            # PDFs générés (local)
dist/             # site statique (GitHub Pages)
```
