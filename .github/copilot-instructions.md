# BMO SharePoint Design System — Copilot instructions

You are helping a developer **build a new SharePoint app/page on top of this design
system**. This is a buildless, CDN-free, self-hosted HTML/CSS/JS system. Apps built
on it are interactive — your job is to wire them up correctly and in house style.

**Building a new page? Start from [`docs/PAGE-TEMPLATE.md`](../docs/PAGE-TEMPLATE.md)** — the
minimal complete working page (correct CSS link order, inlined sprite, `x-data` root,
sample components, deferred self-hosted Alpine). Copy it and build outward. Don't
hand-roll a scaffold from scratch.

## File map (bind these names to the real artifacts)
- `colors_and_type.css` — design tokens (`:root`, defined once) + base element styles + utilities (`.imgph .photo .lift .reveal`).
- `components.css` — every component as a BEM class, built from tokens.
- `styles.css` — one-tag bundle: `@import`s the two above in the right order.
- `bmo-icons.svg` — the icon sprite (48 `<symbol>`s, ids `ic-fluent-{name}-24-regular`).
- `fluent-icon.js` — the optional `<fluent-icon>` element (authoring sugar over the sprite).
- `editorial.css` — the **Editorial mode** additive layer (warm content-page register): `--ed-*` tokens on a `.editorial` scope + editorial blocks. Opt-in third link, after `components.css`, only on editorial pages; never redefines `:root`. Rules + component catalog: `docs/EDITORIAL-MODE.md`. Supporting assets: `bmo-content-icons.svg` (content line-icon sprite, `bmo-ic-*`), `bokeh.svg`, `illustrations/`.
- `docs/PAGE-TEMPLATE.md` — start-here page scaffold.
- `docs/TECHNICAL-REFERENCE.md` — component/token/class reference; **state contract = §5**, retired forks = §3, tokens = §4.
- `examples/components.html` (live specimens), `examples/design-system-reference.html` (visual), `examples/example-advanced-ui.html` (full composed page) — read for real markup; do not restyle them. Editorial-mode proof pages: `examples/editorial-learning-catalog.html`, `examples/editorial-resource-hub.html`; editorial library + guide: `examples/editorial-components.html`, `examples/editorial-design-guide.html`.

---

## Architecture — buildless, CDN-free, self-hosted (non-negotiable)
Runs as raw HTML/CSS/JS inside SharePoint. Governance: same-origin, nothing leaves
the firewall, must work where custom-script is restricted (the no-JS icon path does).
The rule constrains the **shipped artifact**, not the developer's machine:
- ❌ The deployed page can never **require** a build/compile step, a bundler, or ES `import` — SharePoint cannot build or run Node; what you author is what runs, as-is. There is no compile.
- ❌ No CDN `<script>`/`<link>` **in production** — every runtime dependency is self-hosted in SiteAssets. A CDN tag is fine as a convenience during local dev, but the developer must download the file and self-host it before it ships.
- ✅ **Local dev tooling is unrestricted.** `npm install`, Node, Python, static servers, linters, screenshot tools — all fair game *as tools* on the dev machine. Propose them freely when they help; they just can't become something the artifact needs in order to build or run.
- ✅ **Proposing a library that happens to be CDN-distributed is fine** — the developer obtains it and self-hosts it (exactly like Alpine below). What stays vetoed is the *library itself* when other rules reject it (third-party UI/icon kits, anything that forces a build step), not its CDN distribution channel.
- ✅ Link CSS directly; self-host every dependency in SiteAssets.
- Self-host Alpine too — load deferred, after the markup:
  - ✅ `<script defer src="alpine.min.js"></script>`
  - ❌ shipping `<script src="https://unpkg.com/alpinejs@3/dist/cdn.min.js"></script>` to production

## Styling — one BEM vocabulary on shared tokens
Compose from existing classes + modifiers. Never invent component classes or inline-style values that a class/token already covers — one-off literals are how the original multi-way fork spread.
- ✅ `<button class="btn btn--primary btn--lg">Submit</button>`
- ❌ `<button class="btn primary size-lg">` · ❌ `<button class="btn" style="background:#0079C1;height:40px">`
- Tokens are the only source of values — no raw hex, no off-ramp px:
  - ✅ `gap: var(--space-160); color: var(--fg-primary);`
  - ❌ `gap: 16px; color: #001928;`
- Don't redefine `:root` or add a competing token set; consume the existing tokens.
- **Retired vocabularies — never reintroduce** (TECHNICAL-REFERENCE §3): `.btn primary` / `.btn.primary` → `.btn.btn--primary`; `size-lg` → `.btn--lg`; `.is-focus` / `.is-disabled` → native `:focus-visible` / `:disabled`; `.cc` / `.cc-b` / `.cc-ic` → `.card` / `.card__content` / `.card__icon-tile`; `.statcard` → `.card` + `.stat`; `.card-body` / `.card-foot` / `.card-img` → `.card__content` / `.card__footer` / `.card__media`.

## Components — hand-rolled Fluent 2 + BMO, not a third-party kit
Build UI from THIS system's classes. Full Fluent 2 + brand fidelity with zero external component dependency.
- ❌ Don't pull in Web Awesome, Fluent React, Material, or any component/UI library. (The docs name Web Awesome explicitly as a rejected option — it's an external dependency that fights governance and cedes token control.)
- ✅ A component is a CSS class on plain HTML: `<button class="btn btn--primary">`, `<article class="card">…</article>`.

## Interactivity — inline Alpine against the documented state contract (DO use it)
Apps here ARE interactive. Wire with minimal inline Alpine; bind to the documented state classes/attributes in TECHNICAL-REFERENCE §5.
- **Every Alpine binding must live inside an `x-data` ancestor.** A bound control placed outside any `x-data` renders fine, does nothing, and throws **no error** — the #1 first-page mistake.
  - ✅ `<main x-data="{ filter:'all' }"> <button class="chip" :class="{ 'is-active': filter==='all' }" :aria-pressed="filter==='all'" x-on:click="filter='all'">All</button> </main>`
  - ❌ a `:class`/`x-model`/`x-on` control with no `x-data` ancestor.
- Drive the documented state, don't hardcode it: chip selected = `.is-active` (+ `aria-pressed`); switch/checkbox/radio = `x-model` on `:checked`; tab current = `.is-active` + `aria-selected="true"`; invalid input = `[aria-invalid="true"]`; grid row open = `.is-selected`.
- Use native pseudo-classes/attributes where they exist; use an `.is-*` class only where there's no native equivalent. Keep ARIA synced to the visual state (`:aria-pressed`, `:aria-selected`, `:aria-invalid`).
- The system ships **no `Alpine.data()` factory layer and no `bmo-behaviors.js`** — by design. For ordinary controls (chip/switch/tab/checkbox) write the inline one-liner from the state contract; it's simpler and binds to YOUR app's data.
  - ❌ Don't auto-scaffold a factory or `bmo-behaviors.js` for a trivial control.
- A hand-written factory is worth it only for genuinely hard / a11y-critical widgets — **dialog** (focus trap, Escape, scroll-lock, return-focus), secondarily tabs/toast. For the focus trap, the first-party **`@alpinejs/focus`** plugin is **allowed** — self-host it in SiteAssets exactly like Alpine core (CDN-free bans external hosts at runtime, not self-hosted plugins); prefer it over hand-rolling a trap. Flag these as a deliberate choice; don't generate one by default.
- For `x-show`-controlled visibility (dialog/toast), add `x-cloak` + the `[x-cloak]{display:none}` rule so they don't flash before Alpine boots.

## Icons — name token is the durable contract; two same-document forms
Author by the Fluent NAME TOKEN `ic-fluent-{icon}-{size}-{variant}`. Two equivalent forms resolve over the same sprite:
- No-JS: `<svg class="icon icon--16"><use href="#ic-fluent-arrow-right-24-regular"/></svg>`
- Sugar element: `<fluent-icon name="home-24-regular"></fluent-icon>` (needs `fluent-icon.js`).

The sprite is the **curated default** — the common UI-chrome icons, inlined once per page as real same-document symbols. It deliberately holds only icons in use today and is **not** meant to grow into the whole Fluent set. When you need an icon it doesn't carry, reach into the **`fluentui-system-icons`** repo (a **separate** repo — the complete library of per-icon SVGs, the font builds, and the `fluent-font-library.{json,html}` index; not part of this repo, its path set in project config):
- **A few extra icons →** copy the matching real SVG from the repo into `bmo-icons.svg` as a new `<symbol id="ic-fluent-{name}">` (24 viewBox, `fill:none` + `currentColor`). Stays on the no-JS sprite path.
- **Many / arbitrary icons →** self-host the Fluent **icon font** from that repo (full set, one cached download, no JS) — see below.
- The two SVG forms are **equivalent** — the name token is the durable contract and both use it. Pick the no-JS `<use>` form (the documented default; `docs/PAGE-TEMPLATE.md` uses it) where zero-JS is required or preferred; `<fluent-icon>` is just optional authoring sugar over the same sprite.
- ❌ Don't grow the sprite speculatively toward the full set — add a symbol only for an icon used now; for broad coverage use the font, not an ever-expanding sprite.

Mechanical rules:
1. **Size is the CSS helper class, not the name.** ✅ `<fluent-icon name="search-24-regular" class="icon--20">` · ❌ `name="search-20-regular"` (sprite is 24-viewBox normalized; never fabricate a `-20-` symbol).
2. Inline the **whole** current sprite (the full `bmo-icons.svg`) once per page; don't ship a per-page subset.
3. `<fluent-icon>` is **light DOM on purpose** — shadow DOM breaks `<use>`. Don't "fix" it to a shadow root.
4. A name with no matching symbol renders **blank, no error** — add the `<symbol>` to `bmo-icons.svg` (copy the matching real SVG from the `fluentui-system-icons` repo). Never invent a glyph or substitute a foreign icon. Not every Fluent icon ships in every size — the size segment must match a real asset.
5. Same-document `#id` refs need the sprite physically present in the page.

**Third form — the Fluent icon FONT (optional).** Microsoft also ships these icons as a self-hosted `@font-face` font — **first-party Fluent, not a third-party kit.** Self-host `FluentSystemIcons-Regular.{woff2,css}` (and `-Filled` if needed) — taken from the separate `fluentui-system-icons` repo (path specified in project config) — in SiteAssets, link the CSS, and render `<i class="icon-ic_fluent_home_24_regular" aria-hidden="true"></i>` (the name token, underscored, with an `icon-ic_fluent_` prefix). It's the lowest-friction way to get the **full** Fluent set with no sprite and no JS — reach for it when a page needs many icons beyond the curated `bmo-icons.svg` set. Caveats: **always `aria-hidden` the `<i>` and label the parent** (font glyphs are Private-Use chars — the SVG `<use>` form stays the more-accessible default); size via `font-size`, not `.icon--N`; ship the full font (subsetting needs a build). Full details + when-to-use: TECHNICAL-REFERENCE §6.

Never substitute a third-party icon kit or ad-hoc web SVGs — those are out. The Fluent icon **font** is first-party Microsoft Fluent, so it's *not* a third-party kit; it's the supported way to reach the full set.

## Reference pages consume the system — they don't re-style
Demo/reference pages link the shared CSS and use canonical classes; no local component `<style>` forks (local inline `<style>` was a primary source of the original fragmentation). Build your pages the same way: link `colors_and_type.css` + `components.css` (or `styles.css`), don't re-declare component styles.

## Ramps carry documented intent — don't "tidy" non-obvious values
Unusual scale entries are purpose-built. The avatar ramp (`components.css`) is a dense-UI slice of Fluent 2 with the small end tuned to text line-heights — e.g. `.avatar--22 { width:22px; height:22px; font-size:9px; } /* flush w/ body2 line-box (16/22) — inline-with-text size */`. Don't round, collapse, or "rationalize" these; respect the annotated intent.
