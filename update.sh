#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Updating claude-imprint..."
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

# Copy any new working memory templates (never overwrite existing)
TEMPLATES_ADDED=0
for tpl in "$SCRIPT_DIR/working-memory/templates/"*.md; do
  name="$(basename "$tpl")"
  if [ -e "$CLAUDE_DIR/working-memory/$name" ]; then
    continue
  else
    cp "$tpl" "$CLAUDE_DIR/working-memory/$name"
    echo "  NEW: working-memory/$name"
    TEMPLATES_ADDED=$((TEMPLATES_ADDED + 1))
  fi
done

if [ "$TEMPLATES_ADDED" -gt 0 ]; then
  echo "  $TEMPLATES_ADDED new working memory template(s) installed"
else
  echo "  No new working memory templates"
fi

# Check for new tracking features
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
if [ -f "$CLAUDE_MD" ] && ! grep -q "remember-count-since-reflect" "$CLAUDE_MD" 2>/dev/null; then
  echo ""
  echo "  New: session nudging now tracks /remember runs."
  echo "  Add this to your CLAUDE.md (in the Working Memory section):"
  echo "    <!-- remember-count-since-reflect: 0 -->"
  echo ""
  echo "  /remember and /reflect will manage it automatically."
fi

# Never touch existing working memory files — those are personal data
# Never touch CLAUDE.md — that was a one-time install step

echo ""
echo "Available commands:"
for cmd in "$CLAUDE_DIR/commands/"*.md; do
  echo "  /$(basename "$cmd" .md)"
done
echo ""
echo "Working memory and CLAUDE.md were not modified."
echo "To re-run full setup (e.g., on a new machine), use ./install.sh instead."
