# Employee Security Hub — implementation

Implements the **circle-photo hero** artboard (`1a Arc hero`) of the Claude Design
handoff in [`handoffs/employee-security-hub/`](../../handoffs/employee-security-hub/),
as a set of SharePoint **custom script web parts** plus two disk-openable previews.

## Files

| File | What it is |
|---|---|
| `index.html` | Hub home **preview** — open straight from disk |
| `wifi.html` | Wifi sub-page **preview** — open straight from disk |
| `webparts/sechub-hero-nav.html` | **Web part 1/3** — hero + sub-nav, full-width section, identical on every page |
| `webparts/home-main.html` · `webparts/home-aside.html` | **Web parts 2/3 + 3/3** for the hub home (2/3 left column · 1/3 right rail) |
| `webparts/wifi-main.html` · `webparts/wifi-aside.html` | Same pair for the Wifi page |
| `assets/hero-photo-circle.png` | Hero photo — ⚠ **unlicensed Adobe Stock comp (asset 275233825)**; license before production |

The `webparts/` fragments are the **source of truth**; the previews are the same
markup assembled with paths repointed for disk (examples convention — relative in
`examples/`, absolute in real pages). Edit a fragment → mirror it in the preview.

## Assembling a real page

Every hub page is three script web parts on a SharePoint modern page
(`/sites/TandO-FCU/SitePages/SecurityHub/<slug>.aspx`, page title area hidden):

1. **Full-width section** → paste `sechub-hero-nav.html`, unchanged, on every page.
   (If a true full-width section isn't available, uncomment the canvas-zone CSS
   override at the bottom of the fragment's `<style>` block.)
2. **2/3 + 1/3 section** → paste the page's `…-main.html` into the left column
   and `…-aside.html` into the right.

The hero-nav web part carries the CSS `<link>`s, the icon sprite, and all
`sechub-*` styles — the body web parts are pure markup and depend on it.

## How the nav knows the current page

The hero-nav fragment is byte-identical everywhere. Its inline script takes the
URL's filename stem (`…/wifi.aspx` → `wifi`), and immediately injects one small
`<style>` into `<head>` that (a) highlights that item in `#sechub-nav` and
(b) swaps in that page's hero copy block. CSS applies whenever it lands — no
waiting on the DOM, no flash, no lazy-load race. It then sets `aria-current` /
`.is-active` for assistive tech once the nav element exists. Any unrecognized
filename (including whatever the hub home ends up being called) falls back to
the hub-home state.

**Adding a topic page** = create `<slug>.aspx` and paste the same three-web-part
recipe. All ten topics (`wifi devices collaboration documents iot email
passwords workplace preparedness travel`) are already wired into the nav and the
hero copy blocks; only that topic's `…-main.html` / `…-aside.html` need writing.

**Nav layout:** with eleven items (Hub + ten topics) the icon sits *above* the
label, so each item is only as wide as its own word. The strip measures 1180px
against a 1116px content box at desktop and does not scroll; it keeps
`overflow-x: auto` as a narrow-viewport fallback. The active underline is an
`::after` inset to the item's content box — so it starts and ends exactly on the
label, not on the padding — and is pulled down onto the divider (`bottom: -1px`)
so the blue rule and the grey rule read as one line.

## Things to fix before production

- **Hero photo license** — the checked-in PNG is a free-tier comp; buy the Adobe
  Stock license (or swap the asset), then upload to
  `/sites/TandO-FCU/SiteAssets/SecurityHub/hero-photo-circle.png`.
- **Hub home URL** — the Hub nav link points at `FCU-Page.aspx`, taken from the
  live URL. Fix the one `href` in `sechub-hero-nav.html` if it moves; the
  current-state script needs no change either way, since any unrecognised
  filename falls back to the hub-home state.
- **Asset host** — fragments load the design system from
  `/sites/FCUPortal/Code/bsp-design/` per the deploy layout; repoint if the
  system gets deployed under TandO-FCU instead.
- **Related-resources links** — placeholders (`#`) in both `…-aside.html` files.
- **Draft copy** — the wifi body text and the six not-yet-designed hero ledes
  are drafts; have the security team review.

## Design notes

- Hero gradient/texture and oversized photo circle are the design's sanctioned
  "allowed to pop" exception; everything else composes existing blocks
  (`.sp-nav` + `.is-active`, `.card` + `.card__icon-tile`, `.webpart--framed`,
  `.related--divided`, `.lift`) on tokens. Pure blue ramp — **no green, no teal**.
- Nine of the eleven nav icons are **stand-ins drawn to the 1.6-stroke Fluent
  grammar** (`wifi`, `phone-laptop`, `people-team`, `print`, `iot`,
  `lock-closed`, `weather-thunderstorm`, `airplane`); only `home` and `mail`
  come from `fluent-basic-icons.svg`. Each of those names a real Fluent icon, so
  swap in the authentic SVGs from the `fluentui-system-icons` library when it's
  to hand. The eleventh, `desk-chair` (Workplace), was drawn from scratch and
  may have no Fluent equivalent — check the library before assuming a swap. The topic-card icons on the live page are the custom migrated
  set and are not touched here.
- The sub-page hero deliberately oversizes the "Employee Security Hub" eyebrow
  (21 px semibold, pale sky blue): a page titled just "Wifi" is meaningless
  without the section name.
