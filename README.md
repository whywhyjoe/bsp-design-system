# BMO SharePoint Design System

A **buildless, CDN-free, self-hosted** component library for BMO apps and pages
embedded in **SharePoint Online**. Raw HTML/CSS/JS — no bundler, no npm build, no
external CDN at runtime. You consume it by copy-pasting markup against shared CSS
and wiring interactivity with minimal inline [Alpine.js](https://alpinejs.dev).

This folder is the complete, standalone system — everything needed to build with
it is here.

## Quick start

1. Link the library — tokens first, components second (or the one-tag bundle):
   ```html
   <link rel="stylesheet" href="colors_and_type.css">
   <link rel="stylesheet" href="components.css">
   <!-- or: <link rel="stylesheet" href="styles.css"> -->
   ```
2. Inline `fluent-basic-icons.svg` once in the `<body>` so icons resolve.
3. Write BEM markup. Copy live snippets from **`examples/components.html`**.
4. Need a whole page? Start from **`docs/PAGE-TEMPLATE.md`** — the smallest complete
   working page, with the four load-bearing pieces that fail silently if skipped.
5. Add Alpine (self-hosted) for interactivity, loaded `defer` after the markup.

**Minimum-dependency path:** the two CSS files + the inlined sprite render a fully
styled, fully iconned page with **zero JavaScript**. Alpine is only needed for
interactive behavior.

## The rules (in brief)
- **Tokens are the only source of values** — no raw hex, no off-ramp pixels. Use `var(--token)`.
- **One BEM vocabulary.** Compose with existing classes + modifiers (`btn btn--primary`); don't invent component classes or restyle inline.
- **Blue is interactive-only; BMO Red is logo-only** (errors use `--fg-danger`). White surfaces, subtle elevation.
- **Icons** use the name token `ic-fluent-{name}-24-regular` over `fluent-basic-icons.svg`, as no-JS `<use>` or `<fluent-icon>` (size via `.icon--12/16/20/24/28/48`), or via the first-party Fluent **icon font** for the full set with no sprite/JS (`aria-hidden` the `<i>`) — see `docs/TECHNICAL-REFERENCE.md` §6. When the **complete library** of Fluent icons is useful, use the SVG or Font options from the **`fluentui-system-icons`** companion repo (a **separate repo**, not part of this one — nothing here reads a path to it; it deploys live as the sibling top-level folder `fluent-icons/`). The library SVG filenames use the ic_fluent_{name}_{size}_style.svg pattern. Reference that repo's `fluent-font-library.json` for a full index and description of all icons and font codepoints.   
- **Interactivity is inline Alpine** — every binding inside an `x-data` root.

## What's here

**Use these (the library):**
| File or Folder | What |
|---|---|
| `colors_and_type.css` | Design tokens + base element styles + utilities (`.imgph .photo .lift .reveal`). Link first. |
| `components.css` | Every component as a token-built BEM class. Link second. |
| `styles.css` | One-tag bundle (`@import`s the two above in order). |
| `editorial.css` | **Editorial mode** — the opt-in warm content-page layer. Link *after* `components.css`, only on editorial pages; scope with `class="editorial"`. Built on the same tokens; never redefines `:root`. See [Editorial mode](#editorial-mode-additive-layer) below. |
| `fluent-basic-icons.svg` | Icon sprite — 48 Fluent symbols, ids `ic-fluent-{name}-24-regular`. Inline once per page. |
| `fluent-icon.js` | Optional `<fluent-icon>` custom element (sugar over the same sprite). |
| `abacus-icons/` | The canonical BMO consumer-brand (Abacus) icon set — 712 SVGs, `<icon>-<size>.svg` at 16/24/28/48. Browse: [`abacus-icons/index.html`](abacus-icons/index.html). Used **by URL, never via a sprite**: `<img class="icon icon--24" src="abacus-icons/add-24.svg" alt="">`. Baked hex, so they can't be tinted. See `docs/TECHNICAL-REFERENCE.md` §6 Form 4. |
| `fluentui-system-icons` (**separate repo**) | Optional full Fluent icon library with SVG and Font implementations--including all styles--and a JSON and HTML index. Not part of this repo, and nothing here resolves a path to it. In production it deploys as its own top-level folder, `fluent-icons/`, a sibling of `bsp-design/`. Use it under the same criteria as the icon docs describe. |

**Browse / copy from:**
| File | What |
|---|---|
| `index.html` | **The human index** — links every guide, example and reference, lists what each shipped file does, and maps the asset libraries. Repo-only; not deployed. |
| `examples/components.html` | Every component rendered live with copy-paste markup — the fastest path. |
| `examples/design-system-reference.html` | The visual / brand spec (color, type, spacing, states, do/don't). |
| `examples/example-advanced-ui.html` | A full composed page assembled from the system. |
| `examples/preview/` | Small single-purpose gallery cards (one token group or component each). |

**Read:**
| File | What |
|---|---|
| `examples/developer-guide.html` | In-browser onboarding — how the system fits together. |
| `docs/PAGE-TEMPLATE.md` | Start-here scaffold for a new page. |
| `docs/TECHNICAL-REFERENCE.md` | Developer reference — per-component snippets, tokens, classes, state contract, icons. |
| `docs/EDITORIAL-MODE.md` | The editorial-mode layer — when to use it, the 3-tier art system, component catalog, do/don't. |
| `context/` | Source material — BMO brand, SharePoint context, Fluent 2 guide. |

**AI agents:** see `CLAUDE.md` and `.github/copilot-instructions.md` (auto-loaded by
Claude Code and GitHub Copilot respectively).

## Editorial mode (additive layer)

Most of the system is **app mode** — dense, austere surfaces for getting work done.
**Editorial mode** is an opt-in layer for the other kind of page — learning catalogs,
resource hubs, awareness and program pages: warm, spacious, hero-led,
photography-forward. It's a *mode, not a fork* — same tokens, same BEM vocabulary, same
buildless delivery; it only relaxes the austerity dials, and only under a `.editorial`
scope. An app applet embedded inside an editorial page keeps its own austere styling.

Opt in with a third stylesheet after `components.css`, and scope the content:
```html
<link rel="stylesheet" href="colors_and_type.css">
<link rel="stylesheet" href="components.css">
<link rel="stylesheet" href="editorial.css">   <!-- only on editorial pages -->
…
<main class="editorial"> … editorial blocks … </main>
```

| File | What |
|---|---|
| `editorial.css` | The layer — `--ed-*` tokens on `.editorial`, SharePoint host chrome, hero brand-devices, editorial component blocks (showcase + flat "mesh" register). Never redefines `:root`. |
| `assets/bmo-bokeh-{a…e}.svg` | Official BMO bokeh artwork (blue gradient + translucent circles), five variants from busiest (`a`) to sparsest (`d`). `.hero--bokeh` defaults to `a`; add `.hero--bokeh-{a…e}` to choose. Chooser: `docs/EDITORIAL-MODE.md` §4. |
| `assets/BMO-logo_*.svg` · `BMO-roundel.svg` | The real BMO logos (SVG + PNG) and the M-bar roundel used in the suite bar. |
| `spot-illustrations/` | The canonical BMO line-drawing spot-illustration library — 481 SVGs, plus `catalog.json` and `README.md`. Browse: [`spot-illustrations/index.html`](spot-illustrations/index.html). |
| `docs/EDITORIAL-MODE.md` | The written spec: registers, 3-tier art system, hero devices, component catalog, do/don't. |
| `examples/editorial-design-guide.html` | Rendered visual guide — showcase-vs-mesh, hero chooser, rules, do/don't. |
| `examples/editorial-components.html` | Every editorial block live with copy-paste markup. |
| `examples/editorial-learning-catalog.html` · `examples/editorial-resource-hub.html` | Proof pages — the register in-token, framed in SharePoint chrome, wired with inline Alpine. |

**Motion note:** editorial reuses the same motion tokens as app mode, but `.reveal` under
`.editorial` is a self-sufficient CSS animation (plays on load, no script) rather than the
app-mode transition that needs a scroll observer to add `.is-in`. The two coexist by scope
and specificity — see `docs/EDITORIAL-MODE.md` and the editorial design guide.


## Versioning & deployment

`VERSION` at the repo root is the single source of truth. `tools/Set-Version.ps1`
propagates it into the two places a deployed copy can be identified from with no
git and no build:

- a `/*! BMO SharePoint Design System · v1.0.0 · <file> */` banner on line 1 of
  each shipped CSS/JS file — visible the moment you open the file in SiteAssets;
- `--ds-version` in `colors_and_type.css`'s `:root` block, which makes the live
  page answer for itself from devtools:

  ```js
  getComputedStyle(document.documentElement).getPropertyValue('--ds-version')
  ```

That second one is the useful one in practice: it reports which copy the page is
*actually* loading, which is the real question when several versioned folders
exist and you're unsure what a page points at. It's declared inside the existing
single `:root` block, so it doesn't redefine `:root`.

```bash
pwsh ./tools/Set-Version.ps1 1.1.0
```

Review the diff, commit, and tag (`git tag v1.1.0`). Deployment is then a **pure
copy** — nothing is generated or rewritten — so a deployed folder is
byte-identical to the tagged source and can be diffed against it.

```bash
pwsh ./tools/Deploy-BspDesign.ps1 -Destination \\host\sites\Brand\SiteAssets -WhatIf
```

Point `-Destination` at the **container** — the script creates the deployed folder
inside it:

```
<Destination>/bsp-design/           default
<Destination>/bsp-design/1.0.0/     with -Versioned
```

If `-Destination` already ends in `bsp-design` it's used as-is rather than nesting
a second one. `-FolderName` overrides the name.

Drop `-WhatIf` to run. The script ships the CSS layers, both sprites, `fluent-icon.js`,
everything in `assets/` (logos SVG+PNG, the five bokeh variants SVG+JPG), and both
asset libraries' SVGs — 1,220 files, 5.8 MB. It leaves behind `examples/`, `docs/`,
`context/`, `tools/`, `index.html`, every `.md`, and each library's `catalog.json` /
`index.html` / `README.md` (authoring aids, not runtime). It writes one generated
file, `DEPLOY-INFO.txt`, recording version, UTC timestamp, commit, and file count.

It refuses to run on a dirty working tree (`-AllowDirty` to override) or when
`VERSION` and the stamped `--ds-version` disagree. `-Clean` refuses on a
non-empty folder lacking a `DEPLOY-INFO.txt`, so a mistyped path can't wipe an
unrelated directory. `-SkipIllustrations` / `-SkipAbacusIcons` trim the 8 MB of
asset libraries when a target doesn't need them.

**Alpine is not in this repo and is not deployed.** Place your self-hosted
`alpine.min.js` in the destination yourself; the script warns when it's absent.

**Versioned folders + cache busting.** Deploying to `…/ds/1.1.0/` lets consumers
opt into a new version by changing one link, and lets two versions coexist during
a migration — which matters because every internal reference in the system is
relative, so the tree relocates cleanly. Appending `?v=1.1.0` to the stylesheet
links also sidesteps SharePoint's aggressive SiteAssets caching.

## SharePoint / buildless notes
- Self-host every file (including Alpine) -  bmo.sharepoint.com counts as self-hosting; no CDN external to BMO or Local in production.
- The SharePoint shell already loads Segoe UI; no `@font-face` needed.
- One light theme, tuned for the shell. No dark mode.
