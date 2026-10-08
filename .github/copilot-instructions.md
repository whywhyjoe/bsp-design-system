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
- `fluent-basic-icons.svg` — the icon sprite (48 `<symbol>`s, ids `ic-fluent-{name}-24-regular`).
- `fluent-icon.js` — the optional `<fluent-icon>` element (authoring sugar over the sprite).
- `abacus-icons/` — the canonical BMO consumer-brand (Abacus) icon set: 712 flat SVGs, `<icon>-<size>.svg` at 16/24/28/48. Browse `abacus-icons/index.html`; index in `abacus-icons/catalog.json`. **Referenced by URL, never inlined into a sprite** — `.icon`/`.icon--N` are geometry-only so they work on an `<img>`: `<img class="icon icon--24" src="abacus-icons/add-24.svg" alt="">`. Pin a size with `.icon--12/16/20/24/28/48` (bare `.icon` is `1.25em` and will undersize a 28/48 icon). Baked hex + `<img>` means **no tinting** — expected, not a bug. Never author these as `<use href="#…">`; there is no symbol to resolve.
- `editorial.css` — the **Editorial mode** additive layer (warm content-page register): `--ed-*` tokens on a `.editorial` scope + editorial blocks. Opt-in third link, after `components.css`, only on editorial pages; never redefines `:root`. Rules + component catalog: `docs/EDITORIAL-MODE.md`. Supporting assets: `abacus-icons/` (content-labeling icons, by URL — there is **no** content-icon sprite; `.c-icon` / `bmo-ic-*` were removed), `assets/bmo-bokeh-{a…e}.svg` (five variants), `spot-illustrations/` (481-SVG spot-illustration library — flat folder, contact sheet at `spot-illustrations/index.html`, index in `catalog.json`).
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

## Paths — absolute in SharePoint
- ✅ `<link rel="stylesheet" href="/sites/FCUPortal/Code/bsp-design/components.css">` · `<script defer src="/sites/FCUPortal/Code/lib/alpine.js">` · `<img src="/sites/FCUPortal/Code/bsp-design/abacus-icons/add-24.svg">`
- ❌ `href="components.css"` / `src="../abacus-icons/add-24.svg"` in a real page — SharePoint does not resolve page-relative links reliably.
- The `examples/` pages use relative paths **on purpose** (they open from disk). Repoint any snippet you copy from them.
- **Do not "fix" relative `url()` inside the CSS** — those resolve against the stylesheet, not the page, and must stay as they are.

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

The sprite is the **curated default** — the common UI-chrome icons, inlined once per page as real same-document symbols. It deliberately holds only icons in use today and is **not** meant to grow into the whole Fluent set. When you need an icon it doesn't carry, reach into the **`fluentui-system-icons`** repo (a **separate** repo — the complete library of per-icon SVGs, the font builds, the `fluent-icon-library.json` catalog and `index.html` gallery; not part of this repo, and **nothing here resolves a path to it** — no config key, no build step. In production it deploys as its own top-level folder **`fluent-icons/`**, a sibling of `bsp-design/`; on the dev machine ask where the clone is rather than assuming):
- **Icons the sprite lacks →** use the Fluent **Resizable icon font** from that folder (full set, outline + filled, one cached download, no JS) — see below.
- **One or two extras that must stay SVG →** copy the matching real SVG into `fluent-basic-icons.svg` as a new `<symbol id="ic-fluent-{name}-24-regular" viewBox="0 0 24 24">` and change each path's baked `fill="#212121"` to `fill="currentColor"` (Fluent SVGs are filled shapes — ❌ never `fill:none`, they vanish).
- The two SVG forms are **equivalent** — the name token is the durable contract and both use it. Pick the no-JS `<use>` form (the documented default; `docs/PAGE-TEMPLATE.md` uses it) where zero-JS is required or preferred; `<fluent-icon>` is just optional authoring sugar over the same sprite.
- ❌ Don't grow the sprite speculatively toward the full set — add a symbol only for an icon used now; for broad coverage use the font, not an ever-expanding sprite.

Mechanical rules:
1. **Size is the CSS helper class, not the name.** ✅ `<fluent-icon name="search-24-regular" class="icon--20">` · ❌ `name="search-20-regular"` (sprite is 24-viewBox normalized; never fabricate a `-20-` symbol).
2. Inline the **whole** current sprite (the full `fluent-basic-icons.svg`) once per page; don't ship a per-page subset.
3. `<fluent-icon>` is **light DOM on purpose** — shadow DOM breaks `<use>`. Don't "fix" it to a shadow root.
4. A name with no matching symbol renders **blank, no error** — add the `<symbol>` to `fluent-basic-icons.svg` (copy the matching real SVG from the `fluentui-system-icons` repo). Never invent a glyph or substitute a foreign icon. Not every Fluent icon ships in every size — the size segment must match a real asset.
5. Same-document `#id` refs need the sprite physically present in the page.

**Third form — the Fluent icon FONT (optional).** Microsoft also ships these icons as a self-hosted `@font-face` font — **first-party Fluent, not a third-party kit.** Use the **Resizable** font from the live `fluent-icons/` folder: preload `/sites/FCUPortal/Code/fluent-icons/fonts/FluentSystemIcons-Resizable.woff2` (`as="font" type="font/woff2" crossorigin`, URL identical to the `@font-face` src), link `…/fonts/FluentSystemIcons-Resizable.css`, and render `<i class="icon-ic_fluent_home_20_regular" aria-hidden="true"></i>` (or `…_20_filled`). It's the lowest-friction way to get the **full** Fluent set with no sprite and no JS. Rules:
- ✅ Names in the Resizable font are **always `_20_`** — ❌ `icon-ic_fluent_home_24_regular` doesn't exist there and renders blank. Size via `font-size` (20px native), not `.icon--N`; don't add `.icon` to the `<i>`.
- ✅ **Link exactly one icon-font stylesheet per page.** ❌ Never Regular + Filled together, never `FluentSystemIcons-All.css` — the fonts share codepoints and each stylesheet forces its font on every `i[class^="icon-"]`, so the others render wrong glyphs.
- ✅ **Always `aria-hidden` the `<i>` and label the parent** (font glyphs are Private-Use chars). Ship the font unmodified (subsetting needs a build).
- Live specimen: `examples/components.html` → Icons (uses the demo copy in `examples/fonts/`). Full details: TECHNICAL-REFERENCE §6.

Never substitute a third-party icon kit or ad-hoc web SVGs — those are out. The Fluent icon **font** is first-party Microsoft Fluent, so it's *not* a third-party kit; it's the supported way to reach the full set.

## Layout — respond to the SharePoint column, not the window
An app part runs in a script web part inside a SharePoint column (full, half, or one-third width), so its width is the column's, not the viewport's. Lay it out with the `.l-*` primitives (TECHNICAL-REFERENCE §2 "Layout"; live demo in `examples/components.html` → Layout):
- ✅ Root: `<div class="l-app" x-data="{…}">`. Inside: `.l-stack` (vertical), `.l-cluster` (wrapping row; `--end`/`--between`), `.l-sidebar` › `__side` + `__main`, `.l-switcher` (+ `__wide` for ⅔ + ⅓), `.l-grid--auto` / `.l-grid--2/3/4`. Spacing via `.l-gap--N` (ramp: 0 40 80 120 160 200 240 320 480).
- ✅ Tune with `--l-side`, `--l-break`, `--l-min` (inline or page class). Own breakpoints: `@container app (max-width: …)`.
- ✅ Keep `.l-app` a full-width block (`<div>`/`<main>` filling the column) — ❌ never inline-block, floated, absolutely positioned, or a non-growing flex item (it collapses).
- ✅ Wrap wide tables, `<pre>` and other unshrinkable content in `.l-scroll`.
- `.l-stack` clears only the margins of unclassed plain-content children (headings, `p`, lists…); anything with a class (e.g. `.section-head`) keeps its margins, which add to the gap.
- ❌ No viewport `@media` breakpoints for a part's layout — they fire on the window, not the column.
- ❌ No raw `gap:` on `.l-grid--2/3/4` — use `.l-gap--N`; the column math reads `--l-gap`.
- ❌ No `.l-wrap` / `.l-section` inside a web part — full pages only; they double SharePoint's padding.
- ❌ Don't add a grid framework (Bootstrap grid, `ms-Grid`, Tailwind) — viewport-based, and their generic class names collide with other web parts on the page.

## Reference pages consume the system — they don't re-style
Demo/reference pages link the shared CSS and use canonical classes; no local component `<style>` forks (local inline `<style>` was a primary source of the original fragmentation). Build your pages the same way: link `colors_and_type.css` + `components.css` (or `styles.css`), don't re-declare component styles.

## Ramps carry documented intent — don't "tidy" non-obvious values
Unusual scale entries are purpose-built. The avatar ramp (`components.css`) is a dense-UI slice of Fluent 2 with the small end tuned to text line-heights — e.g. `.avatar--22 { width:22px; height:22px; font-size:9px; } /* flush w/ body2 line-box (16/22) — inline-with-text size */`. Don't round, collapse, or "rationalize" these; respect the annotated intent.
