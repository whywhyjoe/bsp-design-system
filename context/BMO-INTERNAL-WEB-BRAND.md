# BMO Internal Brand & Intranet Design Guide

> **⚠️ Reconciliation note (shipped decision):** The system's single interactive accent is **BMO Blue `#0079C1`**, consumed via `var(--accent-rest)`. Where older guidance below prescribes `#0075BE` ("Accessible Blue") or Fluent's `#0f6cbd` as the interactive/accent color, the shipped token wins — use `#0079C1`. `#0075BE` remains a valid BMO color but is no longer the UI accent.

> Compiled from: BMO Brand Toolkit (Our Visual Style) and
> BMO Intranet Design System / Creating Content guide .
> Source: internal brand documentation. Treat as authoritative over BMO-BRAND-CONTEXT.md
> where values conflict.

---

## 1. Brand Pillars

Three core expressions define everything BMO creates:

**Human** — Every decision, interaction, and transaction is about a human connection
and has a human impact. We care more than other banks.

**Intuitive** — We know what people need before they can articulate it. We can
envision what's possible for our customers.

**One bank** — The customer is at the centre of everything. We work together to help
them grow and succeed, creating meaningful social change.

These pillars should inform tone, layout priority, and component decisions. Apps
should feel like they were built by people who understand the user's work, not
assembled from a template.

---

## 2. Design Principles (Intranet)

The BMO intranet design system is built on five principles:

| Principle | Description |
|-----------|-------------|
| User-centered | Sites, navigation, and content focus first on the business needs and goals of the user |
| Effective | Design prioritizes effective delivery of content and services over aesthetics |
| Mobile/BYOD | Consistently using a responsive framework |
| Inclusive | Content must support core BMO values and be welcoming to all BMO community members |
| Accessible | Steps should be taken to ensure content is accessible to all users |

**The foundation is Microsoft Fluent Design**, explicitly stated in the intranet
design system: "Fluent is Microsoft's design system and is used extensively in
SharePoint Online. It is an open-source, cross-platform system that gives designers
and developers the frameworks they need to create engaging product experiences —
accessibility, internationalization, and performance included."

Fabric Core (CSS-based Fluent) is specifically noted as the CSS layer used for
SharePoint colors, animations, fonts, icons, and grid.

---

## 3. Color System

### 3.1 Core Brand Colors

| Name | HEX | RGB | Notes |
|------|-----|-----|-------|
| BMO Blue | `#0079C1` | 0-121-193 | Signature color; the single interactive accent (`var(--accent-rest)`) — buttons, links, focus, selected. WCAG AA on white (~4.66:1) |
| **Accessible Blue** | **`#0075BE`** | **0-117-190** | **Alternate BMO blue; WCAG 2.0 compliant. Not the UI accent** |
| BMO Red | `#ED1C24` | 237-28-36 | Reserved — see red rules below |
| Black | `#000000` | 0-0-0 | |
| White | `#FFFFFF` | 255-255-255 | Primary background |

> **Critical rule** (reconciled): **BMO Blue (`#0079C1`) is the interactive blue** for
> the intranet — the single accent for buttons, links, focus, and selected states,
> consumed via `var(--accent-rest)`. It is the blue the BMO intranet uses corporate-wide
> and meets WCAG AA on white (~4.66:1). Accessible Blue (`#0075BE`) is the older
> accessible variant — retained as a valid BMO color but no longer the UI accent.

### 3.2 Digital-Only Colors

These are the standard colors developed by the BMO Design team specifically for
digital/intranet use.

**Text / UI structure**

| Name | HEX | RGB | Use |
|------|-----|-----|-----|
| Slate | `#001928` | 0-25-40 | Primary text color; headings; dark UI elements |
| Granite | `#646C76` | 100-108-118 | Secondary text; subheadings; supporting content |
| Ultramarine | `#005587` | 0-85-135 | Button hover states; dark interactive accents |
| Cerulean | `#73C3EB` | 115-195-235 | Focus border states |

**Backgrounds / surfaces**

| Name | HEX | RGB | Use |
|------|-----|-----|-----|
| White | `#FFFFFF` | 255-255-255 | Primary page/app surface |
| Albicant | `#F5F6F7` | 245-246-247 | Secondary background; subtle surface differentiation |
| Light Grey | `#D9DCE1` | 217-220-225 | Rules, dividers, borders |
| Pale Skyblue | `#C1E7FF` | 193-231-255 | Light background tints; illustration use |

**Feedback / status colors**

| Name | HEX | RGB | Use |
|------|-----|-----|-----|
| Positive | `#0F9B2C` | 15-155-44 | Positive financial results; success states |
| Negative | `#D12121` | 209-33-33 | Negative financial results; error states |

> **Note on Negative vs. BMO Red**: `#D12121` (Negative) is the correct color for
> error states and negative data in digital UI — NOT `#ED1C24` (BMO Red). These
> are different colors for different purposes. BMO Red is logo-only.

### 3.3 Red — Reserved Uses Only

BMO Red (`#ED1C24`) is strictly reserved for:

1. The roundel in the logo
2. The red circle used in marketing to contain brand-aligned messaging
3. The red sign-in button on secure sites
4. Negative financial performance indicators (use `#D12121` Negative instead)
5. Alert icons and warnings for digital (use `#D12121` Negative instead)

> "Adding red to a layout does not make it more on brand. In fact, overuse of red
> will detract from our brand look."

For hyperlink focus states, BMO Red text overrides blue — this is the one approved
UI use of the red color family in interactive elements.

### 3.4 Primary Accent Palette (Charts & Diagrams)

Used specifically for data visualization when multiple segments are needed. Use at
100% opacity — avoid tints or transparency.

| Name | HEX | RGB | CMYK | Node HEX |
|------|-----|-----|------|----------|
| Midnight | `#003758` | 0-55-88 | 100-44-0-66 | `#001E30` |
| Navy | `#005789` | 0-87-137 | 100-44-0-30 | `#00304B` |
| BMO Blue (accessible) | `#0075BE` | 0-117-190 | 100-44-0-0 | `#004068` |
| Sky | `#00A9FB` | 0-169-251 | 80-15-0-2 | `#006EA3` |
| Ice | `#B1E5FE` | 177-229-254 | 45-0-0-0 | `#7395A5` |

### 3.5 Secondary Accent Palette (Charts & Diagrams)

For additional segmentation when the primary palette isn't enough.

| Name | HEX | RGB | CMYK | Node HEX |
|------|-----|-----|------|----------|
| Purple | `#974BB7` | 151-75-183 | 55-77-0-6 | `#623177` |
| Lavender | `#8988E1` | 137-136-225 | 62-51-0-0 | `#595992` |
| Mint | `#39D4B9` | 57-212-185 | 72-0-36-2 | `#258A78` |
| Chartreuse | `#CEE226` | 206-226-38 | 19-0-100-4 | `#869319` |
| Orange | `#FAA451` | 250-164-81 | 0-48-87-4 | `#A36B35` |

> Do NOT use the secondary palette for illustrations. Do NOT use BMO Red for
> negative data in charts — use the Negative/Positive feedback colors instead.

### 3.6 Color Hierarchy Summary

```
White (#FFFFFF)         → Primary surfaces, page backgrounds
Albicant (#F5F6F7)      → Secondary surfaces, subtle differentiation
Light Grey (#D9DCE1)    → Dividers, rules, borders
Granite (#646C76)       → Secondary text, labels, supporting copy
Slate (#001928)         → Primary text, headings
BMO Blue (#0079C1)      → Interactive elements, links, buttons (var(--accent-rest))
Ultramarine (#005587)   → Hover states
Cerulean (#73C3EB)      → Focus states/borders
Positive (#0F9B2C)      → Success, positive data
Negative (#D12121)      → Errors, negative data, warnings
BMO Red (#ED1C24)       → Logo/roundel ONLY
```

---

## 4. Typography

### 4.1 Typeface Hierarchy

| Typeface | Role | Notes |
|----------|------|-------|
| **Dax** | Primary BMO brand typeface | Clean, open, approachable. Used for branded print and marketing elements (banners, promotional tiles, artwork). Not a web font. |
| **Segoe UI** | SharePoint interface text | SharePoint controls its own interface fonts. All elements integrated into SharePoint should use Segoe UI. |

**Font fallback stack**: `Segoe UI > Arial > sans-serif`

> For SharePoint-embedded apps: Segoe UI is correct and expected. Heebo is the
> preferred choice if you have control over the font stack in custom-built
> app surfaces. Either is acceptable; Heebo is more precisely on-brand for
> digital content.

### 4.2 BMO Intranet Type Ramp

The official type system for the BMO intranet (from the intranet design guide):

| Element | Tag | Size | Weight | Line Height | Color |
|---------|-----|------|--------|-------------|-------|
| Default Text | — | 16px / 1em | Regular | 22.4px / 1.4em | Slate |
| Heading 1 | H1 | 26px / 1.625em | Regular | 36.4px / 1.4em | Slate |
| Heading 2 | H2 | 24px / 1.5em | Regular | 33.6px / 1.4em | Slate or Granite |
| Heading 3 | H3 | 18px / 1.125em | Regular | 25.2px / 1.4em | Slate or Granite |
| Heading 4 | H4 | 16px / 1em | **Bold** | 22.4px / 1.4em | Slate |
| Heading 5 | H5 | 14px / 0.875em | **Bold** | 19.6px / 1.4em | Slate |
| Heading 6 | H6 | 12px / 0.75em | **Bold** | 16.8px / 1.4em | Slate |
| Paragraph | P | — | — | — | — |
| Blockquote | BLOCKQUOTE | — | — | — | Slate or Granite |
| Small Text | SMALL | 12px / 0.75em | — | 16.8px / 1.4em | — |

**Padding rules:**
- Default Text top padding: 24px / 1.5em
- Paragraph top padding: 24px / 1.5em
- Blockquote left/right padding: 24px / 1.5em

> **Important**: BMO brand guidelines discourage the use of bold on headlines.
> H1, H2, H3 are Regular weight. Only H4, H5, H6 are bold.

### 4.3 Typography Rules

- Avoid typographic widows and orphans
- Do not use too many different font weights — less is more
- Do not underline or italicize text for emphasis — use a bolder font weight instead
- Clean layouts play content in the clearest way possible

---

## 5. Buttons & Interactive Elements

### 5.1 Button Types

**Primary** — Focus on primary actions the user is seeking to do.

| State | Style |
|-------|-------|
| Default | BMO Blue (`#0079C1`, `var(--accent-rest)`) background, White text |
| Hover | Ultramarine (`#005587`) background |
| Focus | Cerulean (`#73C3EB`) border (overrides hover) |
| Disabled | Light Gray (`#D9DCE1`) background, Slate (`#001928`) text |

**Secondary** — Supporting features; reset or clear functions.

| State | Style |
|-------|-------|
| Default | White background, BMO Blue border and text |
| Hover | Ultramarine (`#005587`) text and border |
| Focus | Cerulean (`#73C3EB`) border (overrides hover) |
| Disabled | Light Gray (`#D9DCE1`) background, Slate text |

**Tertiary** — Text-only; lowest visual prominence.

### 5.2 Hyperlinks

**Flat links** (inline text):
- Default: BMO Blue (`#0079C1`, `var(--accent-rest)`) text, no underline
- Hover: BMO Blue (`#0079C1`) text with underline
- Focus: BMO Red text (this is the one approved interactive use of the red family)

**Links with icons:**
- Icon size: 24×24px
- Icon right padding: 4px
- Line height for link text: 24px

**Best practices:**
- Hyperlink meaningful words that describe what the user will see when they click
- Start with a keyword; keep to 100 characters or less
- Do not use "click here" or "read more"
- Avoid linking single words

---

## 6. Data Display

### 6.1 Tables

- Use for presenting tabular information in grids or matrices
- Always include row and/or column headers for accessibility
- Use proportional (percentage) widths rather than fixed pixel widths
- Flatten tables where possible — avoid spanned cells and multiple header levels
- Avoid fixed cell heights; let cells expand downward
- Add a brief caption before or after the table to indicate its content

### 6.2 Accordions

- Use for FAQs, lists of questions/topics, or to truncate detail about a sub-item
- Exposed information must be a synopsis of the hidden content
- Not for navigation; for structured progressive disclosure

### 6.3 Charts & Diagrams

- Blues and greys are sufficient for most charts
- Use the primary accent palette when additional segmentation is needed
- Do NOT use BMO Red for negative financial data — use Negative (`#D12121`) and
  Positive (`#0F9B2C`) biased colors
- "Saying it simply with numbers" — express data as simply as possible
- Donut charts, bar charts, and line charts all use the blue palette family

---

## 7. Illustration & Infographic Rules

### 7.1 When to use illustrations

- Announcements
- Celebrating success
- Progress indicators
- Empty states (e.g., nothing found)
- How-to guides
- Loading screens
- Headline statement section overviews

### 7.2 When NOT to use illustrations

- To draw attention to features being bypassed or misused
- When there is too much text and it won't be read
- When you need to speak directly to the user (use copy instead)
- As ornamental decoration with no communicative purpose

### 7.3 Illustration style rules

**Color:**
- Lines must be BMO Blue, Slate, or Light Gray only
- All illustrations staged on White or Albicant backgrounds
- Use the five digital illustration colors: Slate (`#001928`), Ultramarine (`#005587`),
  BMO Blue (`#0079C1`), Cerulean (`#73C3EB`), Pale Skyblue (`#C1E7FF`)

**Structure:**
- All strokes have rounded edges and ends
- All end caps and edges are rounded
- Spacing is symmetrically consistent (object padding, vertical/horizontal relations)
- Frontal 2D perspective only — no depth of field

**Subject matter:**
- Use visual metaphors to present content
- Use personification to add human characteristics
- Avoid styles that are cute, cartoon-y, or childish
- No human forms, faces, or figures (body parts and silhouettes are acceptable)

**Technical specs:**
- Create at maximum expected display size
- SVG preferred; PNG acceptable
- Transparent background (or matched to page background)
- 300kb or smaller

---

## 8. Information Design

BMO's approach to layout and information presentation:

- Clean layouts that play content in the clearest way possible
- "Contemporary, approachable brand style should shine through in the way we present information"
- White space is not wasted space — it helps layouts breathe and gives content hierarchy
- Use narrower columns for long text; long lines fatigue the eye and discourage reading
- Bullets and tables call out important points and help readers digest key information
- Information hierarchy: headings → subheadings → body text → supporting labels

**Avoid:**
- Placing text over busy backgrounds
- Cluttering with too much detail on one page
- Too many different font weights (less is more)
- Underlining or italicizing for emphasis (use bold weight instead)
- Typographic widows and orphans

---

## 9. Brand Tone & Voice (Visual)

- "Money is personal. At BMO, we bring a human touch to everything we do."
- Layout and information design should reflect a contemporary, approachable style
- White creates a fresh, modern tone and helps colours and images stand out
- Shades of grey create structure and segmentation online
- The brand is anchored in BMO blue — every creative should have this colour somewhere
- BMO red is a strategic accent, not a layout tool

---

## 10. Key Relationships: BMO Digital vs. Fluent 2

The intranet design system explicitly states that **Microsoft Fluent Design is the
foundation**. This means the systems are designed to work together, not compete.

| BMO Digital | Fluent 2 Equivalent | Notes |
|-------------|---------------------|-------|
| BMO Blue `#0079C1` (accent, `var(--accent-rest)`) | themePrimary `#0f6cbd` | Close relatives; `#0f6cbd` is the Fluent default but not the BMO accent — use `#0079C1` for the interactive accent. `#0075BE` is an alternate BMO blue, not the UI accent |
| Slate `#001928` | neutralDark `#141414` | Slate is warmer/bluer; use for text in BMO-branded contexts |
| Granite `#646C76` | neutralSecondary `#5c5c5c` | Similar intent; Granite has a blue-grey cast |
| Albicant `#F5F6F7` | neutralLighterAlt `#fafafa` | Albicant is very slightly warmer |
| Light Grey `#D9DCE1` | neutralQuaternaryAlt `#e0e0e0` | Similar; use BMO value for rule/divider elements |
| Negative `#D12121` | colorPaletteRedBackground3 `#d13438` | Nearly identical — strong alignment |
| Positive `#0F9B2C` | colorPaletteGreenBackground3 `#107c10` | Nearly identical — strong alignment |
| Heebo / Segoe UI | Segoe UI | Same family; Segoe UI is always correct in SharePoint contexts |

---

## 11. Critical Rules — From the Source

These come directly from BMO's official documentation:

- **BMO Blue (`#0079C1`) is the interactive blue** for all digital/intranet
  interactive elements, consumed via `var(--accent-rest)`. Accessible Blue (`#0075BE`)
  is the older accessible variant — retained as a valid BMO color but no longer the UI accent.

- **"Adding red to a layout does not make it more on brand."** Red is for the
  logo roundel. Error/warning states use `#D12121` (Negative), not `#ED1C24`.

- **Bold is not for headlines** — H1, H2, H3 are Regular weight. Bold is only
  for H4, H5, H6.

- **Gradients are not normally used** in BMO designs.

- **Accent palette colors are used at 100% opacity** — no tints, no transparency.

- **Illustrations use only**: Slate, Ultramarine, BMO Blue, Cerulean, Pale Skyblue.
  Always on White or Albicant backgrounds.

- **Fluent Design is the stated foundation** of the intranet design system.
  Fabric Core is the CSS implementation layer.
