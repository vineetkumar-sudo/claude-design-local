# claude-design-local

A Claude Code plugin that reproduces the core experience of Anthropic's hosted "Claude Design" research preview — locally, against **any design system you want**, with no weekly credit cap.

You install it once, then any teammate can scaffold a new themed prototype in seconds, iterate with Claude Code, and view the result live in their browser. You can also define new design systems on the fly — either through a guided conversation with Claude, or by importing an existing stylesheet, palette, or website.

## What it does

Claude Design's loop is: pick a design system, prompt for a UI, get a themed HTML prototype back, iterate via chat. This plugin gives you the same loop, with these moving parts:

- **`design-systems/`** is the home for every system the plugin knows about. Each subfolder is one system (Polymath ships by default). The folder name is the system's slug. The contract — what files must exist — is documented in `design-systems/README.md`.
- **`templates/prototype-starter/`** is the generic seed of every new prototype: `index.html`, `serve.sh`, a per-project `CLAUDE.md`, and an empty `design-system/` folder that gets populated when you scaffold a project.
- **`skills/design-system/SKILL.md`** activates whenever a project contains `design-system/tokens.css` and teaches Claude the universal rules — read the system's README first, use semantic tokens not hex, rotate brand families across lists, persist state, ship dark mode.
- **`skills/design-system-author/SKILL.md`** activates when the user wants to create a new design system; supports both guided-interview and import-from-source flows.
- **`commands/`** ships two slash commands: `/new-prototype` and `/new-design-system`.
- **`scripts/`** ships the matching shell scripts so the workflow also works outside Claude Code.

What you give up vs. hosted Claude Design: no in-canvas "Tweaks" knobs panel, no comment-pin annotations, no shared multi-user editing. What you gain: unlimited iteration speed, unlimited design systems, full filesystem access, and your existing Claude Code workflow.

## Quick start

```bash
git clone https://github.com/vineetkumar-sudo/claude-design-local ~/.claude/plugins/claude-design-local
```

Restart Claude Code. That's it — the two skills (`design-system`, `design-system-author`) and two slash commands (`/new-prototype`, `/new-design-system`) are now available everywhere.

Prerequisites: `claude` (Claude Code CLI), `python3` (any 3.x), `git`.

## Install — other options

### Option A — clone, then symlink (preferred if you also want to edit the plugin)

```bash
git clone https://github.com/vineetkumar-sudo/claude-design-local ~/dev/claude-design-local
ln -s ~/dev/claude-design-local ~/.claude/plugins/claude-design-local
```

This keeps the source somewhere you'll work in, and the symlink registers it with Claude Code.

### Option B — Claude Code plugin install flow

If your version of Claude Code exposes a marketplace/install flow that takes a Git URL, point it at `https://github.com/vineetkumar-sudo/claude-design-local`. The manifest at `.claude-plugin/plugin.json` is what it reads.

### Staying up to date

```bash
cd ~/.claude/plugins/claude-design-local
git pull
```

New design systems other teammates have added land here automatically.

### Verify

After install, restart Claude Code, then confirm with `/skills` (look for `design-system` and `design-system-author`) and `/` (look for `new-prototype` and `new-design-system` in the command palette).

## Starting a new prototype

In Claude Code:

```
/new-prototype my-app polymath
```

Or from a shell:

```bash
~/.claude/plugins/claude-design-local/scripts/new-prototype.sh my-app polymath
```

Either invocation copies the starter to `my-app/` and drops the chosen system's files into `my-app/design-system/`. Then:

```bash
cd my-app
./serve.sh           # in one terminal — http://localhost:8000
claude               # in another terminal, from this folder
```

Now prompt away — "build me a habit tracker", "add a dashboard with three charts", "make the cards more playful". Claude reads `CLAUDE.md` and the `design-system` skill on entry, edits `index.html` (or creates new files), and you reload `localhost:8000` to see the change.

## Creating a new design system — guided

If you want a fresh brand from scratch, in Claude Code:

```
/new-design-system
```

Claude will interview you in one batch: brand name (→ slug), vibe, primary color and accents, brand families (Polymath's six or your own set), font, light/dark preference, default radius. Then it generates `design-systems/<slug>/{tokens.css, tailwind-bridge.js, README.md}` matching the contract.

Use it immediately:

```
/new-prototype my-app <slug>
```

## Creating a new design system — import

When you already have a stylesheet, palette, or live site:

```
/new-design-system from path/to/your-styles.css
/new-design-system from path/to/palette.json
/new-design-system from https://your-product.com
/new-design-system from path/to/screenshot.png
```

Claude parses the source, maps it onto the contract's semantic names (primary, background, card, accent, ...), fills in family variants and dark-mode flips, shows you the result, and writes the files after you confirm.

## Currently shipped systems

- **`polymath`** — Polymath Design System. Six brand families (purple, amber, blue, emerald, pink, teal), Mulish body, light-first with full dark mode. Warm, rounded, slightly playful.

To inspect the contract every system must satisfy, see [`design-systems/README.md`](design-systems/README.md). To contribute one, see [`CONTRIBUTING.md`](CONTRIBUTING.md).

## Folder layout

```
claude-design-local/
  README.md                          # this file
  .claude-plugin/
    plugin.json                      # plugin manifest
  design-systems/
    README.md                        # the design-system contract
    polymath/                        # one shipped system
      tokens.css
      tailwind-bridge.js
      README.md
  skills/
    design-system/SKILL.md           # how Claude uses a system in a project
    design-system-author/SKILL.md    # how Claude creates a new system
  commands/
    new-prototype.md
    new-design-system.md
  scripts/
    new-prototype.sh                 # copy starter + wire chosen system
    new-design-system.sh             # scaffold empty system folder
  templates/
    prototype-starter/               # generic starter — no system baked in
      CLAUDE.md
      index.html
      serve.sh
      design-system/                 # populated at copy time
        .gitkeep
```

## Limitations vs. hosted Claude Design

- **No live Tweaks panel.** Hosted Claude Design has a slide-out panel of theme knobs (colors, radius, typography) that re-themes the canvas in real time. Here, ask Claude in chat — "swap primary to emerald-vivid" — and it'll edit `tokens.css` directly.
- **No comment pins.** You can't drop a pin on an element and write a note. Use a regular Claude Code message: "the hero button feels small, bump padding".
- **No multi-user collab.** Each teammate runs their own copy on their own machine.
- **No file-history UI.** Versioning is whatever you set up — `git init` your prototype folder and commit between iterations.

In exchange, you get unbounded iteration speed, the full Claude Code toolbelt (file globs, bash, MCP), unlimited design systems, and direct access to your repo.

Maintained by the Polymathai engineering team. MIT-licensed — see [`LICENSE`](LICENSE).
