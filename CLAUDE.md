# BMO SharePoint Design System — agent guide (CLAUDE.md)

This folder **is** the design system. It's a buildless, CDN-free, self-hosted
HTML/CSS/JS component library that runs inside SharePoint Online. You'll either
build new pages/apps **on top of it**, or extend the system itself.

**Start a new page from [`docs/PAGE-TEMPLATE.md`](docs/PAGE-TEMPLATE.md)** — the smallest
complete working page (correct CSS link order, inlined icon sprite, an `x-data`
root, sample components, deferred Alpine). Copy it and build outward; don't
hand-roll a scaffold.

**Different audience?** This system is for **employee-facing** pages and apps. If
you are building an internal *developer tool* in the DCS Workbench family
(DCSPad, SP Workbench, Halo, the File Broker), you want the DCS Workbench design
system and the method docs in `whywhyjoe/dcs-workbench-tools` (`docs/README.md`)
instead — different register, different shell, different hosting rules.

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
  Two equivalent forms over the canonical `fluent-basic-icons.svg` sprite — no-JS
  `<svg class="icon icon--16"><use href="#ic-fluent-home-24-regular"/></svg>` and
  the optional `<fluent-icon name="home-24-regular">`. Inline the whole sprite once
  per page; size via `.icon--N`, never in the name; a name with no symbol renders
  blank — add the symbol, don't invent a glyph. A **third** delivery exists: the
  first-party Fluent **icon font** (self-hosted `@font-face`; `<i class="icon-ic_fluent_home_24_regular" aria-hidden>`)
  — the full set, no sprite, no JS; `aria-hidden` the `<i>` and label the parent,
  size via `font-size`. The **complete** Fluent library (per-icon SVGs, the font
  builds, and the `fluent-font-library.{json,html}` index) lives in the separate
  **`fluentui-system-icons`** repo — not in this one; use it under the same criteria.
  **Nothing in this system reads a path to it** — no config key, no resolver, no
  build step. In **production it is deployed as its own top-level folder,
  `fluent-icons/`, a sibling of `bsp-design/`**; on the dev machine it's a separate
  clone whose location you should ask for rather than assume.
  See `docs/TECHNICAL-REFERENCE.md` §6.

## Paths in a real page — absolute, not relative
SharePoint does not resolve page-relative links reliably. Every URL a **page** emits is
**server-relative from `/sites/FCUPortal`**: `/sites/FCUPortal/Code/bsp-design/components.css`,
`/sites/FCUPortal/Code/bsp-design/abacus-icons/add-24.svg`, `/sites/FCUPortal/Code/lib/alpine.js`.
The `examples/` pages use relative paths on purpose so they open from disk — **their
snippets must be repointed when pasted into a real page.** The one thing that stays
relative is `url()` *inside* the CSS (`editorial.css` → `assets/bmo-bokeh-a.svg`): CSS
resolves those against the stylesheet URL, which is what keeps the folder relocatable.
Alpine and pnpjs live in `/sites/FCUPortal/Code/lib/`, a sibling of `bsp-design/`.

## File map
**The library (link these):**
- `colors_and_type.css` — tokens (`:root`, defined once) + base element styles + utilities (`.imgph .photo .lift .reveal`). Link first.
- `components.css` — every component as a BEM class, built from tokens. Link second.
- `styles.css` — one-tag bundle: `@import`s the two above in order.
- `editorial.css` — **Editorial mode** additive layer (the warm, content-page register): `--ed-*` tokens on a `.editorial` scope, SharePoint host chrome, hero brand-devices, editorial component blocks. Link **after** `components.css`, only on editorial pages (opt-in — not in the `styles.css` bundle). Built entirely on existing tokens; never redefines `:root`. Full guide: `docs/EDITORIAL-MODE.md`.

**Icons:** `fluent-basic-icons.svg` (48-symbol sprite, `ic-fluent-*`, the curated default) · `fluent-icon.js` (optional `<fluent-icon>` element — authoring sugar over the sprite). For icons beyond the 48, the full library (all SVGs, fonts, index) is the separate `fluentui-system-icons` repo (deployed live as the sibling top-level folder `fluent-icons/`; nothing in this repo resolves a path to it): copy a real SVG into the sprite for a few extras, or self-host the icon font for many.

**Abacus icons (BMO consumer brand):** `abacus-icons/` — the canonical BMO brand icon set,
712 flat SVGs named `<icon>-<size>.svg` at 16/24/28/48. Browse `abacus-icons/index.html`;
index in `abacus-icons/catalog.json`. **These are never inlined into a sprite.** Reference
the file by URL — `.icon`/`.icon--N` are geometry-only, so they work on an `<img>`:
`<img class="icon icon--24" src="abacus-icons/add-24.svg" alt="">` (TECHNICAL-REFERENCE §6,
Form 4). The `.icon--12/16/20/24/28/48` ladder covers every Abacus size — always pin one,
since bare `.icon` is `1.25em`. Colors are baked hex and an `<img>` can't
be tinted — `color`-based tinting has no effect; that's expected, not a bug. On a blue ground
add `.icon--on-blue`, which whitens the glyph with a filter (editorial.css).
**There is no content-icon sprite** — `.c-icon` and `bmo-ic-*` were removed; these SVGs are
the content-labeling tier now. In native SharePoint web parts there's no markup at all — just the SiteAssets URL.
35 files are flagged as bad exports in the catalog; see `abacus-icons/README.md`.

**Index:** `index.html` (repo root) — the human table of contents: every guide/example/reference linked, what each shipped file does, the asset-library map. Repo-only, never deployed. Keep it current when files are added or renamed.

**Showcases (read for real markup; they consume the library, don't restyle):**
- `examples/components.html` — every component live + copy-paste snippets (fastest path).
- `examples/design-system-reference.html` — the visual/brand spec.
- `examples/example-advanced-ui.html` — a full composed page.
- `examples/developer-guide.html` — in-browser onboarding guide (doc-chrome).
- `examples/editorial-learning-catalog.html` · `examples/editorial-resource-hub.html` — the **Editorial mode** proof pages: the warm register rendered in-token, framed in SharePoint chrome, wired with inline Alpine.
- `examples/editorial-components.html` — every editorial block live with copy-paste markup (incl. the flat **mesh register**, video player, spotlight slider) · `examples/editorial-design-guide.html` — when to use, showcase-vs-mesh, hero chooser, do/don't.

**Docs:** `docs/PAGE-TEMPLATE.md` (start here) · `docs/TECHNICAL-REFERENCE.md` (deep reference; retired→canonical map in §3) · `docs/EDITORIAL-MODE.md` (the editorial-mode layer: when to use, 3-tier art rules, component catalog, do/don't) · `.github/copilot-instructions.md` (agent rules) · `context/` (BMO brand, SharePoint, Fluent 2 source material).

**Editorial mode (additive layer — warm, employee-facing content pages):**
- `editorial.css` — the layer (link after `components.css`, scoped to `.editorial`). Guide: `docs/EDITORIAL-MODE.md`.
- `assets/bmo-bokeh-{a…e}.svg` — the official BMO bokeh artwork (blue gradient + round translucent circles), **five variants** differing only in how much of the frame the circles occupy: `a` busiest → `c` → `b` → `e` → `d` sparsest. `.hero--bokeh` gives you `a`; add `.hero--bokeh-{a…e}` alongside it to pick another. Square 1:1 source, so a wide banner crops to a middle slice. `.jpg` twins ship as a raster fallback. Chooser table: `docs/EDITORIAL-MODE.md` §4.
- `spot-illustrations/` — the canonical BMO line-drawing spot-illustration library: 481 flat SVGs (reference them as `spot-illustrations/<name>.svg`), alongside `catalog.json` and `README.md`. Browse the contact sheet at `spot-illustrations/index.html`.

**Versioning & deploy:** `VERSION` (repo root) is the source of truth. `tools/Set-Version.ps1 <semver>`
stamps it into the `/*! … v1.0.0 … */` banner on line 1 of each shipped CSS/JS file and into
`--ds-version` in `colors_and_type.css`'s `:root` (declared inside the single existing block — this
is **not** a second `:root`). A live page reports its own version via
`getComputedStyle(document.documentElement).getPropertyValue('--ds-version')`. Bump → review → commit
→ tag. `tools/Deploy-BspDesign.ps1` (defaults to the synced `C:\dev\fcuportal-code`) then does a **pure copy** of the
runtime files into a `bsp-design/` folder created inside that container (`-Versioned` nests
`bsp-design/<version>/`). Runtime only — no `examples/`, `docs/`, `context/`, `tools/`,
`index.html`, `.md`, or the libraries' `catalog.json` / `index.html` — so prod is byte-identical
to the tag. It refuses a dirty tree or a VERSION/stamp mismatch. **Never hand-edit a version
stamp** — run the script, or they drift and the deploy blocks.

**Ignore (tooling/artifacts, not part of the system):** `project-notes/_adherence.oxlintrc.json`, `.claude/`, `tools/` (dev-machine PowerShell, never shipped). `assets/` holds the placeholder logo/lockup.

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
old icon ids (`#ic-home`, `#i-*`, `assets/icons.svg#*`) → `fluent-basic-icons.svg#ic-fluent-*`.
Full mapping in `docs/TECHNICAL-REFERENCE.md` §3.
