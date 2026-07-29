# Editorial mode

The warm, employee-facing content register for the BMO SharePoint Design System —
learning catalogs, resource hubs, awareness pages, program landing pages. It is an
**additive layer**, not a fork: same tokens, same BEM vocabulary, same delivery
constraints. It relaxes the app register's austerity (bigger type, more air, hero-led,
photography/illustration-forward) and selectively pulls in the BMO marketing brand.

- **Layer:** `editorial.css`, linked **after** `components.css` (opt-in, only on
  editorial pages — it is not part of the `styles.css` bundle).
- **Scope:** everything editorial lives under a root `class="editorial"`.
- **Proof pages:** `examples/editorial-learning-catalog.html`, `examples/editorial-resource-hub.html`.
- **Library + guide:** `examples/editorial-components.html` (every block live, copy-paste
  markup), `examples/editorial-design-guide.html` (showcase-vs-mesh, hero chooser, do/don't).

---

## 1. When to use editorial vs app

| | **App mode** (default) | **Editorial mode** |
|---|---|---|
| Purpose | Get work done — intake, approvals, dashboards, data | Inform, orient, welcome — catalogs, hubs, awareness |
| Feel | Dense, austere, "effective over aesthetic" | Warm, spacious, hero-led, brand-forward |
| Type | Small (14–16px), tight | Large display steps, generous line-height |
| Imagery | Rare; functional icons only | Photography leads; spot illustrations; brand devices |
| Motion | Minimal | Reveal-on-scroll, hover-lift (still functional) |
| Example | Expense & approvals applet | The learning catalog example |

**They coexist.** An app applet embedded inside an editorial page keeps its own austere
styling — it simply isn't under `.editorial`, and the editorial `--ed-*` tokens never
reach it. Don't restyle an embedded app to "match"; let each register be itself.

Everything that makes the app register correct (Content fundamentals: plain, calm,
sentence-case, no emoji, numerals, explicit currency) is **unchanged** in editorial. Warm
is a matter of scale, space, and imagery — not chattier copy.

---

## 2. Delivery constraints (unchanged — "pile A")

Editorial ships inside SharePoint Online exactly like app mode, so every hard rule holds:

- **Buildless, CDN-free, self-hosted.** No bundler, no ES `import`, no runtime CDN.
- **Token-only.** Every value is `var(--token)`. No raw hex, no off-ramp px. **Never
  redefine `:root`** — editorial adds `--ed-*` custom properties *on the `.editorial`
  scope*, layered over the existing scale.
- **One BEM vocabulary.** Compose existing classes + modifiers; new editorial blocks have
  unique names.
- **Interactivity = inline Alpine** against the documented state contract — the example
  pages wire the filter chips and carousel exactly this way (see §7).
- **Icon contract** unchanged for functional icons: `ic-fluent-{name}-24-regular` over the
  inlined `fluent-basic-icons.svg` sprite, sized with `.icon--N`.

---

## 3. The three-tier art system

Editorial formalizes how each asset family may appear. This is the guardrail that keeps it
from becoming clip-art soup.

| Tier | Asset | Source | Allowed use | Never |
|---|---|---|---|---|
| **0 · Photography** | Real photos (`.photo` wrapper) | Licensed BMO library | **Leads.** Hero and feature moments on home / article / intro pages where a warm, authentic human moment fits. | Dark/dramatic/high-contrast; trendy filters; glossy stock |
| **1 · Functional icons** | Fluent `ic-fluent-*` | `fluent-basic-icons.svg` | App UX affordances — buttons, controls, inline meaning, chrome. Unchanged from app mode. | Content decoration |
| **2 · Content-labeling icons** | Abacus SVGs via `<img class="icon icon--N">` | `abacus-icons/` ([contact sheet](../abacus-icons/index.html)) | **Content labeling** — categories, section markers, scorecard-tile glyphs. On a blue tile add `.icon--on-blue`. | Real app UX (edit/save/nav) — that's tier 1 |
| **3 · Spot illustrations** | 481-SVG BMO line-drawing family | `spot-illustrations/` ([contact sheet](../spot-illustrations/index.html)) | **Hero-substitute / feature moment**, ~1 per page, staged on white/albicant, for dry subjects or app welcome screens; or a section-divider accent. | Competing beside a photo hero; wallpaper repetition; crowding |

**The prominence rule.** Photography leads. When a page has a photo hero, do **not** place
a spot illustration or corporate line-icon at competing prominence. A spot illustration as
hero is a deliberate *substitute* (for a dry subject with no appropriate photo), never a
co-star beside a photo.

**How to choose photo vs spot illustration:**
- **Photography** → home, article/news, intro/welcome pages with a genuine human moment.
  Select for BMO's voice: authentic / candid / natural light / believable human
  perspective / diverse. *Not* object close-ups or staged stock. (A course on
  anti-money-laundering shows attentive colleagues, not a pile of cash.)
- **Spot illustration** → an intro for **dry** subject matter where a photo feels forced
  (e.g. a standards library); to warm an **app welcome/landing** screen; or as a **section
  divider** accent down a long page.

**Spot-illustration delivery:** reference as `<img>` from the self-hosted `spot-illustrations/`
folder (the SVGs carry baked-in brand hex, so inlining buys nothing). Decorative by
default — `alt="" aria-hidden="true"`; use a meaningful `alt` only when the illustration is
the sole carrier of meaning. Copy only the illustrations a page uses.

> **There is no content-icon sprite.** The old placeholder sprite (`bmo-ic-*` via `.c-icon`)
> has been **removed**. Tier 2 is now served directly by the canonical Abacus set —
> `abacus-icons/` (712 SVGs, [contact sheet](../abacus-icons/index.html)) — referenced by
> URL and **never inlined into a sprite**:
>
> ```html
> <img class="icon icon--32" src="abacus-icons/goals-48.svg" alt="">
> ```
>
> Size with the base `.icon--N` ladder (TECHNICAL-REFERENCE §6, Form 4). These SVGs carry
> baked hex and an `<img>` can't inherit `color`, so **on a blue ground a blue glyph
> disappears** — add `.icon--on-blue`, which forces the mark white with a filter.

---

## 4. Brand hero devices (digital-valid subset)

BMO's graphic elements are a **kit of parts**: a page uses a *few*, never stacks them on
one element. The digital-valid subset, all token-driven:

| Device | Class | Recipe |
|---|---|---|
| **Blue band** | `.hero--band` | Translucent BMO-blue panel over a full-colour photo, heaviest behind the text, fading toward the image (≤85% blue, Normal blend). The BMO Central home-hero treatment — blue clearly carries the frame. |
| **Blue overlay** | `.hero--blue` | 100% BMO blue, Multiply blend, over a greyscale image at ~40% opacity (20–40% for darker images). A heavier brand wash. |
| **Scrim** | `.hero--scrim` | Slate legibility scrim, weighted to the text. Use when the photo should stay near full-colour and you only need legibility. |
| **Circle overlay** | `.hero--circle` | Concentric partial rings (the roundel-derived motif) arcing over hero imagery. Inline SVG, brand-token strokes, `aria-hidden`. |
| **Arc / ring** | `.hero--arc` | Circular photo crop encircled by a single-tone thin ring (BMO blue, or `.hero--arc--white` over darker grounds). The roundel-derived "Major Resource Hub" treatment. |
| **Arc on blue** | `.hero--arc-blue` | The photo circle atop a solid BMO-blue block — white ring, white copy (sanctioned blue fill; text + at most one inverted CTA, never controls). |
| **Masonry** | `.hero-masonry` | The SP tiled hero web part — count-aware: 2 tiles side by side, 3 = lead spanning two equal rows + two stacked, 4 = lead + wide top-right + two below. Functional scrim + white titles. Always flat/flush; never takes the showcase frame. |
| **Bokeh** | `.hero--bokeh` (+ `--bokeh-a`…`-e`) | The official BMO bokeh artwork, self-hosted in `assets/` (blue gradient corner-to-corner + round translucent circles) — the sanctioned alternative to photography for dry content. Five variants; see the chooser below. |
| **Flood of blue** | `.band--flood` | A solid BMO-blue section band, white content, inverted white buttons. Use for one CTA / statement band. |

### Choosing a bokeh variant

Five bokeh files ship as `assets/bmo-bokeh-{a…e}.svg`. They are one design — a corner-to-
corner blue gradient, light at the bottom-left, deep BMO blue at the top-right, with
translucent white circles clustered toward the light corner. What differs is **how much of
the frame the circles occupy**, and therefore how much clear gradient is left for a
headline, a photo, or a spot illustration to sit on.

| Variant | Character | Reach for it when |
|---|---|---|
| **a** (default) | Busiest — circles across nearly the whole frame; only the top-right corner stays clear | The artwork *is* the content; little or no overlay |
| **c** | Dense, opening up toward the right edge | Short headline held to the right |
| **b** | Balanced — clear upper band, texture below | The general-purpose choice; headline top, texture under it |
| **e** | Clear top half; circles in the lower ~40% | A full headline + lede across the top |
| **d** | Sparsest — clear across the top-right two-thirds, circles as a bottom-left corner accent | Text-heavy heroes, or a photo/illustration composited over it |

```html
<div class="hero hero--banner hero--bokeh hero--bokeh-d"> … </div>
```

`.hero--bokeh` on its own gives you **a**. Add a variant modifier alongside it — the
variant class only swaps the image, so both classes are required.

> **The source art is square (1:1 — declared `48in`, i.e. 4608px intrinsic).** Under `background-size: cover` a wide banner
> shows a horizontal slice through the middle, so the top-right clear corner and the
> bottom-left cluster are both partly cropped — the taller the hero, the more of the
> composition survives. Bias it with `background-position` when a specific region has to
> stay visible, and check the variant at the hero's real aspect ratio rather than trusting
> the square preview.

The full-bleed photo heroes (`--scrim` / `--blue` / `--band` / `--bokeh`) build on
`.hero.hero--banner` (a layered banner); a page picks **one** of these banner treatments.
`--arc` builds on the two-column base `.hero`. All heroes are flat/flush — square corners,
no border, no elevation — matching the OOB SP hero web part, in both finishes.

**The circle overlay is the one compatible *overlay* device.** `.hero--circle` is a
marker class — the visual is the `.hero__device` inline ring SVG placed inside the hero,
strokes on brand tokens, `aria-hidden`. Because it's an overlay (not a competing banner
treatment) it may sit atop a *single* banner treatment — the brand's arc-over-photo
pattern (the Learning Catalog example pairs it with `--band`). Never combine two banner
treatments, and never add a circle overlay to an already-busy hero.

**Hard limits (never):** triangle overlay and chevrons (print only), the **red content
circle** (against BMO guidelines — red is logo-roundel-only), surrounding-circle icons
(print/presentation only). No gradients as page decoration — the only sanctioned gradients
are the functional legibility band and the approved bokeh artwork.

---

## 4.5 Two finishes: showcase vs mesh

Editorial blocks come in two finishes; pick **one per page** based on what the content sits
next to (never mix on one surface — an embedded app applet is exempt):

- **Showcase** (default) — 8px radius, `shadow-4`, `.lift` on interactive cards. For
  destination pages you own end-to-end. (Heroes are flat/flush in both finishes.)
- **Mesh** — flat, hairline, square/4px, dividers over boxes, no `.lift`. For content
  living beside out-of-box SP web parts. Modifiers: `.card--quiet`,
  `.player--flat`, `.key-messages--quiet`; mesh-native blocks: `.webpart` (`--framed`),
  `.news-list`/`.news-item`, `.quicklink-grid`/`.quicklink`, `.related` (`--divided`).

---

## 5. Color & type notes

- **BMO blue is the unifier** — every editorial page carries it (chrome, links, accents,
  one flood or device). **Blue stays interactive/brand**, never a random decorative fill —
  the one exception is the **scorecard** and the **flood-of-blue band**, both sanctioned
  patterns with white content on top and no interactive controls inside.
- **Lots of white.** Editorial leans on *more* whitespace than app mode; let colour and
  imagery pop.
- **Red is logo-only.** The single red anywhere is the M-bar roundel in the suite bar.
  Errors still use `--fg-danger`. Never a red content circle.
- **Chart accents** (`--bmo-chart-*` purple/mint/etc.) are **data-viz only** — never page
  decoration.
- **Type:** live text is always **Segoe / SP default**. Dax is never a webfont — it only
  ever appears baked into an image asset. Editorial adds larger Segoe display steps
  (`--ed-display` 52/60, `--ed-title-1` 40/48, `--ed-title-2` 32/40, `--ed-lede` 20/30),
  all **Regular weight** per BMO's H1–H3 rule.
- **Light only.** The SP intranet is effectively light-only; editorial does not invest in
  dark.

---

## 6. Component catalog

All scoped under `class="editorial"`. Link order: `colors_and_type.css` →
`components.css` → `editorial.css`.

### SharePoint host chrome (mesh)
Models the real BMO intranet so content sits next to it comfortably: a **BMO-blue suite
bar** with the BMO wordmark + red roundel, a **blue hub-nav strip**, a white **site header**
+ **nav row**, and a **blue `© BMO Financial Group` footer**.

```html
<header class="sp-suite">
  <button class="sp-suite__btn" aria-label="App launcher">…grid icon…</button>
  <span class="sp-suite__brand"><img src="assets/BMO-roundel.svg" alt="BMO" width="26" height="26"><span class="sp-suite__word">BMO</span></span>
  <span class="sp-suite__search">…search…</span>
  <div class="sp-suite__actions">…alert / settings / avatar…</div>
</header>
<nav class="sp-hubnav"><a class="sp-hubnav__link is-active">Technology &amp; Operations</a>…</nav>
<div class="sp-site"><span class="sp-site__icon">…</span><span class="sp-site__title">Risk &amp; Compliance</span>…</div>
<nav class="sp-nav"><a class="sp-nav__link is-active">Resource hub</a>…</nav>
…content…
<footer class="sp-footer"><span>© BMO Financial Group</span>…</footer>
```

### Hero
`.hero.hero--banner` + one device (§4) with `.hero__bg > img` and `.hero__copy`. Or
`.hero.hero--arc` (two-column) with `.hero__copy` + `.hero__media > .photo > img`. Add
`.hero__device` (inline ring SVG) for the circle overlay.

### Course-module card
```html
<article class="card card--flush card--course lift">
  <div class="card__media card__media--top photo"><img src="…" alt="…"></div>
  <div class="card__content">
    <span class="eyebrow-chip">Compliance</span>
    <h3 class="card__title">Anti-money laundering essentials</h3>
    <p class="card__body">…</p>
    <div class="card__footer">
      <span class="card__meta">…clock… 45 min · 3 modules</span>
      <a class="card__cta" href="#">More information …arrow…</a>
    </div>
  </div>
</article>
```

### Course-materials link rows
```html
<div class="link-list">
  <div class="link-row">
    <span class="link-row__icon">…icon…</span>
    <span class="link-row__main"><a class="link-row__title" href="#">Facilitator guide</a><span class="link-row__desc">…</span></span>
    <span class="link-row__meta">PDF · 2.4 MB</span>
    <span class="link-row__cta">…arrow…</span>
  </div>
  …
</div>
```

### Facilitator card
```html
<div class="facilitator">
  <span class="avatar avatar--48">SC</span>
  <div>
    <div class="facilitator__name">Sarah Chen</div>
    <div class="facilitator__title">Senior learning partner, T&amp;O</div>
    <div class="facilitator__contacts">
      <a class="facilitator__contact" href="tel:…">…phone… 416 555 0142</a>
      <a class="facilitator__contact" href="mailto:…">…mail… sarah.chen@bmo.com</a>
    </div>
  </div>
</div>
```

### Scorecard tiles (sanctioned solid-blue)
```html
<div class="scorecard scorecard--4">
  <div class="scorecard__tile">
    <span class="scorecard__icon"><img class="icon icon--32 icon--on-blue" src="abacus-icons/goals-48.svg" alt=""></span>
    <div class="scorecard__value">94%</div>
    <div class="scorecard__label">Controls tested on time</div>
    <div class="scorecard__caption">Target 90% · trailing 12 months</div>
  </div>
  …  <!-- add .scorecard__tile--midnight for a deeper tile -->
</div>
```

### Media / video card
```html
<article class="card card--flush media-card lift">
  <div class="media-card__thumb">
    <img src="…" alt="…">
    <button class="media-card__play" aria-label="Play: …">…play icon…</button>
    <span class="media-card__duration">4:12</span>
  </div>
  <div class="card__content"><p class="card__eyebrow">Watch</p><h3 class="card__title">…</h3></div>
</article>
```

### Key-messages carousel
```html
<div class="key-messages">
  <div class="key-messages__media"><img src="…" alt="…"></div>
  <div class="key-messages__body">
    <p class="key-messages__quote">…</p>
    <p class="key-messages__cite"><strong>Michael Torres</strong> · Chief Risk Officer, T&amp;O</p>
    <div class="key-messages__dots" role="group" aria-label="Choose a message">
      <button class="key-messages__dot is-active" aria-pressed="true" …></button>
      <button class="key-messages__dot" aria-pressed="false" …></button>
    </div>
  </div>
</div>
```

### CTA band
```html
<div class="band band--flood">
  <div class="l-wrap" style="padding:var(--space-480) var(--space-320)">
    <div class="cta-band">
      <div><h2 class="cta-band__title">…</h2><p class="cta-band__lede">…</p></div>
      <div class="cta-band__actions"><a class="btn btn--primary btn--lg">…</a><a class="btn btn--secondary btn--lg">…</a></div>
    </div>
  </div>
</div>
```

### Spot illustration
```html
<div class="spot spot--lg"><img src="spot-illustrations/education-l.svg" alt="" aria-hidden="true"></div>
```

### Video player (full inline look)
```html
<div class="player">  <!-- player--flat for the mesh register -->
  <div class="player__stage">
    <img src="poster.jpg" alt="…">
    <div class="player__title">Behind the strategy · Episode 4</div>
    <button class="player__play" aria-label="Play">…play icon…</button>
    <div class="player__bar">
      <button class="player__btn" aria-label="Play">…</button>
      <div class="player__progress"><div class="player__progress-fill" style="width:38%"></div></div>
      <span class="player__time">1:43 / 4:32</span>
      <button class="player__btn" aria-label="Volume">…</button>
      <button class="player__btn" aria-label="Captions">…</button>
      <button class="player__btn" aria-label="Full screen">…</button>
    </div>
  </div>
</div>
```

### Spotlight slider (key-messages, generalized)
Quote slides use `__quote`/`__cite`; generic slides use `__eyebrow`/`__title`/`__text`/`__link`.
`__nav` wraps prev/next `__arrow` buttons around the dots. `--quiet` flattens the shell.

### Mesh-register blocks
```html
<!-- Web-part shell -->
<section class="webpart webpart--framed">
  <h2 class="webpart__title">Leaders' corner</h2>
  …
  <div class="webpart__foot"><button class="btn btn--primary">More messages</button></div>
</section>

<!-- News list -->
<div class="news-list">
  <article class="news-item">
    <span class="news-item__thumb"><img src="…" alt=""></span>
    <div class="news-item__main">
      <a class="news-item__title" href="#">…</a>
      <p class="news-item__desc">…</p>
      <span class="news-item__meta">23 hours ago</span>
    </div>
  </article>
</div>

<!-- Quick links -->
<div class="quicklink-grid">
  <a class="quicklink" href="#"><img class="icon icon--24" src="abacus-icons/light-bulb-48.svg" alt="">
    <span class="quicklink__label">Knowledge sharing library</span></a>
</div>

<!-- Featured news (BMO Central two-zone news) -->
<div class="news-feature">
  <article class="news-lead">
    <div class="news-lead__img"><img src="…" alt=""></div>
    <span class="eyebrow-chip">BMO Central</span>
    <a class="news-lead__title" href="#">…</a>
    <p class="news-lead__desc">…</p>
    <span class="news-lead__meta">12 hours ago</span>
  </article>
  <div class="news-compact">
    <article class="news-compact__item">
      <span class="news-compact__thumb"><img src="…" alt=""></span>
      <div class="news-compact__main">
        <span class="eyebrow-chip">BMO Central</span>
        <a class="news-compact__title" href="#">…</a>
        <span class="news-compact__meta">June 18</span>
      </div>
    </article>
  </div>
</div>

<!-- Related links -->
<nav class="related related--divided" aria-label="Related links">
  <a class="related__link" href="#">Code of conduct</a>
</nav>
```

### Essential-resources tinted grid
A `.l-grid` of `.card`s composed on a `.band--blue` band (§6 patterns) — no new block.

---

## 7. Interactivity — inline Alpine

Editorial interactivity uses the same documented state contract as app mode, wired with
minimal inline Alpine (every binding inside an `x-data` ancestor). The example pages ship
exactly this form:

```html
<!-- Category filter — x-data wraps BOTH the chip row and the grid it filters -->
<div class="l-wrap l-section" x-data="{ cat: 'all' }">
  <div class="chip-row" role="group" aria-label="Filter courses by category">
    <button class="chip" :class="{ 'is-active': cat==='all' }" :aria-pressed="cat==='all'" x-on:click="cat='all'">All courses</button>
    …
  </div>
  <div class="l-grid l-grid--3">
    <article class="card card--course …" x-show="cat==='all' || cat==='compliance'">…</article>
    …
  </div>
</div>

<!-- Key-messages carousel — index state; dots drive .is-active + aria-pressed.
     Message 1 is the no-JS state; later messages carry x-cloak. -->
<div class="key-messages" x-data="{ i: 0 }">
  <p class="key-messages__quote" x-show="i===0">…</p>
  <p class="key-messages__quote" x-show="i===1" x-cloak>…</p>
  …
  <div class="key-messages__dots">
    <button class="key-messages__dot" :class="{ 'is-active': i===0 }" :aria-pressed="i===0" x-on:click="i=0"></button>
    …
  </div>
</div>
```

**Motion — two reveal mechanisms, one class, no conflict.** Editorial reuses the app
motion tokens exactly (`--motion-reveal` 550ms, `--ease-out`, `--reveal-rise` 14px) and
does **not** redefine them, so timing is identical across both registers. What differs is
the mechanism, and the `.editorial` scope keeps them from colliding:

- **App mode** — `.reveal` is a *transition* that starts hidden (`opacity:0`) and only
  plays when a script adds `.is-in` (the scroll-triggered IntersectionObserver in
  `example-advanced-ui.html`). Without that script and with motion allowed, content stays
  hidden — so app pages must ship the observer.
- **Editorial mode** — `.editorial .reveal` (higher specificity) is instead a CSS
  *animation* that plays on load, so an editorial page is **self-sufficient**: content is
  never stranded hidden even if no script runs — one less load-bearing dependency. The
  same `.is-in` still short-circuits it to instantly-visible when a reveal script is
  present (the example pages include the observer for that reason).

Both honor `prefers-reduced-motion` (each hides its animated state only inside
`@media (prefers-reduced-motion: no-preference)`). `.lift` (hover elevation) is shared and
unchanged. An app fragment embedded outside `.editorial` keeps the app transition
mechanism and still needs the observer.

---

## 8. Do / don't

**Do**
- Pick one hero device; lean on white space; let one photo or one illustration lead.
- Use corporate line-icons for content labels, Fluent icons for controls.
- Keep copy plain and calm — warmth comes from scale and imagery, not tone.
- Select photography for BMO's voice: authentic, natural light, human, diverse.

**Don't**
- Stack brand devices (bokeh + arc + flood on one element).
- Put a spot illustration beside a photo hero at equal weight.
- Paint blue behind interactive content (scorecard/flood are the only exceptions).
- Reach for red, chart accents as decoration, gradients as decoration, or Dax as webfont.
- Redefine `:root` or introduce values a token already covers.

---

## 9. Files

| File | Role |
|---|---|
| `editorial.css` | The additive layer — `--ed-*` tokens, `.editorial` scope, SP chrome, hero devices, editorial blocks. Link after `components.css` (opt-in; not in the `styles.css` bundle). |
| `abacus-icons/` | The canonical BMO consumer-brand (Abacus) icon set — 712 SVGs at 16/24/28/48. [Contact sheet](../abacus-icons/index.html) · `catalog.json`. Referenced **by URL** as `<img class="icon icon--N">`, never via a sprite; baked hex, so no tinting. |
| `assets/bmo-bokeh-{a…e}.svg` | Official BMO bokeh artwork, five variants (`.jpg` twins ship alongside as a raster fallback). |
| `spot-illustrations/` | The canonical BMO line-drawing spot-illustration library — 481 SVGs. [Contact sheet](../spot-illustrations/index.html) · `catalog.json` · `README.md`. |
| `assets/BMO-roundel.svg` | M-bar roundel used in the suite bar. |
| `examples/editorial-learning-catalog.html` | Flagship example — band+circle hero, course grid, materials, facilitators, spot marker, flood CTA. |
| `examples/editorial-resource-hub.html` | Second example — arc hero, essential-resources tinted grid, scorecard, video cards, key-messages carousel. |
| `examples/editorial-components.html` | The editorial component library — every block live with copy-paste markup. |
| `examples/editorial-design-guide.html` | The visual design guide — showcase vs mesh, hero chooser, rules, do/don't. |
