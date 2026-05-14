---
name: new-prototype
description: Scaffold a new themed prototype folder by copying the starter and wiring in a chosen design system.
argument-hint: <project-name> <system-slug>
---

# /new-prototype

Create a new prototype folder in the current directory, pre-wired with the design system you choose.

## Usage

```
/new-prototype <project-name> <system-slug>
```

- `<project-name>` — the folder name for the new prototype (e.g. `habit-tracker`).
- `<system-slug>` — the design system to use; must match a folder under the plugin's `design-systems/` (e.g. `polymath`).

## What Claude should do

1. Run the plugin's scaffold script with the user's arguments:
   ```bash
   "${CLAUDE_PLUGIN_ROOT}/scripts/new-prototype.sh" <project-name> <system-slug>
   ```
   If `$CLAUDE_PLUGIN_ROOT` isn't set in your shell context, resolve the plugin root from this command file's path (its grandparent directory).
2. If the script errors with "unknown system slug", list available systems via `ls "${CLAUDE_PLUGIN_ROOT}/design-systems"` and ask the user to pick one.
3. After it succeeds, remind the user of the next steps the script printed:
   - `cd <project-name>`
   - `./serve.sh` in one terminal
   - `claude` in another terminal, from the same folder

## Resulting folder

```
<project-name>/
  CLAUDE.md
  index.html
  serve.sh
  design-system/
    tokens.css
    tailwind-bridge.js
    README.md
    (assets/ if the system shipped any)
```

The design-system folder is a **copy** — edits inside the project don't bleed into the plugin's canonical system. Push changes back to `design-systems/<slug>/` only when you intend them to be canonical.
