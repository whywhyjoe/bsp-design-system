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

    /* ── MIGRATION SEAM ───────────────────────────────────────────────
       resolve(name) -> icon markup (string OR Promise<string>).
       This is the ONLY thing that changes to switch icon engines. No
       component markup anywhere else is touched.

       NOW (sprite-backed): reference a document-level <symbol>.
       LATER (self-hosted Fluent folder): see the commented fetch version
       at the bottom of this file — paste it over this method, set BASE,
       done. render() already awaits, so sync→async needs no other edit.
       ───────────────────────────────────────────────────────────────── */
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


/* =====================================================================
   SWAP TARGET — self-hosted Fluent SVG folder (the future version)
   ---------------------------------------------------------------------
   When you're ready to drop the placeholder sprite and serve the real
   18k+ Fluent set from SiteAssets, replace resolve() above with this and
   add the static cache + BASE. Caches the PROMISE so repeated renders of
   the same icon dedupe to a single network request. Same `name` token in,
   so every <fluent-icon> on every page migrates with zero markup edits.

   class FluentIcon extends HTMLElement {
     static BASE = '/sites/YOURSITE/SiteAssets/fluent-icons/';   // set this
     static _cache = new Map();                                  // url -> Promise<svg>

     resolve(name) {
       // name token "home-24-regular" -> file "ic_fluent_home_24_regular.svg"
       var url = FluentIcon.BASE + 'ic_fluent_' + name.replace(/-/g, '_') + '.svg';
       var p = FluentIcon._cache.get(url);
       if (!p) {
         p = fetch(url)
           .then(function (r) { return r.ok ? r.text() : ''; })
           .catch(function () { return ''; })
           // Normalize: strip the file's hardcoded width/height/fill so it
           // inherits currentColor + .icon sizing, then tag it .icon.
           .then(function (raw) {
             if (!raw) return '<svg class="icon" aria-hidden="true"></svg>';
             return raw
               .replace(/<svg /, '<svg class="icon" aria-hidden="true" ')
               .replace(/\s(width|height)="[^"]*"/g, '')
               .replace(/fill="(?!none)[^"]*"/g, 'fill="currentColor"');
           });
         FluentIcon._cache.set(url, p);
       }
       return p;
     }
     // ...connectedCallback / attributeChangedCallback / render unchanged...
   }

   NOTE: Fluent does not ship every icon in every size. The size segment of
   `name` (…-16-…, -20-, -24-, -28-, -32-, -48-) must match a file that
   exists. Confirm availability at the Fluent System Icons reference.
   ===================================================================== */
