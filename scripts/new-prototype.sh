#!/usr/bin/env bash
# Scaffold a new prototype folder from the plugin's starter, wired to the chosen design system.
#
# Usage:
#   ./scripts/new-prototype.sh <project-name> <system-slug>
#
# Example:
#   ./scripts/new-prototype.sh habit-tracker polymath

set -euo pipefail

PROJECT_NAME="${1:-}"
SYSTEM_SLUG="${2:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

usage() {
  cat <<EOF >&2
Usage: $0 <project-name> <system-slug>

  <project-name>   folder name for the new prototype (e.g. habit-tracker)
  <system-slug>    design system to use; must match a folder under design-systems/

Available systems:
EOF
  if [ -d "$PLUGIN_DIR/design-systems" ]; then
    find "$PLUGIN_DIR/design-systems" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; \
      | sort | sed 's/^/  - /' >&2
  fi
}

if [ -z "$PROJECT_NAME" ] || [ -z "$SYSTEM_SLUG" ]; then
  usage
  exit 1
fi

SYSTEM_DIR="$PLUGIN_DIR/design-systems/$SYSTEM_SLUG"
STARTER_DIR="$PLUGIN_DIR/templates/prototype-starter"

if [ ! -d "$SYSTEM_DIR" ]; then
  echo "Error: unknown system slug '$SYSTEM_SLUG'." >&2
  echo "" >&2
  echo "Available systems under $PLUGIN_DIR/design-systems/:" >&2
  if [ -d "$PLUGIN_DIR/design-systems" ]; then
    find "$PLUGIN_DIR/design-systems" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; \
      | sort | sed 's/^/  - /' >&2
  else
    echo "  (no design-systems directory found)" >&2
  fi
  exit 1
fi

if [ ! -d "$STARTER_DIR" ]; then
  echo "Error: starter template not found at $STARTER_DIR" >&2
  exit 1
fi

if [ -e "$PROJECT_NAME" ]; then
  echo "Error: '$PROJECT_NAME' already exists in the current directory." >&2
  exit 1
fi

# Copy starter.
cp -R "$STARTER_DIR" "$PROJECT_NAME"

# Wipe the placeholder .gitkeep and copy the chosen system into design-system/.
rm -f "$PROJECT_NAME/design-system/.gitkeep"
cp -R "$SYSTEM_DIR/." "$PROJECT_NAME/design-system/"

# Make serve.sh executable in case the copy didn't preserve the bit.
chmod +x "$PROJECT_NAME/serve.sh" 2>/dev/null || true

cat <<EOF

Created prototype: $PROJECT_NAME
  Starter:        $STARTER_DIR
  Design system:  $SYSTEM_SLUG  ($SYSTEM_DIR)

Next steps:
  cd $PROJECT_NAME
  ./serve.sh                 # in one terminal — serves on http://localhost:8000
  claude                     # in another terminal, from the same folder

The design-system/ folder inside $PROJECT_NAME is a copy. Edit it freely without
affecting the plugin's canonical $SYSTEM_SLUG system.
EOF
