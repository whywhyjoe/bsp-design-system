# `preview/` update plan — bring the gallery cards onto the canonical system

> Status: **DONE.** Executed across all 27 cards + `_card.css`; verified live (Vite)
> with no console errors. Phase 0 was
> resolved: the `@dsCard` generator is **not** in this repo and `_ds_manifest.json` is
> a metadata-only index (won't overwrite hand-edits), so the cards were hand-edited;
> the sibling `../../project/preview/` is the **backup snapshot** and was left out of
> scope (`project-update/` is the prod-bound tree). The plan below is retained for
> history.

## Why it's stale (assessment)

Most cards still *render* (via their own harness), so this is a methodology/vocabulary
problem, not a total breakage.

1. **None consume the canonical library.** All 27 cards link only `_card.css`, which
   `@import`s the real tokens (good — no `:root` fork) but then **re-declares its own
   component classes**. This is the exact local-fork anti-pattern removed from the
   three main pages.
2. **Retired vocabulary.** `_card.css` defines `.btn.primary/.secondary/.tertiary`
   (dot-compound) and `.input` with `.focus/.error/.disabled`, plus plain
   `.hover/.focus/.disabled` state classes. Cards emit `class="btn primary hover"`,
   `class="input error"`, etc. Canonical is `.btn.btn--primary` + native
   `:hover`/`:focus-visible`/`:disabled`.
3. **Static-state specimens via baked classes.** Button/input cards fake
   hover/focus/disabled with classes (thumbnails can't trigger pseudo-states) — the
   same problem solved in `design-system-reference.html` with native states + a
   `.demo-focus` helper. The previews never got that treatment.
4. **Inline `<style>` forks** in 3 files: `brand-imagery.html`,
   `components-card-composition.html`, `spacing-motion.html`.
5. **Icons off-sprite.** Zero `ic-fluent-*` refs and zero `<fluent-icon>` across the
   folder; the few icon cards use raw inline SVG, not the canonical sprite.
6. **Generated artifacts.** Every file carries an `@dsCard …` marker; there's a
   populated `_ds_manifest.json` (~19 KB) and `_ds_bundle.js`. A preview/thumbnail
   generator produced these — hand-edits may be overwritten on regeneration.
7. **Consumed by the deferred `developer-guide.html`** (the only thing referencing
   `preview/`), which is itself deferred. Previews + Developer Guide are one cluster.

**Not wrong (don't over-scope):** the `class="chip"` hits in the color files are
swatch chips (`.sw .chip`, defined in `_card.css`), not the component `.chip` — they
render fine. No `:root` fork. Tokens are correctly shared.

## Plan

### Phase 0 — Decide the maintenance model (gates everything)
Find out whether the `@dsCard` generator is still in the workflow and where its
source/manifest lives.
- **Live** → fix at the source (re-base `_card.css`, update the card template,
  regenerate). Don't hand-edit a folder a generator will overwrite.
- **Defunct** → hand-edit the 27 files directly.
- Also decide: is the sibling `../../project/preview/` tree in scope or a dead snapshot?

### Phase 1 — Re-base `_card.css` onto the canonical library
- `@import "../colors_and_type.css"; @import "../components.css";` and **delete** its
  duplicated `.btn` / `.input` definitions.
- Keep only preview-harness utilities (`.sw`, `.sw .chip`, `.meta`, `.hex`, `.label`,
  `.token`, `.callout`, `.row`, `.col`, base body).
- Add documented static-state helpers `.demo-hover` / `.demo-focus` / `.demo-disabled`,
  mirroring the `.demo-focus` approach already in `design-system-reference.html`.

### Phase 2 — Repoint preview markup to canonical BEM
- `btn primary` → `btn btn--primary` (and `--secondary`/`--tertiary`).
- State specimens: `disabled` → real `disabled` attribute; `hover` → `.demo-hover`;
  `focus` → `.demo-focus`; `input focus/error/disabled` → `.demo-focus` /
  `aria-invalid="true"` / real `disabled`.
- Drop the 3 inline `<style>` forks; use canonical classes from `components.css`.
- Verify every component class in each card resolves against `components.css`
  (no undefined component classes).

### Phase 3 — Icons onto the canonical contract
- For any icon-bearing card (audit `brand-icons.html`, `brand-icon-colors.html`,
  `components-*`): inline the canonical sprite (or a shared include) + `ic-fluent-*`
  `<use>`, or `<fluent-icon>`; convert raw `<svg width>` to `.icon icon--N`.

### Phase 4 — Regenerate or finalize
- Generator-driven: update its card template + `_card.css`, regenerate all 27 +
  `.thumbnail`s, confirm `_ds_manifest.json` reflects the new state.
- Hand-maintained: apply edits directly; refresh thumbnails if used.

### Phase 5 — Verify (same harness as the main pages)
- Serve via Vite; inspect/screenshot each card.
- grep gates: zero retired vocabulary in `preview/` and `_card.css`; zero
  non-`ic-fluent` icon refs; every card resolves all classes against the canonical CSS.
- **Sequence with the deferred `developer-guide.html` update** — it embeds these cards,
  so do them together.

## Decisions to settle when we start
- **Generator status** — is `@dsCard` / `_ds_manifest.json` still live, and where is
  its source? (Hand-edit vs regenerate.)
- **Sibling tree** — is `../../project/preview/` in scope?
- **Static states** — `.demo-*` helper classes (recommended; buildless-consistent with
  DSR) vs. capturing real `:hover`/`:focus` as screenshots.
- **Keep `_card.css`** as a re-based harness (recommended — one home for preview
  utilities) vs. folding each card directly onto `components.css` + a tiny inline harness.
