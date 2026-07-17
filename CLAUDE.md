# BMO SharePoint Design System — agent guide (CLAUDE.md)

This folder **is** the design system. It's a buildless, CDN-free, self-hosted
HTML/CSS/JS component library that runs inside SharePoint Online. You'll either
build new pages/apps **on top of it**, or extend the system itself.

**Start a new page from [`docs/PAGE-TEMPLATE.md`](docs/PAGE-TEMPLATE.md)** — the smallest
complete working page (correct CSS link order, inlined icon sprite, an `x-data`
root, sample components, deferred Alpine). Copy it and build outward; don't
hand-roll a scaffold.

**Fuller rule set:** [`.github/copilot-instructions.md`](.github/copilot-instructions.md)
(agent rules, ✅/❌ examples) and [`docs/TECHNICAL-REFERENCE.md`](docs/TECHNICAL-REFERENCE.md)
(per-component snippets, token/class reference, state-contract table, icon system).
Read those before non-trivial work.

## Non-negotiables (break these and you've broken the system)
- **Buildless, CDN-free, self-hosted — this constrains the shipped artifact,
  not the dev machine.** The deployed page can never require a build step,
  bundler, or ES `import` (SharePoint can't build or run Node — what you author
  is what runs), and no external CDN at runtime in production: every runtime
  dependency self-hosted in SiteAssets, including Alpine. Local dev tooling
  (`npm install`, Node, Python, servers, linters) is fair game *as tooling*, and
  a CDN tag is fine during local dev — it just gets downloaded and self-hosted
  before shipping, and nothing the artifact needs may depend on a build.
- **One BEM vocabulary on shared tokens.** Components are BEM classes
  (`block--modifier`) built from CSS custom properties. Compose with existing
  classes + modifiers; **never invent component classes or inline-style values a
  class/token already covers.** No raw hex, no off-ramp px. Never redefine `:root`.
- **Hand-rolled Fluent 2 + BMO — not a third-party UI kit.** Build from these
  classes; don't pull in Web Awesome, Fluent React, Material, or any component/icon
  library.
- **Interactivity = minimal inline Alpine** against the documented state contract
  (`x-data` root; `x-model`/`:class`/`x-on` drive `.is-active`, `:checked`,
  `[aria-selected]`, `[aria-invalid]`). Every binding must live inside an `x-data`
  ancestor — a bound control outside one renders but does nothing and throws no
  error (the #1 first-page bug). There is **no `bmo-behaviors.js` / `Alpine.data()`
  factory layer** — don't scaffold one for trivial controls.
- **Icons:** durable contract is the name token `ic-fluent-{name}-24-regular`.
  Two equivalent forms over the canonical `bmo-icons.svg` sprite — no-JS
  `<svg class="icon icon--16"><use href="#ic-fluent-home-24-regular"/></svg>` and
  the optional `<fluent-icon name="home-24-regular">`. Inline the whole sprite once
  per page; size via `.icon--N`, never in the name; a name with no symbol renders
  blank — add the symbol, don't invent a glyph. A **third** delivery exists: the
  first-party Fluent **icon font** (self-hosted `@font-face`; `<i class="icon-ic_fluent_home_24_regular" aria-hidden>`)
  — the full set, no sprite, no JS; `aria-hidden` the `<i>` and label the parent,
  size via `font-size`. The **complete** Fluent library (per-icon SVGs, the font
  builds, and the `fluent-font-library.{json,html}` index) lives in the separate
  **`fluentui-system-icons`** repo — not in this one; use it under the same criteria,
  with its actual path specified in config when developing a real project.
  See `docs/TECHNICAL-REFERENCE.md` §6.

## File map
**The library (link these):**
- `colors_and_type.css` — tokens (`:root`, defined once) + base element styles + utilities (`.imgph .photo .lift .reveal`). Link first.
- `components.css` — every component as a BEM class, built from tokens. Link second.
- `styles.css` — one-tag bundle: `@import`s the two above in order.

**Icons:** `bmo-icons.svg` (37-symbol sprite, `ic-fluent-*`, the curated default) · `fluent-icon.js` (optional `<fluent-icon>` element — authoring sugar over the sprite). For icons beyond the 37, the full library (all SVGs, fonts, index) is the separate `fluentui-system-icons` repo (path set in project config): copy a real SVG into the sprite for a few extras, or self-host the icon font for many.

**Showcases (read for real markup; they consume the library, don't restyle):**
- `examples/Components.html` — every component live + copy-paste snippets (fastest path).
- `examples/Design System Reference.html` — the visual/brand spec.
- `examples/advanced-ui-example.html` — a full composed page.
- `examples/Developer Guide.html` — in-browser onboarding guide (doc-chrome).

**Docs:** `docs/PAGE-TEMPLATE.md` (start here) · `docs/TECHNICAL-REFERENCE.md` (deep reference) · `.github/copilot-instructions.md` (agent rules) · `project-notes/CHANGELOG.md` (what changed + retired→canonical map) · `context/` (BMO brand, SharePoint, Fluent 2 source material).

**Ignore (tooling/artifacts, not part of the system):** `project-notes/_adherence.oxlintrc.json`, `.claude/`. `assets/` holds placeholder logo/lockup + a retired legacy `icons.svg` (unreferenced — use `bmo-icons.svg`).

## Verifying a change
These pages are self-contained: same-document `#id` sprite refs resolve when a file
is opened directly, so opening in a browser works with no server. To serve (for
screenshots), any static server works (e.g. `npx vite` / `python -m http.server`)
— note Node/Python may only be on the PowerShell PATH on Windows. After edits,
sanity-check: every `<use href="#…">` resolves to an inlined `<symbol>`, no
retired vocabulary remains, and pages link the canonical CSS.

## Retired vocabularies — never reintroduce
`.btn primary` / `.btn.primary` → `.btn.btn--primary`; `size-lg` → `.btn--lg`;
`.is-focus`/`.is-disabled` → native `:focus-visible`/`:disabled`;
`.cc`/`.cc-b`/`.cc-ic` → `.card`/`.card__content`/`.card__icon-tile`;
`.statcard` → `.card`+`.stat`; `.card-body`/`-foot`/`-img` → `.card__content`/`__footer`/`__media`;
old icon ids (`#ic-home`, `#i-*`, `assets/icons.svg#*`) → `bmo-icons.svg#ic-fluent-*`.
Full mapping in `project-notes/CHANGELOG.md`.
