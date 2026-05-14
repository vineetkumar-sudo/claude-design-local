// Maps the Polymath design tokens (defined as CSS variables in tokens.css)
// onto Tailwind v3 CDN utility classes, so classes like bg-blue-vivid,
// text-foreground, border-border resolve to the brand colors and dark
// mode swaps automatically.
//
// In any HTML page that loads `https://cdn.tailwindcss.com`, also include
// this script *before* the Tailwind script:
//
//     <link rel="stylesheet" href="design-system/tokens.css" />
//     <script src="design-system/tailwind-bridge.js"></script>
//     <script src="https://cdn.tailwindcss.com"></script>
//
// (Or load this *after* the Tailwind script — both orders work because the
// CDN reads `tailwind.config` lazily before its first utility-class pass.)
window.tailwind = window.tailwind || {};
window.tailwind.config = {
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        background: 'var(--background)',
        foreground: 'var(--foreground)',
        card: { DEFAULT: 'var(--card)', foreground: 'var(--card-foreground)' },
        popover: { DEFAULT: 'var(--popover)', foreground: 'var(--popover-foreground)' },
        primary: { DEFAULT: 'var(--primary)', foreground: 'var(--primary-foreground)' },
        secondary: { DEFAULT: 'var(--secondary)', foreground: 'var(--secondary-foreground)' },
        muted: { DEFAULT: 'var(--muted)', foreground: 'var(--muted-foreground)' },
        accent: { DEFAULT: 'var(--accent)', foreground: 'var(--accent-foreground)' },
        border: 'var(--border)',
        ring: 'var(--ring)',
        purple: { subtle: 'var(--purple-subtle)', muted: 'var(--purple-muted)', vivid: 'var(--purple-vivid)', 'vivid-dark': 'var(--purple-vivid-dark)' },
        amber: { subtle: 'var(--amber-subtle)', muted: 'var(--amber-muted)', vivid: 'var(--amber-vivid)', 'vivid-dark': 'var(--amber-vivid-dark)' },
        blue: { subtle: 'var(--blue-subtle)', muted: 'var(--blue-muted)', vivid: 'var(--blue-vivid)', 'vivid-dark': 'var(--blue-vivid-dark)' },
        emerald: { subtle: 'var(--emerald-subtle)', muted: 'var(--emerald-muted)', vivid: 'var(--emerald-vivid)', 'vivid-dark': 'var(--emerald-vivid-dark)' },
        pink: { subtle: 'var(--pink-subtle)', muted: 'var(--pink-muted)', vivid: 'var(--pink-vivid)', 'vivid-dark': 'var(--pink-vivid-dark)' },
        teal: { subtle: 'var(--teal-subtle)', muted: 'var(--teal-muted)', vivid: 'var(--teal-vivid)', 'vivid-dark': 'var(--teal-vivid-dark)' },
      },
      fontFamily: { sans: ['Mulish', 'system-ui', 'sans-serif'] },
    },
  },
};
