#!/bin/bash

echo "Checking vibe-coding plugin activation..."
echo ""

# Check if plugin directory exists
if [ -d "$HOME/.claude/plugins/marketplaces/cp-vibe-coding" ]; then
    echo "✓ Plugin installed at: $HOME/.claude/plugins/marketplaces/cp-vibe-coding"
else
    echo "✗ Plugin NOT installed"
    echo "  Run: /plugin install github:aimonk2025/cp-vibecoding-plugin"
    exit 1
fi

# Check for required files
echo ""
echo "Checking required files:"

files=(
    ".claude-plugin/plugin.json"
    "skills/vibe-coding/SKILL.md"
    "commands/reverse-engineer.md"
    "commands/ideate.md"
    "commands/build.md"
)

for file in "${files[@]}"; do
    if [ -f "$HOME/.claude/plugins/marketplaces/cp-vibe-coding/$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ✗ $file (MISSING)"
    fi
done

echo ""
echo "If all files are present but plugin still not working:"
echo "1. Restart Claude Code"
echo "2. Run: /plugin reload vibe-coding"
echo "3. Try direct command: /reverse-engineer"
