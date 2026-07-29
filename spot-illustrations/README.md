# BMO Spot Illustration Library

The canonical multicolour BMO line-drawing family — 481 SVGs, self-hosted.

BMO Brand Source: https://zeroheight.com/38e93a7ae/p/398698-illustrations/b/9088b8

## Contents

- `*.svg`: 481 spot illustrations, flat. Reference from a page as
  `spot-illustrations/<name>.svg`.
- `index.html`: visual contact sheet.
- `catalog.json`: per-asset name, size token, dimensions, byte size, and palette.

## Naming

Filenames carry a size token: `-xs` (96×72), `-s`, `-m`, `-l` (240×200), `-xl`.
A few legacy names have no token.

## Use

These are **tier 3** in the editorial art system — hero-substitute or feature
moment, roughly one per page, staged on white/albicant. See `docs/EDITORIAL-MODE.md`
§3 for the rules and the `.spot` component. Reference as `<img>`; the SVGs carry
baked-in brand hex, so inlining buys nothing. Decorative by default —
`alt="" aria-hidden="true"`.
