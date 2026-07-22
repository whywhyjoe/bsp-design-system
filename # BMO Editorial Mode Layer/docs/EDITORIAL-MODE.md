# Editorial mode

The warm, employee-facing content register for the BMO SharePoint Design System —
learning catalogs, resource hubs, awareness pages, program landing pages. It is an
**additive layer**, not a fork: same tokens, same BEM vocabulary, same delivery
constraints. It relaxes the app register's austerity (bigger type, more air, hero-led,
photography/illustration-forward) and selectively pulls in the BMO marketing brand.

- **Layer:** `editorial.css`, linked **after** `components.css`.
- **Scope:** everything editorial lives under a root `class="editorial"`.
- **Proof pages:** `Learning Catalog.dc.html`, `Resource Hub.dc.html`.

---

## 1. When to use editorial vs app

| | **App mode** (default) | **Editorial mode** |
|---|---|---|
| Purpose | Get work done — intake, approvals, dashboards, data | Inform, orient, welcome — catalogs, hubs, awareness |
| Feel | Dense, austere, "effective over aesthetic" | Warm, spacious, hero-led, brand-forward |
| Type | Small (14–16px), tight | Large display steps, generous line-height |
| Imagery | Rare; functional icons only | Photography leads; spot illustrations; brand devices |
| Motion | Minimal | Reveal-on-scroll, hover-lift (still functional) |
| Example | Expense & approvals applet | This learning catalog |

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
- **Interactivity = inline Alpine** against the documented state contract (the DC proof
  pages drive the same `.is-active` / `aria-pressed` contract from a logic class; the
  shipped SharePoint page uses the inline-Alpine one-liner — see §7).
- **Icon contract** unchanged for functional icons: `ic-fluent-{name}-24-regular` over the
  inlined `bmo-icons.svg` sprite, sized with `.icon--N`.

---

## 3. The three-tier art system

Editorial formalizes how each asset family may appear. This is the guardrail that keeps it
from becoming clip-art soup.

| Tier | Asset | Source | Allowed use | Never |
|---|---|---|---|---|
| **0 · Photography** | Real photos (`.photo` wrapper) | Licensed BMO library | **Leads.** Hero and feature moments on home / article / intro pages where a warm, authentic human moment fits. | Dark/dramatic/high-contrast; trendy filters; glossy stock |
| **1 · Functional icons** | Fluent `ic-fluent-*` | `bmo-icons.svg` | App UX affordances — buttons, controls, inline meaning, chrome. Unchanged from app mode. | Content decoration |
| **2 · Corporate line-icons** | `bmo-ic-*` (`.c-icon`) | `bmo-content-icons.svg` | **Content labeling** — categories, section markers, scorecard-tile glyphs. | Real app UX (edit/save/nav) |
| **3 · Spot illustrations** | 154-SVG BMO line-drawing family | `illustrations/` | **Hero-substitute / feature moment**, ~1 per page, staged on white/albicant, for dry subjects or app welcome screens; or a section-divider accent. | Competing beside a photo hero; wallpaper repetition; crowding |

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

**Spot-illustration delivery:** reference as `<img>` from the self-hosted `illustrations/`
folder (the SVGs carry baked-in brand hex, so inlining buys nothing). Decorative by
default — `alt="" aria-hidden="true"`; use a meaningful `alt` only when the illustration is
the sole carrier of meaning. Copy only the illustrations a page uses.

> **Corporate line-icons are placeholders.** `bmo-content-icons.svg` holds on-brand
> line-icons drawn to BMO's rules, standing in for the licensed "BMO Design Icons" library
> until it's dropped in — same sprite pattern, same ids, no reflow. Same posture as the
> placeholder logo.

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
| **Bokeh** | `.hero--bokeh` | Self-hosted `bokeh.svg` (blue gradient corner-to-corner + round translucent circles) — the sanctioned alternative to photography for dry content. |
| **Flood of blue** | `.band--flood` | A solid BMO-blue section band, white content, inverted white buttons. Use for one CTA / statement band. |

The full-bleed photo heroes (`--scrim` / `--blue` / `--band` / `--bokeh`) build on
`.hero.hero--banner` (a layered banner). `--arc` builds on the two-column base `.hero`.
All heroes are flat/flush — square corners, no border, no elevation — matching the OOB
SP hero web part, in both finishes.

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
  <span class="sp-suite__brand"><img src="assets/bmo-logo-placeholder.svg" alt="BMO" width="26" height="26"><span class="sp-suite__word">BMO</span></span>
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
    <span class="scorecard__icon"><svg class="c-icon c-icon--32 c-icon--on-blue"><use href="#bmo-ic-goals"/></svg></span>
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
<div class="spot spot--lg"><img src="illustrations/education-l.svg" alt="" aria-hidden="true"></div>
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
  <a class="quicklink" href="#"><svg class="c-icon"><use href="#bmo-ic-idea"/></svg>
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

## 7. Interactivity — the shipped form

The `.dc.html` proof pages drive the filter chips and carousel from a logic class (the
workspace's native mechanism). The **shipped SharePoint page** wires the identical state
contract with inline Alpine:

```html
<!-- Category filter -->
<div class="chip-row" x-data="{ cat: 'all' }">
  <button class="chip" :class="{ 'is-active': cat==='all' }" :aria-pressed="cat==='all'" x-on:click="cat='all'">All courses</button>
  …
</div>

<!-- Key-messages carousel -->
<div class="key-messages" x-data="{ i: 0, n: 3 }">
  …
  <div class="key-messages__dots">
    <template x-for="k in n"><button class="key-messages__dot" :class="{ 'is-active': i===k-1 }" :aria-pressed="i===k-1" x-on:click="i=k-1"></button></template>
  </div>
</div>
```

Reveal-on-scroll: editorial content carries `.reveal`; `editorial.css` gives it a CSS
load-in fade so an editorial page is **self-sufficient** (content never stranded hidden)
even without the reveal script — one less load-bearing dependency than app mode. Honors
`prefers-reduced-motion`.

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
| `editorial.css` | The additive layer — `--ed-*` tokens, `.editorial` scope, SP chrome, hero devices, editorial blocks. Link after `components.css`. |
| `bmo-content-icons.svg` | Corporate content line-icon sprite (`bmo-ic-*`). Placeholder for the licensed set. |
| `bokeh.svg` | Spec-compliant bokeh background artwork. |
| `illustrations/` | Spot illustrations used by the example pages (subset of the 154-SVG library). |
| `assets/bmo-logo-placeholder.svg` | M-bar roundel used in the suite bar. |
| `Learning Catalog.dc.html` | Flagship example — hero band, course grid, materials, facilitators, spot marker, flood CTA. |
| `Resource Hub.dc.html` | Second example — arc hero, essential-resources tinted grid, scorecard, video cards, key-messages carousel. |
| `Editorial Components.dc.html` | The editorial component library — every block live with copy-paste markup. |
| `Editorial Design Guide.dc.html` | The visual design guide — showcase vs mesh, hero chooser, rules, do/don't. |
