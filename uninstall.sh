#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Uninstalling claude-imprint..."
echo ""

# Remove command symlinks that point back to this repo
REMOVED=0
for cmd in "$SCRIPT_DIR/commands/"*.md; do
  name="$(basename "$cmd")"
  target="$CLAUDE_DIR/commands/$name"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$cmd" ]; then
    rm "$target"
    echo "  Removed commands/$name"
    REMOVED=$((REMOVED + 1))
  fi
done
if [ "$REMOVED" -eq 0 ]; then
  echo "  No command symlinks to remove"
fi

# Remove CLAUDE.md snippet if present
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
if [ -f "$CLAUDE_MD" ] && grep -q "BEGIN claude-imprint" "$CLAUDE_MD" 2>/dev/null; then
  echo ""
  read -p "Remove claude-imprint snippet from ~/.claude/CLAUDE.md? (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Remove everything between BEGIN and END markers (inclusive)
    # Use a temp file for cross-platform compatibility (macOS + Linux)
    tmp="$(mktemp)"
    awk '/<!-- BEGIN claude-imprint -->/{skip=1} /<!-- END claude-imprint -->/{skip=0; next} !skip' "$CLAUDE_MD" > "$tmp"
    # Clean up trailing blank lines
    sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$tmp" > "$CLAUDE_MD"
    rm -f "$tmp"
    echo "  Removed snippet from CLAUDE.md"
  else
    echo "  Skipped. You can remove it manually — look for the <!-- BEGIN claude-imprint --> block."
  fi
fi

# Ask about working memory files
if [ -d "$CLAUDE_DIR/working-memory" ]; then
  echo ""
  echo "  Working memory files contain your personal data:"
  for f in "$CLAUDE_DIR/working-memory/"*.md; do
    [ -f "$f" ] && echo "    $(basename "$f")"
  done
  if [ -d "$CLAUDE_DIR/working-memory/team" ]; then
    echo "  Team patterns:"
    for f in "$CLAUDE_DIR/working-memory/team/"*.md; do
      [ -f "$f" ] && echo "    team/$(basename "$f")"
    done
  fi
  if [ -d "$CLAUDE_DIR/working-memory/projects" ]; then
    for pdir in "$CLAUDE_DIR/working-memory/projects"/*/; do
      [ -d "$pdir" ] || continue
      echo "  Project overlay: $(basename "$pdir")"
      for f in "$pdir"*.md; do
        [ -f "$f" ] && echo "    $(basename "$pdir")/$(basename "$f")"
      done
    done
  fi
  echo ""
  read -p "Delete working memory files? This cannot be undone. (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -f "$CLAUDE_DIR/working-memory/"*.md
    if [ -d "$CLAUDE_DIR/working-memory/team" ]; then
      rm -f "$CLAUDE_DIR/working-memory/team/"*.md
      rmdir "$CLAUDE_DIR/working-memory/team" 2>/dev/null || true
    fi
    if [ -d "$CLAUDE_DIR/working-memory/projects" ]; then
      for pdir in "$CLAUDE_DIR/working-memory/projects"/*/; do
        [ -d "$pdir" ] || continue
        rm -f "$pdir"*.md
        rmdir "$pdir" 2>/dev/null || true
      done
      rmdir "$CLAUDE_DIR/working-memory/projects" 2>/dev/null || true
    fi
    rmdir "$CLAUDE_DIR/working-memory" 2>/dev/null || true
    echo "  Deleted working memory files"
  else
    echo "  Kept working memory files in ~/.claude/working-memory/"
  fi
fi

echo ""
echo "Done. claude-imprint has been uninstalled."
