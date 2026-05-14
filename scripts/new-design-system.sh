#!/usr/bin/env bash
# Scaffold an empty design-system folder under design-systems/<slug>/ with
# placeholder files. Run /new-design-system in Claude Code afterwards to fill
# them in, or edit by hand.
#
# Usage:
#   ./scripts/new-design-system.sh <slug>
#
# Example:
#   ./scripts/new-design-system.sh acme-studio

set -euo pipefail

SLUG="${1:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ -z "$SLUG" ]; then
  echo "Usage: $0 <slug>" >&2
  echo "  <slug> must be lowercase, hyphenated (e.g. acme-studio)" >&2
  exit 1
fi

# Validate slug: lowercase letters, digits, hyphens; cannot start or end with hyphen.
if ! [[ "$SLUG" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "Error: slug '$SLUG' is not valid." >&2
  echo "  Use lowercase letters, digits, and single hyphens between segments." >&2
  echo "  Examples: polymath, acme-studio, brand-2025" >&2
  exit 1
fi

TARGET_DIR="$PLUGIN_DIR/design-systems/$SLUG"

if [ -e "$TARGET_DIR" ]; then
  echo "Error: design-systems/$SLUG already exists." >&2
  echo "  Delete it first, or pick a different slug." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"

cat > "$TARGET_DIR/tokens.css" <<'EOF'
/*
 * TODO: replace with the full token sheet for this design system.
 *
 * Required:
 *   :root {
 *     --radius: 0.5rem;
 *     --background: #...; --foreground: #...;
 *     --card: #...;       --card-foreground: #...;
 *     --popover: #...;    --popover-foreground: #...;
 *     --primary: #...;    --primary-foreground: #...;
 *     --secondary: #...;  --secondary-foreground: #...;
 *     --muted: #...;      --muted-foreground: #...;
 *     --accent: #...;     --accent-foreground: #...;
 *     --destructive: #...;
 *     --border: #...; --input: #...; --ring: #...;
 *
 *     --<family>-subtle: #...;
 *     --<family>-muted:  #...;
 *     --<family>-vivid:  #...;
 *     --<family>-vivid-dark: #...;
 *     (repeat per family)
 *   }
 *
 *   .dark {
 *     // override every variable above with dark-mode values
 *   }
 *
 * See design-systems/polymath/tokens.css for the canonical reference.
 */
EOF

cat > "$TARGET_DIR/tailwind-bridge.js" <<'EOF'
// TODO: map this design system's CSS variables onto Tailwind v3 utility classes.
// See design-systems/polymath/tailwind-bridge.js for the canonical reference.
//
// Load order in HTML:
//   <link rel="stylesheet" href="design-system/tokens.css" />
//   <script src="design-system/tailwind-bridge.js"></script>
//   <script src="https://cdn.tailwindcss.com"></script>

window.tailwind = window.tailwind || {};
window.tailwind.config = {
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        // TODO: semantic surfaces
        background: 'var(--background)',
        foreground: 'var(--foreground)',
        card: { DEFAULT: 'var(--card)', foreground: 'var(--card-foreground)' },
        primary: { DEFAULT: 'var(--primary)', foreground: 'var(--primary-foreground)' },
        // TODO: brand families
      },
      // TODO: fontFamily
    },
  },
};
EOF

cat > "$TARGET_DIR/README.md" <<EOF
# $SLUG design system

TODO: short vibe / voice paragraph — describe the brand personality in 2–3 sentences. This is the first thing Claude reads when generating UI against this system.

## Brand color families

TODO: table of families, with subtle / muted / vivid / vivid-dark hexes in light and dark mode. Mirror the layout in design-systems/polymath/README.md.

## Semantic UI tokens

TODO: table of semantic tokens and their Tailwind utility forms.

## Radius

TODO: state the \`--radius\` value and the derived scale (sm, md, lg, xl).

## Typography

TODO: body font, weights, Google Fonts URL, fallback.

## Dark mode

Add the \`dark\` class to \`<html>\` to flip every token. Toggle with:

\`\`\`js
document.documentElement.classList.toggle('dark');
\`\`\`

## Usage examples

TODO: a primary button, a card, and a colored chip rendered with the system's tokens.
EOF

cat <<EOF

Scaffolded: $TARGET_DIR/
  - tokens.css        (TODO placeholder)
  - tailwind-bridge.js (TODO placeholder)
  - README.md         (TODO placeholder)

Next:
  Run /new-design-system in Claude Code to fill these in via guided conversation,
  or edit the files by hand. The reference shape is design-systems/polymath/.
EOF
