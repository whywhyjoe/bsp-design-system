# Digital-editorial mode — Claude Design handoff brief

> **What this is:** the task + context for building **Editorial mode**, an additive
> "feel-good / employee-facing web" layer on top of the existing BSP Fluent design
> system. Hand the *Kickoff prompt* (below) to a Claude Design session that has this
> repo; it points back at this brief for the full spec.
>
> **Naming (locked):** the warm content register is **Editorial mode** (opposite of the
> functional **app** register). The big line-drawing brand artwork is **spot
> illustrations** (distinct from functional **icons**).

---


---

## 1. The core reframe (read this twice)

The existing design docs (`CLAUDE.md`, `copilot-instructions.md`, `TECHNICAL-REFERENCE.md`)
read as strict law. For Editorial mode, **split those rules into two piles:**

**A. Delivery constraints — still HARD. Inherited unchanged.**
These are true because the artifact still ships inside SharePoint Online, and that
doesn't change in editorial mode:
- **Buildless, CDN-free, self-hosted** at runtime. No bundler, no ES `import`, no runtime
  CDN. Every dependency self-hosted in SiteAssets (including Alpine). What you author is
  what runs.
- **One BEM vocabulary on the shared tokens.** Compose from existing classes + modifiers;
  build new blocks from the CSS custom properties. **No raw hex, no off-ramp px** a token
  covers. **Never redefine `:root`.**
- **Interactivity = minimal inline Alpine** against the documented state contract. Every
  binding inside an `x-data` ancestor. No behavior-factory layer.
- **Icon contract** unchanged: `ic-fluent-{name}-24-regular` over the inlined
  `bmo-icons.svg` sprite; size via `.icon--N`.
- Hand-rolled Fluent 2 + BMO — no third-party UI/icon kit.

**B. Austerity / altitude defaults — this is what Editorial mode RELAXES.**
The current system is deliberately austere because it's mimicking app chrome:
"effective delivery over aesthetics," high density, small type, ornament-avoidance,
illustrations-never-as-hero, tight spacing. **Editorial mode deliberately turns these
dials the other way** — more scale, more air, hero-led, photography/illustration-forward,
CTA-driven warmth — *without touching pile A.*

If you ever feel a rule fighting you, ask: is it a *delivery* rule (obey) or an
*austerity* rule (that's the one editorial mode is here to loosen)?

---

## 2. What we're meshing with (the real target)

The pages live inside **plain SharePoint-modern intranet chrome**: the blue SP suite bar,
the hub-nav strip, a site title + horizontal nav row, the `© BMO Financial Group` footer
bar. Our content sits *inside* that frame. It must sit next to it comfortably — not look
like an alien embedded app, and not look like a broken clone of SP either.

**The intranet's own content vocabulary** (what "good BMO intranet page" looks like):
full-bleed hero/banner images with text over a scrim; card grids (image-top, blue link
title, short blurb); news rollups (thumb + headline + timestamp); quick-link tiles
(small icon + label); "Learn more" CTAs; tinted section bands; section headers.

**Crucially, BMO already publishes sanctioned "Design Patterns"** (via the Digital
Services CoP) for exactly our page types — Communications, Programs & Resources, and
**Learning**. Editorial mode's job is: **render the heart of those blessed patterns natively in our
token system, warmed up, done right.** We're not inventing a register; we're executing
BMO's own one with actual craft.

Pattern shapes to support (from the BMO pattern PDFs):
- **Learning:** course-module cards (image-top + blue "COURSE NAME" eyebrow chip +
  headline + blurb + "More Information →"); a denser course-module grid; "Course
  Materials" (icon + link + one-line descriptor rows); "Facilitators" (avatar card: name /
  title / phone / email); "Roles" (image tiles); events with start/end datetimes + "View
  All Events".
- **Programs & Resources:** "Major Resource Hub" hero; Overview + video thumb; "Essential
  Resources" card grid on a **tinted band**; icon-link rows for supporting info; "Key
  Messages" carousel (person photo + dot nav); a **Scorecard** row of solid-blue tiles
  (white line-icon + metric label + caption); category/subcategory chips; document-
  thumbnail grids; "Training Videos" with play overlays; toolkits.
- **Communications:** hero/featured-story carousel; news tabs; reminders list.
- **This was not an exhaustive list of applications, but, we will start with these**

---

## 3. The three-tier art system (the guardrail that keeps this from becoming clip-art soup)

Editorial mode formalizes exactly how each asset family is allowed to appear. This mirrors
BMO's own guidance ("icons are functional, not decorative"; "use an illustration only if
you have something to say").

| Tier | Asset | Source in repo | Allowed use | Never |
|---|---|---|---|---|
| **Functional icons** | Fluent `ic-fluent-*` sprite (+ optional icon font) | `bmo-icons.svg`, `fluent-icon.js` | App UX affordances — buttons, progress, form controls, inline meaning. Unchanged from today. | — |
| **Corporate line-icons** | "Official BMO Design Icons" library (Accelerate, Account, Athlete, Bank…) | *Not yet in repo — to be added; ~48/96px SVG, BMO Blue/White/Granite* | **Content labeling** in editorial pages: training categories ("Our Clients," "Regulators"), section markers, scorecard-tile glyphs. | Real app UX (edit/save/progress/nav). |
| **Spot illustrations** | 154 consumer line-drawing SVGs, BMO-blue family | `bmo-illustration-library/` (`illustrations/`, `catalog.json`, `gallery.html`) | **Hero-substitute / feature moments**, ~1 per page, staged on white/albicant: (a) web content intro/welcome pages where a photo isn't appropriate ("dry" subject matter — e.g. a tech-standards library); (b) an **app intro / welcome / landing screen** as a warming design element; (c) **section markers / dividers / content-area accents** within long editorial pages (sparingly). | Functional/working app screens; competing beside a photo hero; wallpaper-style repetition; crowding. |

#### Spot-illustration facts for implementation:
- Spot illustrations will be custom created for a particular application, unless a specifically-appropriate version can be sources from the existing library. All custom-created spot illustrations will follow the illustration guidelines and be designed to look as if they are part of the native library.
- The sizes included in the library are not constraints; they are simply the reality of what has already been made available.
- 154 SVGs, `viewBox` mostly `0 0 96 72` (`-xs`), some `-l` (240×200) / `-s` / `-m`.
  Palette is the BMO consumer blue family (`#0079C1`, `#73C3EB`, `#005587`, `#C1E7FF`,
  `#001928`…). `catalog.json` has per-asset source URL, source pages, dims, palette,
  checksum. `gallery.html` is a visual contact sheet.
- BMO's illustration rules to encode: line = BMO Blue/Slate/Light Grey; stage on
  White/Albicant; rounded strokes/caps; frontal 2D (no depth); no faces/figures; not
  "too cute"; SVG preferred; transparent bg; used to *enhance* text, not ornament.

#### The BMO **arc/ring hero motif** (partial gold+blue circles framing a hero image) is a
  real brand device seen in the pattern PDFs — consider an editorial hero variant for it.

### 3.1 Photography is the lead medium (tier 0) + the prominence rule

BMO brand is **photography-forward**. The Brand Toolkit calls photography "our most
powerful tool" and explicitly says to **"avoid using icons or illustrations with the same
prominence as photography."** Direction to encode when specifying/selecting hero imagery:
- Authentic/candid/honest/real/unexpected **moments** — "start with a story"; life in
  progress, not posed. Familiar moments in unexpected ways.
- **Natural light**, soft shadows, realistic color. Avoid dark/dramatic/high-contrast and
  any "trendy effects or filters."
- **Dynamic composition** — interesting angles, out-of-focus foreground, unexpected crops.
- **Believable human perspective** — eye-level / a person's vantage; no bird's-eye views.
- Diverse, inclusive, safe behaviors (helmets/seatbelts), variety of activities.
- Headshots: friendly/genuine/approachable; light, neutral backgrounds; natural light.

**How this reconciles with the 3-tier art system (important):**
- **Photography leads.** When a page has a photo hero, do NOT place a spot illustration or
  corporate line-icon at competing prominence.
- A **spot illustration as hero is a deliberate *substitute*** — for warmth/awareness
  pages that have no photo (or shouldn't use one). It stands in for the hero; it doesn't
  sit beside a photo hero at equal weight. Still ~1/page, staged on white/albicant.

**Photography vs spot illustration — how to choose (author's rule):**
- **Hero photography** → home pages, article/news content, intro/welcome pages — wherever
  a warm, authentic human moment *fits the subject*.
- **Spot illustration** → (a) an intro/welcome page for **"dry" subject matter** where a
  photo would feel forced (e.g. a technology-standards library — no staged IT photo);
  (b) to warm an **app intro / welcome / landing screen** where a working app screen
  wouldn't traditionally carry a hero; (c) **section dividers / content-area accents** down
  a long editorial page.
- It's a deliberate **mix chosen by subject appropriateness**, not one-or-the-other
  globally. The through-line: use this editorial vocabulary *contextually* to make UIs that
  belong in the editorial / learning / internal-comms setting — never to decorate for its
  own sake.

### 3.2 Hero brand devices — digital-valid subset (build these)

From the Brand Toolkit "Our visual style" pages. Some print devices don't apply to digital.

Valid / build as reusable editorial hero treatments:
- **Circle overlay** — BMO circular crop/frame/arc device over hero imagery. (Same family
  as the arc/ring motif above.)
- **Blue overlay** — brand-blue color wash/scrim over photography (also carries text
  legibility). Drive from a token, solid (no gradients per existing token guidance).
- **Bokeh** — soft out-of-focus light/background quality; honor in photo selection and any
  decorative background treatment.
- **Photo + "story" voice pairing** — headline/copy composed to work *with* the image.

Explicitly OUT / hard limits:
- **Triangle overlay — NOT for digital.** Print/brand device only. Do not use.
- **Red circle overlay — NEVER.** Against BMO internal guidelines. Hard no. Reinforces the
  existing rule that logo-red `--bmo-red` is never used in UI.
- No dark/dramatic photo treatments; no trendy filters.

**Buildable brand specs (from the Brand Toolkit — use these exact recipes):**
- **Blue overlay (legibility scrim over a photo):** 100% BMO blue, blend mode **Multiply**,
  underlying image shifted to **greyscale**, image opacity **~40%** (**20–40%** for darker/
  higher-contrast images). This is the recipe for the hero text-over-photo treatment.
- **Blue band (translucent panel):** transparent BMO blue, **Normal** blend, **85% opacity**.
- **Bokeh background** ("Circle inspired: Bokeh background") — the approved alternative to
  photography when a photo isn't necessary or doesn't add value; it "carries the visual
  energy." A **BMO-blue gradient** (BMO blue at one corner → ~25% cyan at the diagonally
  opposite corner) overlaid with **translucent round circles**. Approved artwork exists in
  classic / light / dark. May be cropped/rotated/scaled **only if** the gradient stays
  diagonal corner-to-corner and circles stay round (not distorted). Great behind a
  spot-illustration hero or as a section band on dry content. **Action:** source/self-host
  the approved bokeh artwork (or generate a spec-compliant SVG) — don't hand-fake a
  distorted one.

**Kit-of-parts discipline (important):** BMO's graphic elements (circle/arc, bokeh, blue
bar / flood-of-blue, white bar, etc.) are "a kit of parts… the system may use all of these,
but **a single item should not**. Keep it simple, open, uncluttered." → An editorial page
picks a *few* devices; never stacks them. Reinforces the one-hero + lots-of-white discipline.
Digital-valid kit subset to build: bokeh background, blue overlay/scrim, blue bar /
flood-of-blue section band, white bar, circle/arc crop. **Out:** triangle & chevrons (print
only), red content circle (**never**), and surrounding-**circle** icons (print/presentation
only — the standalone line-icon is the web/app form).

### 3.3 Typography & color brand notes

**Typography — the settled rule: live text is ALWAYS Segoe / SP default; Dax is NEVER a
webfont.** Dax is BMO's print/brand font, but on our surfaces (HTML pages + apps in
SharePoint) **every live, selectable, interactive character renders in the Segoe/SP stack —
never Dax.** There is no Dax `@font-face`, no Dax WOFF, no Dax applied to DOM text — ever.
Dax appears **only as rasterized text baked into an image asset**: a headline burned into a
hero/banner overlay, or a large editorial accent supplied as SVG/PNG. When you want Dax
character on a page, it arrives *inside the picture*, not as web type. (Dax also lives in
print / PowerPoint / web-PDFs — all out of scope for our HTML artifacts.) The toolkit's Dax
weight guidance — Dax Light headlines + Dax Medium emphasis; Dax Bold subheads; Dax Regular
body; sentence case; left-aligned; no italics — governs **those baked-in image assets**, not
our CSS. Our CSS styles Segoe.

**Color — "we are the blue bank."** Encode as soft guidance for editorial pages:
- **BMO blue is the unifier** — "any BMO creative should have this blue somewhere." Every
  editorial page should carry it.
- **Lots of white** = the fresh, modern, premium tone; let color/imagery pop. Editorial
  leans *more* whitespace than app mode.
- **Red is logo-only / never in UI** (already `--bmo-red`), used by the brand only in
  select strategic "spark action" moments in *marketing* — we don't reach for it here, and
  the red content circle is banned.
- **Expanded accent palette** (purple/lavender/mint/chartreuse/orange — already tokenized as
  `--bmo-chart-*`) is **for data-viz/charts only**, when blues+greys need more segmentation.
  Never as page decoration. NEVER USE BMO red for negative values in charts. Use exisitng BMO negative.
- **Greys** structure/segment online layouts (already in the Fluent neutral ramp).

---

## 4. Architecture — mode, not fork

- **Scope by class, don't redefine anything.** Recommend a root scope class (e.g.
  `.editorial` on the page/section wrapper). Editorial component variants and the relaxed
  scale live *under that scope*, so an app embedded inside an editorial page keeps its own
  austere styling (they must coexist on one page). Propose the exact mechanism + name in
  Phase 1.
- **Additive tokens only.** Editorial may add tokens (e.g. an editorial display type step,
  section-rhythm spacing, hero min-heights, scrim, larger radii) but **derives them from /
  layers them over** the existing token scale — never edits `:root` values. Existing
  `--surface-tint-*` tokens already exist for exactly this warmth; use them.
- **Components are variants/compositions**, not new primitives — extend existing BEM
  blocks (`card`, `stat`, buttons, chips) with editorial modifiers/blocks; reuse the
  state contract for any interactivity.
- **Delivery unchanged:** same CSS link order, same inlined sprite, same deferred Alpine,
  SharePoint-safe. A learning catalog opened straight from disk must still render.

---

## 5. Deliverables

1. **`editorial.css`** (or agreed filename) — the additive layer: editorial tokens +
   `.editorial` scope + editorial component variants/blocks. Built entirely from existing
   tokens. Linked *after* `components.css` (propose exact wiring; keep `styles.css` bundle
   coherent).
2. **Editorial component set** — at least: hero (incl. scrim + optional arc/ring + spot-
   illustration variants), feature card, course-module card + grid, course-materials
   link-rows, facilitator card, category/subcategory chips, essential-resources tinted
   grid, scorecard tiles, media/video card w/ play overlay, key-messages carousel, CTA
   band, spot-illustration wrapper (sizing/placement helper).
3. **Spot-illustration integration** — decide + document delivery (inline vs `<img>` vs a
   generated sprite; sizing; how to reference from `bmo-illustration-library/`), honoring
   buildless/self-hosted.
4. **Example pages** (the proof): a flagship **Learning Catalog / course page** first,
   then a **Resource Hub**, both built from the BMO patterns and rendered in-token. Follow
   `docs/PAGE-TEMPLATE.md` scaffolding. Frame each inside representative SP chrome so mesh
   is visible.
5. **`docs/EDITORIAL-MODE.md`** — when to use editorial vs app; the 3-tier art rules;
   component catalog w/ copy-paste snippets; do/don't; the scoping mechanism.
6. **Housekeeping** — cross-link from `CLAUDE.md` file map; add a `CHANGELOG.md` entry;
   don't reintroduce any retired vocabulary.

---

## 6. Read-first files (before writing anything)

- `CLAUDE.md`, `.github/copilot-instructions.md` — rules (apply the §1 A/B split above).
- `docs/PAGE-TEMPLATE.md` — the scaffold every example starts from.
- `docs/TECHNICAL-REFERENCE.md` — component snippets, token/class reference, state
  contract, icon system.
- `colors_and_type.css` — the token vocabulary (esp. `--surface-tint-*`, brand blues,
  spacing/radii). **The names to reuse.**
- `components.css` — the BEM blocks to extend.
- `examples/Components.html`, `examples/advanced-ui-example.html`,
  `examples/Design System Reference.html` — real markup + brand spec.
- `context/BMO-INTERNAL-WEB-BRAND.md` — authoritative brand/intranet guidance (pillars:
  Human / Intuitive / One bank; color; type).
- `bmo-illustration-library/README.md`, `catalog.json`, `gallery.html` — the spot
  illustrations.

**Precedence:** the `bsp-design-system` repo is the authoritative source of truth. Where
your memory of originally building this system conflicts with the repo, the repo wins. Where
an attached screenshot conflicts with this brief or the repo, the brief + repo win — flag
the conflict, don't silently follow the image.

### 6.1 How to read the attached reference screenshots

A named slot + caption for each screenshot lives in
`context/editorial-mode-reference/README.md` (the packing list). Screenshots may also be
pasted into the session as loose images. They are **reference/context,
not pixel targets.** Four families, each read differently:

1. **Plain SharePoint intranet pages** (BMO Central, T&O Central, The Digital Lounge, the
   Digital Services CoP). Purpose: (a) the SP-modern **chrome you must mesh with** (blue
   suite bar, hub nav, site title + nav row, `© BMO Financial Group` footer); (b) BMO's
   real content vocabulary (hero banners, card grids, news rollups, quick-link tiles).
   **Execute this register *well* — do NOT clone the uneven originals.** They're the "sit
   next to this comfortably" target, not the quality bar.
2. **BMO "Design Patterns" PDFs** (Learning; Programs & Resources; Communications). BMO's
   **sanctioned page patterns** for our exact page types — the *shapes* to render natively
   in-token (see §2). They're lorem-ipsum wireframes; take structure, not content.
3. **Brand Toolkit / Brand Expression PDFs** (photography style, graphic elements, bokeh,
   blue overlays/bands, Dax, "we are the blue bank"). The **authoritative brand source**
   behind §3.1–3.3. Where a toolkit rule is print-specific (triangle overlay; surrounding-
   circle icons; Dax as *type*), the brief already states the digital-valid subset —
   **follow the brief, not a literal reading of the print guide.**
4. **Icon libraries** (official "BMO Design Icons"; "Intranet Icon Library"). These are the
   **corporate line-icon** tier for content labeling (§3 table) — distinct from the Fluent
   `ic-fluent-*` app icons. Not yet in the repo; see §8.

---

## 7. Phasing (don't build blind)

- **Phase 1 — Audit + spec proposal (approval gate).** Confirm the scoping mechanism +
  name, the additive editorial token set, the component list, and a one-page plan for the
  flagship example. Surface the open questions (§8) with recommendations. **Stop for
  sign-off.**
- **Phase 2 — Build `editorial.css` + the flagship Learning Catalog example.** Prove the
  mesh and the 3-tier art system on one real page.
- **Phase 3 — Second example (Resource Hub) + `docs/EDITORIAL-MODE.md`.**
- **Phase 4 — Polish, accessibility pass, changelog, cross-links.**

## 8. Open questions to resolve (recommend, don't guess silently)

- **Scoping class name** — `.editorial` vs `x-editorial` vs a data attribute. (Rec:
  `.editorial` root class.)
- **Typeface — RESOLVED (see §3.3).** Live text is always Segoe / SP default; Dax is never
  a webfont — it only ever appears baked into image assets. No `@font-face`, no licensing
  gate, no decision needed. Still open: the editorial display **type scale** — how much
  larger the Segoe headline step should be for editorial pages vs app mode.
- **Spot-illustration delivery** — individual files vs generated sprite vs inline; and
  a11y (decorative `aria-hidden` vs meaningful `alt`/`<title>`).
- **Corporate line-icon library** — not yet in repo. Propose how to add a curated subset
  (same sprite pattern as `bmo-icons.svg`? separate file?) for content labeling.
- **Light/dark** — SharePoint intranet is effectively light-only; confirm we don't invest
  in dark for editorial.
- **Arc/ring hero motif** — build as a reusable editorial hero variant, or treat as
  per-page art? (Rec: a variant.)

## 9. Acceptance criteria

- Meshes with SP-modern chrome (shown in-context), reads as "a nice BMO intranet page,"
  not an embedded app and not a broken SP clone.
- Pile-A constraints intact: buildless, self-hosted, token-only (no raw hex/px an existing
  token covers), no `:root` redefine, inline Alpine only, icon contract honored, every
  `<use href="#…">` resolves.
- 3-tier art system respected (spot illustrations judicious, ~1/page, never in app chrome).
- No retired vocabulary reintroduced.
- Accessible: contrast holds, focus states native, illustrations correctly
  decorative-vs-meaningful.
- Example pages render correctly opened straight from disk.
