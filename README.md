# claude-imprint

Persistent working memory for Claude Code. Claude learns how you work and remembers it across sessions.

## Before / After

**Without claude-imprint** — every session starts from zero:

```
You: [finishes a big refactor across 4 files]
Claude: I'll commit all the changes now.
         git commit -m "Refactor authentication system"
You: No — commit phase by phase, one commit per logical boundary.
Claude: Got it, splitting into separate commits.

[next session]
You: [finishes another refactor]
Claude: I'll commit all the changes now.
```

**With claude-imprint** — Claude reads your memory at session start:

```
You: [finishes a big refactor across 4 files]
Claude: I'll commit this phase by phase at each logical boundary.
         git commit -m "Extract auth middleware into separate module"
         git commit -m "Update routes to use new middleware"
         git commit -m "Remove legacy auth helpers"
```

Every correction you make can become permanent. Instead of you writing rules, Claude observes how you work and proposes entries. Your memory evolves through use and gets maintained automatically instead of going stale — like imprinting in the animal world, where a newborn learns from its parent.

## How it works

Claude Code loads `.md` files from `~/.claude/commands/` as slash commands, and injects `~/.claude/CLAUDE.md` into every session. claude-imprint uses these two mechanisms to give Claude persistent memory. No plugins, no runtime, no dependencies — just markdown files.

```
~/.claude/
├── commands/
│   ├── remember.md      # /remember command
│   ├── reflect.md       # /reflect command
│   └── distill.md       # /distill command
├── working-memory/
│   ├── profile.md            # How you work
│   ├── collaboration-patterns.md  # How you and Claude work together
│   └── boundaries.md         # What stays separate
└── CLAUDE.md                  # Loads working memory + session nudging
```

**Everything stays local.** Working memory is plain markdown on your machine. Nothing is sent to a server. Nothing trains a model.

## Install

Requires [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and `git`.

```bash
git clone https://github.com/rybaier/claude-imprint.git && cd claude-imprint && ./install.sh
```

This does four things:

1. **Symlinks commands** into `~/.claude/commands/` so they're available as slash commands
2. **Copies working memory templates** into `~/.claude/working-memory/` (your personal data, never overwritten)
3. **Seeds from universal patterns** if you have an `imprinted-memories` repo from another machine
4. **Asks to append a CLAUDE.md snippet** that wires up memory reading and session nudging

## Commands

### Start here: `/remember`

Run at the end of a session (or anytime). Claude reviews what happened — corrections you made, preferences you expressed, patterns that emerged — and proposes entries for the right memory file. It filters out anything project-specific and only keeps transferable patterns. You approve before anything gets written.

Example output:

```
Proposed update:
  File: ~/.claude/working-memory/profile.md
  Section: Git & commits
  Addition: "Phase-by-phase commits — commit at each logical boundary, never in bulk"

Apply this entry? (y/n)
```

### After a few weeks: `/reflect`

Periodic health check on your working memory. Claude reads everything it's learned about you, summarizes it as a narrative, and audits for problems — stale entries, contradictions, redundancy, entries too vague to actually change behavior. It proposes sharper rewrites and flags entries that didn't prevent mistakes they should have.

### When you use multiple machines: `/distill`

Cross-references working memory across machines. If you use Claude Code on a laptop and a desktop, each builds memory independently. Distill snapshots your local memory to a private GitHub repo, pulls from your other machines, and promotes patterns that show up everywhere. It seeds new machines with your evolved patterns. Requires [`gh` CLI](https://cli.github.com/) authenticated with GitHub.

### Nudging

The CLAUDE.md snippet tells Claude to suggest the right command at the right time — `/remember` when corrections happen, `/reflect` when memory goes stale, `/distill` on new machines. It never runs anything silently; it always asks first.

## What memory looks like

After a few weeks of use, your `profile.md` might contain entries like:

```markdown
## Git & commits
- Phase-by-phase commits — commit at each logical boundary, never in bulk
- Write commit messages that explain *why*, not *what*

## Communication style
- Detailed summaries — never close anything with just "Done"
- Present options with trade-offs at decision points rather than picking one silently

## Workflow
- Checkpoint-driven: stop and present findings at key junctures before proceeding
- Always grep for the OLD pattern after bulk replacement to verify nothing was missed
```

Two developers using the same commands end up with completely different memory files.

## Update

When new commands are added to the repo:

```bash
cd claude-imprint && ./update.sh
```

This pulls the latest, links any new commands, and **never** touches your working memory files or CLAUDE.md.

## Adding your own commands

Drop a `.md` file in `commands/` and re-run `./update.sh`. The filename (minus `.md`) becomes the slash command:

```
commands/my-workflow.md  →  /my-workflow
```

## FAQ

**Does this replace CLAUDE.md?**
No. CLAUDE.md is for project-specific rules and instructions that apply to everyone on a project. Working memory is personal — how *you* specifically work, across all projects.

**Can I edit memory files directly?**
Yes. They're plain markdown. Edit them anytime — the commands are just a convenience for discovering and maintaining entries.

**What if Claude proposes a bad memory entry?**
You approve everything before it's written. `/remember` and `/reflect` always present proposals and wait for your sign-off.

**Does this work with Claude on the web?**
No. claude-imprint requires the Claude Code CLI, which supports custom slash commands and CLAUDE.md injection.

## License

MIT
