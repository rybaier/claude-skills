#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Installing claude-imprint..."
echo ""

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
mkdir -p "$CLAUDE_DIR/working-memory/projects"
for tpl in "$SCRIPT_DIR/working-memory/templates/"*.md; do
  name="$(basename "$tpl")"
  if [ -e "$CLAUDE_DIR/working-memory/$name" ]; then
    echo "  Skipping working-memory/$name (already exists — your data is safe)"
  else
    cp "$tpl" "$CLAUDE_DIR/working-memory/$name"
    echo "  Created working-memory/$name from template"
  fi
done

# Ask about team usage
echo ""
echo "claude-imprint supports team-wide convention tracking."
echo "Team patterns are shared across team members via /distill and"
echo "capture things like branch naming, PR requirements, and deploy process."
echo ""
read -p "Will you be using claude-imprint with a team? (y/n) " -n 1 -r
echo ""

TEAM_INSTALL=false
if [[ $REPLY =~ ^[Yy]$ ]]; then
  TEAM_INSTALL=true
  mkdir -p "$CLAUDE_DIR/working-memory/team"
  for tpl in "$SCRIPT_DIR/working-memory/templates/team/"*.md; do
    [ -f "$tpl" ] || continue
    name="$(basename "$tpl")"
    if [ -e "$CLAUDE_DIR/working-memory/team/$name" ]; then
      echo "  Skipping working-memory/team/$name (already exists)"
    else
      cp "$tpl" "$CLAUDE_DIR/working-memory/team/$name"
      echo "  Created working-memory/team/$name from template"
    fi
  done
else
  echo "  Skipped team setup. Run ./install.sh again if you change your mind."
fi

# Seed from universal patterns if imprinted-memories exists
if [ -d "$HOME/.claude/imprinted-memories/universal" ]; then
  echo ""
  echo "Found universal memory patterns from other machines."
  read -p "Seed working memory from universal patterns? (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    for ufile in "$HOME/.claude/imprinted-memories/universal/"*.md; do
      [ -f "$ufile" ] || continue
      name="$(basename "$ufile")"
      if [ -e "$CLAUDE_DIR/working-memory/$name" ]; then
        echo "  Note: working-memory/$name already exists — run /distill to merge"
      else
        cp "$ufile" "$CLAUDE_DIR/working-memory/$name"
        echo "  Seeded working-memory/$name from universal patterns"
      fi
    done
  else
    echo "  Skipped. Run /distill later to merge universal patterns."
  fi
fi

# Seed from team patterns if imprinted-memories has them (only if team install)
if [ "$TEAM_INSTALL" = true ] && [ -d "$HOME/.claude/imprinted-memories/team" ]; then
  echo ""
  echo "Found team patterns from imprinted-memories."
  read -p "Seed team memory from shared patterns? (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    for tfile in "$HOME/.claude/imprinted-memories/team/"*.md; do
      [ -f "$tfile" ] || continue
      name="$(basename "$tfile")"
      if [ -e "$CLAUDE_DIR/working-memory/team/$name" ]; then
        echo "  Note: team/$name already exists — run /distill to merge"
      else
        cp "$tfile" "$CLAUDE_DIR/working-memory/team/$name"
        echo "  Seeded team/$name from shared patterns"
      fi
    done
  fi
fi

# Install CLAUDE.md snippet (ask first, append if approved)
SNIPPET="$SCRIPT_DIR/claude-md-snippet.md"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
if [ -f "$CLAUDE_MD" ] && grep -q "BEGIN claude-imprint" "$CLAUDE_MD" 2>/dev/null; then
  echo "  Skipping CLAUDE.md snippet (already installed)"
else
  echo ""
  read -p "Add working memory directives to ~/.claude/CLAUDE.md? (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "$CLAUDE_MD" ]; then
      echo "" >> "$CLAUDE_MD"
    fi
    cat "$SNIPPET" >> "$CLAUDE_MD"
    echo "  Added working memory snippet to CLAUDE.md"
  else
    echo "  Skipped. You can add it manually later: cat claude-md-snippet.md >> ~/.claude/CLAUDE.md"
  fi
fi

# Check for gh CLI (optional, only needed for /distill)
if ! command -v gh &>/dev/null; then
  echo ""
  echo "  Note: gh CLI not found. Install it (https://cli.github.com/) if you want"
  echo "  to use /distill for cross-machine memory sync."
fi

echo ""
echo "Done! Available commands:"
for cmd in "$CLAUDE_DIR/commands/"*.md; do
  echo "  /$(basename "$cmd" .md)"
done
echo ""
echo "Working memory files are in ~/.claude/working-memory/"
if [ "$TEAM_INSTALL" = true ]; then
  echo "Team patterns are in ~/.claude/working-memory/team/"
fi
echo ""
echo "Run /remember at the end of sessions to build up your profile."
echo "Run /reflect periodically to keep your memory fresh and accurate."
echo "Run /distill to sync working memory across machines."
if [ "$TEAM_INSTALL" = true ]; then
  echo "Run /distill to share team patterns with teammates."
fi
