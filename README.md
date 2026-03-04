# claude-imprint

Claude Code commands that let Claude imprint on *your* development style.

Like imprinting in the animal world — where a newborn learns from its parent — Claude learns from you. Your corrections, your preferences, your patterns. Everything is local to your machine. Over time, Claude stops feeling like a generic tool and starts working like a partner that knows how you think.

Every Claude Code session starts from scratch. No matter how many times you correct the same behavior, the next session doesn't know about it. You can hardcode rules into CLAUDE.md, but that requires you to notice your own patterns, articulate them precisely, and maintain them as they evolve. Most of what makes someone effective with Claude isn't a rule you'd think to write down — it's the accumulation of small corrections and preferences over dozens of sessions.

claude-imprint flips that. Instead of you writing the rules, Claude observes how you work and proposes the entries. Your memory evolves through use rather than upfront authoring, and gets maintained automatically instead of going stale.

Two developers using the same commands end up with completely different memory files, because the whole point is learning what's specific to each person.

## Commands

### `/remember`

Run this at the end of a session (or anytime). Claude reviews what happened — corrections you made, preferences you expressed, patterns that emerged — and proposes entries for the right memory file. It filters out anything project-specific and only keeps transferable patterns. You approve before anything gets written.

Over time, Claude stops repeating the same mistakes and starts matching how *you* specifically work:

- "Present options with trade-offs rather than picking silently"
- "Always grep for the OLD pattern after bulk replacement to verify nothing was missed"
- "Phase-by-phase commits at each boundary, never in bulk"

### `/reflect`

Periodic health check on your working memory. Claude reads everything it's learned about you, summarizes it as a narrative, and audits for problems — stale entries, contradictions, redundancy, entries too vague to actually change behavior. It also checks the current session for mistakes Claude made *despite* having a memory about it, and proposes sharper rewrites.

### `/distill`

Cross-references working memory across all your machines. If you use Claude Code on a laptop and a desktop, each builds memory independently. Distill snapshots your local memory to a private repo, pulls from your other machines, and finds the patterns that show up everywhere. It promotes universals on your approval and seeds new machines with your evolved patterns.

**First run:** Creates a private `imprinted-memories` repo via `gh` CLI. After that, it's a single command.

**Requires:** `gh` CLI authenticated with GitHub.

### Nudging (built into CLAUDE.md)
All three skills work best when used regularly. The included CLAUDE.md snippet tells Claude to:
- Suggest `/remember` at the end of sessions where corrections were made or new patterns emerged
- Suggest `/reflect` when memory files haven't been reviewed in 7+ days
- Suggest `/distill` when working on a new machine or 30+ days since last sync
- Never run any silently — always ask first

## Install (first time)

```bash
git clone git@github.com:rybaier/claude-imprint.git ~/dev/claude-imprint
cd ~/dev/claude-imprint
./install.sh
```

This does four things:
1. **Symlinks commands** into `~/.claude/commands/` so they're available as slash commands
2. **Copies working memory templates** into `~/.claude/working-memory/` (your personal data, never overwritten)
3. **Seeds from universal patterns** if you have an `imprinted-memories` repo from another machine
4. **Asks to append CLAUDE.md snippet** that wires up memory reading and session nudging

## Update (getting new skills)

When new skills are added to the repo:

```bash
cd ~/dev/claude-imprint
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
commands/reflect.md   →  /reflect
commands/distill.md   →  /distill
```

## How it works

Claude Code loads any `.md` file in `~/.claude/commands/` as a custom slash command. The file contents become the prompt Claude follows when you invoke it. That's it — no plugins, no config, just markdown.

Working memory lives in `~/.claude/working-memory/` as plain markdown files that get injected into Claude's system prompt. Everything stays on your machine — nothing is sent to a server, nothing trains a model. It's just local markdown files that shape how Claude works with you.
