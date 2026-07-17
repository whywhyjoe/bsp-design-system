# CHANGELOG — Design system reconciliation, repair & documentation

Scope: `project-update/`. Goal: collapse a multi-way class- and icon-vocabulary
fork onto one canonical BEM library on the shared token layer, repoint every
icon onto the provided `bmo-icons.svg`, standardize the inline-Alpine state
contract, and document it — all buildless, CDN-free, SharePoint-safe.

---

## 1. What was forked (the starting state)

**Class vocabulary — three+ conventions on one shared token layer:**
- `components.css` + `Components.html` — the real BEM library (`.btn--primary`), fully tokenized. **Source of truth for naming.**
- `advanced-ui-example.html` — a self-contained mockup with ~170 lines of inline `<style>` using a *different* convention (`.btn primary`, `.statcard`, `.card-body`, `.hero`, `.gallery`…). Linked only `colors_and_type.css`. Its design quality lived in throwaway inline CSS.
- `Design System Reference.html` — a *third* convention (`.btn.primary`, `.is-focus`/`.is-disabled`, `.size-lg`, `.cc`/`.cc-b`/`.cc-ic`) in its own inline `<style>` + hardcoded hex. Linked only `colors_and_type.css`.

**Icon system — independently forked four ways, none using the provided sprite:**
- `bmo-icons.svg` (canonical, provided) — `ic-fluent-{name}-24-regular`, 37 symbols.
- `Components.html` — inline sprite, `ic-{name}` (e.g. `#ic-home`, `#ic-warn`); snippets referenced `assets/icons.svg#…`.
- `assets/icons.svg` — a separate shipped sprite, `ic-{name}` semantic ids.
- `Design System Reference.html` — inline sprite, `ic-{name}`/`ic-chev-*`.
- `advanced-ui-example.html` — inline sprite, `i-{name}` + raw `<svg width=…>`.
- `Developer Guide.html` — inline sprite, `ic-x`/`ic-file`/`ic-folder`.

**Behavior layer:** none. There is **no `bmo-behaviors.js`** and **no
`Alpine.data()` factory** anywhere in the repo (verified across both trees). The
only real Alpine *runtime* reference was a CDN tag inside a doc code-sample. This
confirms the system's premise: CSS + markup + documented inline-Alpine contract.

---

## 2. What was reconciled (mapping)

### Class vocabulary → canonical BEM
| Forked (Visual Interest / Design System Reference) | → Canonical |
|---|---|
| `.btn primary` / `.btn.primary` | `.btn.btn--primary` |
| `.btn secondary/tertiary/subtle/danger` | `.btn--secondary/--tertiary/--subtle/--danger` |
| `.btn.sm` (VI) | `.btn` (default 32px) |
| default `.btn` 40px (VI hero) | `.btn.btn--lg` |
| `.size-sm` / `.size-lg` (DSR) | `.btn--sm` / `.btn--lg` |
| `.is-focus` (DSR) | native `:focus-visible` (+ a doc-only `.demo-focus` helper for static specimens) |
| `.is-disabled` (DSR) | native `:disabled` / `[aria-disabled="true"]` |
| `.input.is-focus/.is-error/.is-disabled` | `:focus` / `[aria-invalid="true"]` / `:disabled` |
| `.badge info/success/warning/neutral/danger` | `.badge.badge--info` … (tokenized) |
| `.msgbar info/success/warning/danger` | `.msgbar.msgbar--*` |
| `.tab active` | `.tab.is-active` + `aria-selected="true"` (+ `role="tab"`/`tablist`) |
| `.tag selected` | `.tag.is-active` |
| `.tag .x` (removable) | `.tag__remove` button (net-new, see §4) |
| `.statcard` + `.top .ic` | `.card` + `.stat` + `.stat__head` + `.card__icon-tile--sm` |
| `.card-body/.card-foot/.card-img/.card-icon` (VI) | `.card__content/__footer/__media--top/__icon-tile` |
| `.cc/.cc-b/.cc-f/.cc-img/.cc-ic/.cc-key` (DSR) | `.card/__content/__footer/__media/__icon-tile/__eyebrow` |
| `.qcard .ic/.t/.d` (VI) | `.card__icon-tile` / `.qcard__title` / `.qcard__desc` |
| `.feature .media/.copy/.ticks` (VI) | `.feature__media/__copy/__ticks` (canonical already had these) |
| `.band.sky` etc. | `.band.band--sky` |
| `.wrap` / `.sec` / `.sec-head` / `.statrow` / `.grid-3` (VI) | `.l-wrap` / `.l-section` / `.section-head` / `.l-grid--4` / `.l-grid--3` |

### Icon ids → canonical `ic-fluent-*` (per the sprite header's OLD→NEW map)
`#ic-home`/`#i-search`-style → `#ic-fluent-{name}-24-regular`. Full set repointed:
home, search, add, filter, document(`doc`/`file`), folder, edit, delete,
checkmark(`check`), checkmark-circle, chevron-right(`chev-right`),
chevron-down(`chev-down`), arrow-up/-down/-right(`arrow`), mail, person,
person-add, settings, calendar-ltr(`calendar`), attach, info, warning(`warn`),
dismiss(`close`/`x`), money(`dollar`), grid, more-horizontal(`more`), clock,
alert(`bell`), mail-inbox(`inbox`), arrow-export(`export`), receipt,
shield(`policy`), data-bar-vertical(`chart`). Raw `<svg width=N>` → `<svg class="icon icon--N">`.

**Sprite is now inlined per page** (`Components.html`, `advanced-ui-example.html`,
`Design System Reference.html`), and both icon forms (`<use>` no-JS + optional
`<fluent-icon>`) share the same `ic-fluent-*` tokens.

---

## 3. What was fixed

**`colors_and_type.css`** — added tokens so the component layer carries no raw
hex: `--fg-danger-hover`, `--fg-success-on-dark`, `--stroke-info-tint`/
`-success-tint`/`-warning-tint`/`-danger-tint`, `--scrim`.

**`components.css`**
- Tokenized previously-hardcoded hex: `.btn--danger:hover` (`#A21B1B` → `--fg-danger-hover`), `.toast .icon` (`#5EE36B` → `--fg-success-on-dark`), the four `.msgbar--*` border colors → `--stroke-*-tint`, `.scrim` background → `--scrim`.
- Updated the stale icon doc-comment (was `assets/icons.svg#ic-home`) to the canonical `ic-fluent-*` / dual-form usage.

**`Components.html`**
- Replaced its forked inline sprite with the canonical `bmo-icons.svg`; repointed every `<use>` to `ic-fluent-*`; stripped the `assets/icons.svg` path from snippets (now same-document `#id`).
- Fixed stale header meta (`Stack: Alpine.js` / `Icons: assets/icons.svg`) and the broken `ui_kits/sharepoint-app/index.html` link (that applet does not exist in `project-update`) → now points to `advanced-ui-example.html`.
- Icons section now documents **both** rendering forms; added the optional `<script src="fluent-icon.js" defer>` and a live `<fluent-icon>` demo.

**`advanced-ui-example.html`** — deleted the ~170-line inline component `<style>`
fork; now links `colors_and_type.css` + `components.css`; re-expressed every
section on canonical BEM; inlined the canonical sprite; repointed all icons;
converted raw `<svg width=…>` to `.icon icon--N`. Kept the example Unsplash
imagery (with `onerror` fallback) and the reduced-motion-safe reveal script.

**`Design System Reference.html`** — now links `components.css` and *consumes*
it: removed the forked `.btn`/`.input`/`.badge`/`.tag`/`.dot`/`.presence`/
`.avatar`/`.msgbar`/`.tab` and `.cc*` definitions from its inline `<style>`
(kept genuine doc-chrome: swatches, callouts, do/don't, layers, TOC, type/space/
radius/elevation showcases, gallery layout). Converted all component markup to
canonical classes; inlined the canonical sprite; repointed all icons; updated
the icon-grid labels to the real fluent tokens; added `role="tablist"/"tab"` and
`aria-selected`/`aria-invalid` where the forked state classes were removed.

**Accessibility raised:** focus-visible rings are native; tabs carry
`role`/`aria-selected`; invalid inputs use `aria-invalid`; removable tags and
icon buttons carry `aria-label`; `<fluent-icon>` light-DOM preserved.

---

## 4. What's net-new (authored into `components.css`)

Promoted from `advanced-ui-example.html`'s intent as proper tokenized BEM:
- **Page shell:** `.suite` (+ `__inner/__mark/__app/__divider/__env/__spacer/__action`), `.crumbs` (+ `__sep/__current`), `.hero` (+ `__eyebrow/__title/__lede/__cta/__media`), `.trust` (+ `__item/__num/__label`), `.section-head` (+ `--flex`, `__eyebrow/__title/__lede`).
- **Layout helpers:** `.l-wrap`, `.l-section`, `.l-grid` + `.l-grid--2/--3/--4` (responsive).
- **Small variants:** `.card__icon-tile--sm` + `.stat__head` (stat with leading tile), `.tag.is-active` + `.tag__remove` (removable/selected tag), `.avatar-wrap` + `.avatar__presence--success/--warning/--danger/--away`.

New documentation:
- **`TECHNICAL-REFERENCE.md`** — developer guide: getting started + minimum-dependency path, per-component reference with copy-paste snippets, CSS class reference, full token reference, the state-contract reference + the `Alpine.data()` recommendation list, the icon system (both forms + tradeoff), and SharePoint gotchas.
- **`Components.html`** — new "Page shell" section rendering the net-new components.

---

## 5. Standardized inline-Alpine state contract

Unified the inline patterns so each is written the same way everywhere, and
documented the state→class/attribute mapping (chip `.is-active`+`aria-pressed`;
switch/checkbox/radio `x-model` on `:checked`; tab `.is-active`+`aria-selected`;
input `[aria-invalid]`; grid row `.is-selected`; dialog `x-show`+Esc; toast
`x-show`). Full table in `TECHNICAL-REFERENCE.md` §5.

**Recommendation (NOT built, flagged for a separate pass):** a small,
self-hosted `Alpine.data()` factory would later be worth it only for the
genuinely hard / a11y-critical cases — **dialog** (focus trap, Escape, scroll
lock, return focus; note CDN-free means hand-rolled, no `@alpinejs/focus`), and
secondarily **tabs** (roving tabindex/arrow keys) and **toast** (queue +
auto-dismiss). No behavior layer was created in this run.

---

## 6. Working-state verification (acceptance criterion)

Static verification run on each delivered HTML file:

| Check | Components.html | advanced-ui-example.html | Design System Reference.html |
|---|---|---|---|
| (a) canonical sprite inlined | ✅ 37 symbols | ✅ (subset used; all refs covered) | ✅ 37 symbols |
| (b) every `<use>`/`name` resolves to a real symbol — no blanks | ✅ | ✅ | ✅ |
| (c) no class depends on a removed fork | ✅ | ✅ | ✅ |
| links canonical CSS | ✅ tokens+components | ✅ tokens+components | ✅ tokens+components |
| no legacy icon ids remain | ✅ | ✅ | ✅ |

Verification method: every `<use href="#id">` was diffed against the inlined
`<symbol id>` set (empty difference = all resolve); grep confirmed zero remaining
forked component classes and zero non-`ic-fluent` icon refs. Same-document `#id`
references resolve when the file is opened directly (no server required).

**No referenced icon was missing from the sprite** — across all files every
icon mapped to one of the 37 provided symbols, so nothing had to be invented or
flagged for addition.

---

## 7. Parity gaps / deferred (with reasons)

- **`Developer Guide.html`** — was deferred; **now updated (see §10).** Repointed
  onto the canonical sprite, stale references fixed. It keeps the CDN Alpine example
  as a deliberate exception (now with a self-host note); it stays doc-chrome and
  intentionally does not link `components.css`.
- **`assets/icons.svg` (the separate shipped fork) left in place.** No delivered
  page references it anymore (snippets now emit same-document `ic-fluent-*`). It
  is dead but harmless; can be deleted in a cleanup pass.
- **Imagery is external (Unsplash), by decision.** The showcase pages keep
  example stock photos via external URLs (with `onerror` fallback). This is the
  one intentional external network reference; swap in self-hosted licensed BMO
  imagery, or `.imgph` placeholders, for a strictly offline build.
- **`fluent-icon name="…-20-…"` / filled names.** The provided sprite is
  normalized to the `24` viewBox and ships filled variants only for
  `checkmark-circle` and `warning`. Snippets were corrected to reference only
  real symbols (size via the `.icon--N` CSS helper). A name pointing at a
  non-existent symbol (e.g. `search-20-regular`) will render blank until that
  symbol is added to the sprite — expected, documented in `TECHNICAL-REFERENCE.md` §6.
- **No live browser screenshot** — the environment had no Node/Python to serve
  files, so verification was static (icon-resolution diff + class greps) rather
  than a rendered screenshot. All same-document refs resolve on file open.
- **Static state specimens in `Design System Reference.html`** use a doc-only
  `.demo-focus` helper to *show* the focus ring (states can't be forced
  statically); real components use native `:focus-visible`.

---

## 8. Follow-up: avatar ramp — extend, annotate, de-fork

**This is de-forking, not adding a fork** — it *removes* inline avatar overrides
and replaces them with real preset classes.

- **Extended the ramp** in `components.css`: added `.avatar--48` (19px initials)
  and `.avatar--64` (26px initials), restoring two Fluent 2 sizes the original
  dense-UI slice had excluded (identity / profile surfaces). Literal px, no new
  token — the ramp isn't tokenized and this change deliberately doesn't start
  that. Full ramp is now `20/22/28/32/40/48/64`; default stays 28.
- **Annotated the type-locked small sizes** so the intent survives future
  cleanups (the missing comment is what made 22 look arbitrary): `20` is flush
  with the body1 line-box (14/20), `22` is flush with the body2 line-box (16/22)
  — **22 was kept deliberately** as the inline-with-text size, even though it
  isn't a standard Fluent size.
- **Snapped the showcase's off-ramp inline-sized avatars onto real classes** and
  removed every inline `width`/`height`/`font-size` override (only
  `style="background:…"`, the sanctioned color hook, remains):
  - `Design System Reference.html` size row was the ramp *demonstration* — rebuilt
    it to show the true canonical ramp `20/22/28/32/40/48/64` (label updated to
    match), rather than mechanically snapping it into duplicates/gaps. The former
    `48`/`64` (which had carried `.avatar--40` + inline px) now use the real
    `.avatar--48`/`.avatar--64`.
  - Presence-demo avatars were inline `36px` on `.avatar--32`. **Judgment call:
    snapped `36 → .avatar--40`** (the spec default; a presence showcase isn't a
    clearly compact/secondary context, so 40 over 32).
  - No `24` standalone avatar remained after rebuilding the ramp row; the rule
    `24 → .avatar--28` (not 22 — 22 is reserved for inline-with-text) was applied
    in spirit by dropping the off-ramp 24 specimen in favor of the real 22/28.
  - `advanced-ui-example.html` and `Components.html` had **no** inline size/font
    overrides on avatars (only `style="background:…"`), so they were left as-is.
- **Docs updated:** `TECHNICAL-REFERENCE.md` §2 (size list `20/22/28/32/40/48/64`
  + the line-height-lock / default / identity rationale) and §3 (modifier example
  → `.avatar--20…64`).
- **Verified:** zero inline `width`/`height`/`font-size` overrides on any avatar
  across all three pages; the §2 doc size list exactly matches the `.avatar--N`
  classes in `components.css`; all avatars render with no clipped initials
  (confirmed live in-browser — fonts scale 8→26px across the ramp).

---

## 9. Follow-up: `preview/` gallery cards de-forked onto the canonical system

The 27 generated `@dsCard` thumbnails predated the reconciliation and re-introduced
the fork pattern via `preview/_card.css`. Brought onto the canonical library.
**De-forking, not a new fork.**

- **`preview/_card.css` re-based.** Now `@import`s `colors_and_type.css` **and**
  `components.css` and **deletes its duplicated `.btn`/`.input` definitions** (which
  used the retired `.btn.primary` / `.input.focus/.error/.disabled` vocabulary). It
  keeps only gallery-harness utilities (`.preview` frame, `.row`/`.col`, `.sw`,
  `.label`, `.token`, `.callout`) plus static-state demo helpers
  (`.demo-focus`, `.btn--*.demo-hover`, `.input.demo-focus`) — mirroring the
  `.demo-focus` convention in `Design System Reference.html`.
- **Frame collision resolved.** The outer thumbnail wrapper was `<div class="card">`,
  which would shadow the real `.card` component once `components.css` is imported.
  Renamed the frame to **`.preview`** across all 27 files.
- **Component cards rewritten onto canonical BEM**, replacing inline-hex mockups:
  `components-button-primary`/`-secondary` (→ `.btn.btn--*` + real `disabled` attr,
  `.demo-hover`/`.demo-focus` for the un-triggerable states), `-inputs` (→ `.field`
  + `.input` + `aria-invalid` + real `disabled`), `-badges` (→ `.badge--*`,
  `.dot--*`, `.tag`/`.tag__remove`/`.tag.is-active`), `-card` (→ real `.card` +
  `.btn--sm`), `-card-composition` (→ real `.card` BEM, dropped its local card
  `<style>` fork; kept only a fixed 3-col gallery grid as scaffolding), `-message-bars`
  (→ `.msgbar--*`), `-tabs` (→ `.tabs`/`.tab.is-active` + `role`/`aria-selected`).
- **Icons.** Every preview icon now uses the canonical sprite via
  `<use href="../bmo-icons.svg#ic-fluent-…">` (the system's supported external-file
  mode — chosen over per-card inlining to stay DRY and avoid subset drift across 27
  generated cards). Raw `<svg width=…>` drawings removed. `brand-icons` labels updated
  to the real name tokens (e.g. `check`→`checkmark`, `calendar`→`calendar-ltr`).
- **Judgment calls / accuracy fixes:** `components-tabs` subtitle changed from
  "Selected = filled icon…" to "Selected = accent text + 2px accent underline" — the
  sprite has no filled-grid glyph, so selection is shown by accent text + underline
  (subtitle synced in `_ds_manifest.json` too). `brand-imagery` was already consuming
  canonical `.imgph`/`.lbl`, so only its frame was renamed.
- **`_ds_manifest.json`** kept in sync (metadata-only index; the two changed
  subtitles updated; valid JSON; 27 paths all resolve).
- **Out of scope by decision:** the sibling `project/preview/` (backup snapshot;
  `project-update/` is the prod-bound tree).
- **Verified live (Vite):** external sprite serves 200; **every icon paints**
  (16/16 in `brand-icons`, all component-card icons via `getBBox`); real `.card`
  carries the component border/radius (proves `components.css` applied); button
  states resolve (rest `#0075BE`, hover `#005587`, focus 2px ring, disabled
  opacity .5); swatch/type/spacing cards still render after the rebase; **no console
  errors**. grep gates: zero retired vocabulary, zero non-`ic-fluent` icon refs,
  zero `.btn`/`.input` defs left in `_card.css`. The 3 remaining inline `<style>`
  blocks (`brand-icons`, `brand-imagery`, `components-card-composition`) are pure
  layout scaffolding (catalog grid / demo sizing / gallery), not component forks.

---

## 10. Follow-up: `Developer Guide.html` updated (previously deferred)

The last deferred page, now brought onto the canonical system.

- **Icons.** Replaced its forked 5-symbol inline sprite with the full canonical
  `bmo-icons.svg` (37 symbols) and repointed every `<use>`: `ic-arrow`→`arrow-right`,
  `ic-file`→`document`, `ic-folder`→`folder`, `ic-x`→`dismiss`, `ic-check`→`checkmark`.
  All resolve; nothing blank.
- **Stays doc-chrome (intentionally does NOT link `components.css`).** The guide
  renders no live component specimens — every component example is text inside
  `<pre>`. Linking `components.css` would only introduce a `.panel` collision (the
  guide defines its own doc `.panel`) for no benefit, so it remains self-contained
  with its own chrome + the canonical sprite.
- **Stale references fixed.** Removed the broken `ui_kits/sharepoint-app/` links
  (that applet isn't in `project-update`) and the dangling `README.md`/`SKILL.md`
  mentions (not in this tree). The "What's in the box" map now lists the real files:
  added `styles.css`, `bmo-icons.svg`, `fluent-icon.js`, `PAGE-TEMPLATE.md`,
  `TECHNICAL-REFERENCE.md`, `CHANGELOG.md`; updated `assets/` (icons now in the
  canonical sprite; legacy `assets/icons.svg` noted as retired); README/tone pointers
  repointed to `docs/`. Sidebar now links Page template + Technical reference.
- **CDN Alpine kept (accepted exception)** with an added inline note to self-host
  `alpine.min.js` in SiteAssets for production.
- **Verified live (Vite):** 32/32 icons paint at full width (the 5 "blank" at narrow
  widths are just the responsive `aside{display:none}`); sidebar links correct; file
  map accurate; no console errors.

### Bonus fix — DSR `.panel` regression (introduced in §6 when `components.css` was linked)
Linking `components.css` into `Design System Reference.html` had let the `.panel`
**component** (flex column, `overflow:hidden`) leak into DSR's 36 doc `.panel`
containers — which would clip the `.demo-focus` outline rings in the state
showcases. Neutralized with `display:block; overflow:visible` on DSR's local
`.panel` rule. Verified: all 36 panels now `block`/`visible`; the button-state
focus ring renders un-clipped.

---

## 11. Reorganization into a standard layout + interactive blue → #0079C1

**Interactive accent changed to #0079C1.** Analysis of the live BMO intranet showed
the interactive blue is consistently **#0079C1** ("First Bank Blue"), not the
#0075BE "Accessible Blue" previously tokenized. Changed `--bmo-blue` → `#0079C1` in
`colors_and_type.css` (one token; every interactive role — `--accent-rest/-hover`,
`--fg-accent`, `--stroke-accent` — consumes it, so all components updated). Contrast
on white is comparable to the prior blue (~4.5:1). Per decision this pass changed the
**token only** — hardcoded `#0075BE` swatches/labels in the showcases, the chart
ramp's `--bmo-chart-blue`, and the now-redundant unused `--bmo-blue-logo` (#0079C1)
were intentionally left for a later pass.

**Folder reorganization (standalone-handoff tidy-up).** Root was cluttered (library +
showcases + docs + brand context + history all together) and one file had spaces in
its name. New layout — the **shippable library stays flat at root** (so SharePoint
copy-paste snippets, which represent files dropped flat into SiteAssets, stay correct);
everything else filed:
- `examples/` ← `Components.html`, `Design System Reference.html`, `Developer Guide.html`,
  `Visual Interest.html` → **renamed `advanced-ui-example.html`**, `preview/`,
  `_ds_manifest.json`, `_ds_bundle.js`.
- `docs/` ← `PAGE-TEMPLATE.md`, `TECHNICAL-REFERENCE.md`.
- `context/` ← the former `docs/` brand source material (BMO brand, internal-web brand,
  Fluent 2, SharePoint) — marked **deep/optional, not read by default** to save tokens.
- `project-notes/` ← `CHANGELOG.md`, `COLOR-RECONCILIATION.md`, `_adherence.oxlintrc.json`,
  `.thumbnail`.
- Stays at root: the 5 library files, `assets/`, `README.md`, `CLAUDE.md`, `AGENTS.md`,
  `.github/`.

**References rewritten** to match: showcase `<head>` links → `../` (copy-paste snippets
inside them deliberately kept flat); `examples/preview/_card.css` import + cards →
`../../`; entry docs, `copilot-instructions.md`, `Developer Guide.html`, and dev docs
repointed to the new folders; the `Visual Interest`→`advanced-ui-example` rename
propagated everywhere (one historical mention in §9's fork-source table left as-is).
`_ds_manifest.json` moved into `examples/` so its `preview/…` paths still resolve with
no edit.

**Caveat:** the external `@dsCard` gallery tool (not in this repo) previously expected
`_ds_manifest.json` at root; if it's ever re-run, point it at `examples/`.

---

## 12. Removed the export-tool artifacts (gallery cruft)

The leftovers from the Claude Design export tool were deleted so nothing extraneous
ships in the handoff — none of it was part of the runtime system:
- Deleted `examples/_ds_manifest.json`, `examples/_ds_bundle.js`, and `project-notes/.thumbnail`.
- Stripped the `<!-- @dsCard … -->` marker comment from all 27 `examples/preview/*.html`
  cards (kept the cards themselves — they remain valid standalone specimens).
- Updated the "ignore/tooling" notes in `CLAUDE.md`/`README.md` accordingly.
- This supersedes §11's "point the tool at `examples/`" caveat — the tool's index is
  gone; the gallery would need regenerating from scratch if ever revived. The
  `Developer Guide.html` still calls `preview/` "the cards the Design System tab
  renders," which is now historical.

**`COLOR-RECONCILIATION.md` removed (obsolete + contradictory).** It went missing
mid-cleanup, was restored from the `project-update - Copy/` backup, then **deleted** —
it predated the accent decision and argued the *opposite*: it prescribed `#0075BE`
(Accessible Blue) as the interactive accent and explicitly banned `#0079C1` from UI.
With the accent now settled at `#0079C1`, the doc was wrong, not just stale. Its still-
valid rule (errors use `--fg-danger`/BMO Negative, never BMO Red or Fluent red) is
already encoded in the tokens + `copilot-instructions.md`. References removed from
`README.md`/`CLAUDE.md`. (Recoverable from the backup copy if ever needed.)

## 13. Full color reconciliation — `#0079C1` is the single "BMO Blue"

Settled and propagated everywhere (the §12 open follow-up, now done). `#0079C1` is
the one interactive accent; `#0075BE` ("Accessible Blue") is demoted to a historical/
alternate BMO color; Fluent's `#0f6cbd` is not the accent. Note: `#0079C1` meets WCAG
AA on white (~4.66:1), so the demotion of the "Accessible" variant doesn't regress
text contrast.

- **Token layer (`colors_and_type.css`):** removed the now-redundant unused
  `--bmo-blue-logo` (was a duplicate `#0079C1`); aligned `--bmo-chart-blue`
  `#0075BE` → `#0079C1` so the chart's blue step matches the brand blue. `--bmo-blue`
  is `#0079C1` (since §11).
- **Showcases / previews / dev docs:** replaced every displayed `#0075BE` with
  `#0079C1` (swatches, token tables, the Developer-Guide token-layer example, the
  copilot anti-pattern example, the avatar-bg comment in `components.css`). The
  interactive-blue specimens now show the real shipped value.
- **`context/` brand guides** (`BMO-INTERNAL-WEB-BRAND.md`, `BMO-BRAND-CONTEXT.md`,
  `SHAREPOINT-CONTEXT.md`) — these are source material, so reconciled surgically: a
  **banner** at the top of each stating the shipped decision, and the specific
  directive lines flipped (the "use `#0075BE`, not `#0079C1`, for interactive" rule
  inverted; the "use Fluent `#0f6cbd` as the accent" recommendations changed to
  `#0079C1`/`var(--accent-rest)`). Palette tables keep both hexes as documented BMO
  colors; only the *role/usage* text changed.
- **Intentionally retained `#0075BE` mentions:** the migration note in
  `colors_and_type.css`'s `--bmo-blue` comment, the historical entries in this
  CHANGELOG, and the demoted/"alternate" references + one data-viz palette row in the
  context guides — none claim the interactive-accent role.
- **Verified live (Vite):** `--bmo-blue` and `--bmo-chart-blue` both compute
  `#0079C1`; primary buttons render `rgb(0,121,193)`; no `#0075BE` left in the
  rendered showcases; icons paint; no console errors.

---

## 14. Documented a third icon-delivery form — the Fluent icon font

Added the **Fluent System Icons font** as a documented, supported option alongside
the SVG sprite `<use>` and the `<fluent-icon>` element. It's **first-party Fluent**
(Microsoft's own font build of the same icons), so it does not violate the
"hand-rolled Fluent 2, no icon libraries" rule (that rule rejects third-party kits
like Iconify / Font Awesome / Material — not Microsoft's Fluent font).

- **Why it's worth having:** self-hosts as pure `@font-face` CSS + a `woff2` (zero
  JS, works under SharePoint custom-script restrictions), and delivers the **entire**
  Fluent set with no build — a simpler answer to "I need an icon the curated
  37-symbol `bmo-icons.svg` doesn't have" than the planned sprite→SVG-folder migration.
- **Usage:** `<i class="icon-ic_fluent_home_24_regular" aria-hidden="true">` — the
  name token, underscored, with an `icon-ic_fluent_` prefix (same `-`→`_` transform
  `fluent-icon.js` `resolve()` already uses).
- **Documented tradeoffs (why it's not the default):** accessibility (font glyphs
  are Private-Use chars → always `aria-hidden` the `<i>` and label the parent; the
  SVG `<use>` form stays the more-accessible default); size via `font-size`, not
  `.icon--N`; possible FOUT; ship the **full** font (subsetting needs a build).
- **Not vendored:** the font files aren't added to the repo (a few-hundred-KB
  binary the consuming app self-hosts in SiteAssets) — the docs point to Microsoft's
  `fluentui-system-icons/fonts` and explain adoption.
- **Docs updated:** `docs/TECHNICAL-REFERENCE.md` §6 (new "Form 3" + a "which form?"
  guide), `.github/copilot-instructions.md` (Icons section + "roads not taken"
  clarified), `CLAUDE.md` (icon rule). The SVG sprite remains the default.

---

## 15. Full Fluent library extracted to the separate `fluent-system-icons` repo

The full Fluent System Icons library — formerly vendored here as the
`/fluentui-system-icons` folder — now lives in its own **separate repo**,
**`fluent-system-icons`**. Nothing about its contents or usage changed: the
per-icon SVGs (`ic_fluent_{name}_{size}_{style}.svg`), the font builds
(`FluentSystemIcons-{Regular,Filled,Light,Resizable}.{woff2,css}` + per-style
HTML/JSON codepoint indexes), and the `fluent-font-library.{json,html}` master
index all exist there and work exactly as documented — use them under the same
criteria as before.

- **Path is project config.** The library's actual location is specified in
  config when developing a real project; docs reference the repo by name, not a
  hard-coded path.
- **Included natively, unchanged:** the design system's own icon deliveries —
  the curated `bmo-icons.svg` sprite, `fluent-icon.js`, and the documented icon
  **font** delivery form (TECHNICAL-REFERENCE §6 Form 3).
- **Docs updated:** `README.md` (icons rule + file map), `CLAUDE.md` (icon rule
  + file map), `docs/TECHNICAL-REFERENCE.md` §6 ("Not shipped here" bullet +
  migration-seam note), `.github/copilot-instructions.md` (folder-swap
  destination + icon-font sourcing).

---

## 16. Buildless/CDN-free rule rescoped to the shipped artifact; `@alpinejs/focus` allowed self-hosted

Two clarifications to the architecture rule — the *policy* (buildless, CDN-free,
self-hosted **at runtime in production**) is unchanged; what changed is scope and
a rationale that no longer held.

- **Rescoped: the rule constrains the shipped artifact, not the dev machine.**
  The old wording ("never propose a build step, `npm install`, … or a CDN
  `<script>`") read as a blanket ban on dev tooling. Corrected: the *deployed
  page* can never require a build/compile step, bundler, or ES `import`
  (SharePoint can't build or run Node — what you author is what runs), and
  production pages self-host every runtime dependency in SiteAssets. Local dev
  tooling (`npm install`, Node, Python, static servers, linters) is explicitly
  fair game *as tooling*, CDN tags are fine as a dev-time convenience (download
  + self-host before shipping), and proposing a CDN-distributed *library* is
  fine — libraries are vetoed by the other rules (third-party UI/icon kits,
  forced build steps), never by their distribution channel.
- **`@alpinejs/focus` allowed, self-hosted.** The prior ban was justified by
  "CDN-free" — but the plugin self-hosts as one static file exactly like Alpine
  core, so that rationale doesn't hold. New policy: **prefer** the first-party
  plugin (battle-tested focus trap) self-hosted in SiteAssets; hand-rolling
  remains the fallback when keeping the vendored script surface to Alpine core
  alone matters more. (Entry 5's "no `@alpinejs/focus`" note reflects the old
  policy and is superseded here.)
- **Docs updated:** `.github/copilot-instructions.md` (Architecture section
  rewritten; factory/dialog bullet), `CLAUDE.md` (first non-negotiable),
  `AGENTS.md` (rule 1), `docs/TECHNICAL-REFERENCE.md` §5 (dialog factory
  recommendation). README / PAGE-TEMPLATE / TECH-REF §7 already said "at
  runtime" / "in production" and needed no change.
