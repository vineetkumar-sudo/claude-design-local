---
name: design-system
description: Activate whenever the user is building a UI prototype, mockup, dashboard, landing page, or any visual front-end in a folder that contains `design-system/tokens.css` and `design-system/tailwind-bridge.js`. Generates HTML/JSX wired to whatever design system that folder defines.
triggers:
  - "design-system/tokens.css and design-system/tailwind-bridge.js both exist in the project"
  - "user asks for a prototype, mockup, dashboard, landing page, UI, app screen, or component"
  - "user mentions theme tokens, brand styling, or the project's design system"
---

# Design system skill

You are working inside a themed prototype starter. The folder ships with a `design-system/` directory containing the chosen brand's tokens, Tailwind bridge, and README. Different prototypes use different design systems — never assume a specific brand; learn it from the files.

## First thing to do, every session

Before generating any UI, **read `design-system/README.md`**. It tells you:

- The brand families and shade variants this system defines (Polymath has six families × four shades; another system might have three families × three shades, or different names entirely).
- The semantic UI tokens available (`--primary`, `--card`, `--accent`, etc.).
- The body font and how it's loaded.
- The brand vibe / voice — match this in everything you produce.

If `design-system/README.md` doesn't exist, fall back to inspecting `design-system/tokens.css` and `design-system/tailwind-bridge.js` directly to learn the variable and utility names.

## Universal rules

1. **Import order in `<head>`** — always these three, in this order:
   ```html
   <link rel="stylesheet" href="design-system/tokens.css" />
   <script src="design-system/tailwind-bridge.js"></script>
   <script src="https://cdn.tailwindcss.com"></script>
   ```
   The bridge maps CSS variables onto Tailwind utility names. Without it, brand-color classes won't resolve.

2. **Use the system's tokens, not raw hex.** Reach for CSS variables (`var(--primary)`) or the Tailwind utilities the bridge exposes (`bg-primary`, `text-foreground`, `border-border`, brand-family classes). Never paste arbitrary `#aabbcc` values.

3. **Semantic surfaces, always.** Use `bg-background`, `text-foreground`, `bg-card`, `text-card-foreground`, `border-border`, `bg-muted`, `text-muted-foreground`, `bg-accent`, `bg-primary` / `text-primary-foreground`, `bg-secondary`, `bg-destructive` — these are the universal contract every system in this plugin exposes.

4. **Rotate brand families for variety.** When rendering a list where each item deserves its own accent (habit cards, course tiles, status pills, project chips), cycle through the families the system defines in the order listed in its README. Use the `subtle` shade for backgrounds, the `vivid` shade for accents and icons, the `vivid-dark` shade for hover/active.

5. **Match the system's vibe.** The README contains a voice paragraph — warm/rounded/playful, or sharp/dense/serious, or whatever. Let that drive radius, spacing, hover behavior, and copy tone. Don't impose a default look.

6. **Dark mode is one class away.** All tokens flip when `<html>` or any ancestor has `.dark`. Include a dark-mode toggle on any non-trivial prototype:
   ```js
   document.documentElement.classList.toggle('dark');
   ```

7. **Persist state to `localStorage`.** Any interactive prototype (checked items, kanban moves, theme preference) must serialize on change and rehydrate on load. Use a namespaced key like `proto:<feature>`.

8. **Self-contained pages.** Vanilla HTML + Tailwind CDN + inline JS. No build step. Break a `.js` out only past ~300 lines.

9. **Iterate fast, don't refactor.** Prototype playground — favor visible change over architecture. Avoid frameworks unless the user asks.

## When the user wants a new design system

This skill is about *using* an existing system. To *create* one, the `design-system-author` skill takes over (triggered by phrases like "make a new design system", "import this stylesheet as a brand", or the `/new-design-system` slash command). The plugin's `design-systems/` folder is the canonical place to find existing systems to crib from — `design-systems/polymath/` is the reference shape.

## Reference snippet (works against any system in this plugin)

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="design-system/tokens.css" />
    <script src="design-system/tailwind-bridge.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <title>My prototype</title>
  </head>
  <body class="bg-background text-foreground">
    <main class="max-w-4xl mx-auto p-8">
      <h1 class="text-3xl font-bold text-primary">Hello</h1>
      <button class="tap-active rounded-lg bg-primary text-primary-foreground px-4 py-2 mt-4 hover:opacity-90 transition">
        Click me
      </button>
    </main>
  </body>
</html>
```
