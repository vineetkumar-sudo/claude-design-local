---
name: design-system-author
description: Activate when the user asks to create a new design system, add a brand, define a theme, or import an existing stylesheet, palette, or website into the plugin's `design-systems/` folder. Produces `tokens.css`, `tailwind-bridge.js`, and `README.md` matching the plugin's design-system contract.
triggers:
  - "user says: create a new design system, add a brand, make a theme, define a palette, import this CSS"
  - "user invokes /new-design-system"
  - "user wants to scaffold a new entry under design-systems/"
---

# Design system author skill

You are creating a new entry under `design-systems/<slug>/` in this plugin. Your job is to produce three files that satisfy the contract in `design-systems/README.md`:

- `tokens.css` — CSS variables for palette, semantic surfaces, radius, typography, plus a `.dark` override block.
- `tailwind-bridge.js` — sets `window.tailwind.config` mapping the variables onto Tailwind v3 utility classes.
- `README.md` — human + Claude reference: families table, semantic tokens table, radius, fonts, vibe paragraph, usage snippets.

**Always open `design-systems/polymath/tokens.css`, `design-systems/polymath/tailwind-bridge.js`, and `design-systems/polymath/README.md` before generating.** They are the canonical reference shape — mirror their structure exactly. Same section order, same semantic token names, same dark-mode pattern (`.dark { --foo: ...; }`), same table layout in the README.

You support two flows. Pick based on what the user gave you.

---

## Flow A — Guided conversation

Use this when the user wants to design a system from scratch and hasn't pointed you at an existing artifact.

### Interview checklist

Ask one short batch of questions, not a long form. Collect:

1. **Brand name.** Convert to slug: lowercase, hyphens, no spaces (e.g. "Acme Studio" → `acme-studio`).
2. **Vibe / voice.** One or two sentences. Examples: "warm, rounded, slightly playful", "minimalist, technical, dense", "editorial, serif-heavy, generous whitespace". This drives radius, motion, and density defaults.
3. **Primary brand color** as a hex. Optionally one or two accent hexes.
4. **Brand families.** Either reuse Polymath's pattern (six families: purple, amber, blue, emerald, pink, teal), or define a custom set (3–8 families is the sweet spot). For each family, you only need the user to give you one `vivid` hex — derive the rest:
   - `subtle` ≈ very light tint (mix with white ~95% / lightness ~97).
   - `muted` ≈ light tint (~85% white).
   - `vivid` = the brand hex itself.
   - `vivid-dark` = darker shade (~15% black).
   - Dark-mode variants: invert the tint logic — `subtle` becomes a very dark version, `vivid` shifts lighter for contrast on dark backgrounds.
5. **Font.** Google Fonts name (`Mulish`, `Inter`, `Source Serif Pro`, etc.) plus rough weight range. Default to `Inter` if unsure.
6. **Light / dark preference.** Light-first, dark-first, or both equal. Always implement both; the difference is just which surface looks more "designed".
7. **Radius default.** Pull from the vibe: rounded → `0.75rem`, sharp → `0.25rem`, in between → `0.5rem`.

### Then generate

If the slug folder doesn't exist, run `./scripts/new-design-system.sh <slug>` first to scaffold placeholders, then overwrite each file. Otherwise write directly.

For `tokens.css`:
- Mirror Polymath's section ordering: `@import "tailwindcss"`-style preamble if applicable, root `:root { --radius: ... ; --background: ...; ... }` block, semantic surfaces, brand families (each family declares all four variants), then a full `.dark { ... }` override.
- Include `@theme inline { ... }` block if the user wants Tailwind v4 syntax — otherwise stick to the v3 CDN bridge pattern.

For `tailwind-bridge.js`: copy Polymath's literal shape, swap family names and variable references to match.

For `README.md`: same table layout, real hex values in light/dark columns, two or three usage snippets, and a 2–3 sentence vibe paragraph at the top.

---

## Flow B — Import from existing source

Use this when the user points at an artifact. The artifact can be:

- A path to a CSS file (`/path/to/styles.css`).
- A path to a JSON palette (`{"primary": "#...", ...}`).
- A URL to a deployed website.
- A screenshot of the brand (uploaded image).
- A pasted color list or description.

### Per-source extraction

- **CSS file.** Read it. Pull out every `--*` variable. Pattern-match against the contract's semantic names — `primary`, `background`, `card`, `border`, `accent`, `muted`, etc. If the source uses different names (`--brand-color` instead of `--primary`), rename when copying into the new system, but preserve the values. If a required semantic surface is missing (e.g. no `--card`), derive a reasonable default (e.g. `--card` = white in light, `#11181c` in dark).
- **JSON palette.** Map the keys to semantic names. Generate the family variants and dark counterparts using the same color math as Flow A.
- **URL.** Ask the user to run one of these and paste the output:
  - `curl -sL <url> | grep -oE '#[0-9a-fA-F]{3,8}' | sort | uniq -c | sort -rn | head -40` — most-used hex colors.
  - Or open the site in DevTools → Inspect → Computed → copy out the brand variables.
  Then treat the pasted palette as Flow A inputs.
- **Screenshot / description.** Extract the dominant 5–8 colors. Present them to the user and ask which is primary, which are accents, which is background. Once confirmed, generate.

### Required user confirmation

Before writing files, show the user:
- The slug you're using.
- The mapped semantic colors (primary, background, foreground, card, accent).
- The list of brand families and their hexes.
- The font you picked.

Ask: "Generate the system with these values?" Wait for explicit yes.

---

## Output (both flows)

Write to `design-systems/<slug>/`:

- `tokens.css`
- `tailwind-bridge.js`
- `README.md`

If the user supplied a logo or icons, also create `design-systems/<slug>/assets/` and place them there.

After writing, print a confirmation:

```
Created design system: <slug>
  Path:       design-systems/<slug>/
  Families:   purple, amber, blue, ...
  Primary:    #xxxxxx
  Font:       Inter

To use it in a new prototype:
  ./scripts/new-prototype.sh my-app <slug>
or in Claude Code:
  /new-prototype my-app <slug>
```

## Common pitfalls

- Forgetting the `.dark { ... }` override block. The system is broken in dark mode without it.
- Naming family variants inconsistently. Stick to `subtle / muted / vivid / vivid-dark` unless the user explicitly wants different names — the starter's demo and other prototypes assume this scheme.
- Hex values that don't have enough contrast on the chosen background. Sanity-check `--primary` against `--primary-foreground` (WCAG AA, ratio ≥ 4.5).
- Writing files outside `design-systems/<slug>/`. Never modify the polymath system unless the user explicitly asks.
