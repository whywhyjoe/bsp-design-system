# Handoff — Employee Security Hub (SharePoint page template)

A Claude Design export, checked into this repo so a fresh coding session can pick it up
with no prior context. The verbatim export is in [`bundle/`](bundle/); this file is the
map to it.

**Start here → [`bundle/project/Employee Security Hub.dc.html`](bundle/project/Employee%20Security%20Hub.dc.html)**
then read [`bundle/chats/chat1.md`](bundle/chats/chat1.md) for the intent behind it.

---

## What was designed

A template for a **SharePoint Online modern page** that fronts a section of ~8 related
pages — the Employee Security Hub (Wifi, Email, Passwords, Cloud, Mobile, Remote work,
Phishing, Reporting).

The design file holds **two artboards**, both 1280px wide, alternate treatments of the
same page:

| Artboard | Hero treatment |
|---|---|
| `1a Arc hero` | Photo in a white-ringed circle, oversized, bleeding off the right edge and bottom |
| `1b Spot illustration hero` | `security-s.svg` staged in a white roundel with echo rings |

Everything below the hero is identical between the two.

### How it maps onto SharePoint

This matters — it's the constraint the whole design is built around:

- The **site header, hero and sub-navigation** ship as a *custom script web part*. That
  web part is normally clamped to the main content column; a CSS override on the canvas
  zone container takes it to 100% width so the hero background can bleed full-bleed,
  simulating a full-width web part.
- **Everything below the sub-nav is mocked, not built** — it stands in for standard
  SharePoint canvas zones in a 2/3 main + 1/3 right-rail split. Real deployments fill
  those with stock web parts (text, quick links).
- The **footer** is the standard SP page footer.

So the deliverable is realistically the header + hero + sub-nav web part; the body is
reference for how the finished page should look around it.

### Page states

The file drives two states off a `pageExample` prop:

- **Hub home** (default) — hero title *"Employee Security Hub"*, `Hub` tab active,
  body is a 2-column grid of topic cards.
- **Sub-page (Wifi)** — the eyebrow *"Employee Security Hub"* is deliberately large and
  emphasized (21px semibold, pale sky blue) above a smaller page title, because a page
  named just "Wifi" is meaningless without the section name. `Wifi` tab active.

A second prop, `zoneGuides`, toggles dashed annotations marking which regions are the
custom web part vs. standard canvas zones.

---

## Verification (run 2026-08-24, before check-in)

The bundle was audited end to end. **No broken references.**

| Check | Result |
|---|---|
| Files referenced by the `.dc.html` | all present |
| CSS classes used (18) | all defined |
| CSS custom properties used (28) | all defined |
| SVG `<use>` symbols (12 used, 15 defined) | all inline — self-contained sprite, no external icon file needed |
| `url()` refs in CSS | all resolve |
| 50 SVG assets | 0 malformed |
| HTML structure | parses clean, no unclosed tags |

Note: `.webpart` has no base rule in `editorial.css` — that is **by design** ("an unboxed
section"); only `.webpart__title`, `.webpart--framed` and `.webpart__foot` carry styles.

---

## Read this before you build

1. **Ignore `bundle/project/_ds/`.** It is a stale snapshot of the design system —
   `colors_and_type.css` differs by 26 lines, `components.css` by 468, and it has no
   `editorial.css` at all. The designer switched to the live repo copies on purpose.
   Build against `bundle/project/*.css`, which are byte-identical to this repo's root
   CSS files.

2. **The design-system assets are duplicates.** All 49 SVGs in `bundle/project/`
   (abacus-icons, spot-illustrations, bokeh) are content-identical to this repo's root
   copies — the only difference is that the export re-serialized `<path/>` as
   `<path></path>`. Prefer the repo root copies as the source of truth.

3. **The hero photo needs a real license.** `bundle/project/assets/hero-photo{,-circle}.jpg|png`
   is Adobe Stock asset **275233825** on the free tier. The user's words: *"we will use
   Adobe Stock in the end."* Swap in a properly licensed asset before production.
   The PNG is a plain 1200×1200 square — the circle is CSS `border-radius: 50%`,
   not baked into the file.

4. **The transcript is truncated in two places.** In `chat1.md` the recorded `ask_user`
   answers cut off mid-sentence: the subject list reads *"mobile devices, remote work…."*
   and the hub-page description ends at *"links to each p…"*. The eight topics are
   recoverable from the design file itself, but if there were subjects beyond those
   eight, they are not in this bundle. **Confirm the full page list with the user.**

5. **Artboard 1b is missing two `zoneGuides` annotations** that 1a has (the two
   canvas-zone labels). Cosmetic, affects only the annotation overlay.

6. **`support.js` is the Claude Design runtime**, not project code. It powers the
   `<x-dc>`, `<sc-if>` and props machinery used to preview the two page states. Do not
   port it — resolve the states at build time instead.

---

## Design decisions worth preserving

These came out of several rounds of iteration; the transcript has the full arc.

- **No green, no teal, anywhere.** This is a hard requirement from the user, not a
  preference — an earlier bokeh background was rejected for drifting cyan. Keep the
  whole ramp pure blue. The hero now sits on:
  a BMO-blue glow top-left over `#005587 → #003A5C → #00263D`, with a quiet techy
  texture — a fine dot grid plus thin circuit traces with node dots, white at ~10%.
- **One icon set: Fluent stroke icons.** An earlier mix of Abacus icons and hand-drawn
  glyphs read as inconsistent and was replaced wholesale. Nav icons 30px, topic-card
  icons 42px in tinted tiles.
- **The hero is allowed to break the design system.** The user was explicit: *"this is a
  highly visual feature, you do not have to hold to the design system exactly here, it
  needs to pop."* Imagery is deliberately off-center on both axes and bleeds off an edge.
- **Topics are a card grid, not a list** — chosen so the icons could be larger, with
  one-line descriptions.
- **The rail closes on a spot illustration** (`shield-light-bulb-xs.svg`) — security plus
  a positive, forward-looking read. An earlier pick was rejected as unsettling. The
  runner-up, if this one needs replacing, is `goals-l.svg` (summit + flag, finest linework).

---

## Bundle contents

```
bundle/
  README.md                        Claude Design's own handoff notes
  chats/chat1.md                   the full design conversation — read it
  project/
    Employee Security Hub.dc.html  the design (two artboards)
    colors_and_type.css            \
    components.css                  | identical to this repo's root copies
    editorial.css                  /
    support.js                     Claude Design runtime (not project code)
    assets/                        hero photos, bokeh SVGs, BMO roundel
    abacus-icons/                  29 icons — now unused, superseded by Fluent
    spot-illustrations/            14 illustrations — 2 used
    fluent-basic-icons.svg         unused; the design inlines its own symbols
    scratch/                       contact sheets used to pick icons/illustrations
    _ds/                           STALE design-system snapshot — do not use
    github.md                      sync log from the design session
    .thumbnail                     preview render of the final state
```

Unused assets were left in place deliberately: they are what the designer had staged
while choosing, and they make swaps cheap.
