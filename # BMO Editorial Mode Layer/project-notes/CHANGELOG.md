# Changelog

All notable changes to the BMO SharePoint Design System.

## [Unreleased]

### Added — Editorial mode (additive layer)

A new **Editorial mode** register for warm, employee-facing content pages (learning
catalogs, resource hubs, awareness pages) that mesh with the SharePoint-modern intranet
chrome. It is a **mode, not a fork**: built entirely on the existing tokens and BEM
vocabulary, scoped under a root `.editorial` class, and it never redefines `:root`. All
delivery constraints (buildless, CDN-free, self-hosted, token-only, inline-Alpine, icon
contract) are inherited unchanged; only the app register's austerity defaults are relaxed.

- **`editorial.css`** — the additive layer. Adds `--ed-*` custom properties on the
  `.editorial` scope (display type ramp, section rhythm, hero min-heights, brand-device
  helpers), the SharePoint host chrome (`.sp-suite` / `.sp-hubnav` / `.sp-site` / `.sp-nav`
  / `.sp-footer`), hero brand-devices (`.hero--band` / `--blue` / `--scrim` / `--circle` /
  `--arc` / `--bokeh`, plus `.band--flood`), and editorial component blocks
  (`.card--course`, `.eyebrow-chip`, `.link-row`, `.facilitator`, `.scorecard`,
  `.media-card`, `.key-messages`, `.cta-band`, `.spot`, `.c-icon`). Link **after**
  `components.css`.
- **`docs/EDITORIAL-MODE.md`** — the guide: when editorial vs app, the delivery
  constraints, the 3-tier art system + prominence rule, brand hero devices with recipes and
  hard limits, colour/type notes, component catalog with snippets, the shipped inline-Alpine
  wiring, do/don't, and file map.
- **`bmo-content-icons.svg`** — the corporate **content line-icon** tier (`bmo-ic-*`,
  rendered with `.c-icon`), for content labeling — distinct from the functional
  `bmo-icons.svg` Fluent app icons. Placeholder art standing in for the licensed "BMO Design
  Icons" library (same sprite pattern, same ids, no reflow when swapped).
- **`bokeh.svg`** — spec-compliant bokeh background artwork (blue gradient corner-to-corner
  + round translucent circles), the sanctioned alternative to photography for dry content.
- **`illustrations/`** — spot illustrations used by the example pages (a subset of the
  154-SVG BMO line-drawing library).
- **Example pages** — `Learning Catalog.dc.html` (hero band, course-module grid, materials,
  facilitators, spot-illustration marker, blue-flood CTA) and `Resource Hub.dc.html` (arc
  hero, essential-resources tinted grid, blue scorecard tiles, video cards, key-messages
  carousel), each framed in representative SharePoint chrome.

### Changed — Editorial mode: heroes flat by default; user-tuned type scales

- **All heroes are flat/flush** — `.hero--banner` and `.hero--arc-blue` lose radius,
  border and shadow, matching the OOB SP hero web part. `.hero--flat` is **retired**
  (redundant; never reintroduce). Cards, player and slider keep the showcase finish.
- `--ed-overlay-ground: #0079C1` — tuned ground under the `--blue` overlay's greyscale photo.
- Type tuning: masonry lead title 500 28/36 (hover underline removed), `.webpart__title`
  weight 500, `.news-lead__title` 500 30/36.

### Added — Editorial mode: mesh register, video player, spotlight slider, library + guide

- **Mesh register** (editorial.css §16) — flat, hairline forms that sit flush beside
  out-of-box SharePoint web parts (the live T&O Central look): `.card--quiet`,
  `.webpart` / `--framed` / `__title` / `__foot` (SP web-part shell), `.news-list` +
  `.news-item` (thumbnail-left news rows on dividers), `.quicklink-grid` + `.quicklink`
  (outlined icon+label tiles), `.related` / `--divided` (related-links web part).
  Rule of thumb: pick ONE finish (showcase or mesh) per page.
- **Video player** (§17) — `.player` full inline-player look: 16:9 stage, centered play,
  title band, control bar (progress/time/volume/cc/fullscreen) on a functional legibility
  scrim. `.player--flat` for the mesh register. Complements the existing `.media-card`.
- **Spotlight slider** (§18) — the `.key-messages` shell generalized beyond quotes:
  `__eyebrow` / `__title` / `__text` / `__link` slide parts, `__nav` with `__arrow`
  prev/next buttons joining the dots, and `.key-messages--quiet` for the flat form.
- **Arc on blue / masonry / featured news** (editorial.css §19–21) — `.hero--arc-blue`
  (photo circle atop a solid BMO-blue block, white ring), `.hero-masonry` (SP tiled hero web part, always flat), and
  `.news-feature` / `.news-lead` / `.news-compact` (the BMO Central two-zone news block).
- **`Editorial Components.dc.html`** — the editorial component library page (in the style
  of `examples/Components.html`): every editorial block live with copy-paste markup.
- **`Editorial Design Guide.dc.html`** — the editorial design guide (in the style of
  `examples/Design System Reference.html`): when to use, showcase-vs-mesh decision, hero
  device chooser, art tiers, color/type/shape/motion rules, do/don't, file map.

### Notes

- **Sanctioned blue-fill exceptions.** "Blue is never a decorative fill" holds, with two
  documented exceptions that are blessed BMO patterns carrying white content and no
  interactive controls: the **scorecard** tiles and the **flood-of-blue** section band.
- **Red stays logo-only.** The single red anywhere in editorial mode is the M-bar roundel in
  the suite bar. No red content circle (against BMO guidelines).
- **Placeholders to replace for production.** `bmo-content-icons.svg` (→ licensed BMO Design
  Icons), `assets/bmo-logo-placeholder.svg` (→ official BMO logo), `bokeh.svg` (→ approved
  bokeh artwork), and example imagery (→ licensed BMO photography).
- No retired vocabulary was reintroduced; no existing component or token was modified.
