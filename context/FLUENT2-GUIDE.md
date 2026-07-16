# Fluent 2 Design System — Reference Guide

> Compiled from https://fluent2.microsoft.design — Design Language section  
> Source pages: Design Principles, Color, Elevation, Iconography, Layout, Material, Motion, Shapes, Typography  
> Last fetched: May 2026

---

## 1. Design Principles

Fluent 2 is guided by four core principles:

### 1.1 Natural on Every Platform
Layouts adapt to device and platform, building on the familiar. Native platform components are used ~80% of the time; energy is focused on signature experiences for the remaining 20%. Creates reliability and trust.

### 1.2 Built for Focus
Experiences inspire action without getting in the way. Minimal visual noise keeps people centered, calm, and confident. Technology communicates and performs; it does not interrupt.

### 1.3 One for All, All for One
Inclusive design that considers a range of perspectives and abilities from the earliest stages. Including diverse users makes for better solutions and broader creative thinking.

### 1.4 Unmistakably Microsoft
Signature experiences — color, sound, illustration, icons — connect products and create brand familiarity. A little personality goes a long way.

---

## 2. Color

### 2.1 Three Fluent Palettes

**Neutral** — blacks, whites, and grays that ground the interface. Used on surfaces, text, and layout. In components, neutrals signal state changes. Use lighter neutrals on primary-focus surfaces to create hierarchy.

**Shared** — aligned across M365 apps; used in reusable high-value components (avatars, calendars, badges). Use sparingly to accent and highlight. In dark mode, shared colors shift in saturation/brightness for eye strain reduction and accessibility.

**Brand** — product-specific colors (Teams purple, Excel green, Word blue, etc.). Apply to create visual prominence and anchor users in a specific product context. Do not overuse or apply to large surfaces — this dilutes hierarchy.

### 2.2 Semantic Colors
A subset of shared colors that communicate feedback, status, or urgency. Always convey important information; never use for decoration.

| Color | Meaning |
|-------|---------|
| Red | Danger / Error |
| Yellow | Caution / Warning |
| Green | Success / Positive feedback |

Pair semantic colors with text/iconographic indicators for accessibility (don't rely on color alone).

### 2.3 Interaction States
Components darken progressively through interaction:
- Rest → lightest state
- Hover → slightly darker
- Pressed/Active → darker still
- Selected → darkest

**Focus state**: color does not change; container receives a thicker stroke to distinguish keyboard vs. mouse.

> **Platform distinction**: Windows reverses this — controls get *lighter* as they are interacted with.

### 2.4 Accessibility
- Minimum 4.5:1 contrast ratio for standard text
- Minimum 3:1 for large text (18.5px bold or 24px regular)
- Do not use color as the sole communication method
- Allow user personalization of color schemes

### 2.5 Color Tokens
Use alias tokens rather than raw hex values. Global tokens are context-agnostic; alias tokens apply context.  
Reference: https://react.fluentui.dev/?path=/docs/theme-colors--page

---

## 3. Elevation

Elevation is the perceived distance between an object and the surface behind it, expressed through shadows and light. Used to create visual hierarchy and aid scannability.

### 3.1 Shadow System
Shadows are composed of two layers:
- **Key shadow** — sharp, directional; defines element edges
- **Ambient shadow** — soft, diffused; implies distance from surface

Shadow size is named by its blur value: `$shadow2` = 2px blur, `$shadow64` = 64px blur.

> **Platform distinction**: Windows uses strokes instead of key shadows to outline objects.

### 3.2 Low Elevation Ramp

| Token | Light Mode Use | Dark Mode Use |
|-------|---------------|---------------|
| `$shadow2` | Cards without edge, FABs when pressed | Ribbons, icons, hero buttons |
| `$shadow4` | Cards without edge | Cards, grid items, list items |
| `$shadow8` | FABs, raised cards, raised app bars | Command bars, dropdowns, tooltips |
| `$shadow16` | Cards without edge, FABs pressed | Callouts, hover cards |

**Low elevation formula:**
- Shadow 1: Blur = 1×n, X=0, Y=0.5×n, Opacity Light=14% / Dark=28%
- Shadow 2: Blur = 1×n, X=0, Y=0.5×n, Opacity Light=14% / Dark=14%

### 3.3 High Elevation Ramp

| Token | Use (Light & Dark) |
|-------|-------------------|
| `$shadow28` | Bottom sheets, side nav, raised tab bars |
| `$shadow64` | Pop-up dialogs, panels |

**High elevation formula:**
- Shadow 1: Blur = 1×n, X=0, Y=0.5×n, Opacity Light=24% / Dark=28%
- Shadow 2: Blur=8 (Light) or Blur=2 (Dark), X=0, Y=0, Opacity=20%

### 3.4 Shadows on Color Surfaces
Use luminosity equation to adjust shadow opacity on brand/color backgrounds:

```
Luminosity = 0.2126×R + 0.7152×G + 0.0722×B
Shadow 1 opacity = round(42 − 0.116 × luminosity)
Shadow 2 opacity = round(34 − 0.09 × luminosity)
```

Use brand shadow tokens — do not apply the main shadow ramp directly to colored surfaces.

---

## 4. Iconography

### 4.1 Three Icon Collections

**System icons** — used inside UI (command bars, nav, status). Open-source under MIT License.  
- Figma library: https://www.figma.com/community/file/836835755999342788  
- GitHub: https://github.com/microsoft/fluentui-system-icons

**Product launch icons** — represent Microsoft apps. Identify capabilities; never substitute for the Microsoft logo.

**File type icons** — indicate specific file formats. Best at 16, 48, and 96px. Available as SVG and WebP.

### 4.2 System Icon Themes

| Theme | Usage |
|-------|-------|
| Regular | Wayfinding; identify and select available actions |
| Filled | Selected states; small contexts needing more weight |

### 4.3 Icon Sizes
- 12px — informational only; not for interaction
- Larger sizes for smaller screens / touch targets
- Match icon size to the precision of the interaction tool

### 4.4 Product Icon Scaling
- Below 48px: simplify detail for readability; use specific sizes, not arbitrary scaling
- Above 48px: scale by factors of 4 (48 → 64 → 96 → 192px)

### 4.5 Icon Usage Rules
- **Naming**: use literal metaphors named for shape/object, not function. "Shield" not "Security."
- **Modifiers**: always filled theme; always bottom-right corner. Don't over-complicate.
- **Color**: use sparingly; one solid color only; maintain contrast. Never change product launch icon colors.
- **Localization**: validate icon choices culturally; some symbols differ across regions.

---

## 5. Layout

### 5.1 Spacing System
Base unit: **4px**. Reduces confusion while remaining flexible.

| Token | Value |
|-------|-------|
| sizeNone | 0px |
| size20 | 2px |
| size40 | 4px |
| size60 | 6px |
| size80 | 8px |
| size100 | 10px |
| size120 | 12px |
| size160 | 16px |
| size200 | 20px |
| size240 | 24px |
| size280 | 28px |
| size320 | 32px |
| size360 | 36px |
| size400 | 40px |
| size480 | 48px |
| size520 | 52px |
| size560 | 56px |

Values 2, 6, and 10 account for Fluent icon padding and alignment to the 4px grid. Space is measured from an element's bounding box. Platform units: iOS = pt, Android = dp, Web = px.

**Minimum touch targets**: iOS/Web = 44×44px; Android = 48×48px.

### 5.2 Grid

Three elements: **columns**, **gutters**, **margins**.

**Grid types:**
- **Baseline grid** — dense horizontal rows for text alignment; establishes vertical rhythm
- **Column grid** — 12 columns; most common for web; divides into halves, thirds, fourths, sixths
- **Manuscript grid** — single column; optimal line length for reading; text-heavy content
- **Modular grid** — columns + horizontal rows; matrix of cells; combined for complex layouts

### 5.3 Breakpoints

| Size Class | Breakpoint Range |
|------------|-----------------|
| small | < 479px |
| medium | < 639px |
| large | < 1023px |
| x-large | > 1024px |
| xx-large | > 1366px |
| xxx-large | > 1920px |

### 5.4 Responsive Techniques

| Technique | Description |
|-----------|-------------|
| Reposition | Move stacked elements to horizontal layout on wider screens |
| Resize | Adjust element size and margins; stretch heroes; add white space |
| Reflow | Rearrange elements (single column → two columns) above-the-fold |
| Show/Hide | Reveal additional metadata or UI on larger viewports |
| Re-architect | Fork or collapse entire sections (e.g., master-detail pattern) |

**Responsive** = one fluid layout using media queries.  
**Adaptive** = multiple fixed layouts triggered at breakpoints (progressive enhancement).

---

## 6. Material

Material describes surface texture. Fluent supports four types.

### 6.1 Solid
Most common material. Opaque; uses color and elevation to define UI regions and interactions. Supports light and dark mode.

### 6.2 Acrylic
Semi-transparent frosted glass effect. Use for **transient, light-dismiss** surfaces: popovers, menus, flyouts. Mode-aware (light/dark). Primarily a Windows-native material.

### 6.3 Mica
Opaque material subtly tinted with the user's desktop wallpaper color (active window) or neutral (inactive window). Signals window focus. Mode-aware. Windows only.

### 6.4 Smoke
Translucent black overlay. Not mode-aware. Dims the interface beneath a modal/blocking component (dialogs). Signals: interaction below is blocked.

> **Rule of thumb**: Acrylic = transient surfaces. Mica = persistent base layer. Smoke = modal backdrop. Solid = everything else.

---

## 7. Motion

### 7.1 Motion Principles

| Principle | Description |
|-----------|-------------|
| Functional | Applied with purpose; identifies next steps, informs changes, celebrates outcomes |
| Natural | Follows physical laws — inertia, gravity, weight, velocity — for believable animation |
| Consistent | Unified across Microsoft products; reinforces "Unmistakably Microsoft" |
| Appealing | Delightful; draws people in; makes experiences memorable |

### 7.2 Duration & Easing
- Match duration to element size and distance traveled
- Larger elements get more time; aim for fast and smooth
- Avoid sluggish (too long) or abrupt (too short)

**Easing types:**

| Type | Behavior | Use When |
|------|----------|----------|
| Linear | Constant speed | Rotations only |
| Ease-in | Starts slow, speeds up | Element exits |
| Ease-out | Starts fast, slows down | Element enters |
| Ease-in-out | Slow → fast → slow | General movement |

### 7.3 Transitions

| Type | Use Case |
|------|----------|
| Enter and Exit | Menus, dialogs, elements appearing/disappearing |
| Elevation | Button states, drag/drop, depth changes |
| Top Level | Page/destination navigation; use quick fade, not slide |
| Container Transform | Responsive layout shifts, resize/reposition of containers |

### 7.4 Choreography
- **Staggering**: delay animation starts in large sets to soften entry or guide the eye. Use short offsets. Preferred for most multi-element scenarios.
- **Hierarchy**: animate important elements with more prominent movement and longer duration; group secondary elements with synchronized timing.

### 7.5 Accessible Motion
- Include a "no motion" setting (per WCAG)
- Keep durations short; movement natural
- Avoid flashes or jarring sudden movements (epilepsy/seizure risk)
- Keep motion constrained to focused element
- Use ARIA live regions as alternative for dynamic content conveyed via animation

---

## 8. Shapes

Shapes are defined by form, corner radius, and stroke.

### 8.1 Forms

| Form | Use Case |
|------|----------|
| Rectangle | Buttons, cards, textareas, menus, images — most common components |
| Circle | Avatars, persona representations |
| Pill | Sliders, toggles, tags, keywords, selection lists |
| Beak | Callouts, popovers — reference point for floating surfaces |

Forms are distinguished by **fill** (defines/emphasizes shape) or **border** (outlines unfilled shapes like cards).

### 8.2 Corner Radius

| Token | Value | Usage |
|-------|-------|-------|
| None | 0px | Navigation bars, tab bars |
| Small | 2px | Small badges, elements < 32px |
| Medium | 4px | Buttons, dropdowns — **default** |
| Large | 8px | Large buttons |
| X-Large | 12px | Bottom sheets, popovers |
| Circle | 50% | Personas, avatars |

**Rules:**
- Do not use rounded corners when they create awkward gaps (e.g., split buttons)
- Do not round corners on components that extend to the screen edge

### 8.3 Stroke

**Stroke Thickness:**

| Token | Web | Mobile |
|-------|-----|--------|
| Thin | 1px | 1px |
| Thick | 2px | 2px |
| Thicker | 3px | 4px |
| Thickest | 4px | 6px |

Scale stroke thickness proportionally to element size. Use **rounded stroke caps** — avoid square caps. Stroke properties: weight, color, distribution, endpoint style.

---

## 9. Typography

### 9.1 Font Stack

**Segoe UI** — Microsoft's primary typeface. Friendly, legible, emphasizes readability and personality at all sizes. Used on Windows, WinUI, and web.

| Platform | Typeface |
|----------|----------|
| Windows | Segoe UI Variable |
| Web | Segoe UI |
| macOS | San Francisco Pro |
| iOS | San Francisco Pro |
| Android | Roboto |

### 9.2 Type Ramp — Web (Segoe UI)

| Name | Weight | Size / Line-height |
|------|--------|--------------------|
| Caption 2 | Regular | 10px / 14px |
| Caption 2 Strong | Semibold | 10px / 14px |
| Caption 1 | Regular | 12px / 16px |
| Caption 1 Strong | Semibold | 12px / 16px |
| Caption 1 Stronger | Bold | 12px / 16px |
| Body 1 | Regular | 14px / 20px |
| Body 1 Strong | Semibold | 14px / 20px |
| Body 1 Stronger | Bold | 14px / 20px |
| Subtitle 2 | Semibold | 16px / 22px |
| Subtitle 2 Stronger | Bold | 16px / 22px |
| Subtitle 1 | Semibold | 20px / 26px |
| Title 3 | Semibold | 24px / 32px |
| Title 2 | Semibold | 28px / 36px |
| Title 1 | Semibold | 32px / 40px |
| Large Title | Semibold | 40px / 52px |
| Display | Semibold | 68px / 92px |

### 9.3 Type Ramp — Windows (Segoe UI Variable)

| Name | Weight | Size / Line-height |
|------|--------|--------------------|
| Caption | Regular small | 12px / 16px |
| Body | Regular | 14px / 20px |
| Body Strong | Semibold | 14px / 20px |
| Body Large | Regular | 18px / 24px |
| Subtitle | Semibold display | 20px / 28px |
| Title | Semibold display | 28px / 36px |
| Large Title | Semibold display | 40px / 52px |
| Display | Semibold display | 68px / 92px |

### 9.4 Type Ramp — macOS (San Francisco Pro)

| Name | Weight | Size / Line-height |
|------|--------|--------------------|
| Caption 1 | Regular | 10pt / 13pt |
| Caption 1 Strong | Semibold | 10pt / 13pt |
| Body 1 | Regular | 13pt / 16pt |
| Body 1 Strong | Semibold | 13pt / 16pt |
| Subtitle 2 | Regular | 11pt / 14pt |
| Subtitle 1 | Bold | 13pt / 16pt |
| Title 3 | Regular | 15pt / 20pt |
| Title 3 Strong | Semibold | 15pt / 20pt |
| Title 2 | Regular | 17pt / 22pt |
| Title 2 Strong | Bold | 17pt / 22pt |
| Title 1 | Regular | 22pt / 26pt |
| Title 1 Strong | Bold | 22pt / 26pt |
| Large Title | Regular | 26pt / 32pt |
| Display | Bold | 30pt / 40pt |

### 9.5 Type Ramp — iOS (San Francisco Pro)

| Name | Weight | Size / Line-height |
|------|--------|--------------------|
| Caption 2 | Regular | 12pt / 16pt |
| Caption 1 | Regular | 13pt / 18pt |
| Caption 1 Strong | Semibold | 13pt / 18pt |
| Body 2 | Regular | 15pt / 20pt |
| Body 2 Strong | Semibold | 15pt / 20pt |
| Body 1 | Regular | 17pt / 22pt |
| Body 1 Strong | Semibold | 17pt / 22pt |
| Title 3 | Semibold | 20pt / 25pt |
| Title 2 | Semibold | 22pt / 28pt |
| Title 1 | Bold | 28pt / 34pt |
| Large Title | Bold | 34pt / 41pt |
| Display | Bold | 60pt / 70pt |

### 9.6 Type Ramp — Android (Roboto)

| Name | Weight | Size / Line-height |
|------|--------|--------------------|
| Caption 2 | Regular | 12sp / 16sp |
| Caption 1 | Regular | 13sp / 18sp |
| Caption 1 Strong | Medium | 13sp / 18sp |
| Body 2 | Regular | 14sp / 20sp |
| Body 2 Strong | Medium | 14sp / 20sp |
| Body 1 | Regular | 16sp / 24sp |
| Body 1 Strong | Semibold | 16sp / 24sp |
| Title 3 | Medium | 18sp / 24sp |
| Title 2 | Medium | 20sp / 24sp |
| Title 1 | Bold | 24sp / 32sp |
| Large Title | Regular | 34sp / 44sp |
| Display | Regular | 60sp / 72sp |

### 9.7 Text Styling Rules

**Casing**: Use sentence case. Never all-caps for emphasis — it's difficult to read.

**Alignment:**
- Default to left-align for LTR languages
- Right-align for RTL languages (Arabic, Hebrew)
- Center sparingly — for short callout copy or in support of another element only
- Use baseline alignment for vertical rhythm

**Color:**
- Standard text: minimum 4.5:1 contrast against background
- Large text (18.5px bold / 24px regular): minimum 3:1 contrast
- Brand/primary color text increases prominence
- Lighter neutral text de-emphasizes and lowers hierarchy position

---

## 10. Quick Reference — Token Summary

### Spacing (4px base)
`sizeNone (0)` → `size20 (2)` → `size40 (4)` → `size80 (8)` → `size120 (12)` → `size160 (16)` → `size200 (20)` → `size240 (24)` → `size320 (32)` → `size400 (40)` → `size480 (48)`

### Corner Radius
`0` (nav bars) → `2px` (badges) → `4px` (buttons, default) → `8px` (large btns) → `12px` (sheets, popovers) → `50%` (personas)

### Shadow Tokens
`$shadow2` → `$shadow4` → `$shadow8` → `$shadow16` → `$shadow28` → `$shadow64`

### Stroke Thickness
Thin `1px` → Thick `2px` → Thicker `3px/4px` → Thickest `4px/6px`

### Core Web Type Scale
`10px` (Caption 2) → `12px` (Caption 1) → `14px` (Body 1) → `16px` (Subtitle 2) → `20px` (Subtitle 1) → `24px` (Title 3) → `28px` (Title 2) → `32px` (Title 1) → `40px` (Large Title) → `68px` (Display)

---

## 11. External Resources

| Resource | URL |
|----------|-----|
| Fluent 2 main site | https://fluent2.microsoft.design |
| Fluent UI React Storybook | https://react.fluentui.dev |
| Alias color tokens | https://react.fluentui.dev/?path=/docs/theme-colors--page |
| System icon Figma library | https://www.figma.com/community/file/836835755999342788 |
| System icon GitHub repo | https://github.com/microsoft/fluentui-system-icons |
| FluentUI main repo | https://github.com/microsoft/fluentui |
| Windows elevation | https://learn.microsoft.com/en-us/windows/apps/design/signature-experiences/layering |
| Windows material | https://learn.microsoft.com/en-us/windows/apps/design/signature-experiences/materials |
| Accessibility guidelines | https://fluent2.microsoft.design/accessibility |
| Inclusive Design | https://inclusive.microsoft.design |

---

*Compiled from official Fluent 2 documentation. All design decisions should be validated against the live Fluent 2 site and component library for the latest updates.*
