#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Updating claude-skills..."
echo ""

# Pull latest
git -C "$SCRIPT_DIR" pull --ff-only 2>/dev/null && echo "  Pulled latest from remote" || echo "  (no remote changes or not a git repo)"
echo ""

# Link any new commands — never touch existing ones
ADDED=0
for cmd in "$SCRIPT_DIR/commands/"*.md; do
  name="$(basename "$cmd")"
  if [ -e "$CLAUDE_DIR/commands/$name" ]; then
    # Already exists (symlink or user's own file) — don't touch it
    continue
  else
    ln -s "$cmd" "$CLAUDE_DIR/commands/$name"
    echo "  NEW: /$(basename "$name" .md)"
    ADDED=$((ADDED + 1))
  fi
done

if [ "$ADDED" -eq 0 ]; then
  echo "  No new commands to install"
fi

# Never touch working memory files — those are personal data
# Never touch CLAUDE.md — that was a one-time install step

echo ""
echo "Available commands:"
for cmd in "$CLAUDE_DIR/commands/"*.md; do
  echo "  /$(basename "$cmd" .md)"
done
echo ""
echo "Working memory and CLAUDE.md were not modified."
echo "To re-run full setup (e.g., on a new machine), use ./install.sh instead."
