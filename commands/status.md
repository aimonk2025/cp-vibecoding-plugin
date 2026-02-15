---
description: Show current workflow progress, phase, and next action
---

# Status Command

Display the current state of the Vibe Coding workflow.

## Instructions

1. Check if `progress.txt` exists in the current directory
2. If NO progress.txt:
   ```
   NO ACTIVE VIBE CODING PROJECT

   No progress.txt found in this directory.

   Start a new project:
   - "I want to build [your idea]" - Full IDEATE interrogation
   - "/vibe-coding:fast-track" - Quick 10-question mode
   - "/vibe-coding:import-prd [path]" - Import existing PRD
   ```

3. If YES, read and parse progress.txt
4. Display formatted status:

```
VIBE CODING STATUS
==================

Current Phase: [PHASE NAME]
Status: [in_progress/complete]
Started: [timestamp]
Last Updated: [timestamp]

[Phase-specific details below]
```

## Phase-Specific Display

### If IDEATE Phase:
```
IDEATE PHASE (Requirements Gathering)

Mode: [full/fast-track/from-prd]
Questions Asked: [X]
Duration: [Y minutes]

Topics Covered:
✓ Core Concept - Complete
✓ Users & Personas - Complete
⊙ Features - In Progress
✗ Data & Storage - Not Started
[...remaining topics...]

Next Action: [from progress.txt NEXT ACTION field]
```

### If DOCUMENT Phase:
```
DOCUMENT PHASE (Documentation Generation)

Progress: [X/8] documents complete

Documents Status:
✓ PRD.md - Approved [timestamp]
✓ APP_FLOW.md - Approved [timestamp]
⊙ TECH_STACK.md - Awaiting Approval
[ ] DESIGN_SYSTEM.md
[ ] BACKEND_STRUCTURE.md
[ ] FRONTEND_GUIDELINES.md
[ ] IMPLEMENTATION_PLAN.md
[ ] CLAUDE.md

Next Action: [from progress.txt NEXT ACTION field]
```

### If BUILD Phase:
```
BUILD PHASE (Implementation)

Current: [Phase X, Step Y - Feature Name]
Implementation Progress: [X%]

Phases Status:
✓ Phase 1: Setup - Complete
⊙ Phase 2: Core Features - 3/5 steps done
[ ] Phase 3: Polish
[ ] Phase 4: Testing
[ ] Phase 5: Final

Recently Completed:
- [Feature 1] - [timestamp]
- [Feature 2] - [timestamp]

Files Changed (this session):
- [file 1]
- [file 2]

Next Action: [from progress.txt NEXT ACTION field]
```

### If DEBUG Phase:
```
DEBUG PHASE (Bug Fixing)

Active Debug Session: #[X]
Started: [timestamp]
Issue: [description]

Status: [investigating/fixing/verifying]

Investigation Log:
- [Step 1]
- [Step 2]

Next Action: [from progress.txt NEXT ACTION field]
```

### If SHIP Phase:
```
SHIP PHASE (Deployment)

Deployment Progress: [X/Y] steps complete

Checklist:
✓ Pre-flight checks
✓ Environment setup
⊙ Deploying to [platform]
[ ] Smoke tests
[ ] Monitor

Next Action: [from progress.txt NEXT ACTION field]
```

## Footer (Always Show)

```
==================

Commands:
- Type "continue" to proceed with next action
- "/vibe-coding:show [doc]" to view a document
- "/vibe-coding:status" to refresh this status

Project Directory: [current directory]
Progress File: progress.txt
```

## Error Handling

If progress.txt exists but is corrupted or unreadable:
```
ERROR: Could not parse progress.txt

The progress file exists but appears corrupted.

Options:
1. Show me the file content (I'll try to recover it)
2. Start fresh (create new progress.txt)
3. Manual fix (you edit progress.txt, then I'll retry)

What would you like to do?
```
