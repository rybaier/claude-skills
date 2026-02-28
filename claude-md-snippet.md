## Working Memory

Claude maintains a working memory of your development style and collaboration patterns.
These files are located in `~/.claude/working-memory/` and should be consulted at the
start of meaningful work sessions.

### Required Reading
At the start of sessions involving significant work (not quick one-off questions), read:
- `~/.claude/working-memory/profile.md` — Working style and preferences
- `~/.claude/working-memory/collaboration-patterns.md` — What works in our pairing
- `~/.claude/working-memory/boundaries.md` — Work vs personal separation rules

### Proactive Update Protocol
When any of the following happen during a session, suggest updating working memory
(ask before writing — never silently update):
- A correction to an assumption or approach
- A new workflow preference emerges
- A collaboration pattern proves effective or ineffective
- An explicit request to remember something

Updates go to the appropriate file:
- Style/preference → `profile.md`
- Collaboration insight → `collaboration-patterns.md`
- Separation rule → `boundaries.md`

### Session Nudging
At the end of meaningful sessions (not quick one-off questions), evaluate whether to
suggest `/remember` or `/review`:

**Suggest `/remember`** when any of these occurred during the session:
- A correction to an assumption or approach
- A new workflow preference emerged
- A collaboration pattern proved effective or ineffective
- A mistake was made that should be avoided in the future

**Suggest `/review`** when:
- Any working memory file has a `<!-- last-reviewed: -->` date older than 7 days
- There have been 5+ `/remember` runs since the last `/review`
- The user asks about what Claude has learned or how memory works

Never run either skill silently. Always ask first.

### Separation Rules
- Working memory captures HOW you work — patterns, preferences, style
- NEVER store project-specific details (endpoints, secrets, architecture, team info)
- Project details belong in project-level memories only
- When unsure whether something is a pattern vs a project detail, ask
