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
   - **project**: A project-specific pattern, convention, or gotcha -> `projects/{owner}--{repo}/patterns.md`

   If a pattern could be personal or team-wide, ask: "Is this your personal preference
   or a team convention?"

2b. **Detect the current project** (for project-specific routing):
    - Run `git remote get-url origin 2>/dev/null` to get the remote URL
    - Extract `{owner}/{repo}` from the URL (strip `.git` suffix, protocol, and host)
    - Sanitize to `{owner}--{repo}` (double-dash separator) for the directory name
    - If no remote, fall back to `basename` of the git root directory
    - If not in a git repo, skip project routing entirely

3. For each candidate learning, decide:
   - **Transferable patterns** (how you work, not what the project is) -> global memory files
   - **Project-specific patterns** (architecture, conventions, gotchas for this repo) -> project overlay
   Only filter out truly ephemeral details (sprint numbers, temporary workarounds).

4. Present the proposed updates to the user in this format:
   **File**: `~/.claude/working-memory/<file>.md`
   **Section**: <which section>
   **Addition**: <the concise entry to add>

5. Wait for approval before writing anything.

6. After approval, use the Edit tool to add the entry to the appropriate file.
   Keep entries concise — one to two lines each. If an existing entry covers the
   same ground, update it rather than adding a duplicate.

   If a learning is categorized as **tools**, **anti-pattern**, **team**, or **project** but
   the target file doesn't exist yet, create it from the template structure (with the
   appropriate headings and metadata comments) before adding the entry. Create the
   target directory if needed (`team/` or `projects/{owner}--{repo}/`). For project
   overlays, replace `{owner}/{repo}` in the `<!-- project: -->` comment with the
   actual project identifier.

7. After writing entries, update the metadata comments at the top of each file
   that received a new entry:
   - Find `<!-- stats: corrections=N, since=DATE -->` and increment N by the number
     of entries added to that file
   - If `since=YYYY-MM-DD` (literal placeholder), replace with today's date
   - If the stats comment doesn't exist, add it after the first heading:
     `<!-- stats: corrections=1, since={today} -->`
   - Update `<!-- last-remember: YYYY-MM-DD -->` to today's date in each modified file
     (add it after the stats comment if missing)
   - In `~/.claude/CLAUDE.md`, find `<!-- remember-count-since-reflect: N -->` and
     increment N by 1. If the comment doesn't exist, add it at the end of the
     Working Memory section (or end of file):
     `<!-- remember-count-since-reflect: 1 -->`
