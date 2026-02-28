# claude-skills

Custom Claude Code slash commands that teach Claude how *you* personally work.

Everything here is local to your machine. These skills build a persistent profile of your individual development style — how you plan, how you commit, what mistakes to avoid, how you prefer to collaborate. Claude loads this profile at the start of every session, so over time it stops feeling like a generic tool and starts working like a partner that knows your preferences.

Two developers using the same skills will end up with completely different memory files, because the whole point is learning what's specific to each person.

## What's in here

### `/remember`
Run this at the end of a session (or anytime). Claude reflects on the conversation and identifies learnings worth saving — your working style, collaboration patterns, mistakes to avoid. These get written to local markdown files that load into Claude's system prompt next session.

Over time, Claude stops repeating the same mistakes and starts matching how *you* specifically work. Every developer's memory ends up completely different.

**What it captures (examples):**
- Collaboration patterns: "Present options with trade-offs rather than picking silently"
- Mistakes to avoid: "Always grep for the OLD pattern after bulk replacement to verify nothing was missed"
- Execution style: "Phase-by-phase commits at each boundary, never in bulk"

**What it filters out:**
- Project-specific details (endpoints, secrets, architecture)
- Anything non-transferable across projects

### `/review`
Periodic health check on your working memory. Run it when you want to see what Claude has learned, or let Claude suggest it when your memory files are getting stale.

**What it does:**
- Summarizes what Claude has learned about you as a readable narrative
- Flags stale, contradictory, or redundant entries and proposes cleanup
- Identifies vague entries that aren't specific enough to change behavior
- Checks for patterns repeated across projects that should be promoted to global memory
- Reviews the current session for mistakes Claude made despite having a memory about it — and proposes sharper rewrites
- Tracks freshness so your memory evolves instead of accumulating dead weight

### Nudging (built into CLAUDE.md)
Both skills work best when used regularly. The included CLAUDE.md snippet tells Claude to:
- Suggest `/remember` at the end of sessions where corrections were made or new patterns emerged
- Suggest `/review` when memory files haven't been reviewed in 7+ days
- Never run either silently — always ask first

## Install (first time)

```bash
git clone git@github.com:rybaier/claude-skills.git ~/dev/claude-skills
cd ~/dev/claude-skills
./install.sh
```

This does three things:
1. **Symlinks commands** into `~/.claude/commands/` so they're available as slash commands
2. **Copies working memory templates** into `~/.claude/working-memory/` (your personal data, never overwritten)
3. **Asks to append CLAUDE.md snippet** that wires up memory reading and session nudging

## Update (getting new skills)

When new skills are added to the repo:

```bash
cd ~/dev/claude-skills
./update.sh
```

This is safe to run anytime. It will:
- Pull the latest from the repo
- Link any **new** commands that don't exist yet
- **Never** touch your working memory files
- **Never** touch your CLAUDE.md

## Adding your own skills

Drop a `.md` file in `commands/` and re-run `./update.sh`. The file name becomes the slash command:

```
commands/remember.md  →  /remember
commands/review.md    →  /review
```

## How it works

Claude Code loads any `.md` file in `~/.claude/commands/` as a custom slash command. The file contents become the prompt Claude follows when you invoke it. That's it — no plugins, no config, just markdown.

Working memory lives in `~/.claude/working-memory/` as plain markdown files that get injected into Claude's system prompt. Everything stays on your machine — nothing is sent to a server, nothing trains a model. It's just local markdown files that shape how Claude works with you.
