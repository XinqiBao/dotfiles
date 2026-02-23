#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Installing Claude Code configuration..."

# Backup existing CLAUDE.md if it exists and is not a symlink
if [ -f "$CLAUDE_DIR/CLAUDE.md" ] && [ ! -L "$CLAUDE_DIR/CLAUDE.md" ]; then
    echo "Backing up existing CLAUDE.md to CLAUDE.md.bak"
    cp "$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.bak"
fi

# Symlink CLAUDE.md
ln -sf "$SCRIPT_DIR/claude/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "  ✓ CLAUDE.md"

# Symlink commands
mkdir -p "$CLAUDE_DIR/commands"
for cmd in "$SCRIPT_DIR"/claude/commands/xdev-*.md; do
    [ -f "$cmd" ] || continue
    ln -sf "$cmd" "$CLAUDE_DIR/commands/$(basename "$cmd")"
    echo "  ✓ commands/$(basename "$cmd")"
done

echo "Done. Claude Code xdev workflow installed."
