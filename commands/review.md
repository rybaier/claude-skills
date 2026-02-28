Review working memory files and provide a health check on the accumulated learnings.

## Process

1. **Read all working memory files**:
   - `~/.claude/working-memory/profile.md`
   - `~/.claude/working-memory/collaboration-patterns.md`
   - `~/.claude/working-memory/boundaries.md`

2. **Generate a summary** of what Claude has learned about the user. Write this as a
   short narrative (not just repeating the bullets back). Frame it as: "Here's what I've
   learned about how you work." This should feel like a useful mirror, not a recitation.

3. **Check freshness**: Look at the `<!-- last-reviewed: YYYY-MM-DD -->` comment at the
   top of each file. Flag any file not reviewed in 14+ days.

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

6. **Upward extraction check**:
   Scan project-level memory files (if accessible) for patterns that appear across multiple
   projects. Suggest promoting these to global working memory.

7. **Present findings** in this format:

   ### Summary
   (Narrative of what Claude has learned)

   ### Health
   - **Entries**: X total across Y files
   - **Last reviewed**: (date per file, or "never")
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
   comment at the top of each reviewed file.
