# Design systems

This folder is the canonical home for every design system the plugin knows about. One subfolder per system. Each subfolder's name is the system's **slug** — lowercased, hyphen-separated — and is what you pass to commands like `/new-prototype habit-tracker polymath`.

```
design-systems/
  README.md           # this file — the contract
  polymath/           # one system
    tokens.css
    tailwind-bridge.js
    README.md
    assets/           # optional
  <your-system>/
    ...
```

## The contract

For a folder under `design-systems/` to count as a valid design system, it must contain the following files. The `new-prototype` script and the `design-system` skill assume this layout — anything missing will break the workflow.

### `tokens.css` — required

A self-contained CSS file that defines the entire visual language as CSS custom properties.

It must declare:

- **Brand palette.** A handful of color "families" (Polymath ships six: purple, amber, blue, emerald, pink, teal). Each family typically has shade variants — Polymath uses `subtle`, `muted`, `vivid`, `vivid-dark`. The exact names are your choice, but be consistent across families so they can be rotated programmatically.
- **Semantic surfaces.** These are required because they back the universal Tailwind utilities the starter and skill assume:
  - `--background`, `--foreground`
  - `--card`, `--card-foreground`
  - `--popover`, `--popover-foreground`
  - `--primary`, `--primary-foreground`
  - `--secondary`, `--secondary-foreground`
  - `--muted`, `--muted-foreground`
  - `--accent`, `--accent-foreground`
  - `--destructive`, optionally `--destructive-foreground`
  - `--border`, `--input`, `--ring`
- **Radius.** A `--radius` variable; the standard `rounded-{sm,md,lg,xl}` scale derives from it.
- **Typography.** Either a `--font-*` variable or a body-level `font-family` declaration so headings and body text inherit the brand.
- **Dark mode.** All semantic surfaces and brand families should re-declare under a `.dark` selector (e.g. `.dark { --background: ...; }`) so toggling `document.documentElement.classList.add('dark')` flips the whole UI.

Optional but recommended: chart series (`--chart-1` through `--chart-5`), sidebar tokens (`--sidebar`, `--sidebar-foreground`, ...), header tokens (`--header`, `--header-foreground`).

### `tailwind-bridge.js` — required

A small script that sets `window.tailwind.config` before the Tailwind v3 CDN script runs. Its job is to map your CSS variables onto Tailwind utility names so classes like `bg-card`, `text-foreground`, `border-border`, and your branded `bg-blue-vivid`-style utilities resolve at runtime.

Minimum shape:

```js
window.tailwind = window.tailwind || {};
window.tailwind.config = {
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        background: 'var(--background)',
        foreground: 'var(--foreground)',
        card: { DEFAULT: 'var(--card)', foreground: 'var(--card-foreground)' },
        primary: { DEFAULT: 'var(--primary)', foreground: 'var(--primary-foreground)' },
        // ...and each brand family with its variants
      },
      fontFamily: { sans: ['<your font>', 'system-ui', 'sans-serif'] },
    },
  },
};
```

Without this file, utility classes like `bg-blue-vivid` will not resolve. Tailwind will still apply, but the brand colors are inert.

### `README.md` — required

The human- and Claude-readable token reference. It must describe:

- The brand families that exist, with their hex values in light and dark mode, in a table.
- The semantic UI tokens and the Tailwind class form for each.
- The radius scale.
- The body font and how to load it (Google Fonts URL, fallback).
- A few usage snippets (a button, a card, a colored chip).
- A short "vibe / voice" paragraph describing the brand personality — Claude reads this first to set the tone of every prototype it generates.

### `assets/` — optional

Brand images that the prototype starter may want to reference: a logo SVG, a favicon, file-type icons, empty-state illustrations. If present, the `new-prototype` script copies these alongside the CSS into each new project.

## How systems are consumed

When you run `./scripts/new-prototype.sh <project-name> <slug>` (or `/new-prototype` in Claude Code), the script:

1. Copies `templates/prototype-starter/` to `<project-name>/`.
2. Copies `design-systems/<slug>/*` into `<project-name>/design-system/`.
3. The starter's `index.html` and the per-project `CLAUDE.md` reference `design-system/tokens.css`, `design-system/tailwind-bridge.js`, and `design-system/README.md` — so the chosen system is now wired up.

This means the project carries its own copy of the design system. Tweaking it inside the project never bleeds back into the plugin's source — push changes into `design-systems/<slug>/` here only when you intend to make them canonical.

## Currently shipped

- **`polymath/`** — the Polymath Design System. Six brand families, Mulish body, light-first with full dark mode. Vibe: warm, rounded, slightly playful, engineering-minded.

To add a new one, either edit by hand following this contract, or run `/new-design-system` in Claude Code (guided) or `/new-design-system from <path-or-url>` (import).
