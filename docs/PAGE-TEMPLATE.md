## 1.5 Minimal complete page (start here)

Everything else in this reference is *parts*. This is the *assembly* — the
smallest complete, working page, with the wiring those parts assume. Copy it,
delete what you don't need, and build outward. Three things in here are
load-bearing and fail **silently** if you skip them; they're called out inline
and explained right after.

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Requests · BMO</title>

  <!-- (1) Tokens BEFORE components. Or use the one-tag styles.css equivalent. -->
  <link rel="stylesheet" href="colors_and_type.css">
  <link rel="stylesheet" href="components.css">

  <!-- x-cloak: hide Alpine-controlled (x-show) elements until Alpine boots,
       so a dialog/toast doesn't flash on load. Harmless if unused. -->
  <style>[x-cloak]{display:none!important}</style>
</head>

<body>

  <!-- (2) THE SPRITE — inline the ENTIRE contents of bmo-icons.svg here, once,
       as the first thing in <body>. Both icon forms use same-document
       #id references, so the symbols must physically live in this document.
       (Shown collapsed; paste the real 37-symbol block from bmo-icons.svg.) -->
  <svg xmlns="http://www.w3.org/2000/svg" style="display:none" aria-hidden="true">
    <defs>
      <!-- …all <symbol id="ic-fluent-…"> from bmo-icons.svg… -->
    </defs>
  </svg>

  <!-- (3) THE STATE ROOT — x-data declares the page's reactive state. EVERY
       Alpine binding below (:class, x-model, x-on) must live INSIDE this
       element. A chip or switch placed outside any x-data ancestor renders,
       but its bindings do nothing — and throws no error. This is the #1
       first-page trap. -->
  <main class="l-wrap" x-data="{ filter: 'all', notify: false }">

    <header class="section-head">
      <p class="section-head__eyebrow">Finance</p>
      <h1 class="section-head__title">Expense requests</h1>
      <p class="section-head__lede">Review and approve submitted reports.</p>
    </header>

    <section class="l-section">

      <!-- Interactive: chip row bound to `filter` (state-contract §5). The
           .is-active class + aria-pressed are DRIVEN by state, not hardcoded. -->
      <div class="chip-row" role="group" aria-label="Filter requests">
        <button class="chip" :class="{ 'is-active': filter==='all' }"
                :aria-pressed="filter==='all'" x-on:click="filter='all'">All</button>
        <button class="chip" :class="{ 'is-active': filter==='pending' }"
                :aria-pressed="filter==='pending'" x-on:click="filter='pending'">Pending</button>
        <button class="chip" :class="{ 'is-active': filter==='approved' }"
                :aria-pressed="filter==='approved'" x-on:click="filter='approved'">Approved</button>
      </div>

      <!-- Interactive: switch bound to `notify` via x-model (§5). -->
      <label class="switch">
        <input type="checkbox" x-model="notify">
        <span class="switch__track"></span> Email me on new requests
      </label>

      <!-- Static content: cards in a responsive grid. No JS needed — icons use
           the no-JS <use> form, which works with zero scripting. -->
      <div class="l-grid l-grid--3">

        <article class="card">
          <p class="card__eyebrow">Travel</p>
          <h3 class="card__title">Q3 conference travel</h3>
          <p class="card__body">Flights, hotel, and per-diem for the Toronto summit.</p>
          <div class="card__footer">
            <span class="card__meta">Submitted Oct 2</span>
            <a class="card__cta" href="#">Review
              <svg class="icon icon--16"><use href="#ic-fluent-arrow-right-24-regular"/></svg>
            </a>
          </div>
        </article>

        <article class="card">
          <p class="card__eyebrow">Expense</p>
          <h3 class="card__title">Client dinner</h3>
          <p class="card__body">Reimbursement for the Q3 account review dinner.</p>
          <div class="card__footer">
            <span class="card__meta">Submitted Oct 1</span>
            <a class="card__cta" href="#">Review
              <svg class="icon icon--16"><use href="#ic-fluent-arrow-right-24-regular"/></svg>
            </a>
          </div>
        </article>

        <article class="card">
          <p class="card__eyebrow">Equipment</p>
          <h3 class="card__title">Monitor + dock</h3>
          <p class="card__body">Home-office hardware request, pending manager sign-off.</p>
          <div class="card__footer">
            <span class="card__meta">Submitted Sep 29</span>
            <a class="card__cta" href="#">Review
              <svg class="icon icon--16"><use href="#ic-fluent-arrow-right-24-regular"/></svg>
            </a>
          </div>
        </article>

      </div>
    </section>
  </main>

  <!-- (4) ALPINE LAST, deferred, SELF-HOSTED. It must load after the markup it
       binds (defer does that). Point src at your SiteAssets copy — never an
       external CDN on a production SharePoint page. Omit this whole tag and the
       page is still fully styled and iconned; only the chip/switch go inert. -->
  <script defer src="alpine.min.js"></script>

</body>
</html>
```

### The four load-bearing pieces (and how each fails if you skip it)

1. **Link order — tokens before components.** `components.css` reads
   `var(--token)`s defined in `colors_and_type.css`. Reverse them and components
   fall back to unstyled/initial values. (Or link `styles.css`, which imports both
   in the right order.)

2. **The sprite must be *in the document*.** Both `<use href="#ic-fluent-…">` and
   `<fluent-icon>` resolve **same-document**. Paste the full `bmo-icons.svg`
   contents once at the top of `<body>`. If the sprite isn't on the page, every
   icon renders blank — no error. Inline the **whole** 37-symbol sprite (don't
   ship a per-page subset; that drift is how icon coverage silently rots).

3. **The `x-data` root is the scope your bindings need.** Alpine bindings only
   work inside an element that has `x-data`. The state object
   (`{ filter:'all', notify:false }`) lives there; the `:class` / `x-model` /
   `x-on` bindings reference its properties. A bound control placed *outside* any
   `x-data` ancestor renders fine and does nothing — the single most common
   first-page mistake. Group related interactive state under one `x-data`; nest
   more for isolated widgets.

4. **Alpine loads last, deferred, self-hosted.** `defer` guarantees it
   initializes after the DOM it binds. Self-host `alpine.min.js` in SiteAssets —
   a production SharePoint page must not depend on an external CDN. Leaving Alpine
   out is a valid mode: the page stays fully styled and iconned (icons need zero
   JS); only the interactive bits go inert.

**`x-cloak` note:** for elements whose *visibility* is Alpine-driven
(`x-show="open"` dialogs, toasts), add `x-cloak` so they stay hidden until Alpine
boots — otherwise they flash visible on load. The one-line `[x-cloak]{display:none}`
rule in `<head>` above enables it. Components that are merely *styled* by state
(chips, tabs) don't need it.
