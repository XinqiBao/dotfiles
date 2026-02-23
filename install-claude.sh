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

# Install xdev plugin from devloop marketplace
# Plugin includes: skills (xdev-implement, xdev-draft, xdev-setup)
#                  hooks (commit validation, sensitive file protection)
echo ""
echo "Installing xdev plugin..."
if command -v claude &>/dev/null; then
    claude plugin marketplace add XinqiBao/devloop 2>/dev/null || true
    claude plugin install xdev@devloop 2>/dev/null || true
    echo "  ✓ xdev@devloop plugin (skills + hooks)"
else
    echo "  ⚠ claude CLI not found, skipping plugin install"
fi

echo ""
echo "Done. Claude Code xdev workflow installed."
