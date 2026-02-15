# Progress File Templates

## Initial Template (IDEATE Start)

```
VIBE CODING PROGRESS
====================
Project: [Project Name]
Created: [timestamp]
Last Updated: [timestamp]

CURRENT STATE:
phase: IDEATE
step: interrogation_started
next_action: Ask opening question

---
PHASE: IDEATE
---

STATUS: in_progress
started: [timestamp]

INTERROGATION TRANSCRIPT:

[Q&A will be appended here]

TOPICS COVERED:
✗ Core Concept
✗ Users & Personas
✗ Features
✗ Data & Storage
✗ Auth & Security
✗ Tech Stack
✗ Business Constraints
✗ Edge Cases
✗ Integrations
✗ Design & UX

KEY INSIGHTS:
[Will be populated as interrogation progresses]

NEXT ACTION: Ask: "What's the one-sentence description of what you want to build?"

---
PHASE: DOCUMENT
---

STATUS: not_started

---
PHASE: BUILD
---

STATUS: not_started

---
PHASE: DEBUG
---

[Debug sessions tracked here]

---
PHASE: SHIP
---

STATUS: not_started
```

## IDEATE In Progress

```
---
PHASE: IDEATE
---

STATUS: in_progress
started: 2025-02-15T10:30:00Z
last_updated: 2025-02-15T11:15:00Z

INTERROGATION TRANSCRIPT:

Q: What's the one-sentence description of what you want to build?
A: A simple task management app for busy parents

Q: What specific problem with existing task managers are you solving?
A: They're too complicated with features parents don't need

Q: Which task managers have you tried?
A: Todoist, Asana, Microsoft To Do

Q: What specifically felt complicated about them?
A: Too many options, project hierarchies, tagging systems. Parents just need a simple list.

Q: Who would use this simpler version? Describe a specific person.
A: Sarah, 35, mom of 2 kids (ages 5 and 8), works part-time, uses phone for everything

Q: How often would Sarah use this?
A: Daily, multiple times - morning to plan day, throughout day to check off items

[...continues...]

TOPICS COVERED:
✓ Core Concept - Complete
✓ Users & Personas - Complete
⊙ Features - Partial (need priorities)
✗ Data & Storage
✗ Auth & Security
✗ Tech Stack
✗ Business Constraints
✗ Edge Cases
✗ Integrations
✗ Design & UX

KEY INSIGHTS:
Problem: Existing task managers too complex for busy parents
Target User: Parents with young kids, mobile-first
Current Solution: Paper lists + phone reminders
Pain Point: Things fall through cracks between systems
V1 Scope: Simple shared family task list
Out of Scope: Projects, tags, advanced features
Success Metric: Family completes 80%+ of daily tasks

NEXT ACTION: Continue interrogation - focus on Features priorities
```

## IDEATE Complete

```
---
PHASE: IDEATE
---

STATUS: complete
started: 2025-02-15T10:30:00Z
completed: 2025-02-15T12:45:00Z
duration: 2h 15m

INTERROGATION TRANSCRIPT:
[Full Q&A preserved]

TOPICS COVERED:
✓ Core Concept
✓ Users & Personas
✓ Features
✓ Data & Storage
✓ Auth & Security
✓ Tech Stack
✓ Business Constraints
✓ Edge Cases
✓ Integrations
✓ Design & UX

SUMMARY GENERATED: Yes
SUMMARY APPROVED: Yes (2025-02-15T12:45:00Z)

NEXT ACTION: Transition to DOCUMENT phase
```

## DOCUMENT In Progress

```
---
PHASE: DOCUMENT
---

STATUS: in_progress
started: 2025-02-15T12:50:00Z
last_updated: 2025-02-15T13:20:00Z

current_doc: TECH_STACK.md
current_doc_status: awaiting_approval

DOCS COMPLETED:
✓ PRD.md
  - Generated: 2025-02-15T12:55:00Z
  - Approved: 2025-02-15T13:00:00Z
  - Location: /docs/PRD.md

✓ APP_FLOW.md
  - Generated: 2025-02-15T13:05:00Z
  - Approved: 2025-02-15T13:10:00Z
  - Location: /docs/APP_FLOW.md

DOCS IN PROGRESS:
⊙ TECH_STACK.md
  - Generated: 2025-02-15T13:15:00Z
  - Status: Awaiting approval
  - Location: /docs/TECH_STACK.md

DOCS PENDING:
- DESIGN_SYSTEM.md
- BACKEND_STRUCTURE.md
- FRONTEND_GUIDELINES.md
- IMPLEMENTATION_PLAN.md
- CLAUDE.md

NEXT ACTION: Wait for user approval of TECH_STACK.md
```

## BUILD In Progress

```
---
PHASE: BUILD
---

STATUS: in_progress
started: 2025-02-15T14:00:00Z
last_updated: 2025-02-15T15:30:00Z

current_phase: Phase 2 - Core Features
current_step: Step 4 - Task Creation Form
session_started: 2025-02-15T14:00:00Z

IMPLEMENTATION PLAN:
Phase 1: Setup (Complete)
Phase 2: Core Features (In Progress - 3/6 done)
Phase 3: Polish (Not started)
Phase 4: Testing (Not started)

FEATURES COMPLETED:
✓ Phase 1, Step 1: Project setup
  - Completed: 2025-02-15T14:10:00Z
  - Files: package.json, tsconfig.json, vite.config.ts
  - Tests: ✓ Build passes

✓ Phase 1, Step 2: Authentication
  - Completed: 2025-02-15T14:30:00Z
  - Files: src/auth/, src/components/Login.tsx
  - Tests: ✓ Login flow works

✓ Phase 2, Step 3: User Dashboard
  - Completed: 2025-02-15T14:45:00Z
  - Files: src/components/Dashboard.tsx, src/pages/index.tsx
  - Tests: ✓ Dashboard renders, ✓ Task list displays

CURRENT FEATURE:
⊙ Phase 2, Step 4: Task Creation Form
  - Started: 2025-02-15T15:00:00Z
  - Status: In progress
  - Files in progress: src/components/TaskForm.tsx

FILES CHANGED (this session):
- src/components/TaskForm.tsx (created)
- src/types/task.ts (modified)

TESTS STATUS:
✓ All previous tests passing
⊙ New tests for TaskForm pending

NEXT ACTION: Complete TaskForm implementation and tests
```

## DEBUG Session

```
---
DEBUG SESSION #1
---

triggered_from: BUILD - Phase 2, Step 4 (Task Creation Form)
started: 2025-02-15T15:45:00Z
issue: Form submission fails with TypeError

STATUS: investigating

INVESTIGATION LOG:
[15:45] Bug reported: Form doesn't submit
[15:46] Reproduced: Click submit, console shows TypeError
[15:47] Error: Cannot read property 'title' of undefined
[15:48] Located: src/components/TaskForm.tsx:42
[15:50] Root cause: Form state not initialized properly

FIX APPLIED:
- File: src/components/TaskForm.tsx
- Change: Initialize form state with empty defaults
- Commit: abc123 (if using git)

VERIFICATION:
✓ Form submits successfully
✓ Task created in database
✓ No regressions in other tests

RESOLUTION: fixed
completed: 2025-02-15T15:55:00Z
duration: 10 minutes

LESSON LEARNED: Always initialize form state with proper defaults

NEXT ACTION: Resume BUILD - Phase 2, Step 4
```

## SHIP Ready

```
---
PHASE: SHIP
---

STATUS: in_progress
started: 2025-02-15T16:00:00Z

PRE-FLIGHT CHECKLIST:
✓ All features implemented
✓ All tests passing
✓ No critical bugs
✓ Performance acceptable
✓ Security audit complete
✓ Documentation complete
✗ Environment variables set
✗ Database migrations ready
✗ Deploy script tested

DEPLOYMENT STEPS:
1. [✓] Pre-flight checks
2. [⊙] Environment setup (in progress)
3. [ ] Database migration
4. [ ] Deploy to staging
5. [ ] Smoke tests
6. [ ] Deploy to production
7. [ ] Verify deployment
8. [ ] Monitor

NEXT ACTION: Set environment variables for production
```

## Template Usage Guide

### When to Create progress.txt
- At IDEATE start (first question asked)
- Use "Initial Template"

### When to Update
- After every Q&A (IDEATE)
- After every doc operation (DOCUMENT)
- After every feature (BUILD)
- After every debug session (DEBUG)
- After every deploy step (SHIP)

### How to Update
1. Read current progress.txt
2. Parse relevant section
3. Append new data
4. Update timestamps
5. Set next_action
6. Write back

### Recovery from Lost Session
1. User says "continue"
2. Read progress.txt
3. Find last_updated timestamp
4. Find NEXT ACTION
5. Resume from there
