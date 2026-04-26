<!-- BEGIN claude-imprint -->
## Working Memory

Claude maintains a working memory of the user's development style and collaboration patterns.
These files are located in `~/.claude/working-memory/` and should be consulted at the
start of meaningful work sessions.

### Required Reading
At the start of sessions involving significant work (not quick one-off questions), read:
- `~/.claude/working-memory/profile.md` — Working style and preferences
- `~/.claude/working-memory/collaboration-patterns.md` — What works in pairing with this user
- `~/.claude/working-memory/boundaries.md` — Work vs personal separation rules
- `~/.claude/working-memory/tools.md` — Preferred tools and environment (if it exists)
- `~/.claude/working-memory/anti-patterns.md` — Mistakes to avoid (if it exists)

### Proactive Update Protocol
When any of the following happen during a session, suggest updating working memory
(ask before writing — never silently update):
- The user corrects an assumption or approach
- A new workflow preference emerges
- A collaboration pattern proves effective or ineffective
- The user explicitly asks to remember something

Updates go to the appropriate file:
- Style/preference -> `profile.md`
- Collaboration insight -> `collaboration-patterns.md`
- Separation rule -> `boundaries.md`
- Tool/environment preference -> `tools.md`
- Mistake/anti-pattern -> `anti-patterns.md`

### Session Nudging
At the end of meaningful sessions (not quick one-off questions), evaluate whether to
suggest `/remember` or `/reflect`:

**Suggest `/remember`** when any of these occurred during the session:
- The user corrected an assumption or approach
- A new workflow preference emerged
- A collaboration pattern proved effective or ineffective
- A mistake was made that should be avoided in the future
- A tool preference or environment detail was established

**Suggest `/reflect`** when:
- Any working memory file has a `<!-- last-reviewed: -->` date older than 7 days
  (or still a `YYYY-MM-DD` placeholder, meaning it has never been reviewed)
- The `<!-- remember-count-since-reflect: N -->` comment shows N >= 5
  (meaning 5+ /remember runs since the last /reflect)
- The user asks about what Claude has learned or how memory works

**Suggest `/distill`** when:
- The user mentions working on another machine or syncing preferences
- claude-imprint is freshly installed on a new machine
- It has been 30+ days since the last distill (check `~/.claude/imprinted-memories/machines/{hostname}/.snapshot-date`)
- The user asks about differences between how Claude works on different machines

Never run any command silently. Always ask the user first.

### First-Session Onboarding
If `~/.claude/working-memory/profile.md` has no `<!-- onboarding-complete: -->` comment
and contains only template placeholders (lines starting with `<!-- e.g.,`), suggest:
"Want to run `/teach` to set up your preferences quickly? Or just start working and
use `/remember` to build memory organically." Only suggest this once per session.

### Separation Rules
- Working memory captures HOW the user works — patterns, preferences, style
- NEVER store project-specific details (endpoints, secrets, architecture, team info)
- Project details belong in project-level memories only
- When unsure whether something is a pattern vs a project detail, ask the user

<!-- remember-count-since-reflect: 0 -->
<!-- END claude-imprint -->
