Reflect on the current session and identify learnings worth preserving in working memory.

## Process

1. Review what happened in this session — corrections made, preferences expressed,
   patterns that emerged, workflow decisions.

2. For each candidate learning, categorize it:
   - **style**: A working style preference or approach -> `profile.md`
   - **collaboration**: Something about how we work together -> `collaboration-patterns.md`
   - **boundary**: A separation rule or context concern -> `boundaries.md`
   - **tools**: A tool preference, CLI flag, editor setting, or environment preference -> `tools.md`
   - **anti-pattern**: A mistake that happened, a footgun, a pattern to avoid -> `anti-patterns.md`
   - **team**: A team-wide convention or standard (not personal preference) -> `team/team-patterns.md`

   If a pattern could be personal or team-wide, ask: "Is this your personal preference
   or a team convention?"

3. For each candidate learning, decide:
   - **Transferable patterns** (how you work, not what the project is) -> global memory files
   - **Project-specific context** (architecture, conventions, gotchas for this repo) -> skip these;
     Claude's built-in auto memory handles project-specific context automatically
   Only filter out truly ephemeral details (sprint numbers, temporary workarounds).

4. Present the proposed updates to the user in this format:
   **File**: `~/.claude/working-memory/<file>.md`
   **Section**: <which section>
   **Addition**: <the concise entry to add>

5. Wait for approval before writing anything.

6. After approval, use the Edit tool to add the entry to the appropriate file.
   Keep entries concise — one to two lines each. If an existing entry covers the
   same ground, update it rather than adding a duplicate.

   If a learning is categorized as **tools**, **anti-pattern**, or **team** but
   the target file doesn't exist yet, create it from the template structure (with the
   appropriate headings and metadata comments) before adding the entry. Create the
   target directory if needed (`team/`).

7. After writing entries, update the metadata comments at the top of each file
   that received a new entry:
   - Find `<!-- stats: corrections=N, since=DATE -->` and increment N by the number
     of entries added to that file
   - If `since=YYYY-MM-DD` (literal placeholder), replace with today's date
   - If the stats comment doesn't exist, add it after the first heading:
     `<!-- stats: corrections=1, since={today} -->`
   - Update `<!-- last-imprint: YYYY-MM-DD -->` to today's date in each modified file
     (add it after the stats comment if missing)
   - In `~/.claude/CLAUDE.md`, find `<!-- imprint-count-since-reflect: N -->` and
     increment N by 1. If the comment doesn't exist, add it at the end of the
     Working Memory section (or end of file):
     `<!-- imprint-count-since-reflect: 1 -->`

8. **Session log entry**: Prepend a summary to `~/.claude/working-memory/session-log.md`.
   If the file doesn't exist, create it with the header from the template.

   Format (prepend after the `<!-- Entries will be prepended below this line -->` marker):
   ```
   ## YYYY-MM-DD | {project} | {one-line summary of session activity}

   - Key learning or decision 1
   - Key learning or decision 2
   ```

   - Date: today's date (YYYY-MM-DD)
   - Project: extracted from `git remote get-url origin` as `{owner}/{repo}`,
     or "general" if not in a git repo
   - Summary: one-line description of the session's main activity
   - Details: 2-3 bullet points of key learnings or decisions (derived from the
     entries just written, or from session activity if no entries were written)
   - Increment `<!-- entry-count: N -->` at the top of the file by 1
   - This step does not require separate approval — it's a factual log entry,
     not an opinionated memory entry
