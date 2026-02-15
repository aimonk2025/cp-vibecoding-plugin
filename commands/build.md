---
description: Start BUILD phase (implement features step-by-step)
---

# Build Command

Start the BUILD phase - implement features following documentation.

## Instructions

### Step 1: Validate Prerequisites

Check if DOCUMENT phase is complete:

**Required Documents:**
- PRD.md
- TECH_STACK.md
- IMPLEMENTATION_PLAN.md
- BACKEND_STRUCTURE.md (if applicable)
- FRONTEND_GUIDELINES.md (if applicable)

### Step 2: Handle Missing Documents

If critical docs missing:
```
CANNOT START BUILD PHASE

Required documentation missing.

Found:
✓ PRD.md
✓ TECH_STACK.md
✗ IMPLEMENTATION_PLAN.md - REQUIRED
✗ BACKEND_STRUCTURE.md - REQUIRED

You need complete documentation before building.

Options:
1. Complete DOCUMENT phase (type "/vibe-coding:document")
2. Generate missing docs only
3. View what docs exist (type "/vibe-coding:status")

What would you like to do?
```

### Step 3: If Already in BUILD Phase

Read progress.txt:
```
BUILD PHASE IN PROGRESS

Current: Phase [X], Step [Y] - [Feature Name]
Progress: [X]% complete

Recently completed:
- [Feature 1] - [timestamp]
- [Feature 2] - [timestamp]

Next: [Next feature from IMPLEMENTATION_PLAN.md]

Options:
1. "continue" - Resume building
2. "status" - Show detailed progress
3. "restart phase" - Start current phase over

What would you like?
```

### Step 4: Start BUILD Phase

**Load:** `references/engineer/main.md`

Read required docs:
1. progress.txt
2. IMPLEMENTATION_PLAN.md
3. PRD.md
4. TECH_STACK.md
5. FRONTEND_GUIDELINES.md
6. BACKEND_STRUCTURE.md

### Step 5: Show Build Plan

```
BUILD PHASE STARTING
====================

Reading IMPLEMENTATION_PLAN.md...

Build Roadmap:
Phase 1: Setup ([X] steps)
Phase 2: Core Features ([Y] steps)
Phase 3: Polish ([Z] steps)
Phase 4: Testing ([W] steps)

Total: [N] implementation steps

Current: Phase 1, Step 1 - [Description]

Tech Stack (from TECH_STACK.md):
- Frontend: [...]
- Backend: [...]
- Database: [...]

I'll follow your IMPLEMENTATION_PLAN.md exactly.
After each feature, I'll:
- Update progress.txt
- Run tests
- Verify no regressions

Ready to start building? (Type "continue")
```

**[STOP AND WAIT]**

Follow engineer/main.md workflow.

### Step 6: Session Startup (if resuming)

```
BUILD SESSION STARTING
======================

Reading documentation...
✓ IMPLEMENTATION_PLAN.md
✓ PRD.md
✓ TECH_STACK.md
✓ progress.txt

Resuming from: Phase [X], Step [Y]
Last completed: [Feature name]

Next: [Next feature]

Ready to continue? (Type "continue")
```
