# Polymath Design System tokens

`tokens.css` is a Tailwind v4 stylesheet that defines every variable used across the Polymath product. Drop it into any HTML page and the Tailwind CDN will expose its tokens as utility classes automatically.

## How to load it

```html
<link rel="stylesheet" href="design-system/tokens.css">
<script src="https://cdn.tailwindcss.com"></script>
```

The `<link>` must come before the CDN script so Tailwind can pick up the `@theme inline` definitions.

## Brand color families

Six families, each with four shades, plus a dark-mode flip. Use `subtle` for backgrounds, `muted` for chips, `vivid` for primary accents/icons, and `vivid-dark` for hover/active or strong text.

| Family   | subtle (light / dark) | muted (light / dark) | vivid (light / dark) | vivid-dark (light / dark) |
|----------|-----------------------|----------------------|----------------------|----------------------------|
| purple   | `#faf5ff` / `#2e1065` | `#f3e8ff` / `#4c1d95`| `#9333ea` / `#c084fc`| `#7e22ce` / `#d8b4fe`      |
| amber    | `#fffbeb` / `#451a03` | `#fef3c7` / `#78350f`| `#d97706` / `#fbbf24`| `#b45309` / `#fcd34d`      |
| blue     | `#eff6ff` / `#172554` | `#dbeafe` / `#1e3a8a`| `#2563eb` / `#60a5fa`| `#1d4ed8` / `#93c5fd`      |
| emerald  | `#ecfdf5` / `#022c22` | `#d1fae5` / `#064e3b`| `#059669` / `#34d399`| `#047857` / `#6ee7b7`      |
| pink     | `#fdf2f8` / `#500724` | `#fce7f3` / `#831843`| `#db2777` / `#f472b6`| `#be185d` / `#f9a8d4`      |
| teal     | `#f0fdfa` / `#042f2e` | `#ccfbf1` / `#134e4a`| `#0d9488` / `#2dd4bf`| `#0f766e` / `#5eead4`      |

Reach for them as either CSS variables (`var(--blue-vivid)`) or Tailwind utilities (`bg-blue-vivid`, `text-blue-vivid`, `border-blue-vivid`).

When rendering a collection of cards where each item deserves its own accent (habits, courses, project tiles, status pills), cycle through `purple, amber, blue, emerald, pink, teal` so the page feels alive without becoming noisy.

## Semantic UI tokens

These tokens drive the chrome of the app and automatically flip in dark mode (when an ancestor has the `dark` class).

| Token                   | Purpose                                | Tailwind class form         |
|-------------------------|----------------------------------------|-----------------------------|
| `--background`          | Page background                        | `bg-background`             |
| `--foreground`          | Default text                           | `text-foreground`           |
| `--card`                | Card surface                           | `bg-card`                   |
| `--card-foreground`     | Text on a card                         | `text-card-foreground`      |
| `--popover`             | Popover / menu surface                 | `bg-popover`                |
| `--popover-foreground`  | Text on a popover                      | `text-popover-foreground`   |
| `--primary`             | Brand primary (Deep Engineering Blue)  | `bg-primary` / `text-primary` |
| `--primary-foreground`  | Text on a primary surface              | `text-primary-foreground`   |
| `--secondary`           | Secondary buttons, soft surfaces       | `bg-secondary`              |
| `--secondary-foreground`| Text on secondary                      | `text-secondary-foreground` |
| `--muted`               | Muted backgrounds (inputs, chips)      | `bg-muted`                  |
| `--muted-foreground`    | Muted text                             | `text-muted-foreground`     |
| `--accent`              | Hover accent                           | `bg-accent`                 |
| `--accent-foreground`   | Text on accent                         | `text-accent-foreground`    |
| `--destructive`         | Errors / delete                        | `bg-destructive`            |
| `--border`              | Default border                         | `border-border`             |
| `--input`               | Input border                           | `border-input`              |
| `--ring`                | Focus ring                             | `ring-ring`                 |
| `--sidebar`, `--sidebar-foreground`, `--sidebar-primary`, `--sidebar-accent`, `--sidebar-border`, `--sidebar-ring` | Sidebar chrome | `bg-sidebar`, etc. |
| `--header`, `--header-foreground` | Page header chrome           | `bg-header`, `text-header-foreground` |
| `--chart-1` through `--chart-5` | Chart series colors            | `bg-chart-1` ... `bg-chart-5` |

## Radius

`--radius` is `0.75rem` (squaricle). The scale gives you:

- `rounded-sm` -> `calc(var(--radius) - 4px)` = 0.5rem
- `rounded-md` -> `calc(var(--radius) - 2px)` = 0.625rem
- `rounded-lg` -> `var(--radius)` = 0.75rem (default)
- `rounded-xl` -> `calc(var(--radius) + 4px)` = 0.875rem

## Typography

Body uses `var(--font-mulish), sans-serif`. Mulish isn't bundled — load it from Google Fonts when you want it explicit:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Mulish:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>:root { --font-mulish: 'Mulish'; }</style>
```

If `--font-mulish` is unset the browser falls back to its default sans-serif — still acceptable for a prototype.

## Dark mode

Add the `dark` class anywhere up the tree (commonly on `<html>` or `<body>`) and every semantic token + brand-family variable flips. Toggle it with one line:

```js
document.documentElement.classList.toggle('dark');
```

## Usage examples

### A primary button (raw CSS vars)

```html
<button style="
  background: var(--primary);
  color: var(--primary-foreground);
  border-radius: var(--radius);
  padding: 0.5rem 1rem;
">
  Save changes
</button>
```

### The same button (Tailwind utilities)

```html
<button class="tap-active bg-primary text-primary-foreground rounded-lg px-4 py-2 hover:opacity-90 transition">
  Save changes
</button>
```

### A habit-style card with a brand accent

```html
<article class="bg-card border border-border rounded-xl p-5 hover:shadow-md transition">
  <div class="flex items-center gap-3">
    <span class="w-10 h-10 rounded-lg flex items-center justify-center bg-emerald-subtle text-emerald-vivid">
      <!-- icon -->
    </span>
    <div>
      <h3 class="text-card-foreground font-semibold">Morning walk</h3>
      <p class="text-muted-foreground text-sm">5 day streak</p>
    </div>
  </div>
</article>
```

### Card grid that cycles brand families

```html
<div class="grid grid-cols-3 gap-4">
  <div class="bg-purple-subtle border border-purple-muted rounded-xl p-4">Purple</div>
  <div class="bg-amber-subtle border border-amber-muted rounded-xl p-4">Amber</div>
  <div class="bg-blue-subtle border border-blue-muted rounded-xl p-4">Blue</div>
  <div class="bg-emerald-subtle border border-emerald-muted rounded-xl p-4">Emerald</div>
  <div class="bg-pink-subtle border border-pink-muted rounded-xl p-4">Pink</div>
  <div class="bg-teal-subtle border border-teal-muted rounded-xl p-4">Teal</div>
</div>
```

## Forking the theme

If a sub-project needs to deviate (different primary color, custom radius), edit `tokens.css` in that copied starter. The plugin's source `tokens.css` is the single source of truth — keep changes downstream unless you intend to push them back into the plugin.
