# Migration Guide: Plugin to Skills

This guide helps you migrate from the vibe-coding plugin to the new skills architecture.

## Overview

The vibe-coding project has been redesigned from a monolithic plugin to a modular skills-based architecture. All functionality is preserved while improving composability and following Claude Skills best practices.

## What Changed

### Architecture

**Before (Plugin):**
```
.claude-plugin/
  plugin.json
  marketplace.json
  triggers.json
commands/
  ideate.md
  document.md
  build.md
  [6 more commands]
hooks/
  hooks.json
skills/
  vibe-coding/
    SKILL.md (11KB monolithic file)
```

**After (Skills):**
```
skills/
  vibe-coding-orchestrator/
  vibe-coding-ideate/
  vibe-coding-document/
  vibe-coding-build/
  vibe-coding-debug/
  vibe-coding-ship/
  vibe-coding-reverse-engineer/
references/ (shared knowledge base)
```

### Command Changes

**Slash Commands → Natural Language**

| Old Plugin | New Skills |
|------------|------------|
| `/vibe-coding:ideate` | "let's ideate" or "plan features" |
| `/vibe-coding:document` | "generate docs" or "create PRD" |
| `/vibe-coding:build` | "let's build" or "start coding" |
| `/vibe-coding:reverse-engineer` | "generate docs from my code" |
| `/vibe-coding:status` | "show status" or "where am I?" |
| `/vibe-coding:show PRD` | "show PRD" or "display PRD" |
| `/vibe-coding:fast-track` | "skip the questions" or "fast mode" |
| `/vibe-coding:import-prd` | "I have a PRD" or "use this spec" |

### Progress Tracking Changes

**Before (Automatic Hooks):**
- `hooks/hooks.json` auto-saved progress.txt
- Automatic after every Write operation

**After (Explicit Checkpoints):**
- Skills explicitly update progress.txt at checkpoints
- More reliable and transparent
- No hidden behavior

### State Management

**Compatible!** Your existing `progress.txt` files work with the new skills architecture. The file format is unchanged.

```
VIBE CODING PROGRESS
====================
CURRENT STATE:
phase: [PHASE]
step: [STEP]
next_action: [ACTION]
active_skill: vibe-coding-[phase]  ← NEW field
```

The new `active_skill` field helps the orchestrator route to the correct skill when resuming.

## Migration Steps

### Step 1: Backup Your Work

```bash
# Backup your existing progress files
cp progress.txt progress.txt.backup

# Optional: Backup plugin directory
cp -r ~/.claude/plugins/marketplaces/cp-vibe-coding ~/vibe-coding-plugin-backup
```

### Step 2: Install New Skills

```bash
# Clone the new skills repository
git clone https://github.com/aimonk2025/cp-vibe-coding.git
cd cp-vibe-coding

# Copy skills to Claude skills directory
cp -r skills/* ~/.claude/skills/

# Windows:
# xcopy /E /I skills\* %USERPROFILE%\.claude\skills\
```

### Step 3: Verify Installation

```bash
# Check skills are installed
ls ~/.claude/skills/vibe-coding-orchestrator
ls ~/.claude/skills/vibe-coding-ideate
ls ~/.claude/skills/vibe-coding-document
# ... etc

# Windows:
# dir %USERPROFILE%\.claude\skills\vibe-coding-orchestrator
```

### Step 4: Test Skills

Open Claude and try:

```
You: show status

Claude: [Should show your current progress if progress.txt exists]
```

```
You: continue

Claude: [Should resume from where you left off]
```

### Step 5: Remove Old Plugin (Optional)

Once you've verified the skills work:

```bash
# Remove old plugin
rm -rf ~/.claude/plugins/marketplaces/cp-vibe-coding

# Windows:
# rmdir /S %USERPROFILE%\.claude\plugins\marketplaces\cp-vibe-coding
```

## Compatibility Matrix

| Feature | Plugin | Skills | Compatible? |
|---------|--------|--------|-------------|
| progress.txt format | ✅ | ✅ | ✅ Yes |
| IDEATE phase | ✅ | ✅ | ✅ Yes |
| DOCUMENT phase | ✅ | ✅ | ✅ Yes |
| BUILD phase | ✅ | ✅ | ✅ Yes |
| DEBUG phase | ✅ | ✅ | ✅ Yes |
| SHIP phase | ✅ | ✅ | ✅ Yes |
| REVERSE-ENGINEER | ✅ | ✅ | ✅ Yes |
| Auto-detection | ✅ | ✅ | ✅ Yes |
| Session resume | ✅ | ✅ | ✅ Yes |
| Fast-track mode | ✅ | ✅ | ✅ Yes |
| PRD import | ✅ | ✅ | ✅ Yes |
| Slash commands | ✅ | ❌ | ⚠️ Use natural language |
| Hooks auto-save | ✅ | ❌ | ⚠️ Explicit checkpoints |

## Common Migration Issues

### Issue 1: Skills Not Activating

**Problem:** You say "let's ideate" but nothing happens.

**Solution:**
1. Verify skills are installed:
   ```bash
   ls ~/.claude/skills/vibe-coding-*
   ```
2. Restart Claude or reload skills
3. Try more explicit phrases:
   - "I want to build an app"
   - "generate docs from my code"

### Issue 2: Context Not Transferring

**Problem:** You say "continue" but Claude doesn't resume.

**Solution:**
1. Check progress.txt exists in your project directory
2. Add `active_skill` field if missing:
   ```
   CURRENT STATE:
   phase: IDEATE
   active_skill: vibe-coding-ideate
   ```
3. Try: "continue where we left off"

### Issue 3: Missing Slash Commands

**Problem:** `/vibe-coding:ideate` doesn't work anymore.

**Solution:** Use natural language instead:
- Old: `/vibe-coding:ideate`
- New: "let's ideate"

### Issue 4: Progress Not Saving

**Problem:** Your progress isn't being saved automatically.

**Solution:** This is expected! Skills now save at explicit checkpoints:
- After each question-answer exchange (IDEATE)
- After each document (DOCUMENT)
- After each feature (BUILD)

If you need to save manually, say: "save progress"

## Feature Improvements

### New in Skills Architecture

1. **Modularity**
   - Each phase is an independent skill
   - Install only what you need
   - Easier to maintain and update

2. **Natural Language**
   - No need to remember slash commands
   - Just describe what you want
   - More intuitive user experience

3. **Better Context Handoff**
   - Hybrid approach (progress.txt + orchestrator)
   - Explicit skill activation
   - Clearer state transitions

4. **Composability**
   - Skills work standalone or together
   - Can be used with other Claude skills
   - Follows official skills standards

## Rollback Instructions

If you need to rollback to the plugin:

### Step 1: Remove Skills

```bash
rm -rf ~/.claude/skills/vibe-coding-*
```

### Step 2: Reinstall Plugin

```bash
# Restore from backup
cp -r ~/vibe-coding-plugin-backup ~/.claude/plugins/marketplaces/cp-vibe-coding

# Or reinstall from GitHub
cd ~/.claude/plugins/marketplaces
git clone https://github.com/aimonk2025/cp-vibe-coding.git
cd cp-vibe-coding
git checkout backup-plugin-architecture
```

### Step 3: Restart Claude

Your old slash commands will work again.

## Getting Help

**Issues with migration?**
- [GitHub Issues](https://github.com/aimonk2025/cp-vibe-coding/issues)
- [GitHub Discussions](https://github.com/aimonk2025/cp-vibe-coding/discussions)

**Need clarification?**
- Post in Discussions with the `migration` tag
- Include your Claude version and OS

## FAQ

### Q: Do I need to delete the old plugin?

**A:** No, but recommended once you verify the skills work. They won't conflict, but having both is redundant.

### Q: Will my existing progress.txt files work?

**A:** Yes! The format is compatible. The orchestrator will add the `active_skill` field if missing.

### Q: Can I use both plugin and skills?

**A:** Technically yes, but not recommended. Choose one approach to avoid confusion.

### Q: What if I'm mid-workflow?

**A:** Finish your current phase with the plugin, then migrate. Or add `active_skill` to your progress.txt and continue with skills.

### Q: Do I need all 7 skills?

**A:** At minimum, install:
- vibe-coding-orchestrator (required for routing)
- vibe-coding-ideate (if starting new projects)
- vibe-coding-reverse-engineer (if documenting existing code)

Install others as needed.

### Q: Can I customize the skills?

**A:** Yes! Fork the repository and modify the SKILL.md files. Skills are just markdown files with YAML frontmatter.

### Q: Will there be updates to the plugin?

**A:** The plugin is deprecated in favor of the skills architecture. All future updates will be to the skills version.

## Timeline

- **Before Feb 2026:** Plugin architecture (deprecated)
- **Feb 2026:** Skills architecture released
- **March 2026+:** Skills only (plugin unsupported)

## Summary

**Migration is smooth:**
- ✅ progress.txt files compatible
- ✅ All features preserved
- ✅ Better architecture
- ✅ Natural language is more intuitive
- ✅ Can rollback if needed

**Recommended approach:**
1. Install skills alongside plugin
2. Test with a small project
3. Once confident, remove plugin
4. Enjoy cleaner, modular skills!
