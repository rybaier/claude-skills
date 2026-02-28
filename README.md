# claude-skills

Personal collection of custom Claude Code slash commands for building a persistent working relationship with Claude.

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

## Install

```bash
git clone git@github.com:rybaier/claude-skills.git ~/dev/claude-skills
cd ~/dev/claude-skills
chmod +x install.sh
./install.sh
```

Commands are **symlinked** so `git pull` gives you new skills instantly.
Working memory templates are **copied** so your personal data is never overwritten.

## Adding new skills

Drop a `.md` file in `commands/` and re-run `install.sh`. The file name becomes the slash command:

```
commands/remember.md  →  /remember
commands/review.md    →  /review
```

## How it works

Claude Code loads any `.md` file in `~/.claude/commands/` as a custom slash command. The file contents become the prompt Claude follows when you invoke it. That's it — no plugins, no config, just markdown.

Working memory lives in `~/.claude/working-memory/` as plain markdown files that get injected into Claude's system prompt. Everything is local to your machine.
