# BMO SharePoint Design System — Technical Reference

A buildless, CDN-free component library that runs as raw HTML/CSS/JS inside
SharePoint. No bundler, no npm build step, no external CDN — every asset is
self-hosted. You consume it by **copy-pasting markup snippets** against shared
CSS, and wiring interactivity with **minimal inline Alpine**.

This is the developer-facing reference. For the visual/brand showcase see
`../examples/design-system-reference.html`; for live, copy-paste specimens of every
component see `../examples/components.html`; for a full composed page see
`../examples/example-advanced-ui.html`.

---

## 1. Getting started

### Files, and the order to include them

| File | What it is | Required? |
|---|---|---|
| `colors_and_type.css` | Design tokens (`:root` custom properties) + styled base elements (`h1`–`h6`, `a`, `code`…) + a few opt-in utilities (`.imgph`, `.photo`, `.lift`, `.reveal`). | **Yes** |
| `components.css` | The component layer — every BEM class, built entirely from the tokens. | **Yes** |
| `styles.css` | Convenience single entry point: `@import`s the two files above, in order. Link this *instead of* the two if you prefer one tag. | Optional |
| `fluent-basic-icons.svg` | The canonical icon sprite — 48 `<symbol>`s, ids `ic-fluent-{name}-24-regular`. Inline once per page. | Yes, if you use icons |
| `fluent-icon.js` | Optional `<fluent-icon>` custom element (the "sugar" icon form). | Optional |

**Link order matters** — tokens before components:

```html
<link rel="stylesheet" href="colors_and_type.css">
<link rel="stylesheet" href="components.css">
```

…or the one-tag equivalent:

```html
<link rel="stylesheet" href="styles.css">
```

### The minimum-dependency path (CSS + sprite only, no JS)

You can build a fully-styled, fully-iconned page with **zero JavaScript**:

1. Link the two CSS files (or `styles.css`).
2. Inline the contents of `fluent-basic-icons.svg` into the page body once.
3. Write the BEM markup; render icons with the no-JS `<use>` form.

Nothing else is needed. Interactivity (toggles, dialogs, sorting) is the only
thing that wants JS, and that is **your** inline Alpine — there is no behavior
library shipped with this system (see §5).

### How the pieces wire together

```
colors_and_type.css   →  defines var(--token)s + base element styles
        │
components.css        →  every .class is built from those tokens
        │
your page (HTML)      →  copy-paste BEM markup that uses those classes
        │
fluent-basic-icons.svg         →  inlined once; <use href="#ic-fluent-*"> resolves same-document
        │
inline Alpine         →  x-data / x-model / :class drive documented state classes
fluent-icon.js        →  OPTIONAL: <fluent-icon name="…"> sugar for the same sprite
```

### Copy-paste workflow

1. Find the component in `../examples/components.html`, hit **Copy**.
2. Paste the markup.
3. Swap in your content.
4. If it is interactive, add the inline Alpine from the component's **state
   contract** (§5) — the same pattern every time.
5. Never hand-write a raw hex or off-ramp pixel value; reach for a token (§4).

---

## 2. Component reference

Every component is a token-built CSS class. Variants are BEM modifiers
(`block--modifier`); states are native pseudo-classes/attributes (`:disabled`,
`[aria-selected="true"]`, `.is-active`) — see §5 for the full state contract.

### Button — `.btn`
One base, six variants, three sizes.
- **Variants:** `.btn--primary` · `.btn--secondary` · `.btn--tertiary` · `.btn--subtle` · `.btn--ghost` · `.btn--danger`
- **Sizes:** `.btn--sm` · (default 32px) · `.btn--lg` (40px)
- **Layout:** `.btn--block` (full width) · `.btn--start` (left-align content)
- **States:** `:hover`, `:active`, `:focus-visible` (focus ring), `:disabled` / `[aria-disabled="true"]`
- Blue is the only filled accent. Danger is `--fg-danger`, **never** BMO Red.

```html
<button class="btn btn--primary">Submit request</button>
<button class="btn btn--secondary"><svg class="icon icon--16"><use href="#ic-fluent-filter-24-regular"/></svg> Filter</button>
<button class="btn btn--primary btn--lg">Large</button>
<button class="btn btn--primary" disabled>Disabled</button>
```

### Icon button — `.icon-btn`
32×32 hit target for toolbar/close/overflow actions. Toggle state via
`[aria-pressed="true"]` or `.is-active`. Always give it an `aria-label`.

```html
<button class="icon-btn" aria-label="More"><svg class="icon"><use href="#ic-fluent-more-horizontal-24-regular"/></svg></button>
```

### Floating action button — `.fab`
A persistent primary action that hovers over the content bottom-right ("New",
"Edit"). **Not a native Fluent 2 pattern** — the Material-style floating
affordance, added deliberately for surfaces with one obvious action. Circular +
icon-only by default (give it an `aria-label`); `.fab--extended` for an
icon+label pill; `.fab--sm` (40px); `.fab--secondary` for the quiet white tone;
`.fab--fixed` pins it to the viewport bottom-right. Canonical usage:
`examples/example-ops-dashboard.html` (fixed) and `examples/example-component-patterns.html`.

```html
<button class="fab fab--extended fab--fixed"><svg class="icon"><use href="#ic-fluent-add-24-regular"/></svg> New request</button>
<button class="fab" aria-label="Edit"><svg class="icon"><use href="#ic-fluent-edit-24-regular"/></svg></button>
```

### Form field — `.field` + `.input` / `.select` / `.textarea`
Wrap a control in `.field` for label + hint/error. Controls share one surface.
- **Parts:** `.field__label`, `.field__req` (the `*`), `.field__hint`, `.field__error`
- **States:** `:focus` (accent ring), `:disabled`, `[aria-invalid="true"]` (danger border)

```html
<div class="field">
  <label class="field__label">Subject <span class="field__req">*</span></label>
  <input class="input" placeholder="e.g. Q3 expense report">
  <p class="field__hint">Shown to the approver.</p>
</div>

<!-- error state -->
<input class="input" aria-invalid="true">
<p class="field__error">Subject is required.</p>
```

### Input group — `.input-group`
An icon (and/or suffix) sharing the control border. `:focus-within` lights the ring.

```html
<div class="input-group">
  <svg class="icon icon--16 input-group__icon"><use href="#ic-fluent-search-24-regular"/></svg>
  <input class="input-group__field" placeholder="Search requests">
</div>
```

### Selection controls — `.check` · `.radio` · `.switch` · `.chip`
Native checkbox/radio tinted with `accent-color`; switch is a styled checkbox;
chips are a single-select row. See §5 for the `x-model` / `.is-active` contracts.

```html
<label class="check"><input type="checkbox"> Pending</label>
<label class="switch"><input type="checkbox"><span class="switch__track"></span> Email me</label>
<div class="chip-row">
  <button class="chip is-active" aria-pressed="true">Expense</button>
  <button class="chip">Travel</button>
</div>
```

### Badge / tag / dot — `.badge` · `.tag` · `.dot`
- **Badge** (semantic status pill): `.badge--info/--success/--warning/--danger/--strong`; bare `.badge` = neutral.
- **Tag** (neutral metadata): `.tag`; selected = `.tag.is-active`; removable adds a `.tag__remove` button.
- **Dot** (status): `.dot--success/--warning/--danger/--info/--neutral`, `.dot--10` for 10px.

```html
<span class="badge badge--info">Pending</span>
<span class="tag">Expense <button class="tag__remove" aria-label="Remove"><svg class="icon"><use href="#ic-fluent-dismiss-24-regular"/></svg></button></span>
<span class="dot dot--success"></span>
```

### Avatar — `.avatar`
Initials on a brand-palette ground (set bg inline / from JS). Sizes
`.avatar--20/22/28/32/40/48/64`. The ramp is a dense-UI slice of Fluent 2:
**20 and 22 are line-height-locked** for sitting inline with text (20 = body1
`14/20`, 22 = body2 `16/22`); **28 is the default** (list rows, toolbars);
**48 and 64** are for identity / profile surfaces. Add a presence badge with
`.avatar-wrap` + `.avatar__presence--success/--warning/--danger/--away`.

```html
<span class="avatar avatar--32" style="background:#0079C1">SC</span>
<span class="avatar-wrap"><span class="avatar avatar--40" style="background:#003758">RK</span><span class="avatar__presence avatar__presence--success"></span></span>
```

### Card — `.card`
White surface, 1px divider, `--shadow-4`, large radius. Composition parts mix freely.
- **Parts:** `.card__eyebrow`, `.card__title`, `.card__body`, `.card__footer` (`.card__meta` + `.card__cta`), `.card__icon-tile` (+`--sm`)
- **Media:** pair `.card--flush` with `.card__media` (`--top` banner / `--left` rail) and `.card__content`. `.card--row` for an editorial row.
- **Interactive:** add `.lift` (hover-rise) and `tabindex="0"`.

```html
<article class="card">
  <p class="card__eyebrow">Policy</p>
  <h3 class="card__title">Q3 expense policy</h3>
  <p class="card__body">What's reimbursable, limits, receipts.</p>
  <div class="card__footer">
    <span class="card__meta">Updated Oct 2</span>
    <a class="card__cta" href="#">Review <svg class="icon icon--16"><use href="#ic-fluent-arrow-right-24-regular"/></svg></a>
  </div>
</article>
```

### Stat / KPI — `.stat`
`.stat__label` (optionally inside `.stat__head` with a `.card__icon-tile--sm`),
`.stat__value`, `.stat__row` + `.stat__delta--up/--down`, `.stat__sub`. Place inside a `.card`.

### Tabs — `.tabs` / `.tab`
Underline tabs. Mark current with `.is-active` **and** `aria-selected="true"`.
Add `role="tablist"` / `role="tab"`. Optional `.badge--strong` count.

### Message bar — `.msgbar`
Inline feedback band: `.msgbar--info/--success/--warning/--danger`. Parts:
`.msgbar__icon`, `.msgbar__body`, `.msgbar__close`. Use `role="status"`. Errors
are `--fg-danger`, never BMO Red.

### Toolbar — `.toolbar`
Actions row: `.toolbar__title` + `.toolbar__spacer` (pushes actions right).

### Data grid — `.grid`
A real `<table class="grid">`. `.num` right-aligns numerals (tabular-nums);
`.grid__sort` for sortable headers; mark the open row `.is-selected`; `.mono`
for IDs; `.cell-secondary` for muted cells.

### Side panel — `.panel`
Master/detail rail: `.panel__head/__body/__foot`, `.panel__section-label`. Plus
`.facts` (dl label/value grid) and `.timeline` (`.timeline__item/__rail/__line/__content/__title/__when`).

### Dialog — `.scrim` + `.dialog`
Modal sheet on a scrim. Parts: `.dialog__head/__title/__sub/__body/__foot`.
Also `.dropzone` (+`.dropzone__hint`) for file attach. See §5 — this is the one
component that genuinely benefits from a behavior factory.

### Toast / empty state — `.toast` · `.empty`
Transient confirmation (bottom-center, animates in unless reduced-motion) and a
calm empty state (`.empty__title` + `.empty__hint` + one action).

### Engagement & page-shell layer
Opt-in, for richer landing/home surfaces:
- **Bands:** `.band` + `.band--neutral/--blue/--sky/--white`, inner column `.band__inner`.
- **Quick-action card:** `.qcard` (+ `.qcard__title/__desc`, `.card__icon-tile`).
- **Feature banner:** `.feature` (+ `--media-right`), `.feature__media/__copy/__title/__lede/__ticks`.
- **Page shell:** `.suite` (SharePoint suite bar + `.suite__mark/__app/__divider/__env/__spacer/__action`), `.crumbs` (breadcrumb + `.crumbs__sep/__current`), `.hero` (`.hero__eyebrow/__title/__lede/__cta/__media`, `.trust` + `.trust__item/__num/__label`), `.section-head` (+ `--flex`, `.section-head__eyebrow/__title/__lede`).
- **Layout helpers:** `.l-wrap` (centered max-width column), `.l-section` (vertical rhythm), `.l-grid` + `.l-grid--2/--3/--4` (responsive card grids).
- **Utilities** (in `colors_and_type.css`): `.imgph` (striped placeholder + `.lbl`), `.photo` (real-image crop), `.lift` (hover-rise), `.reveal` (fade-rise on scroll; visible by default).

### Process & filtering layer
Dense-app components; canonical usage in `examples/example-component-patterns.html` and
`examples/example-ops-dashboard.html`.
- **Spinner:** `.spinner` (+ `--16/--32/--48`, default 20; `--on-accent` on filled surfaces) and `.spinner-row` for an inline label. Give it `role="progressbar"` + `aria-label`.
- **Progress bar:** `.progress` › `.progress__meta` (`.progress__label` + `.progress__value`) + `.progress__track` › `.progress__fill`. States: `--indeterminate`, `--striped` (fill always full-width), `--subtle`, `--thick`, `--success`, `--danger`. The `__fill` `width` is the one sanctioned inline value — it *is* the data. Set `aria-valuenow/min/max`.
- **Stepper:** `<ol class="stepper">` › `.stepper__step` (`.is-done` / `.is-current` / `.is-error`) › `.stepper__dot` + `.stepper__label`. The connector is the step's `::before`.
- **Filter bar:** `.filterbar` — a standalone filters/sort surface (not attached to a grid/toolbar). `.filterbar__group` (label + control), `.filterbar__label`, `.filterbar__spacer` (pushes trailing groups right). Drop `.input-group`, `.chip-row`, `.select` inside.
- **Grid header filter:** on a `<th class="grid__filter-host">`, a `.icon-btn.grid__filter-btn` (add `.is-active` when filtered) toggles a `.grid__filter-menu` of `.grid__filter-item` (`.is-active` = current). SharePoint-list-style column funnel; toggle with inline Alpine (`x-show` + `@click.outside`).
- **Stat strip:** `.stat-strip` of `.stat.stat--plain` — card-less, value-first stats. `.stat__spark` (+ `--donut`) is an inline SVG slot (sparkline/open donut) that inherits a `--bmo-chart-*` color.

---

## 3. CSS class reference (composition patterns)

- **Base + modifier:** always include the base, then add modifiers.
  `class="btn btn--primary btn--lg"` — base `.btn`, variant, size.
- **Block + element:** elements are children, namespaced with `__`.
  `.card` › `.card__title`, `.card__footer` › `.card__meta`.
- **State classes vs native states:** prefer native where possible
  (`:disabled`, `:focus-visible`, `[aria-selected]`, `[aria-invalid]`). Use the
  `.is-*` class only where there is no native equivalent (`.is-active`,
  `.is-selected`, `.is-in`).
- **Sizes are explicit modifiers**, not free pixels: `.btn--sm/--lg`,
  `.icon--12/16/20/24/28/48`, `.avatar--20…64` (20/22/28/32/40/48/64), `.dot--10`.
- **Don't restyle a component inline.** Compose with the provided modifiers; if
  a value is missing, it should become a token + modifier, not an inline hack.

The retired forks (do **not** reintroduce): `.btn primary` / `.btn.primary`,
`size-lg`, `.is-focus` / `.is-disabled`, `.cc` / `.cc-b` / `.cc-ic`,
`.statcard`, `.card-body` / `.card-foot` / `.card-img`. Their canonical
equivalents are in §2.

---

## 4. Token reference

All tokens are CSS custom properties on `:root` in `colors_and_type.css`.
Components reference them with `var(--token)` — never a raw value. **No `:root`
is redefined anywhere else; the token layer is shared and authoritative.**

### Color — brand (authoritative)
| Token | Value | Notes |
|---|---|---|
| `--bmo-red` | `#ED1C24` | **Logo only. Never in UI.** (links may use it on focus) |
| `--bmo-blue` | `#0079C1` | Accessible Blue — default interactive |
| `--bmo-blue-hover` | `#005587` | Ultramarine — hover |
| `--bmo-blue-focus` | `#73C3EB` | Cerulean — focus ring |
| `--bmo-slate` | `#001928` | Primary text / headings |
| `--bmo-granite` | `#646C76` | Secondary text |
| `--bmo-white` / `--bmo-albicant` / `--bmo-light-grey` / `--bmo-pale-skyblue` | — | surfaces & dividers |
| `--bmo-positive` / `--bmo-negative` | `#0F9B2C` / `#D12121` | feedback |
| `--bmo-chart-*` (midnight, navy, blue, sky, ice; purple, lavender, mint, chartreuse, orange) | — | chart palette |

### Color — Fluent neutral & brand ramps
`--f2-white … --f2-black` (cool gray ramp; use these, not SharePoint's warm
grays), `--f2-brand-40…80` + `--f2-brand-tint-30/50`, `--f2-red/-red-dark/-green/-yellow`.

### Color — semantic roles (what components consume)
| Group | Tokens |
|---|---|
| Surfaces | `--surface-canvas`, `--surface-subtle`, `--surface-raised`, `--surface-input`, `--surface-selected-tint`, `--surface-tint-neutral/-blue/-sky`, `--surface-image-ph` |
| Foreground | `--fg-primary`, `--fg-secondary`, `--fg-disabled`, `--fg-on-accent`, `--fg-accent`, `--fg-accent-hover`, `--fg-danger`, `--fg-danger-hover`, `--fg-success`, `--fg-success-on-dark`, `--fg-info`, `--fg-warning`, `--fg-neutral` |
| Strokes | `--stroke-divider`, `--stroke-control`, `--stroke-control-strong`, `--stroke-focus`, `--stroke-accent`, `--stroke-info-tint/-success-tint/-warning-tint/-danger-tint` |
| Interactive | `--accent-rest`, `--accent-hover`, `--accent-pressed`, `--accent-focus-ring` |
| Feedback tints | `--surface-info-tint/-success-tint/-warning-tint/-danger-tint/-neutral-tint` |
| Misc | `--scrim` (dialog backdrop) |

### Spacing — 4px ramp
`--space-0` … `--space-560` (`0, 2, 4, 6, 8, 10, 12, 16, 20, 24, 28, 32, 36, 40, 48, 52, 56`px). Consumed by every padding/gap.

### Radius
`--radius-none/-small(2)/-medium(4, default)/-large(8)/-xlarge(12)/-circle(50%)`.

### Stroke thickness
`--stroke-thin(1)/-thick(2)/-thicker(3)/-thickest(4)`.

### Elevation
`--shadow-2/-4/-8/-16/-28/-64` (Fluent ramp). Embedded apps stay at 4–8.

### Typography
`--font-family` (Segoe UI stack), `--font-family-mono`; weights
`--weight-regular/-semibold/-bold`; the ramp `--type-caption2 … --type-display`
(each a full `font:` shorthand — e.g. `--type-body1` = `400 14px/20px`,
`--type-body1-strong`, `--type-title3`, etc.).

### Motion
`--motion-fast(100)/-normal(160)/-slow(250)/-reveal(550)`ms; easings
`--ease-out/-in/-in-out`; `--reveal-rise(14px)`, `--lift-rise(3px)`. All motion
honors `prefers-reduced-motion`.

---

## 5. State-contract reference

For each interactive component: **which class/attribute represents which
state**, and the canonical **minimal inline Alpine** that drives it. Write the
same pattern the same way everywhere.

| Component | State → class/attribute | Canonical inline Alpine |
|---|---|---|
| **Chip** (single-select) | selected = `.chip.is-active` (+ `aria-pressed="true"`) | `<button class="chip" :class="{ 'is-active': type==='Expense' }" :aria-pressed="type==='Expense'" x-on:click="type='Expense'">Expense</button>` |
| **Switch** | on = `input:checked` (drives `.switch__track`) | `<label class="switch"><input type="checkbox" x-model="notify"><span class="switch__track"></span> Email me</label>` |
| **Checkbox / radio** | checked = native `:checked` | `<input type="checkbox" x-model="filter">` · `<input type="radio" name="pri" value="high" x-model="priority">` |
| **Tab** | current = `.tab.is-active` + `aria-selected="true"` | `<button class="tab" role="tab" :class="{ 'is-active': tab==='dashboard' }" :aria-selected="tab==='dashboard'" x-on:click="tab='dashboard'">Dashboard</button>` |
| **Input (error)** | invalid = `[aria-invalid="true"]` | `<input class="input" :aria-invalid="!valid">` |
| **Data grid row** | open = `.is-selected` | `<tr :class="{ 'is-selected': sel?.id===r.id }" x-on:click="sel=r">` |
| **Icon button (toggle)** | pressed = `[aria-pressed="true"]` or `.is-active` | `<button class="icon-btn" :aria-pressed="grid" x-on:click="grid=!grid">` |
| **Dialog** | open = element present / shown | `x-show="open"`, scrim `x-on:click="open=false"`, `x-on:keydown.escape.window="open=false"`, inner `x-on:click.stop` |
| **Toast** | shown = element present | `<div class="toast" x-show="msg" x-text="msg">` |
| **Reveal-on-scroll** | played = `.reveal.is-in` | vanilla IntersectionObserver (see `../examples/example-advanced-ui.html`); not Alpine |

Rules:
- **Reveal has two mechanisms, one class.** In **app mode** `.reveal` is transition-based
  and hidden until a script adds `.is-in` (scroll-triggered — copy the observer from
  `example-advanced-ui.html`). Under the **`.editorial`** scope, `.editorial .reveal` is a
  self-sufficient CSS *animation* that plays on load with no script; the same `.is-in`
  short-circuits it to instantly-visible. Both reuse `--motion-reveal` / `--ease-out` /
  `--reveal-rise`, both honor `prefers-reduced-motion`, and they coexist by scope +
  specificity (see `EDITORIAL-MODE.md`). `.lift` is shared, unchanged.
- Bind the **class/attribute named in this table** — that is the contract. The
  CSS already styles it.
- Do **not** wrap trivial controls in `Alpine.data()` factories. A chip, switch,
  or tab is a one-liner with `x-model` / `:class`.
- Keep ARIA in sync with the visual state (`:aria-pressed`, `:aria-selected`,
  `:aria-invalid`).

### Recommendation (NOT built) — components that may later warrant an `Alpine.data()` factory

These are out of scope for this pass — flagged for a future, separate decision.
A small, **self-hosted** factory would be worth it only where correct behavior
is genuinely hard or accessibility-critical:

1. **Dialog — strongest candidate.** Needs a focus trap, `Escape` to close,
   body scroll-lock, and focus return to the trigger on close. Hand-rolled
   inline Alpine gets the open/close right but routinely drops focus management.
   **Focus trap:** the first-party **`@alpinejs/focus`** plugin is **allowed** —
   self-host it in SiteAssets exactly like Alpine core (it's one static file;
   CDN-free bans external hosts at runtime, not self-hosted plugins). Prefer it
   over a hand-written trap — it's battle-tested for exactly this. Hand-rolling
   remains the fallback when keeping the vendored script surface to Alpine core
   alone matters more.
2. **Tabs** — roving `tabindex` + arrow-key navigation (Home/End/Left/Right) and
   `aria-controls`/`aria-selected` wiring is fiddly to repeat correctly per page.
3. **Toast** — a queue + auto-dismiss timer + pause-on-hover is more state than a
   one-liner should hold.

If/when adopted, these would live in a single self-hosted `bmo-behaviors.js`
exposing `Alpine.data()` factories — **none of which exists today** (confirmed:
there is no behavior layer in this package). Until then, the inline contracts
above are the supported approach.

---

## 6. Icon system

For the **Fluent** family, the durable contract is the **name token**
`{icon}-{size}-{variant}` (e.g. `home-24-regular`), **not** any one wrapper.
Three delivery forms all key off that same token — two SVG (the sprite `<use>`
and the `<fluent-icon>` element) plus a first-party Fluent **icon font** — so a
dev can adopt zero, some, or all of the JS, and pick the delivery that fits the
page.

A **fourth** form (§ Form 4) covers standalone SVG files addressed by URL. That's
how the **Abacus** icons in `abacus-icons/` are used — they are a separate
BMO consumer-brand family, not Fluent, and are not in any sprite.

### Form 1 — no-JS `<use>` (DEFAULT, fully supported)
Needs only the two CSS files + the inlined sprite. **A dev not ready for our
scripting is never blocked.**

```html
<svg class="icon icon--16"><use href="#ic-fluent-home-24-regular"/></svg>
```

### Form 2 — `<fluent-icon>` sugar (optional)
Needs only `fluent-icon.js` (one script tag). Authors by name token; forwards
size helper classes; `label="…"` exposes it to assistive tech (decorative by default).

```html
<script src="fluent-icon.js" defer></script>
<fluent-icon name="home-24-regular"></fluent-icon>
<fluent-icon name="search-24-regular" class="icon--20"></fluent-icon>
<fluent-icon name="warning-24-filled" label="Warning"></fluent-icon>
```

### Form 3 — Fluent icon font (optional; the full set, no sprite, no JS)
Microsoft ships Fluent System Icons **as a font** — the same icons, first-party,
in `@font-face` form. Self-host the font + its CSS in SiteAssets, link the CSS,
and render an icon as a class on an `<i>`:

```html
<link rel="stylesheet" href="FluentSystemIcons-Regular.css">   <!-- ships its own @font-face -->
<i class="icon-ic_fluent_home_24_regular" aria-hidden="true"></i>
```

The class is the name token with **underscores** and an `icon-ic_fluent_` prefix:
system token `home-24-regular` → `icon-ic_fluent_home_24_regular` (the same
`-`→`_` transform that maps a sprite name token to a Fluent SVG filename). Add
`FluentSystemIcons-Filled.css` for `…_filled` variants.

**Why reach for it:** it's the lowest-friction way to get the **entire** Fluent
set self-hosted with **no build and no JS** — no per-page sprite to inline, no
48-symbol curation. It's the answer when a page needs **many** icons beyond the
curated `fluent-basic-icons.svg` set (for just a **few** extras, copy the matching SVGs
from the `fluentui-system-icons` repo into the sprite instead — see "Adding an
icon" below). It is **first-party Fluent, not a third-party icon kit**, so it's
consistent with the "hand-rolled Fluent 2, no third-party icon kits" rule — that
rule is about not pulling in an external icon kit, not Microsoft's own Fluent
font.

**Tradeoffs (why it isn't the default):**
- **Accessibility.** Font glyphs are Private-Use-Area characters; a screen reader
  may announce nothing or a stray codepoint. Always `aria-hidden="true"` the `<i>`
  and put the real label on the interactive parent (`aria-label` on the button/link)
  or adjacent text. The SVG forms are more inherently accessible (they can carry a
  `<title>` / `role="img"`), which is why the no-JS `<use>` sprite stays the default.
- **Sizing is `font-size`, not `.icon--N`.** The `.icon--12/16/20/24/28/48` helpers set
  SVG width/height and don't apply to `<i>`. Size the font icon with `font-size`
  (and `line-height:1`); pick the glyph whose baked size matches (`…_24_regular`
  vs `…_20_regular`).
- **Color** inherits `currentColor` like text — same as the sprite. ✓
- **FOUT.** Icons are invisible until the font loads; prefer `woff2` + `font-display`
  to minimize the flash. The inline sprite has no such flash.
- **Buildless caveat.** Ship the **full** font as-is (a few hundred KB `woff2`).
  *Subsetting* it to shrink the download needs a build step — which breaks the
  buildless rule — so don't subset; accept the full font, or stay on the curated
  sprite (~14 KB).
- **Not shipped here — lives in the `fluentui-system-icons` companion repo.** The
  full Fluent library is maintained as a **separate repo** (`fluentui-system-icons`)
  holding the font builds (`FluentSystemIcons-{Regular,Filled,Light,Resizable}.{woff2,css}`
  with per-style HTML/JSON codepoint indexes), the per-icon SVGs, and the
  `fluent-font-library.{json,html}` master index. Take
  `FluentSystemIcons-Regular.{woff2,css}` (and `-Filled` if needed) from there and
  self-host them in SiteAssets — everything in that repo exists and works as
  described here, under the same criteria. **No part of this system resolves a
  path to that repo** — there is no config key and no build step that reads one.
  In **production it deploys as its own top-level folder, `fluent-icons/`**, a
  sibling of `bsp-design/`, so a page links it as `…/fluent-icons/FluentSystemIcons-Regular.css`.
  On the dev machine it's a separate clone; ask where it lives rather than assuming. (Upstream source: Microsoft's
  [`fluentui-system-icons`](https://github.com/microsoft/fluentui-system-icons).)

### Form 4 — direct URL `<img>` (standalone SVG files; how Abacus icons are used)
The three forms above all key off a Fluent name token. **Abacus icons don't** —
they're a separate BMO consumer-brand family in `abacus-icons/`, named
`<icon>-<size>.svg`, and the **file URL is the whole contract**. No sprite, no
name token, no JS, nothing to inline:

```html
<img class="icon icon--24" src="abacus-icons/add-24.svg" alt="">
```

This needs no new CSS. `.icon` and `.icon--N` set **geometry only** — width,
height, `flex:none`, and a baseline nudge — with no `<use>`, sprite, or
`currentColor` dependency, so they apply to an `<img>` exactly as they do to an
inline `<svg>`.

**Sizing.** Abacus ships at 16/24/28/48, and the `.icon--N` ladder covers all
four — `.icon--12/16/20/24/28/48`. Always pin the size: bare `.icon` is `1.25em`,
so it renders a 28px icon at 20px against a 16px font.

**Color: none.** An `<img>` can't be tinted, and Abacus SVGs carry baked hex
rather than `currentColor` — so you take each icon in its shipped colors. This
costs nothing here (the two facts cancel), but it does mean any `color`-based
tinting has **no effect**. On a blue ground use `.icon--on-blue` (editorial.css),
which forces the glyph white with a filter. Don't use this form for Fluent
icons you want to inherit text color; use Form 1.

**Accessibility differs from the sprite forms.** The element itself carries the
text alternative: `alt=""` when decorative, a real `alt` when the icon is the
sole carrier of meaning. `aria-hidden` on top of `alt=""` is redundant.

**In native SharePoint web parts there's no markup at all.** Image, Quick Links,
and Hero web parts take a URL — point them at the SiteAssets path. The design
system isn't involved; this form only matters in embed-authored HTML.

### Which form should I use?
- **Default → no-JS `<use>` sprite.** Most accessible, zero dependency, no font
  load, curated set. Best for the icons the system already ships.
- **Abacus icons → Form 4 (`<img src>`).** They are not in any sprite and are not
  Fluent-token-addressable; the URL is the contract.
- **`<fluent-icon>`** when you want the optional sugar element (same sprite).
- **Icon font** when you need **breadth** (many Fluent icons) or the **least
  setup** (no per-page sprite, no JS) — and you handle the `aria-hidden` + label.
- **A few icons the sprite lacks** → copy the real SVGs from the
  `fluentui-system-icons` repo into `fluent-basic-icons.svg` (see "Adding an icon").

### Sprite, sizing, and the tradeoff
- **Inline `fluent-basic-icons.svg` once per page** (drop it in the body). Both forms emit
  same-document `#id` references, so the sprite must live in the document.
- **Sizes:** the `.icon` class is `1.25em`; pin with `.icon--12/16/20/24/28/48`
  (28 and 48 exist for the Abacus ladder but work on any icon form). The
  sprite is normalized to the **24** viewBox; size is a CSS concern, so
  `name="…-24-regular" class="icon--20"` is correct — you don't need a 20px
  symbol.
- **Color:** glyphs use `fill:none` + `currentColor`, so they inherit text color.
- **The two SVG forms are equivalent:** both emit a same-document `<use>` against
  the sprite and share the same name tokens, so mixing or moving between them is
  purely mechanical. Pick `<use>` for zero-JS, `<fluent-icon>` for the sugar.
- **Adding an icon (the escape hatch for a few extras):** copy the matching real
  SVG from the `fluentui-system-icons` repo (its `svg/` folder, e.g.
  `ic_fluent_{name}_24_regular.svg`) into `fluent-basic-icons.svg` as a `<symbol>`, set
  `id="ic-fluent-{name}-24-regular"`, and normalize it to `fill:none` +
  `currentColor` on the 24 viewBox. Filled variants suffix `-24-filled`. For
  **many** extra icons, self-host the icon font instead of growing the sprite.

The sprite ships 48 symbols (46 regular + `checkmark-circle-24-filled`,
`warning-24-filled`). If you reference a name with no symbol, the icon renders
blank — add the symbol; don't invent one elsewhere.

---

## 7. Gotchas & SharePoint constraints

- **Buildless & CDN-free.** No bundler, no npm build, no external CDN at runtime.
  Everything is self-hosted in SiteAssets. Link CSS directly; inline the sprite.
- **Alpine is yours to host.** The system ships **no behavior layer**. Add Alpine
  yourself. The examples may show a public CDN tag for convenience —
  **point it at a self-hosted copy in SiteAssets for production** (SharePoint
  pages should not depend on an external CDN):
  ```html
  <script defer src="alpine.min.js"></script>   <!-- self-hosted, not unpkg -->
  ```
- **`<fluent-icon>` must be light-DOM.** The element renders into itself (no
  shadow root) on purpose — an `<svg><use href="#id">` cannot reach a
  document-level sprite `<symbol>` from inside shadow DOM. Don't "fix" it to use
  a shadow root.
- **Icon convention is `ic-fluent-{name}-{size}-{variant}`.** Same-document
  `#id` refs; inline the sprite per page. Don't reference the sprite as an
  external file unless you also repoint `fluent-icon.js`'s `resolve()`.
- **SharePoint custom-script considerations.** Inline `<script>` and custom
  elements require *custom scripts* to be enabled on the site
  (`Set-SPOSite -DenyAddAndCustomizePages $false`) or deployment via a method
  that permits scripting. The no-JS path (CSS + sprite + `<use>`) works even
  where custom script is disabled.
- **The shell already loads Segoe UI** — no `@font-face` needed in SharePoint;
  the font stack falls back gracefully in standalone previews.
- **Retired vocabularies — do not reintroduce.** The old forks
  (`.btn primary` / `.btn.primary`, `size-lg`, `.is-focus`/`.is-disabled`,
  `.cc`/`.cc-b`/`.cc-ic`, `.statcard`, `.card-body`, `#i-*` and `#ic-*` icon ids,
  raw `<svg width=…>`) are gone. Use the canonical BEM in §2 and the
  `ic-fluent-*` icon tokens in §6.
- **Tokens are the only source of values.** No raw hex, no off-ramp px at the
  component layer. If you need a value the system doesn't expose, add a token.
```

