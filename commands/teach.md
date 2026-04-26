Guided preference setup for claude-imprint. Builds initial working memory through conversation.

## Pre-Check

1. Read `~/.claude/working-memory/profile.md`
2. If `<!-- onboarding-complete: YYYY-MM-DD -->` exists with a real date (not the literal
   placeholder), inform the user: "You completed onboarding on {date}. Running /teach
   again will propose additional entries — nothing existing gets removed. Continue?"
3. If profile.md has substantial entries (more than 3 non-comment, non-heading lines),
   note: "You already have working memory entries. /teach will propose additions based on
   your answers — nothing existing gets removed."

## Questionnaire

Walk through each round conversationally. After each round, pause and present proposed
entries before moving on. Don't dump all questions at once — this is a conversation.

### Round 1: Planning & Execution
Ask about:
- Approach preference: "When starting a complex task, do you prefer I (a) dive in and
  show you a working draft, (b) outline 2-3 approaches with trade-offs first, or
  (c) ask clarifying questions before doing anything?"
- Commit granularity: "For commits, do you prefer (a) one commit per logical change,
  (b) squash everything into one, or (c) commit frequently even for WIP?"
- Checkpoint style: "When a plan has multiple steps, should I (a) execute all steps and
  show the result, (b) pause at each step for approval, or (c) pause only at major
  decision points?"

### Round 2: Communication
Ask about:
- Summary detail level: "After completing a task, how detailed should my summary be?
  (a) Just 'Done' is fine, (b) brief summary of what changed, (c) detailed summary
  with reasoning"
- Uncertainty handling: "When I'm unsure about something, should I (a) make my best
  guess and note the assumption, (b) always ask before proceeding, or (c) depends on
  the stakes — guess on low-risk, ask on high-risk?"

### Round 3: Code Style
Ask about:
- Code conventions: "Any strong opinions on code style? For example: function length,
  comments, naming, composition vs inheritance, DRY vs explicit..."
- Testing philosophy: "Testing approach: (a) test everything, (b) test critical paths,
  (c) test as you go, or something else?"
- Tool preferences: "Any preferred tools, CLI utilities, or environment setup?"

### Round 4: Collaboration
Ask about:
- Pet peeves: "Any pet peeves about how AI assistants work? Things you've seen that
  drive you crazy?"
- Common mistakes: "What's the most common mistake AI assistants make when working
  with you?"

Adapt as you go — if an answer to one question implies an answer to another, skip the
redundant question. If an answer is vague ("I like clean code"), ask a follow-up to
get something specific and actionable.

## Processing

After each round (or all rounds if the user prefers):

1. Convert answers into concrete, actionable memory entries — each entry should be
   specific enough to change Claude's behavior (not "write clean code" but "keep
   functions under 30 lines, extract early if growing")

2. Present in standard /imprint format:
   **File**: `~/.claude/working-memory/<file>.md`
   **Section**: <which section>
   **Entry**: <concise, actionable entry — 1-2 lines>

3. Wait for approval before writing anything.

4. Use the Edit tool to add approved entries to the appropriate file. If an existing
   entry covers the same ground, update it rather than adding a duplicate.

5. Update `<!-- stats: corrections=N, since=DATE -->` in each modified file (increment
   N, set since to today if it's a placeholder).

6. After all rounds are complete, add `<!-- onboarding-complete: YYYY-MM-DD -->` (with
   today's date) to the top of profile.md, after the metadata comments.
