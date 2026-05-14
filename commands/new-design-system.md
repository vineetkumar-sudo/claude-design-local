---
name: new-design-system
description: Create a new design system under the plugin's design-systems/ folder, either via guided conversation or by importing from an existing CSS file, palette, URL, or screenshot.
argument-hint: [from <path-or-url>]
---

# /new-design-system

Add a new entry to the plugin's `design-systems/` folder.

## Usage

Guided (Flow A) — interview-driven, you answer questions, Claude generates:
```
/new-design-system
```

Import (Flow B) — Claude reverse-engineers from an existing source:
```
/new-design-system from path/to/styles.css
/new-design-system from path/to/palette.json
/new-design-system from https://your-product.com
/new-design-system from path/to/screenshot.png
```

## What Claude should do

1. Load `skills/design-system-author/SKILL.md` and follow it. That skill defines both flows in detail.
2. Open `design-systems/polymath/tokens.css`, `design-systems/polymath/tailwind-bridge.js`, and `design-systems/polymath/README.md` first — they are the reference shape for every system in this plugin.
3. If the user invoked `/new-design-system from <source>`, run Flow B: parse the source, map to the contract, confirm with the user, then write files.
4. If the user invoked `/new-design-system` with no args, run Flow A: ask the interview questions in one batch, infer color variants and dark-mode flips, then write files.
5. Before writing, you may run `./scripts/new-design-system.sh <slug>` to scaffold a folder with empty placeholder files — or just write the three files directly under `design-systems/<slug>/`.
6. After writing, print:
   ```
   Created: design-systems/<slug>/
   Next:    ./scripts/new-prototype.sh my-app <slug>
   ```

## The contract

Every design system must satisfy `design-systems/README.md`. Don't ship a system that's missing `tokens.css`, `tailwind-bridge.js`, or `README.md`, and don't ship one without the `.dark { ... }` override block.
