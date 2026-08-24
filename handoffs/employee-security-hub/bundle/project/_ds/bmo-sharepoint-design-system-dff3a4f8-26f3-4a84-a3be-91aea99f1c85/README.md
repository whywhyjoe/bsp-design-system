# BMO SharePoint Design System

A design-system reference package for the suite of internal BMO (Bank of Montreal)
business applications that live **embedded inside Microsoft SharePoint Online pages**.
It is a deliberate hybrid of three sources:

| Layer | Role | Priority |
|---|---|---|
| **BMO Internal Web Brand** | Color authority, type ramp, tone | 1 — highest |
| **SharePoint Online** | Host environment, surface behavior | 2 |
| **Fluent 2** | Construction system — spacing, radii, motion | 3 |

The goal is **the best version of a BMO Microsoft experience**: Fluent 2 in
construction, BMO in identity, continuous with the SharePoint shell.

> A BMO employee opening one of these apps inside SharePoint should feel like they
> are using a modern, well-made Microsoft productivity tool that clearly belongs
> to their organization.

---

## Sources

Everything in this package was derived from:

- **Codebase** — `Fluent2Sharepoint/` (mounted via File System Access). The
  authoritative context bundle: brand, SharePoint, and Fluent 2 guides plus a
  PDF of brand-guide snips.
- **Figma file** — *Microsoft Fluent 2 Web (Community)*, mounted as a virtual
  filesystem. 51 pages × ~180 frames covering the full Fluent 2 web component
  set. Used as the design source-of-truth for component anatomy, spacing, and
  state styling.
- **Fluent UI System Icons** — Microsoft's open-source icon set
  (https://github.com/microsoft/fluentui-system-icons, MIT). Referenced inline
  per the brand guide's icon rules.

The four source docs are copied verbatim into `docs/` so the design system is
self-contained — you do not need the original repo to use this package.

---

## Index

```
README.md                ← you are here
SKILL.md                 ← Claude skill manifest (drop into ~/.claude/skills/)
colors_and_type.css      ← all tokens: color, type, spacing, radii, shadow,
                           motion, surface tints + visual-interest utilities
components.css           ← the component layer: token-built CSS classes for
                           buttons, inputs, badges, cards, tabs, grids,
                           dialogs, etc. Link after colors_and_type.css.
styles.css               ← one-link entry point: @imports the two files above
                           (link this OR the two individually)

Components.html                ← rendered component library: every class with
                                 live render + copy-paste markup
Design System Reference.html   ← single-page reference for the whole system
Visual Interest.html           ← worked example of the visual-interest layer
                                 (richer home demo + card-composition gallery)

docs/                    ← authoritative reference material (verbatim)
  BMO-INTERNAL-WEB-BRAND.md     · BMO color + type authority
  BMO-BRAND-CONTEXT.md          · brand interpretation for app UI
  SHAREPOINT-CONTEXT.md         · host environment + tech stack
  FLUENT2-GUIDE.md              · Fluent 2 construction reference

assets/                  ← visual assets
  bmo-logo-placeholder.svg      · M-Bar roundel (placeholder, see CAVEATS)
  bmo-lockup-placeholder.svg    · Horizontal lockup (placeholder)
  icons/                        · Subset of Fluent System Icons

preview/                 ← design-system cards (registered for review)
  colors-*.html, type-*.html, spacing-*.html,
  components-*.html, brand-*.html
  (incl. colors-surface-tints, spacing-motion,
   components-card-composition, brand-imagery)

ui_kits/
  sharepoint-app/         ← embedded SharePoint applet (Alpine + HTML + CSS)
    index.html            · the whole applet: shell, grid, panel, modal,
                            wired in Alpine — the production stack, no build
```

---

## Content fundamentals

Copy in this system is **professional, plain, human**. It is not chatty.

### Voice
- **Direct, second-person** — *"Submit your expense"*, *"You're up to date"*. The
  app speaks to the user, not about them.
- **Plain language over jargon.** "Approver" over "delegate signatory."
- **Active voice.** *"Update your manager"*, not *"your manager will be updated."*
- **Calm.** Status banners say what happened, not how the system feels about it.

### Style rules (from BMO + Fluent 2)
| Rule | Example |
|---|---|
| Sentence case **everywhere** | `Submit for approval` — never `Submit For Approval` |
| No "click here" / "read more" | `Review the Q3 expense policy →` |
| No underline or italic for emphasis | use **bold** weight if you must emphasize |
| No emoji in UI surfaces | enterprise / financial context; emoji read consumer-y |
| No exclamation marks | Reserve for legitimate celebration, sparingly |
| Numbers as numerals | `4 documents`, not `four documents` |
| Currency formatted explicitly | `CAD $12,450.00` |

### Tone examples
| Don't | Do |
|---|---|
| *Click here to submit your expense report!* | *Submit expense report* |
| *Oops! Something went wrong.* | *We couldn't save your changes. Try again.* |
| *Welcome back, friend!* 👋 | *Welcome back, Priya* |
| *Awesome — you're all done!* 🎉 | *Submitted. Approval is pending with Sarah Chen.* |
| *Get started* (vague CTA) | *Start a new request* |

### Empty states
Short statement of fact + one action.

> *No active requests.*
> *Start a new request to get going.*

Never apologetic, never cute.

---

## Visual foundations

### Color
- **Blue is the only interactive accent.** `--bmo-blue` (`#0075BE`) fills
  primary buttons, links, focus rings, selected rows. Hover deepens to
  `--bmo-blue-hover` (`#005587`). Focus ring uses `--bmo-blue-focus`
  (`#73C3EB`).
- **Blue is never decorative.** Don't paint card surfaces, headers, or
  empty-state hero blocks in blue — the SharePoint suite bar above already
  carries strong blue. Stacking blues creates noise.
- **Red is for the logo only.** Error states use `--bmo-negative` (`#D12121`)
  — slightly different hue from BMO Red, identical to Fluent 2 semantic red.
- **Surfaces are white-dominant.** `#FFFFFF` is the canvas. `#F5F6F7`
  (Albicant) is the only secondary surface. Avoid SharePoint's warm `#F3F2F1`
  inside app components — it blurs the app/shell boundary. For richer
  landing/home surfaces, soft `--surface-tint-*` bands may alternate sections
  (still solid, never behind interactive surfaces).

### Type
- **Segoe UI, always.** No other typeface. Emona SemiBold is the BMO logo
  font and is *not* a UI font.
- **H1–H3 are Regular weight**, not Semibold. Only H4–H6 are Bold. This is
  BMO's published rule and the most-broken one when porting from Fluent 2
  defaults.
- **Body is 16px / 22.4px line-height**, color `--bmo-slate` (`#001928`).
  Where Fluent 2 calls for 14px Body1, BMO calls for 16px. Use 14px only when
  matching SharePoint chrome directly (toolbars, breadcrumbs).
- **Sentence case** — never all-caps for labels or buttons.

### Spacing & layout
- **4px base unit.** Use the Fluent 2 ramp: `4, 8, 12, 16, 20, 24, 32, 40, 48`.
- **Internal app padding on the SharePoint canvas: 16–24px** (`size160`–`size240`).
- **12-column grid.** Breakpoints from Fluent 2 (small <479, medium <639,
  large <1023, x-large >1024, etc.).
- **Information-dense is correct.** These are productivity tools. Don't pad to
  feel airy — pad to organize density.

### Shape
- **Default corner radius: 4px** (`--radius-medium`). Buttons, inputs, badges.
- **Cards: 4–8px.** Stay restrained. No pill cards.
- **Dividers, not boxes.** Prefer a 1px `--stroke-divider` rule between
  sections over heavy bordered containers.

### Elevation
- **Subtle, always.** Cards use `--shadow-4` or `--shadow-8`. Dialogs may use
  `--shadow-28`. **Never** `--shadow-64` on an embedded canvas.
- **Border + subtle fill** over heavy shadow for info panels and stat blocks.

### Borders & strokes
- **Dividers:** 1px `--bmo-light-grey` (`#D9DCE1`).
- **Control borders:** 1px `--f2-grey-74` (`#BDBDBD`) at rest, `--bmo-blue`
  on focus with a 2px stroke.
- **No left-accent borders** on cards — it's an AI-design cliché that this
  brand never uses.

### Backgrounds & imagery
- **Surfaces stay white-dominant.** White is the canvas; Albicant the only
  secondary panel.
- **Soft surface tints are allowed for section bands** (the visual-interest
  layer): `--surface-tint-neutral` `#F4F6F8`, `--surface-tint-blue` `#EDF3F9`,
  `--surface-tint-sky` `#E4EEF6`. Use them to alternate one section from the
  next (tint / white / tint). **Solid, very low saturation only — still no
  gradients**, and never a tint behind interactive surfaces (buttons, inputs,
  cards).
- **No transparency or blur effects** inside app surfaces. Acrylic / Mica
  materials are Windows-native, not for web embeds.
- **Imagery is welcome on landing/home surfaces** — hero, top-of-card, and
  full-height side images. Until real assets are licensed, use the labeled
  striped placeholder (`.imgph` + a `.lbl` caption naming the asset and size,
  on `--surface-image-ph` `#E9EDF1`) so a layout reads as intentional.
- **Illustrations**, when used, are line art only — Slate, Ultramarine, BMO
  Blue, Cerulean, Pale Skyblue, on white or Albicant. Rounded stroke caps,
  frontal 2D perspective.
- **Photography**, where present, is professional — warm but desaturated,
  workplace-realistic. Never glossy stock imagery.

### Motion
- **Functional, not decorative.** Fluent 2 curves and durations, now exposed
  as tokens: `--motion-fast` (100ms), `--motion-normal` (160ms), `--motion-slow`
  (250ms), `--motion-reveal` (550ms), with `--ease-out` / `--ease-in` /
  `--ease-in-out`. No bounce, no spring physics, nothing that loops.
- **Reveal on scroll.** Content fades + rises 14px once, then settles
  (`.reveal` → JS adds `.is-in`). The hidden start-state only exists inside
  `@media (prefers-reduced-motion: no-preference)`, so print, no-JS, and
  reduced-motion always show full content.
- **Hover lift.** Interactive cards rise 3px and deepen to `--shadow-16`
  (`.lift`). Reserve for cards that are themselves links/actions.
- **Hover state (buttons/links):** color shift to `--accent-hover`; footer-link
  arrows may nudge 3px. **Press:** darkens to `--accent-pressed`, no scale.
- **Focus state:** 2px solid `--stroke-focus` ring — appears the moment
  keyboard focus lands, no animation.
- **Honour `prefers-reduced-motion`** everywhere.

### Cards
The base card — the default, simplest form — is unchanged:
```
background: var(--surface-raised);     /* #FFFFFF */
border: 1px solid var(--stroke-divider);
border-radius: var(--radius-medium);   /* 4–8px (--radius-large for richer cards) */
box-shadow: var(--shadow-4);
padding: var(--space-160) var(--space-200);   /* 16 / 20 */
```
No colored left border. No gradient. No tilt.

**Card composition (visual-interest layer).** One anatomy, six interchangeable
parts that mix freely — all on the tokens above:
1. **Heading** — eyebrow + title (+ optional body).
2. **Footer** — metadata left + one action right, on a 1px top divider.
3. **Leading icon** — Fluent icon in a soft `--surface-tint-blue` tile.
4. **Top image** — full-width `.imgph`, ~120–152px tall.
5. **Left image** — full-height `.imgph` down the left edge (content stacks right).
6. **Stat block** — large numeral + delta (Positive/Negative).

Add `.lift` to make a card an interactive, hover-lifting surface. See
`Card composition` in the reference and the assembled example in
`Visual Interest.html`.

---

## Iconography

The system uses **Microsoft Fluent System Icons** (open-source, MIT,
https://github.com/microsoft/fluentui-system-icons). This is BMO's own
stated icon system for SharePoint contexts.

### Approach
- **SVG, inline.** Icons render as inline `<svg>` with `currentColor` fill so
  they inherit the parent text color.
- **20px Regular is the default size + weight.** Switch to **Filled** for
  selected / active states.
- **Color rules:**
  - `--fg-primary` (Slate) for standard UI icons
  - `--fg-accent` (Accessible Blue) for actionable / interactive icons
  - `--fg-secondary` (Granite) for de-emphasized rows
  - Never apply gradient, shadow, or multi-tone color to a Fluent icon.
- **Sizes used:** 12, 16, 20, 24. Never scale arbitrarily. 12px is informational
  only (status dots, dense table chevrons) — not a click target.

### No emoji, no unicode chars as icons
This is a financial enterprise productivity context. Emoji are not used in
SharePoint embeds. Unicode arrows / bullets / checkmarks are also out —
always reach for a Fluent icon instead.

### Where icons are
Common icons used by these apps are inlined as SVG in components and listed
under `assets/icons/`. For a wider set, copy from the upstream repo:
`microsoft/fluentui-system-icons/assets/{name}/SVG/ic_fluent_{name}_{size}_{theme}.svg`.

---

## UI kits

- `ui_kits/sharepoint-app/` — a representative embedded BMO SharePoint applet
  (the kind of internal business app these guidelines exist for): a dashboard
  with cards, a data grid, a side panel, and a modal form. Built with the
  production stack — **Alpine.js + plain HTML + CSS**, styling every element
  with the `components.css` classes. Read it to see the system wired end-to-end.

---

## How to use this in design work

1. **Color decision?** Check `colors_and_type.css` → use a semantic token
   (`--fg-primary`, `--accent-rest`, etc.). If undefined, fall back to a BMO
   value, then to a Fluent 2 neutral.
2. **Typography?** Use the `.h1`–`.h6` classes or the `--type-*` font
   shorthands. Don't invent sizes.
3. **Component?** Link `components.css` and use the class (`.btn`, `.card`,
   `.input`, `.badge`, `.grid`, …). See every class rendered with copy-paste
   markup in `Components.html`. If one is missing, build it on the same tokens.
4. **Layout?** 4px ramp, 12-column grid, 16–24px container padding.

## Critical rules (memorize)

- **BMO Red is logo-only.** Errors use `--bmo-negative` (`#D12121`).
- **Blue is interactive, never decorative.**
- **White is the default surface.** Don't use SharePoint's warm `#F3F2F1`.
- **Segoe UI, sentence case, no emoji.**
- **Elevation is subtle** — `--shadow-4` / `--shadow-8` max for embedded surfaces.
- **This is an Alpine + HTML + CSS stack** — not React, no web-component
  library. Components are the `components.css` classes; behaviour is Alpine.

---

## Caveats

- **Logo is a placeholder.** `assets/bmo-logo-placeholder.svg` is a flat
  reconstruction of the M-Bar roundel made for design-mock purposes only. The
  real BMO logo must be requested from BMO's brand team for any production
  use.
- **No real screenshots or photography.** The source materials contain no
  application screenshots or BMO-licensed photography. Where the UI kit calls
  for imagery, neutral placeholders are used.
- **Segoe UI is the system font on Windows.** Standalone previews opened on
  macOS or Linux will fall through to San Francisco / Helvetica Neue /
  Arial — visually close but not identical.
- **Figma file is the Microsoft Fluent 2 community kit**, not a BMO-specific
  Figma. BMO-specific component variations (if any exist) would need to be
  layered on top.
