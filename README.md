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
3. Write BEM markup. Copy live snippets from **`examples/Components.html`**.
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
- **Icons** use the name token `ic-fluent-{name}-24-regular` over `bmo-icons.svg`, as no-JS `<use>` or `<fluent-icon>` (size via `.icon--12/16/20/24`), or via the first-party Fluent **icon font** for the full set with no sprite/JS (`aria-hidden` the `<i>`) — see `docs/TECHNICAL-REFERENCE.md` §6. When the **complete library** of Fluent icons is useful, use the SVG or Font options from the **`fluent-system-icons`** companion repo (a **separate repo**, not part of this one — its actual path is specified in config when developing a real project). The library SVG filenames use the ic_fluent_{name}_{size}_style.svg pattern. Reference that repo's `fluent-font-library.json` for a full index and description of all icons and font codepoints.   
- **Interactivity is inline Alpine** — every binding inside an `x-data` root.

## What's here

**Use these (the library):**
| File or Folder | What |
|---|---|
| `colors_and_type.css` | Design tokens + base element styles + utilities (`.imgph .photo .lift .reveal`). Link first. |
| `components.css` | Every component as a token-built BEM class. Link second. |
| `styles.css` | One-tag bundle (`@import`s the two above in order). |
| `bmo-icons.svg` | Icon sprite — 37 Fluent symbols, ids `ic-fluent-{name}-24-regular`. Inline once per page. |
| `fluent-icon.js` | Optional `<fluent-icon>` custom element (sugar over the same sprite). |
| `fluent-system-icons` (**separate repo**) | Optional full Fluent icon library with SVG and Font implementations--including all styles--and a JSON and HTML index. Not part of this repo; its actual path is specified in config when developing a real project. Use it under the same criteria as the icon docs describe. |

**Browse / copy from:**
| File | What |
|---|---|
| `examples/Components.html` | Every component rendered live with copy-paste markup — the fastest path. |
| `examples/Design System Reference.html` | The visual / brand spec (color, type, spacing, states, do/don't). |
| `examples/advanced-ui-example.html` | A full composed page assembled from the system. |
| `examples/preview/` | Small single-purpose gallery cards (one token group or component each). |

**Read:**
| File | What |
|---|---|
| `examples/Developer Guide.html` | In-browser onboarding — how the system fits together. |
| `docs/PAGE-TEMPLATE.md` | Start-here scaffold for a new page. |
| `docs/TECHNICAL-REFERENCE.md` | Developer reference — per-component snippets, tokens, classes, state contract, icons. |
| `project-notes/CHANGELOG.md` | What changed, the retired→canonical mappings, and why. |
| `context/` | Source material — BMO brand, SharePoint context, Fluent 2 guide. |

**AI agents:** see `CLAUDE.md` and `.github/copilot-instructions.md` (auto-loaded by
Claude Code and GitHub Copilot respectively).


## SharePoint / buildless notes
- Self-host every file (including Alpine) -  bmo.sharepoint.com counts as self-hosting; no CDN external to BMO or Local in production.
- The SharePoint shell already loads Segoe UI; no `@font-face` needed.
- One light theme, tuned for the shell. No dark mode.
