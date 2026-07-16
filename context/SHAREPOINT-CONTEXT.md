# SharePoint Embedding Context

> **⚠️ Reconciliation note (shipped decision):** The system's single interactive accent is **BMO Blue `#0079C1`**, consumed via `var(--accent-rest)`. Where older guidance below prescribes `#0075BE` ("Accessible Blue") or Fluent's `#0f6cbd` as the interactive/accent color, the shipped token wins — use `#0079C1`. `#0075BE` remains a valid BMO color but is no longer the UI accent.

## Purpose

This document provides context for designing apps that are embedded inside Microsoft
SharePoint Online pages. It describes the host environment, its visual characteristics,
and the design intent for apps that live within it. Use this alongside the Fluent 2
Design System reference to make informed decisions that balance modern Fluent 2 design
with the realities of the SharePoint shell.

---

## The Host Environment

These apps are embedded directly inside SharePoint Online modern pages using Script
Editor web parts. They are not standalone applications — they share a page with
SharePoint's own chrome and must feel visually coherent with that environment even
though they are not SharePoint components.

### What surrounds the app

| Region | Description |
|--------|-------------|
| Suite bar | Horizontal top bar; Microsoft 365 wayfinding and account controls |
| Left navigation | Vertical site nav; appears on most team sites and communication sites |
| Page header | SharePoint page title area; may include a hero image or colored band |
| Page canvas | White or near-white content area where the app is embedded |
| Command bar | Optional SharePoint toolbar above page content |

The app renders inside the page canvas. It inherits the page's font stack and sits
within the visual context of SharePoint's chrome without any iframe boundary.

---

## SharePoint Online Visual Baseline

SharePoint Online does not yet fully implement Fluent 2. Its current shell reflects
a mix of Fluent 1 / Office design language. These are the values your app will
sit next to.

### SharePoint shell colors

| Element | Color | Notes |
|---------|-------|-------|
| Suite bar background | `#0078d4` | Fluent 1 / Office blue — not the same as Fluent 2 `#0f6cbd` |
| Page canvas background | `#ffffff` | Standard white |
| Alternative page bg | `#f3f2f1` | Classic SharePoint off-white; common on team sites |
| Left nav background | `#f3f2f1` | Matches alt page bg |
| Left nav text | `#323130` | Slightly warm dark neutral |
| Left nav hover | `#edebe9` | Warm light gray |
| Command bar background | `#ffffff` | White, flush with canvas |
| Command bar border | `#edebe9` | Subtle bottom border |
| Focus/selected accent | `#0078d4` | Fluent 1 blue used throughout SharePoint UI |

### SharePoint typography baseline

| Property | Value |
|----------|-------|
| Font family | Segoe UI, -apple-system, BlinkMacSystemFont, sans-serif |
| Body size | 14px |
| Body weight | 400 (Regular) |
| Body color | `#323130` |
| Line height | 20px |
| Page title size | 28px, Semibold |

Segoe UI is the same typeface used in Fluent 2, so font stack continuity is natural.
However, SharePoint tends to use slightly warmer neutrals (`#323130`, `#605e5c`,
`#a19f9d`) compared to Fluent 2's cooler grays (`#242424`, `#616161`, `#bdbdbd`).

---

## Design Intent

### Goal
Apps should feel **Fluent 2 in spirit** — modern, clean, focused — while reading as
**visually continuous** with the SharePoint page they live inside. The app should feel
like a natural, elevated part of the page, not a foreign object dropped onto it.

### The happy medium
- Use Fluent 2 components, tokens, spacing, and typography as the primary design language
- Choose surface and background colors that don't fight the SharePoint canvas
- Avoid visual treatments that make the app feel like a separate product
- Prefer **subtle elevation** over heavy shadows — the app is on a page, not floating above it
- When SharePoint's accent blue (`#0078d4`) is visible nearby, avoid heavy use of
  the brand blue in fills — reserve the BMO accent (`#0079C1`, via `var(--accent-rest)`)
  for text links and focus states instead

### Dense tool surfaces vs. landing surfaces
Not every surface is the same. Calibrate the visual register to the surface:
- **Dense tool surfaces** (data grids, forms, queues, settings) stay conservative —
  tight density, white surfaces, minimal motion. The guidance below assumes this case
  unless noted.
- **Landing, home, and hub surfaces** (the page a user opens first, dashboards,
  overview pages) may carry more visual interest to aid wayfinding and engagement:
  the design system's **visual-interest layer** — soft surface tints for section
  bands, functional motion, labeled imagery, and richer card composition — is
  appropriate here. It remains restrained and on-brand; see the system's
  `advanced-ui-example.html` worked example. This is additive, never an excuse for
  consumer-facing playfulness.

### Tone
These are productivity tools used inside enterprise SharePoint environments. Design
should feel professional, calm, and efficient. Not sterile — Fluent 2's warmth and
personality are appropriate — but not playful or consumer-facing either.

---

## Practical Design Guidance

### Surfaces and backgrounds
- Use `#ffffff` as the default app surface — matches the SharePoint page canvas
- Use `#fafafa` or `#f5f5f5` (Fluent 2 `neutralLighterAlt` / `neutralLighter`) for
  secondary surfaces like sidebars, headers within the app, or input backgrounds
- Avoid `#f3f2f1` (SharePoint's warm off-white) inside app components — it will blur
  the boundary between app and shell in ways that look accidental rather than intentional
- **Soft surface tints are allowed for section bands on landing/hub surfaces** — the
  design system's `--surface-tint-neutral` / `-blue` / `-sky` (very low saturation,
  solid, no gradients). Alternate a tinted band with white to separate sections; keep
  interactive surfaces (cards, buttons, inputs) on white so the accent stays the only
  thing that reads as actionable.

### Borders and dividers
- Use `#e0e0e0` (Fluent 2 `neutralQuaternaryAlt`) for internal dividers — this reads
  as clean and modern without being too SharePoint-warm
- Avoid `#edebe9` (SharePoint's divider color) inside the app — reserve that warmth
  for the shell

### Elevation
- Use light shadows for cards and panels — Fluent 2 `elevation4` or `elevation8` are
  appropriate; `elevation64` is too heavy for an embedded page context
- Prefer border + subtle background fill over heavy shadow for components like
  information panels, stat blocks, or filter areas

### Accent / brand color
- Use BMO Blue `#0079C1` (via `var(--accent-rest)`) for interactive elements: links,
  focus rings, selected states, primary buttons. Fluent 2's `#0f6cbd` (themePrimary)
  is the Fluent default and a close relative, but it is not the BMO accent.
- Be conservative with filled brand-color backgrounds in components — the suite bar
  above already carries a strong blue; repeating it heavily inside the app creates
  visual noise
- For secondary or ghost buttons, lean on neutral strokes rather than brand fills

### Typography
- Use the Fluent 2 web type ramp as the guide (Segoe UI, size/weight tokens)
- Body text at 14px/400 matches SharePoint's baseline — maintain this for paragraph
  and label text inside the app for continuity
- App-internal headings can use Fluent 2's Subtitle and Title tokens to create clear
  hierarchy within the app without conflicting with the SharePoint page title above

### Spacing
- Use the Fluent 2 4px spacing ramp
- On **dense tool surfaces**, component density should feel similar to SharePoint's
  own components — not more airy (which looks mismatched) and not more compressed
  (which looks older)
- On **landing and hub surfaces**, more generous spacing is appropriate — hero bands,
  section rhythm, and breathing room around feature cards aid wayfinding and are part
  of the visual-interest layer
- A comfortable internal padding for app containers sitting on the page canvas: 16–24px
  (Fluent 2 `size160` to `size240`)

### Motion
- Motion is **functional, not decorative** — it cues, it doesn't entertain. Achievable
  entirely with CSS transitions plus, for reveal-on-scroll, a lightweight
  `IntersectionObserver` toggle. Complex JS animation libraries remain out of scope.
- Sanctioned patterns (from the design system's motion tokens): **reveal-on-scroll**
  (content fades + rises once, then settles) and **hover lift** on interactive cards.
  Both are reduced-motion safe — the hidden start-state only exists under
  `prefers-reduced-motion: no-preference`, so print and reduced-motion show full content.
- No bounce, spring, parallax, looping, or auto-playing decorative motion.

### Focus and interaction states
- Use Fluent 2 focus ring patterns (thick stroke), colored with BMO Blue `#0079C1`
  (via `var(--accent-rest)`) rather than Fluent's default `#0f6cbd` — these are
  accessible and align with SharePoint's own keyboard navigation patterns

---

## Technical Stack

Apps are built with the following stack. Design output and specs should be oriented
toward this environment, not React component libraries.

| Layer | Technology |
|-------|-----------|
| Interactivity | Alpine.js |
| Component primitives | The design system's own CSS classes (`components.css`) — plain HTML + CSS, no component-framework dependency |
| SharePoint data | PnPjs v2 |
| Icon system | Fluent System Icons (SVG, inline or sprite) |
| Styling | CSS custom properties; no preprocessor required |
| Embedding | SharePoint Script Editor web parts |
| Design tokens | Fluent 2 CSS custom properties where supported |

### Implications for design output
- Components are plain HTML + CSS classes (see `components.css`), not JSX or web components
- Avoid designs that depend on React-specific patterns (compound components, context, hooks)
- Prefer CSS custom properties for theming so values can be overridden per-site if needed
- Icon usage should reference SVG files directly, not React icon components
- Animations should be achievable with CSS transitions; complex JS animation libraries
  are out of scope (a small `IntersectionObserver` to drive reveal-on-scroll is fine —
  see the Motion guidance above)

---

## What to Avoid

| Avoid | Why |
|-------|-----|
| Heavy card shadows (`elevation64`) | Too visually dominant on a flat page canvas |
| All-over brand blue fills | Competes with SharePoint suite bar; creates visual noise |
| Warm SharePoint neutrals (`#323130`, `#605e5c`) inside app | Blurs the app/shell boundary unintentionally |
| Consumer-facing playfulness | Wrong tone for enterprise productivity context |
| React-specific component patterns | Stack is Alpine.js + HTML + CSS |
| Arbitrary SVG icon scaling | Fluent icons are pixel-optimized at specific sizes only |
| All-caps text | Fluent 2 guideline: always use sentence case |
| Non-Segoe font stacks | Breaks continuity with SharePoint and Fluent 2 |

---

## Summary

> Design with Fluent 2 tokens, components, and principles. Be conservative with
> elevation and brand color fills. Match SharePoint's surface and body text baseline
> so the app feels like it belongs on the page. On landing and hub surfaces, the
> visual-interest layer — soft surface tints, functional motion, imagery, and richer
> card composition — is welcome and on-brand. Produce specs as HTML/CSS, not React.
> These are enterprise productivity tools — calm, clear, focused, and engaging where
> it helps the user.
