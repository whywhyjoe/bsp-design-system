# Abacus Icon Library

The canonical BMO consumer-brand (Abacus) icon set — 712 SVGs, 518 unique icons,
self-hosted.

## Contents

- `*.svg`: 712 icons, flat, named `<icon>-<size>.svg`.
- `index.html`: visual contact sheet, grouped by size, with a name filter.
- `catalog.json`: per-asset icon name, declared size, actual dimensions, byte
  size, palette, and `flags`.

## Sizes

| Size | Count |
|---|---|
| 16 | 141 |
| 24 | 208 |
| 28 | 5 |
| 48 | 358 |

369 icons ship at one size only; 104 at two; 45 at all three of 16/24/48.

## How to use them

**By URL — never via a sprite.** These are standalone files; the URL is the whole
contract. `.icon` and `.icon--N` set geometry only (width, height, `flex:none`, a
baseline nudge) with no `<use>` or `currentColor` dependency, so they apply to an
`<img>` exactly as to an inline `<svg>`:

```html
<img class="icon icon--24" src="abacus-icons/add-24.svg" alt="">
```

Decorative icons take `alt=""`; give a real `alt` only when the icon is the sole
carrier of meaning. In native SharePoint web parts (Image, Quick Links, Hero)
there is no markup at all — point the web part at the SiteAssets URL.

See `docs/TECHNICAL-REFERENCE.md` §6, Form 4.

**Sizing.** The `.icon--N` ladder covers every size this set ships:
`.icon--12/16/20/24/28/48`. Always pin one — bare `.icon` is `1.25em`, which
renders a 28px icon at 20px against a 16px font.

## Two things to know before using these

**They are not recolorable, and that's fine here.** Every file carries baked hex
(predominantly `#0075BE`), not `currentColor` — unlike `fluent-basic-icons.svg`,
whose symbols inherit CSS `color`. Since these render as `<img>`, which can't be
tinted regardless, nothing is lost: you take each icon in its shipped colors.

The exception that matters: **on a blue ground a blue glyph disappears.** Add
`.icon--on-blue` (editorial.css), which forces the mark white with a filter.

**35 files are flagged in `catalog.json`.** The filename's size and the SVG's
actual box disagree. Three kinds:

- **4 unexported Figma component-set frames** — `bullet-24.svg`,
  `baby-bullet-24.svg`, `in-progress-24.svg`, `social-instagram-24.svg`. These
  are 56×96, contain two stacked variants, and carry a dashed purple `#9747FF`
  border that renders. They are not usable as-is.
- **Intentionally wide glyphs** named for their height — `bar-16.svg` (71×16),
  the `review-*of5` rating strips (96×16). Not defects, just misleading names.
- **Off-by-one export bounds** — 48×49, 49×49, 17×16 and similar, plus
  `number-1-24.svg` (12×12) and the `star-*-24.svg` set (16×16), which are
  materially smaller than their names claim. These will misalign in a grid.

Filter the gallery or read `flags` in the catalog to see them.

## There is no Abacus sprite

There used to be a placeholder content-icon sprite (`abacus-icons.svg`, ids
`bmo-ic-*`, class `.c-icon`). It has been **removed** — these SVGs are the
canonical set and the only way to use Abacus icons. Reference them by URL; never
inline them into a sprite.

`fluent-basic-icons.svg` (functional Fluent `ic-fluent-*` icons) is a separate
family and is unaffected.

