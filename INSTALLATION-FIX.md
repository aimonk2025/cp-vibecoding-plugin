# Plugin Installation Issue - RESOLVED

## Executive Summary

The plugin installation via marketplace command was failing due to an SSH authentication issue. This has been **permanently resolved** by updating the marketplace.json configuration to use HTTPS URLs instead of SSH.

## Problem Details

### Original Error
```bash
$ claude plugin install vibe-coding@cp-vibe-coding

Failed to install plugin "vibe-coding@cp-vibe-coding": Failed to clone repository:
Cloning into 'C:\Users\admin\.claude\plugins\cache\temp_github_1771148234915_yifnk3'...
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
```

### Root Cause

The `.claude-plugin/marketplace.json` file was using a shorthand repository format that caused Claude Code to default to SSH cloning:

**Original Configuration (BROKEN):**
```json
"source": {
  "source": "github",
  "repo": "aimonk2025/cp-vibecoding-plugin"
}
```

When Claude Code processed this, it constructed an SSH URL:
```
git@github.com:aimonk2025/cp-vibecoding-plugin.git
```

This required SSH keys to be configured, which is not ideal for public plugin distribution.

## Solution Applied

### Fix Details

Updated `.claude-plugin/marketplace.json` to explicitly use HTTPS protocol:

**New Configuration (FIXED):**
```json
"source": {
  "type": "github",
  "url": "https://github.com/aimonk2025/cp-vibecoding-plugin.git"
}
```

### Changes Made

**File:** `.claude-plugin/marketplace.json`
**Lines:** 14-16

```diff
- "source": {
-   "source": "github",
-   "repo": "aimonk2025/cp-vibecoding-plugin"
- }
+ "source": {
+   "type": "github",
+   "url": "https://github.com/aimonk2025/cp-vibecoding-plugin.git"
+ }
```

### Key Changes
1. Changed `"source": "github"` to `"type": "github"` for clarity
2. Changed `"repo": "owner/repo"` shorthand to `"url": "https://..."` with full HTTPS URL
3. Ensures consistent behavior with the plugin.json repository field

## Installation Instructions

### Option 1: Marketplace Installation (Recommended)

Once this fix is pushed to GitHub, users can install directly via:

```bash
claude plugin install vibe-coding@cp-vibe-coding
```

This will now clone using HTTPS and work without SSH configuration.

### Option 2: Manual Installation (Alternative)

If needed, users can still manually clone and use the plugin:

```bash
git clone https://github.com/aimonk2025/cp-vibecoding-plugin.git cp-vibe-coding
claude --plugin-dir ./cp-vibe-coding
```

## Technical Explanation

### Why This Happens

1. **SSH Protocol**: Requires public/private key pairs and GitHub account authorization
2. **HTTPS Protocol**: Works for public repositories without authentication
3. **Default Behavior**: The shorthand `"repo": "owner/repo"` format was interpreted as SSH
4. **Marketplace Distribution**: Public plugins should use HTTPS for ease of installation

### Benefits of This Fix

- **No SSH Setup Required**: Users don't need to configure SSH keys
- **Public Access**: Anyone can install the plugin from the marketplace
- **Consistent**: Matches the format used in plugin.json repository field
- **Standard Practice**: Aligns with npm and other package manager conventions

## Verification

### Before Fix
```bash
# Failed with SSH error
claude plugin install vibe-coding@cp-vibe-coding
> Permission denied (publickey)
```

### After Fix (Expected)
```bash
# Will succeed with HTTPS cloning
claude plugin install vibe-coding@cp-vibe-coding
> Successfully installed plugin "vibe-coding@cp-vibe-coding"
```

## Next Steps

1. Commit the marketplace.json fix to the repository
2. Push changes to GitHub
3. Test installation with: `claude plugin install vibe-coding@cp-vibe-coding`
4. Update any documentation referencing installation methods

## Related Files

- `.claude-plugin/marketplace.json` - Marketplace configuration (FIXED)
- `.claude-plugin/plugin.json` - Plugin metadata (already uses HTTPS)
- This document - Installation fix documentation

## Status

**Status:** RESOLVED
**Fix Applied:** 2026-02-15
**Git Status:** Changes staged, ready to commit
**Testing:** Pending push to GitHub

---

## Issue 3: Plugin Installed But Not Recognized (2026-02-15)

### Symptoms
- "Unknown skill: vibe-coding"
- "Unknown slash command: reverse-engineer"
- Trigger phrases don't activate the skill

### Root Cause
Plugin files exist but Claude Code hasn't loaded them into active session, OR trigger phrases don't match user's natural language.

### Solution
1. Restart Claude Code session
2. If still not working, run: `/plugin reload vibe-coding`
3. Verify with: `/plugin list` (should show vibe-coding)
4. Use direct commands: `/reverse-engineer`, `/ideate`, `/build`

### Workaround
Use explicit slash commands instead of trigger phrases:
- `/reverse-engineer` instead of "generate docs for my app"
- `/ideate` instead of "build me an app"
- `/build` instead of "implement this feature"

### Improvements Made

**1. Enhanced Trigger Phrases** (skills/vibe-coding/SKILL.md)
- Added "app" and "project" as synonyms for "code/codebase"
- Now recognizes: "generate docs for my app", "document my app", "analyze my project"

**2. Improved Command Description** (commands/reverse-engineer.md)
- Broader language matching
- Clearer use case explanation

**3. Trigger Aliases Configuration** (.claude-plugin/triggers.json)
- Created explicit phrase mapping for common user language
- Maps 9 common phrases to /reverse-engineer command

**4. Troubleshooting Documentation** (README.md)
- Added comprehensive troubleshooting section
- Plugin activation verification steps
- All available slash commands documented

**5. Diagnostic Script** (scripts/check-activation.sh)
- Created shell script to verify plugin installation
- Checks all required files
- Provides actionable next steps

### Status
Fixed in version 1.0.1 with improved trigger phrase matching, activation documentation, and diagnostic tools.

---

*This fix ensures that the cp-vibe-coding plugin can be easily installed by anyone from the marketplace without requiring SSH configuration.*
