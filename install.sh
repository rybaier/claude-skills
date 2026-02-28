#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Installing claude-skills..."

# Install commands (symlink so git pull = instant updates)
mkdir -p "$CLAUDE_DIR/commands"
for cmd in "$SCRIPT_DIR/commands/"*.md; do
  name="$(basename "$cmd")"
  if [ -e "$CLAUDE_DIR/commands/$name" ]; then
    echo "  Skipping commands/$name (already exists — remove it first to overwrite)"
  else
    ln -s "$cmd" "$CLAUDE_DIR/commands/$name"
    echo "  Linked commands/$name"
  fi
done

# Set up working memory from templates (copy, not symlink — these are personal)
mkdir -p "$CLAUDE_DIR/working-memory"
for tpl in "$SCRIPT_DIR/working-memory/templates/"*.md; do
  name="$(basename "$tpl")"
  if [ -e "$CLAUDE_DIR/working-memory/$name" ]; then
    echo "  Skipping working-memory/$name (already exists — your data is safe)"
  else
    cp "$tpl" "$CLAUDE_DIR/working-memory/$name"
    echo "  Created working-memory/$name from template"
  fi
done

# Install CLAUDE.md snippet (ask first, append if approved)
SNIPPET="$SCRIPT_DIR/claude-md-snippet.md"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
if [ -f "$CLAUDE_MD" ] && grep -q "Session Nudging" "$CLAUDE_MD" 2>/dev/null; then
  echo "  Skipping CLAUDE.md snippet (already installed)"
else
  echo ""
  read -p "Add working memory directives to ~/.claude/CLAUDE.md? (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "" >> "$CLAUDE_MD"
    cat "$SNIPPET" >> "$CLAUDE_MD"
    echo "  Added working memory snippet to CLAUDE.md"
  else
    echo "  Skipped. You can add it manually later: cat claude-md-snippet.md >> ~/.claude/CLAUDE.md"
  fi
fi

echo ""
echo "Done! Available commands:"
for cmd in "$CLAUDE_DIR/commands/"*.md; do
  echo "  /$(basename "$cmd" .md)"
done
echo ""
echo "Working memory files are in ~/.claude/working-memory/"
echo "Run /remember at the end of sessions to build up your profile."
echo "Run /review periodically to keep your memory fresh and accurate."
