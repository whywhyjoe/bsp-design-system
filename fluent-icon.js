/* =====================================================================
   <fluent-icon> — BMO Design System icon element
   ---------------------------------------------------------------------
   Buildless. Dependency-free. No framework, no `import`, no Alpine, no
   bmo-behaviors. Drop this one file into SiteAssets and add ONE tag:

       <script src="fluent-icon.js" defer></script>

   Then author icons by NAME TOKEN ({icon}-{size}-{variant}):

       <fluent-icon name="home-24-regular"></fluent-icon>
       <fluent-icon name="search-20-regular" class="icon--20"></fluent-icon>
       <fluent-icon name="alert-24-filled" label="Notifications"></fluent-icon>

   This is the OPTIONAL "sugar" form. The no-JS form is always supported
   and needs none of this file:

       <svg class="icon icon--16"><use href="#ic-fluent-home-24-regular"/></svg>

   Both resolve to the same sprite symbol, so a page can mix them freely.
   ---------------------------------------------------------------------
   WHY LIGHT DOM (do not "fix" this): the element renders into itself, not
   a shadow root. An <svg><use href="#id"> reference CANNOT reach a sprite
   <symbol> defined in the main document from inside shadow DOM. Light DOM
   is required for the sprite to resolve — and it lets the existing
   .icon / .icon--N CSS apply with no piercing.
   ===================================================================== */

(function () {
  if (customElements.get('fluent-icon')) return;   // guard double-define

  class FluentIcon extends HTMLElement {
    static get observedAttributes() { return ['name', 'label']; }

    connectedCallback() { this.render(); }
    attributeChangedCallback() { if (this.isConnected) this.render(); }

    /* resolve(name) -> icon markup: a same-document <use> against the
       inlined bmo-icons.svg sprite. The sprite is the supported engine;
       to reach icons it doesn't carry, copy the real SVG from the
       fluentui-system-icons repo into the sprite, or use the Fluent icon
       font (docs/TECHNICAL-REFERENCE.md §6) — not a runtime fetch here.
       (render() wraps this in Promise.resolve, so a Promise-returning
       resolve() would also work; the stale-guard covers that case.) */
    resolve(name) {
      return '<svg class="icon" aria-hidden="true"><use href="#ic-fluent-'
           + name + '"/></svg>';
    }

    render() {
      var name = this.getAttribute('name');
      if (!name) { this.innerHTML = ''; return; }
      var self = this;
      Promise.resolve(this.resolve(name)).then(function (html) {
        if (self.getAttribute('name') !== name) return;   // stale guard (async)
        self.innerHTML = html;
        var svg = self.firstElementChild;
        if (!svg) return;
        // Forward host classes (e.g. icon--20) onto the inner <svg> so the
        // existing .icon--N size helpers in components.css just work.
        if (self.className) {
          svg.classList.add.apply(
            svg.classList, self.className.trim().split(/\s+/)
          );
        }
        // Accessibility: decorative by default (aria-hidden in resolve()).
        // Pass label="…" to expose it as a meaningful image to AT.
        var label = self.getAttribute('label');
        if (label) {
          svg.setAttribute('role', 'img');
          svg.setAttribute('aria-label', label);
          svg.removeAttribute('aria-hidden');
        }
      });
    }
  }

  customElements.define('fluent-icon', FluentIcon);
})();
