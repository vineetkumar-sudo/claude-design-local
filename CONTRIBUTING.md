# Contributing

Two things land here: improvements to the plugin itself, and new design systems.

## Adding a design system

The fastest path is to let Claude do it. With the plugin installed, run:

```
/new-design-system
```

Answer the interview questions. Claude writes `design-systems/<slug>/{tokens.css, tailwind-bridge.js, README.md}` for you. Then:

```
git checkout -b add-<slug>-design-system
git add design-systems/<slug>
git commit -m "Add <slug> design system"
git push origin add-<slug>-design-system
```

Open a PR. Reviewers eyeball the README (does the brand voice read clearly?), spot-check a prototype against it (`./scripts/new-prototype.sh review-<slug> <slug> && cd review-<slug> && ./serve.sh`), and merge.

## Plugin changes

For changes to the starter, the skills, or the scripts, the loop is:

1. Open this repo in Claude Code.
2. Make the change.
3. Smoke-test by spinning up a fresh prototype and confirming nothing regressed: `./scripts/new-prototype.sh smoke polymath && cd smoke && ./serve.sh`.
4. Bump version in `.claude-plugin/plugin.json` if the change is user-facing.
5. PR.

## Reviewing design-system PRs — checklist

- `tokens.css` has both `:root` (light) and `.dark` blocks defined.
- All semantic tokens are present: `--background`, `--foreground`, `--card`, `--card-foreground`, `--popover`, `--popover-foreground`, `--primary`, `--primary-foreground`, `--secondary`, `--secondary-foreground`, `--muted`, `--muted-foreground`, `--accent`, `--accent-foreground`, `--border`, `--ring`, `--radius`.
- `tailwind-bridge.js` maps every variable that should be a utility class.
- `README.md` describes the brand voice, lists the families, and gives at least one usage example.
- A test prototype renders without console errors and the dark toggle flips correctly.

## Filing issues

Bug? Idea? Open an issue. Include: macOS / Linux version, `claude --version`, what you ran, what you expected, what happened.
