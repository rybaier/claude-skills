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

3. Filter out anything project-specific (endpoints, architecture details, sprint numbers).
   Only capture transferable patterns.

4. Present the proposed updates to the user in this format:
   **File**: `~/.claude/working-memory/<file>.md`
   **Section**: <which section>
   **Addition**: <the concise entry to add>

5. Wait for approval before writing anything.

6. After approval, use the Edit tool to add the entry to the appropriate file.
   Keep entries concise — one to two lines each. If an existing entry covers the
   same ground, update it rather than adding a duplicate.

   If a learning is categorized as **tools** or **anti-pattern** but the target file
   doesn't exist yet, create it from the template structure (with the appropriate
   headings and metadata comments) before adding the entry.

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
