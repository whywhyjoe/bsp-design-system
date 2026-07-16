# BMO Brand Context

> **⚠️ Reconciliation note (shipped decision):** The system's single interactive accent is **BMO Blue `#0079C1`**, consumed via `var(--accent-rest)`. Where older guidance below prescribes `#0075BE` ("Accessible Blue") or Fluent's `#0f6cbd` as the interactive/accent color, the shipped token wins — use `#0079C1`. `#0075BE` remains a valid BMO color but is no longer the UI accent.

## Purpose

This document provides BMO brand context for apps embedded in SharePoint that are
built using the Fluent 2 design system. Apps should feel Fluent 2 in construction
and SharePoint-aware in their environment, while also reading as unmistakably BMO
in brand character. Read this alongside FLUENT2-DESIGN-SYSTEM.md and
SHAREPOINT-CONTEXT.md.

---

## BMO Brand Identity

BMO (Bank of Montreal) is one of Canada's largest banks and the country's oldest,
founded in 1817. Its brand communicates institutional reliability, trustworthiness,
and a modern commitment to customer progress. The visual identity is built around
the iconic M-Bar roundel — a white stylized M on a bold red circle — and a
signature blue known internally as "First Bank Blue."

Brand tone: professional, confident, clear, human. Not cold or bureaucratic —
BMO's positioning emphasizes approachability and real-world financial progress.
In digital products, this translates to clean layouts, clear hierarchy, and a
controlled but warm use of color.

---

## Brand Colors

### Primary palette

| Color | Name | Hex | Pantone | Usage |
|-------|------|-----|---------|-------|
| BMO Blue | First Bank Blue | `#0079C1` | PMS 660 C | Primary brand color; buttons, links, key UI |
| BMO Red | M-Bar Red | `#ED1C24` | PMS 485 C | Logo/roundel only; accent in marketing contexts |
| White | — | `#FFFFFF` | — | Primary background |

### The blue alignment opportunity

BMO Blue (`#0079C1`), SharePoint's suite bar (`#0078d4`), and Fluent 2's brand
primary (`#0f6cbd`) are all close relatives — mid-range blues in the same family.
This is a meaningful advantage. It means a Fluent 2 interface built with its
standard brand blue will naturally feel harmonious with both the SharePoint chrome
and the BMO brand without requiring heavy color overrides.

In practice: use **BMO Blue `#0079C1`** (consumed via `var(--accent-rest)`) as the
interactive accent throughout the app. Fluent 2's `#0f6cbd` (themePrimary) is the
Fluent default and a close relative, but it is not the BMO accent. `#0079C1` is the
blue the BMO intranet uses corporate-wide and meets WCAG AA on white (~4.66:1).

### The red tension — handle carefully

BMO Red (`#ED1C24`) is a vivid, saturated red used exclusively for the logo roundel
and high-impact marketing contexts. Fluent 2 uses its own red (`#d13438`) for
semantic error and danger states. These are two different reds with different
purposes and they will visually conflict if both appear in the same interface.

**Rule:** Do not use BMO Red (`#ED1C24`) as a UI color inside apps. It belongs
only to the logo/roundel. All red in the app UI should use Fluent 2's semantic
red tokens (`#d13438`, `#bc2f32`) for their intended purpose: errors, destructive
actions, and status indicators. This prevents BMO's brand red from being diluted
or misread as an error state.

---

## Typography

### Logo / wordmark typeface
BMO's official wordmark uses **Emona SemiBold**, a proprietary serif typeface.
It is used for the "Bank of Montreal" wordmark only and is not a UI font.
Do not attempt to replicate it in app interfaces.

### Digital / UI typeface
BMO's digital properties use standard system sans-serif fonts consistent with
their platform. For internal SharePoint apps, **Segoe UI** (the Fluent 2 and
SharePoint default) is the correct and expected choice. It aligns with both
the Microsoft ecosystem and BMO's clean, legible digital tone.

There is no conflict here: Segoe UI at Fluent 2 type ramp sizes is the right
call for all app UI text.

### Type tone
BMO communicates in sentence case, plain language, and active voice. App UI
copy should match: clear labels, direct CTAs, no unnecessary jargon. This
aligns with Fluent 2's own content guidance.

---

## Brand Character in UI

### What BMO digital looks and feels like
- Clean, white-dominant surfaces with blue as the primary accent
- Strong typographic hierarchy — clear section headers, readable body text
- Conservative use of the red accent (logo contexts only in digital)
- Professional but not cold; warm enough to feel human
- Data-forward: financial products require dense information displays that
  are well-organized, not decorative

### How to carry this into embedded apps
- **Blue is the accent**: Use BMO Blue (`#0079C1`, via `var(--accent-rest)`) for all
  interactive elements — buttons, links, focus states, selected indicators. Fluent 2's
  themePrimary (`#0f6cbd`) is the Fluent default but is not the BMO accent.
- **White-dominant surfaces**: Default to white canvas with Fluent 2 neutral
  backgrounds for secondary areas. Avoid heavy use of blue fills on surfaces.
- **Clear hierarchy**: Use the Fluent 2 type ramp assertively — don't flatten
  heading levels. BMO's digital products have visible, deliberate hierarchy.
- **No decorative red**: Red is reserved for logos and semantic error states only.
  Never use it for visual interest, dividers, or category labels.
- **Dense but organized**: Financial app content tends to be data-heavy. Lean
  on Fluent 2's spacing ramp to organize density rather than to add breathing
  room for its own sake. Tables, cards, and lists should be information-rich.

---

## The Three-Way Harmony

These apps must simultaneously satisfy three visual contexts:

| Context | Primary concern |
|---------|----------------|
| BMO brand | Blue-dominant, professional, human, no decorative red |
| SharePoint shell | Neutral surfaces, Fluent 1 chrome, suite bar blue |
| Fluent 2 system | Modern tokens, component patterns, type ramp |

The good news: all three share the same blue family and the same base typeface
(Segoe UI). There is no fundamental conflict between them — only edge cases
to manage.

### Edge cases to watch

**Blue saturation**: BMO Blue, SharePoint blue, and Fluent 2 blue appear together
on some pages. Keep app blue usage contained to interactive elements — don't
paint surfaces or headers in blue, as this compounds with the suite bar and
creates visual overload.

**Red**: BMO logo red must not bleed into app UI. Fluent 2 semantic red must not
be mistaken for brand usage. Keep them entirely separate by role.

**Formality level**: BMO is more formal than a typical Microsoft productivity
app. When choosing between Fluent 2's more casual component variants and its
more structured ones, default to the more structured option. For example: prefer
a standard table over a card grid for data-heavy views; prefer a structured form
layout over a conversational/wizard pattern.

---

## What to Avoid

| Avoid | Why |
|-------|-----|
| BMO Red (`#ED1C24`) as a UI color | Belongs to logo only; conflicts with semantic red |
| Blue-filled surfaces or panels | Amplifies the suite bar; creates visual overload |
| Emona SemiBold or logo-style serifs | Not a UI font; breaks Fluent 2 / SharePoint continuity |
| Playful or consumer-facing tone | Wrong register for a financial institution |
| Flattened type hierarchy | BMO digital expects clear, assertive heading structure |
| Decorative use of the roundel or M-Bar | Logo usage is governed by BMO brand standards |

---

## Summary

> BMO and Fluent 2 are naturally compatible: they share the same blue family,
> the same clean typographic sensibility, and the same professional-but-human tone.
> Use Fluent 2 tokens as the system of record, but the interactive accent is
> **BMO Blue `#0079C1`** (via `var(--accent-rest)`) — Fluent 2's themePrimary
> (`#0f6cbd`) is a close relative but not the BMO accent.
> Never use BMO Red as a UI color — only Fluent 2 semantic red belongs in the app.
> Default to the more structured, information-dense end of Fluent 2's component
> range. These are financial tools: clarity and hierarchy take priority over
> visual lightness.
