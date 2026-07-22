# Editorial mode — Phase 1 audit + spec proposal

**Status:** proposal for sign-off. Nothing built yet. This confirms the scoping
mechanism, the additive token set, the component list, the spot-illustration /
line-icon delivery, and a one-page plan for the flagship example — then stops for
your approval before any CSS or pages are written.

Source of truth throughout: the `bsp-design-system` repo. Where my memory of the
system differed, the repo won (notes inline below).

---

## 1. Audit — what's already there (and what editorial mode inherits)

I read the read-first set in full: `CLAUDE.md`, `.github/copilot-instructions.md`,
`docs/PAGE-TEMPLATE.md`, `colors_and_type.css`, `components.css`,
`context/BMO-INTERNAL-WEB-BRAND.md`, the illustration library, and the reference
packing list.

**The good news: the engagement layer already does ~60% of editorial's job.**
`components.css` already ships a promoted "engagement layer" and "page-shell layer":
`.band` / `.band--sky|blue|neutral|white`, `.hero` (+ `__eyebrow/__title/__lede/__cta/__media`),
`.feature` (split image+copy), `.qcard`, `.section-head`, `.l-wrap` / `.l-section` /
`.l-grid--2|3|4`, `.suite` (SP suite bar), `.crumbs`, `.trust`, plus the `.imgph` /
`.photo` / `.lift` / `.reveal` utilities and the `--surface-tint-*` tokens. These
exist "for exactly this warmth" (the brief's words). Editorial mode is largely
**turning these dials up under a scope**, plus adding the handful of patterns the
BMO Learning / Programs & Resources patterns need that don't exist yet.

**The A/B rule split (brief §1), applied.** I've sorted every rule into:

- **Pile A — HARD, inherited unchanged:** buildless / CDN-free / self-hosted;
  one BEM vocabulary on the shared tokens (no raw hex, no off-ramp px, never
  redefine `:root`); interactivity = inline Alpine inside an `x-data` root; icon
  contract (`ic-fluent-{name}-24-regular` over the inlined `bmo-icons.svg` sprite,
  size via `.icon--N`); hand-rolled Fluent 2 + BMO, no third-party kit. **All of
  this stays.**
- **Pile B — austerity defaults editorial RELAXES (under scope only):** small type,
  high density, tight spacing, ornament-avoidance, illustrations-never-as-hero,
  `shadow-4/8` ceiling. Editorial turns these the other way — bigger display type,
  more air, hero-led, illustration/photography-forward — **without touching pile A.**

**Repo-wins reconciliations worth flagging:**
- The single interactive blue is **`#0079C1`** (`--accent-rest`), *not* the
  `#0075BE` "Accessible Blue" the older brand doc mentions. Confirmed in the token
  file's reconciliation note.
- Headings H1–H3 are **Regular** weight, only H4–H6 bold. The existing
  `.hero__title` / `.section-head__title` / `.feature__title` already follow this
  (regular weight, negative letter-spacing). Editorial's larger steps will too.
- Link focus is **BMO-red text** — this is the *one* sanctioned red in UI and it's
  already in the base `a:focus-visible`. Editorial inherits it; I won't touch it.
- The illustration SVGs carry **baked-in hex** in the consumer-blue family
  (`#0079C1 #73C3EB #005587 #001928 #C1E7FF`), not `currentColor` — this drives the
  delivery recommendation in §5.

---

## 2. Scoping mechanism (open question → recommendation)

**Recommendation: a single root scope class `.editorial`** on the page or section
wrapper. Everything editorial-specific is written as `.editorial <selector>` (or
`.editorial .card--course` etc.). Rationale:

- Matches the existing vocabulary (plain classes, BEM), reads naturally, and lets an
  austere **app** embedded *inside* an editorial page keep its own styling — the app
  fragment simply isn't under `.editorial`, or explicitly opts back out. The brief
  calls out exactly this coexistence requirement.
- No `:root` redefine. The relaxed scale is delivered as scoped overrides + new
  scoped blocks, e.g. `.editorial { --ed-display: ...; }` sets **editorial-only**
  custom properties on the scope element (additive names, `--ed-*`), and scoped rules
  consume them. The global `:root` tokens are untouched; app mode never sees `--ed-*`.
- Alternatives considered: `data-mode="editorial"` (attribute) is equally valid but
  less idiomatic here; `x-editorial` implies Alpine ownership it doesn't need. `.editorial`
  wins on familiarity.

**Escape hatch:** `.editorial .app-scope { /* nothing */ }` isn't needed — because the
relaxed values live on `--ed-*` and scoped selectors, an embedded app subtree that
doesn't use editorial blocks is unaffected automatically. I'll document the pattern
either way.

**Naming convention for new blocks:** editorial-only blocks that have no app-mode
counterpart get plain BEM names and are documented as editorial (`.course-card`,
`.scorecard`, `.facilitator`, `.link-row`, `.spot`, `.cta-band`, `.media-card`,
`.key-messages`). Editorial *variants* of existing blocks use modifiers
(`.hero--scrim`, `.hero--arc`, `.hero--spot`, `.card--course`). New custom properties
are all `--ed-*` and only defined on `.editorial`.

---

## 3. Additive editorial token set (`--ed-*`, defined on `.editorial` only)

All derived from / layered over existing tokens — never new raw values where a token
exists. Proposed set:

**Display type scale** (the open question in §8 — how much bigger than app mode).
Recommendation: a compact editorial display ramp on Segoe, Regular weight, that sits
*above* the existing `.hero__title` (38px). Proposed:
- `--ed-display: var(--weight-regular) 52px/60px var(--font-family)` — editorial hero H1
- `--ed-title-1: var(--weight-regular) 40px/48px var(--font-family)` — section spotlights
- `--ed-title-2: var(--weight-regular) 32px/40px var(--font-family)` — sub-heads
- `--ed-lede: var(--weight-regular) 20px/30px var(--font-family)` — hero/lede body

These reuse the existing type philosophy (regular-weight headings, negative tracking on
the big steps) and the Fluent ramp sizes (52/40/32 already exist as `--type-large-title`
/ `--type-title1` / `--type-title2` values), just re-expressed as editorial roles at
regular weight. Body stays 16px (`--type-body2`) — editorial doesn't shrink text.

**Section rhythm / air:**
- `--ed-section-y: var(--space-560)` (56px) — taller than app `.l-section` padding
- `--ed-gap: var(--space-320)` (32px) — roomier grid gaps than app's 16–20px
- `--ed-hero-min: 420px` — editorial hero min-height (photo/spot heroes)

**Shape / elevation (relaxed ceiling, still restrained):**
- `--ed-radius: var(--radius-large)` (8px) as the editorial card default
- `--ed-radius-xl: var(--radius-xlarge)` (12px) for hero media / feature blocks
- Editorial cards may use `--shadow-8` at rest and `--shadow-16` on `.lift` — one step
  up from app's `shadow-4` ceiling, still well under the banned `shadow-64`.

**Brand hero devices (from Brand Toolkit recipes, driven by tokens):**
- `--ed-scrim: rgba(0,25,40,.55)` — text-legibility scrim over a photo hero (Slate-based,
  same family as the existing `--scrim`, a touch stronger for large text over imagery)
- `--ed-blue-overlay` — the "blue overlay" recipe (100% BMO blue, multiply, greyscale
  image beneath at ~40%). Implemented as a scoped treatment using `--accent-rest` +
  `mix-blend-mode: multiply` on a `::before`, image `filter: grayscale(1)` — no gradient,
  honoring the toolkit recipe.
- `--ed-blue-band: color-mix(in srgb, var(--accent-rest) 85%, transparent)` — the
  translucent "blue band" panel (85% opacity, normal blend) for a text panel over media.

**Bokeh** (approved alt to photography for dry content): sourced/generated as a
**spec-compliant SVG asset** (blue gradient corner-to-corner + translucent round
circles) and self-hosted, *not* faked with CSS that could distort. Referenced as a
background image on `.hero--bokeh` / `.band--bokeh`. (Delivery detail in §5; this is the
one place a "gradient" is sanctioned because it's the approved brand artwork, not a
decorative page gradient.)

No `--ed-*` color tokens beyond the two hero-device helpers — editorial uses the
existing brand blues, greys, and `--surface-tint-*` bands. Blue stays interactive/unifier;
the expanded `--bmo-chart-*` accents stay charts-only; red stays logo-only.

---

## 4. Editorial component set (variants + new blocks)

Grouped by whether they extend an existing block or are new editorial blocks. Every
one is token-built and (where interactive) uses the documented Alpine state contract.

**Extend existing blocks (modifiers):**
1. **Hero variants** — `.hero--scrim` (full-bleed photo + scrim + text over),
   `.hero--arc` (the BMO arc/ring crop motif framing the hero image),
   `.hero--spot` (spot-illustration-as-hero on white/albicant, for dry subjects),
   `.hero--bokeh` (bokeh background behind copy/illustration). Recommendation: build
   arc/ring as a **variant**, not per-page art (open question §8).
2. **Feature banner** — reuse `.feature`; add `.feature--overlay` (copy in a blue band
   over the media) for the "Major Resource Hub" hero shape.
3. **Course-module card** — `.card--course`: image-top + blue **"COURSE NAME" eyebrow
   chip** + headline + blurb + "More information →". Uses `.card--flush` + `.card__media--top`
   + a chip-styled eyebrow. Plus a denser grid arrangement (`.l-grid--3/4`).
4. **Section head** — reuse `.section-head` / `.section-head--flex` (with "View all →").

**New editorial blocks:**
5. **Course-materials link-rows** — `.link-row`: icon + link + one-line descriptor,
   stacked on dividers (the "Course Materials" / icon-link supporting-info pattern).
6. **Facilitator card** — `.facilitator`: avatar + name / title / phone / email.
7. **Category / subcategory chips** — reuse `.chip` / `.chip-row`; add an editorial
   `.chip--category` treatment if needed for the larger register.
8. **Essential-resources tinted grid** — a card grid composed on a `.band--blue`
   tinted band (composition, not a new block).
9. **Scorecard tiles** — `.scorecard` / `.scorecard__tile`: **solid BMO-blue** tiles,
   white corporate line-icon + metric label + caption. (This is the one place a solid
   blue *fill behind content* is sanctioned — it's the blessed BMO pattern; documented
   as an explicit, bounded exception to "blue is never a decorative fill.")
10. **Media / video card** — `.media-card`: thumbnail + **play overlay** (Fluent play
    icon in a circular scrim button) + title.
11. **Key-messages carousel** — `.key-messages`: person photo + quote + **dot nav**,
    wired with minimal inline Alpine (index state, dot `.is-active` + `aria-selected`).
12. **CTA band** — `.cta-band`: a full-width band with headline + primary button
    ("Learn more" driven warmth).
13. **Spot-illustration wrapper** — `.spot` / `.spot--sm|md|lg`: sizing + placement
    helper that stages an illustration on white/albicant at the sanctioned ~1/page
    prominence (§5).

**Roles / image tiles** (Learning "Roles"): composed from `.card--flush` +
`.card__media--top` — no new block needed.

---

## 5. Spot illustrations + corporate line-icons — delivery (open questions → recs)

**Spot illustrations (154 SVGs, baked-in hex, `bmo-illustration-library/`).**
Recommendation: **reference as `<img src>` from a self-hosted illustrations folder**,
wrapped in `.spot`. Rationale:
- Buildless / self-hosted compliant — the folder ships in SiteAssets like any asset.
- The SVGs are multi-color with baked hex (not `currentColor`), so inlining buys no
  theming benefit and would bloat pages; `<img>` keeps them cacheable and the markup
  clean. A generated sprite is possible but offers no win for full-color art referenced
  ~1/page.
- **A11y:** decorative-by-default — `<img alt="" role="presentation">` (or the `.spot`
  wrapper `aria-hidden`) when the illustration merely warms a section; a **meaningful
  `alt`** only when it's the sole carrier of meaning (rare). Documented as a rule.
- For this project I'll **copy the specific illustrations each example page uses** into
  the project (not the whole 154-file library — that's a bulk asset dump). The catalog
  stays the index.

**Corporate line-icon tier (not yet in repo — brief §8).** These are the
content-labeling glyphs ("Our Clients," "Regulators," scorecard tile icons), distinct
from the Fluent app icons. Recommendation: **a separate sprite, same pattern as
`bmo-icons.svg`** — a `bmo-content-icons.svg` with `<symbol id="bmo-ic-{name}">` ids,
inlined once per page, sized by a helper class. Keeping it a *separate* sprite (not
growing `bmo-icons.svg`) preserves the brief's hard line between functional Fluent icons
and corporate line-icons, and mirrors the existing icon-contract mechanics exactly.
- Since the official "BMO Design Icons" set isn't in the repo, I'll **build a small
  curated subset** (the handful the two example pages need) as on-brand line-icons that
  follow the illustration/icon rules (BMO blue/slate line, rounded caps, 48–96px art at
  24 viewBox), clearly labeled as placeholders standing in for the licensed set — same
  posture the repo already takes with the placeholder logo. Flagging this so you can
  swap in the real library later.

---

## 6. Flagship example plan — Learning Catalog / course page (one page)

Built first (Phase 2), framed inside representative SP-modern chrome so the mesh is
visible. Structure, top to bottom:

1. **SP chrome (meshing frame):** the blue SP **suite bar** (`.suite`), a hub-nav
   strip + site title + horizontal nav row, and the `© BMO Financial Group` footer
   bar. Our editorial content sits inside this frame. (Chrome is recreated from the
   existing `.suite` block + the reference screenshots' vocabulary — not cloned pixel
   for pixel.)
2. **Editorial hero** — `.hero--scrim` over a photo of people learning (authentic,
   natural-light per §3.1), eyebrow "Learning", H1 at `--ed-display`, one lede, a
   primary "Browse courses" CTA. One hero device only (scrim) — kit-of-parts discipline.
3. **Category chip row** — filter chips (All / Compliance / Leadership / Technology…),
   inline Alpine driving `.is-active` + `aria-pressed`.
4. **Course-module grid** — `.card--course` in `.l-grid--3`: image-top, blue "COURSE
   NAME" eyebrow chip, headline, blurb, "More information →". This is the flagship
   proof of the blessed Learning pattern rendered in-token.
5. **Course materials** — `.link-row` list (icon + link + descriptor) on a white section.
6. **Facilitators** — `.facilitator` avatar cards (name / title / phone / email) in a grid.
7. **A spot-illustration section marker** — one `.spot` (e.g. `education-l.svg` /
   `knowledge` on white) introducing a "dry" sub-section (e.g. a self-serve learning-
   standards area), proving the illustration-as-warming-accent use — ~1 per page, staged
   on white, not competing with the photo hero.
8. **CTA band** — `.cta-band` on a tinted band: "Can't find a course? Request one" +
   button.
9. **Footer** — `© BMO Financial Group` bar.

This one page exercises: the scope, the display scale, a photo hero + scrim device, the
course pattern, link-rows, facilitators, a spot illustration used correctly, a tinted
band, and the SP mesh — i.e. it proves the whole system before the second example.

**Second example (Phase 3):** Resource Hub — arc/ring hero, essential-resources tinted
grid, scorecard blue tiles, media/video cards with play overlays, key-messages carousel.
This is where bokeh, the scorecard exception, and the carousel get proven.

---

## 7. Deliverables & wiring (confirming the plan)

- `editorial.css` — additive layer (editorial `--ed-*` tokens on `.editorial`, scope,
  variants + new blocks). **Linked after `components.css`.** I'll add an `@import` line
  to `styles.css` after the existing two so the one-tag bundle stays coherent, and
  document both wirings.
- Editorial component set (§4).
- Spot-illustration + line-icon delivery (§5).
- Example pages: Learning Catalog (flagship), then Resource Hub — from
  `docs/PAGE-TEMPLATE.md` scaffolding, framed in SP chrome.
- `docs/EDITORIAL-MODE.md` — when editorial vs app; the 3-tier art rules; component
  catalog with copy-paste snippets; do/don't; the scope mechanism.
- Housekeeping — cross-link from `CLAUDE.md` file map; `CHANGELOG.md` entry; no retired
  vocabulary reintroduced.

> **Note on build environment:** these deliverables are authored here as streaming
> Design Components (`.dc.html`) that load the design-system bundle, which is how this
> workspace previews them. The *shipped* artifact stays buildless raw HTML/CSS/JS —
> `editorial.css` and the page markup are plain, copy-paste-able, and open-from-disk
> safe, exactly as pile A requires. I'll call out the mapping in the docs.

---

## 8. Open questions — my recommendations (please confirm or redirect)

1. **Scope class name** — **Rec: `.editorial` root class** (§2). Confirm, or prefer
   `data-mode="editorial"`?
2. **Editorial display type scale** — **Rec: add `--ed-display` 52/60 and a small
   editorial ramp** (40/32/20) at regular weight (§3). Comfortable with 52px as the top
   step, or want it bigger (e.g. 64–68px like `--type-display`) / more restrained?
3. **Spot-illustration delivery + a11y** — **Rec: `<img>` from a self-hosted folder,
   decorative `alt=""` by default, copy only the illustrations each page uses** (§5).
   OK?
4. **Corporate line-icon library** — **Rec: a separate `bmo-content-icons.svg` sprite
   (same pattern as `bmo-icons.svg`); build a small on-brand curated subset as labeled
   placeholders** until the licensed "BMO Design Icons" set is added (§5). OK, or do you
   have the real set to drop in?
5. **Light/dark** — **Rec: light-only** (SP intranet is effectively light-only; no dark
   investment). Confirm.
6. **Arc/ring hero motif** — **Rec: build as a reusable `.hero--arc` variant** (§4).
   Confirm vs per-page art.
7. **Scorecard blue-fill exception** — I'm treating solid-blue scorecard tiles as a
   *bounded, documented exception* to "blue is never a decorative fill," because it's a
   sanctioned BMO pattern with white content on top. Flagging explicitly — OK to encode
   it as the one allowed blue-fill-behind-content?
8. **Bokeh asset** — **Rec: self-host a spec-compliant bokeh SVG** (blue gradient
   corner-to-corner + round translucent circles) rather than hand-faking with CSS (§3).
   OK for me to generate one that follows the recipe?

---

**Next step:** on your sign-off (and answers to §8), I proceed to Phase 2 — build
`editorial.css` + the flagship Learning Catalog page and prove the mesh + the 3-tier
art system on one real page.
