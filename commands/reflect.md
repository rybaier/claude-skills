Review working memory files and provide a health check on the accumulated learnings.

## Process

1. **Read all working memory files**:
   - `~/.claude/working-memory/profile.md`
   - `~/.claude/working-memory/collaboration-patterns.md`
   - `~/.claude/working-memory/boundaries.md`
   - `~/.claude/working-memory/tools.md` (if it exists)
   - `~/.claude/working-memory/anti-patterns.md` (if it exists)
   - `~/.claude/working-memory/team/team-patterns.md` (if it exists)

2. **Generate a summary** of what Claude has learned about the user. Write this as a
   short narrative (not just repeating the bullets back). Frame it as: "Here's what I've
   learned about how you work." This should feel like a useful mirror, not a recitation.

3. **Check freshness** using each file's metadata comments:
   - `<!-- last-reviewed: YYYY-MM-DD -->` — flag if older than 7 days or still a
     `YYYY-MM-DD` placeholder (meaning never reviewed)
   - `<!-- last-remember: YYYY-MM-DD -->` — note when the last learning was captured
   - `<!-- remember-count-since-reflect: N -->` in `~/.claude/CLAUDE.md` — flag if N >= 5
     (meaning 5+ /remember runs since last /reflect)

4. **Detect issues** across all files:
   - **Stale entries**: Patterns that haven't been reinforced recently or that contradict
     recent session behavior
   - **Contradictions**: Entries that conflict with each other across or within files
   - **Redundancy**: Multiple entries that say the same thing differently — propose merging
     into one clean entry
   - **Vague entries**: Entries too generic to change behavior (e.g., "write clean code") —
     propose sharpening or removing
   - **Gaps**: Sections with few or no entries that could benefit from attention

5. **Effectiveness check** (if in an active session with history):
   Review the current session for moments where Claude repeated a mistake already captured
   in memory. If found, flag the entry as ineffective and propose a rewrite that would
   actually prevent the mistake.

5b. **Effectiveness ratio** (if stats comments exist):
    Compare correction counts against entries flagged as ineffective (step 5). If a file
    has high corrections but entries keep getting flagged as ineffective, note that the
    file may need a rewrite pass rather than incremental additions. If corrections are
    low but many sessions have passed, suggest the user may be under-using /remember.

6. **Upward extraction check**:
   Scan project-level memory files (if accessible) for patterns that appear across multiple
   projects. Suggest promoting these to global working memory.

7. **Present findings** in this format:

   ### Summary
   (Narrative of what Claude has learned)

   ### Health
   - **Entries**: X total across Y files
   - **Corrections captured**: N total (breakdown per file from `<!-- stats: -->` comments)
   - **Tracking since**: earliest `since` date across files, or "not yet tracked"
   - **Last reviewed**: (date per file, or "never")
   - **Last remembered**: (date per file from `<!-- last-remember: -->`)
   - **Remember runs since last reflect**: N (from `<!-- remember-count-since-reflect: -->`)
   - **Freshness**: (ok / stale / needs attention)

   ### Proposed Changes
   For each proposed change:
   - **Action**: merge / remove / sharpen / add / promote
   - **File**: which file
   - **Current**: the existing entry (if applicable)
   - **Proposed**: the new version
   - **Reason**: why this change improves the memory

8. **Wait for approval** before making any changes.

9. After approval, apply the changes and update the `<!-- last-reviewed: YYYY-MM-DD -->`
   comment at the top of each reviewed file to today's date.

9b. Reset `<!-- remember-count-since-reflect: N -->` to 0 in `~/.claude/CLAUDE.md`.
