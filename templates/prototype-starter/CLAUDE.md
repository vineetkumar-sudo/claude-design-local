# Prototype starter

You are inside a UI prototype playground. Treat this folder as a Claude Design canvas: the user prompts, you generate or edit HTML/CSS/JS, and their browser at `http://localhost:8000` shows the result (they hit reload, or use a live-reload extension).

## What's here

- `design-system/` — a copy of the chosen design system. After `new-prototype` ran, this folder contains:
  - `tokens.css` — the brand's CSS variables (palette, semantic surfaces, radius, dark mode).
  - `tailwind-bridge.js` — maps those variables onto Tailwind v3 CDN utility classes so `bg-primary`, `text-foreground`, etc. resolve to brand colors.
  - `README.md` — token reference and brand voice for this system. **Read this first** before generating any UI — it tells you the family names, the vibe, and the fonts.
  - Possibly `assets/` — brand images.
- `index.html` — the active prototype. Overwrite it freely as the user iterates, or split into multiple `.html` files if they want several screens.
- `serve.sh` — starts `python3 -m http.server 8000`. The user runs this once in a separate terminal.

## Universal rules (apply to every design system)

1. **Three head tags, in this order**, on every page you generate:
   ```html
   <link rel="stylesheet" href="design-system/tokens.css" />
   <script src="design-system/tailwind-bridge.js"></script>
   <script src="https://cdn.tailwindcss.com"></script>
   ```
   The bridge is what makes utility classes resolve to the brand tokens. Skip it and the page renders in vanilla Tailwind colors.
2. **Use the system's tokens, not raw hex.** Reach for the CSS variables (`var(--primary)`) or the Tailwind utilities defined in the bridge (`bg-primary`, `text-foreground`, `border-border`, brand-family classes). Don't introduce arbitrary `#aabbcc` values.
3. **Read `design-system/README.md` to learn this brand.** It lists the families, semantic tokens, fonts, and vibe. Match that voice in every prototype — a playful brand wants soft rounded corners and warm accents; a serious brand wants tighter spacing and sharper type.
4. **Dark mode is one class away.** Toggling `document.documentElement.classList.toggle('dark')` flips every semantic token. Include a dark-mode toggle on any non-trivial prototype.
5. **Persist interactive state to `localStorage`.** Any toggled checkbox, kanban move, theme preference — write to a namespaced key (e.g. `proto:<feature>`) on change, rehydrate on load. Reloads should not wipe progress.
6. **Self-contained pages.** Vanilla HTML + Tailwind CDN + inline JS. No build step. Frameworks only on explicit request.

## Iteration loop

The user's browser is open at `http://localhost:8000`. After every edit you make, tell them to refresh (or trust their live-reload). Keep diffs small and visible — prefer one focused change per turn so they can react quickly.

When they say "make it pop", "add some life", "more playful" — reach for brand-color accents (rotate through the families defined in this system), micro-animations (transitions, hover lift, tap-active scale), and generous whitespace.
