#!/usr/bin/env bash
# Serve this prototype on http://localhost:8000
# Usage: ./serve.sh [port]

set -e

PORT="${1:-8000}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$DIR"

echo ""
echo "  Prototype starter"
echo "  -----------------"
echo "  Serving:   $DIR"
echo "  Open:      http://localhost:$PORT"
echo "  Stop:      Ctrl+C"
echo ""

# Prefer python3, fall back to python.
if command -v python3 >/dev/null 2>&1; then
  exec python3 -m http.server "$PORT"
elif command -v python >/dev/null 2>&1; then
  exec python -m http.server "$PORT"
else
  echo "Error: python3 is not installed. Install Python 3 or run any static server in this folder." >&2
  exit 1
fi
