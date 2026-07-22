# AGENTS.md

AI coding agents: this folder is the **BMO SharePoint Design System** — a
buildless, CDN-free, self-hosted HTML/CSS/JS component library for SharePoint.

**Read first:**
- [`CLAUDE.md`](CLAUDE.md) — the full agent guide (rules, file map, workflow).
- [`.github/copilot-instructions.md`](.github/copilot-instructions.md) — directive rules with ✅/❌ examples.
- [`docs/PAGE-TEMPLATE.md`](docs/PAGE-TEMPLATE.md) — start a new page from this scaffold.
- [`docs/TECHNICAL-REFERENCE.md`](docs/TECHNICAL-REFERENCE.md) — per-component snippets, tokens, state contract, icons.

**The five rules you must not break:**
1. **Buildless / CDN-free / self-hosted** — the *shipped artifact* can't require a build step, bundler, or ES `import`, and in production no external CDN: self-host every runtime dependency, Alpine included (valid hosting is bmo.sharepoint.com). Local dev tooling (`npm install`, Node, Python, etc.) and dev-time CDN tags are fine — dependencies just get self-hosted before shipping.
2. **One BEM vocabulary on shared tokens** — compose with existing `block--modifier` classes; no invented classes, no raw hex / off-ramp px, never redefine `:root`.
3. **Hand-rolled Fluent 2 + BMO, not a third-party kit** — no Web Awesome / Fluent React / Material / icon libraries.
4. **Interactivity = inline Alpine** — every binding inside an `x-data` root; drive the documented state classes/attributes; no `Alpine.data()` factory for trivial controls.
5. **Icons** — name token `ic-fluent-{name}-24-regular` over `bmo-icons.svg` (no-JS `<use>` or `<fluent-icon>`); size via `.icon--N`, never in the name.

Copy live markup from `examples/components.html`. The retired→canonical vocabulary mapping is in `CLAUDE.md` and `.github/copilot-instructions.md`.
