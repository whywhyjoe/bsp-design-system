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
2. Inline `bmo-icons.svg` once in the `<body>` so icons resolve.
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
- **Icons** use the name token `ic-fluent-{name}-24-regular` over `bmo-icons.svg`, as no-JS `<use>` or `<fluent-icon>` (size via `.icon--12/16/20/24`), or via the first-party Fluent **icon font** for the full set with no sprite/JS (`aria-hidden` the `<i>`) — see `docs/TECHNICAL-REFERENCE.md` §6. When the **complete library** of Fluent icons is useful, use the SVG or Font options from the **`fluentui-system-icons`** companion repo (a **separate repo**, not part of this one — its actual path is specified in config when developing a real project). The library SVG filenames use the ic_fluent_{name}_{size}_style.svg pattern. Reference that repo's `fluent-font-library.json` for a full index and description of all icons and font codepoints.   
- **Interactivity is inline Alpine** — every binding inside an `x-data` root.

## What's here

**Use these (the library):**
| File or Folder | What |
|---|---|
| `colors_and_type.css` | Design tokens + base element styles + utilities (`.imgph .photo .lift .reveal`). Link first. |
| `components.css` | Every component as a token-built BEM class. Link second. |
| `styles.css` | One-tag bundle (`@import`s the two above in order). |
| `editorial.css` | **Editorial mode** — the opt-in warm content-page layer. Link *after* `components.css`, only on editorial pages; scope with `class="editorial"`. Built on the same tokens; never redefines `:root`. See [Editorial mode](#editorial-mode-additive-layer) below. |
| `bmo-icons.svg` | Icon sprite — 48 Fluent symbols, ids `ic-fluent-{name}-24-regular`. Inline once per page. |
| `fluent-icon.js` | Optional `<fluent-icon>` custom element (sugar over the same sprite). |
| `fluentui-system-icons` (**separate repo**) | Optional full Fluent icon library with SVG and Font implementations--including all styles--and a JSON and HTML index. Not part of this repo; its actual path is specified in config when developing a real project. Use it under the same criteria as the icon docs describe. |

**Browse / copy from:**
| File | What |
|---|---|
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
| `bmo-content-icons.svg` | Corporate **content line-icon** sprite (`bmo-ic-*`, via `.c-icon`) for content labeling — distinct from the functional `bmo-icons.svg`. Placeholder for the licensed "BMO Design Icons" set. |
| `bokeh.svg` | Spec-compliant bokeh background artwork (blue gradient + round translucent circles). |
| `illustrations/` | Spot illustrations used by the examples (a subset of the 154-SVG BMO line-drawing library). |
| `docs/EDITORIAL-MODE.md` | The written spec: registers, 3-tier art system, hero devices, component catalog, do/don't. |
| `examples/editorial-design-guide.html` | Rendered visual guide — showcase-vs-mesh, hero chooser, rules, do/don't. |
| `examples/editorial-components.html` | Every editorial block live with copy-paste markup. |
| `examples/editorial-learning-catalog.html` · `examples/editorial-resource-hub.html` | Proof pages — the register in-token, framed in SharePoint chrome, wired with inline Alpine. |

**Motion note:** editorial reuses the same motion tokens as app mode, but `.reveal` under
`.editorial` is a self-sufficient CSS animation (plays on load, no script) rather than the
app-mode transition that needs a scroll observer to add `.is-in`. The two coexist by scope
and specificity — see `docs/EDITORIAL-MODE.md` and the editorial design guide.


## SharePoint / buildless notes
- Self-host every file (including Alpine) -  bmo.sharepoint.com counts as self-hosting; no CDN external to BMO or Local in production.
- The SharePoint shell already loads Segoe UI; no `@font-face` needed.
- One light theme, tuned for the shell. No dark mode.
