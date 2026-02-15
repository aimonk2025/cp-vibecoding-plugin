---
description: Display a specific generated document (e.g., /vibe-coding:show PRD)
---

# Show Document Command

Display the contents of a generated documentation file.

## Instructions

The user will provide a document name as `$ARGUMENTS`.

### Step 1: Parse Document Name

Extract document name from `$ARGUMENTS`:
- "PRD" → PRD.md
- "APP_FLOW" or "APP FLOW" → APP_FLOW.md
- "TECH_STACK" or "TECH STACK" → TECH_STACK.md
- "DESIGN_SYSTEM" or "DESIGN SYSTEM" → DESIGN_SYSTEM.md
- "BACKEND_STRUCTURE" or "BACKEND STRUCTURE" → BACKEND_STRUCTURE.md
- "FRONTEND_GUIDELINES" or "FRONTEND GUIDELINES" → FRONTEND_GUIDELINES.md
- "IMPLEMENTATION_PLAN" or "IMPLEMENTATION PLAN" → IMPLEMENTATION_PLAN.md
- "CLAUDE" → CLAUDE.md

Case-insensitive matching.

### Step 2: Locate Document

Check common locations:
1. `./docs/[DOC_NAME].md`
2. `./[DOC_NAME].md`
3. `./.vibe-coding/[DOC_NAME].md`

### Step 3: Display Document

If found:
```
[DOCUMENT NAME]
===============
Location: [file path]
Last Modified: [timestamp]
Size: [file size]

[DOCUMENT CONTENTS]

===============
End of [DOCUMENT NAME]

Commands:
- "/vibe-coding:status" - View overall progress
- Type "revise [section]" to update this document
```

If NOT found:
```
DOCUMENT NOT FOUND: [requested name]

This document hasn't been generated yet.

Generated documents:
[List files found in docs/ directory]

Current phase: [check progress.txt]

Options:
1. Type "continue" to generate remaining documents
2. "/vibe-coding:status" to see overall progress
3. Start DOCUMENT phase if not started yet
```

### Step 4: Handle Missing Arguments

If `$ARGUMENTS` is empty:
```
SHOW DOCUMENT COMMAND

Usage: /vibe-coding:show [document name]

Available documents:
1. PRD - Product Requirements Document
2. APP_FLOW - User Journeys and Screen Flows
3. TECH_STACK - Technologies and Versions
4. DESIGN_SYSTEM - Colors, Typography, Components
5. BACKEND_STRUCTURE - Database and API Structure
6. FRONTEND_GUIDELINES - Component Patterns
7. IMPLEMENTATION_PLAN - Step-by-Step Build Guide
8. CLAUDE - Project-Specific Claude Rules

Example: /vibe-coding:show PRD
```

## Smart Features

### Summary Mode

If document is very long (>2000 lines), offer summary:
```
[DOCUMENT NAME] is very long ([X] lines)

Options:
1. "show all" - Display entire document
2. "show summary" - Display section headings only
3. "show [section name]" - Display specific section

What would you like?
```

### Section Display

If user requests specific section:
```
[DOCUMENT NAME] - [SECTION NAME]
================================

[Section contents]

================================

Other sections in this document:
- [Section 1]
- [Section 2]
[...]

Type "show [section name]" to view another section
```

## Examples

**Example 1: Show PRD**
```
User: /vibe-coding:show PRD

Claude:
PRD.md
======
Location: docs/PRD.md
Last Modified: 2025-02-15 14:30
Size: 12.5 KB

# Product Requirements Document

## Executive Summary
[Content...]

## Problem Statement
[Content...]

[...rest of document...]
```

**Example 2: Document Not Generated Yet**
```
User: /vibe-coding:show DESIGN_SYSTEM

Claude:
DOCUMENT NOT FOUND: DESIGN_SYSTEM.md

This document hasn't been generated yet.

Current phase: DOCUMENT (3/8 complete)

Generated so far:
✓ PRD.md
✓ APP_FLOW.md
✓ TECH_STACK.md

Next to generate: DESIGN_SYSTEM.md

Type "continue" to generate it now.
```

**Example 3: No Arguments**
```
User: /vibe-coding:show

Claude:
SHOW DOCUMENT COMMAND

Usage: /vibe-coding:show [document name]

Available documents:
[Lists 8 docs with status...]
```
