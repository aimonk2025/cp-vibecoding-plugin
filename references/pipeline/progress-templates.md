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

## REVERSE-ENGINEER Initial (Auto-Detected)

```
VIBE CODING PROGRESS
====================
Project: [Auto-detected from package.json/code]
Entry Point: Reverse-Engineering (Auto-detected)
Created: [timestamp]
Last Updated: [timestamp]

CURRENT STATE:
phase: REVERSE-ENGINEER
step: quick_scan_in_progress
next_action: Complete quick scan

---
PHASE: REVERSE-ENGINEER
---

STATUS: in_progress
started: [timestamp]
entry_point: auto_detected_codebase

AUTO-DETECTION RESULTS:
framework: [detected]
language: [detected]
file_count: [count]
has_database: [true/false]
has_tests: [true/false]

QUICK SCAN:
status: in_progress
started: [timestamp]

DEEP ANALYSIS:
status: not_started

DOCS FROM CODE:
status: not_started

GAP-FILLING:
status: not_started

COMPLETE DOCS:
status: not_started

NEXT ACTION: Complete quick scan - detect framework and scope

---
PHASE: IDEATE
---

STATUS: not_started

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

## REVERSE-ENGINEER Analysis In Progress

```
---
PHASE: REVERSE-ENGINEER
---

STATUS: in_progress
started: 2026-02-15T10:30:00Z
last_updated: 2026-02-15T10:45:00Z

QUICK SCAN RESULTS:
framework: Next.js 14.0.0
router: app
language: TypeScript
file_count: 487
has_database: true (PostgreSQL via Prisma)
has_tests: true (Jest)
estimated_time: 15-20 minutes
completed_at: 2026-02-15T10:33:00Z

DEEP ANALYSIS PROGRESS:
✓ Features & Functionality (5m 30s)
  - Features detected: 5
  - Routes: 12
  - API endpoints: 15

✓ Technical Architecture (2m 15s)
  - Components: 23
  - Dependencies: 32

✓ Business Logic (3m 45s)
  - Validation schemas: 4
  - Permission rules: 3

✓ UX & Design (1m 50s)
  - Colors extracted: 8
  - Typography: Inter font

⊙ Database Analysis (in progress...)
  - Tables found: 3
  - Analyzing relationships...

  Pending: Auth, External APIs, Middleware

ANALYSIS RESULTS (partial):

Features Detected: 5
- User Authentication (routes: /login, /signup, API: 3 endpoints)
- Task Management (routes: /tasks, /tasks/:id, API: 5 endpoints)
- Team Collaboration (routes: /teams, API: 4 endpoints)
- User Profile (routes: /profile, API: 2 endpoints)
- Dashboard (route: /, API: 1 endpoint)

CONFIDENCE VERIFICATION:
status: not_started

NEXT ACTION: Complete deep analysis (database, auth, external APIs, middleware)
```

## REVERSE-ENGINEER Confidence Verification

```
---
PHASE: REVERSE-ENGINEER
---

STATUS: in_progress
step: confidence_verification_pending
last_updated: 2026-02-15T10:48:00Z

DEEP ANALYSIS COMPLETE:
overall_confidence: 92%
duration: 15m 42s
files_analyzed: 487
completed_at: 2026-02-15T10:45:42Z

ANALYSIS RESULTS:

Features Detected: 5
- User Authentication (routes: /login, /signup, API: 3 endpoints)
- Task Management (routes: /tasks, /tasks/:id, API: 5 endpoints)
- Team Collaboration (routes: /teams, API: 4 endpoints)
- User Profile (routes: /profile, API: 2 endpoints)
- Dashboard (route: /, API: 1 endpoint)

Tech Stack:
- Framework: Next.js 14.0.0 (100% confidence)
- Language: TypeScript
- Database: PostgreSQL via Prisma 5.0.0 (100% confidence)
- Auth: NextAuth 4.x (75% confidence)
- Styling: Tailwind CSS 3.3.0
- Components: 23 total (5 pages, 12 features, 6 UI)

Database Schema:
- Tables: 3 (users, tasks, teams)
- Relationships: 2 (users→tasks, teams→tasks)
- Indexes: 3

External Services:
- SendGrid (email)
- Stripe (payments)

Middleware:
- auth, logger, error-handler

CONFIDENCE VERIFICATION:
status: pending
awaiting_user_confirmation: true
displayed_summary: true

NEXT ACTION: Await user confirmation of detected configuration
```

## REVERSE-ENGINEER Docs From Code

```
---
PHASE: REVERSE-ENGINEER
---

STATUS: in_progress
step: tech_docs_generating
last_updated: 2026-02-15T11:00:00Z

CONFIDENCE VERIFIED: yes
user_corrections: none
verified_at: 2026-02-15T10:50:00Z

DOCS GENERATED FROM CODE:

✓ TECH_STACK.md
  generated: 2026-02-15T10:52:00Z
  approved: 2026-02-15T10:53:00Z
  location: docs/TECH_STACK.md
  lines: 180

✓ BACKEND_STRUCTURE.md
  generated: 2026-02-15T10:54:00Z
  approved: 2026-02-15T10:55:00Z
  location: docs/BACKEND_STRUCTURE.md
  lines: 245

✓ FRONTEND_GUIDELINES.md
  generated: 2026-02-15T10:56:00Z
  approved: 2026-02-15T10:57:00Z
  location: docs/FRONTEND_GUIDELINES.md
  lines: 198

⊙ DESIGN_SYSTEM.md (partial)
  generated: 2026-02-15T10:58:00Z
  status: awaiting_approval
  location: docs/DESIGN_SYSTEM.md
  lines: 156
  note: Will be enhanced after gap-filling

DOCS PENDING:
- APP_FLOW.md (partial)

GAP-FILLING:
status: not_started

NEXT ACTION: Await approval of DESIGN_SYSTEM.md (partial)
```

## REVERSE-ENGINEER Gap-Filling In Progress

```
---
PHASE: REVERSE-ENGINEER
---

STATUS: in_progress
step: gap_filling_in_progress
last_updated: 2026-02-15T11:20:00Z

DOCS FROM CODE COMPLETE: 5 docs generated and approved

GAP-FILLING INTERROGATION:

status: in_progress
started: 2026-02-15T11:05:00Z
questions_asked: 8
estimated_remaining: 5-8 questions

CODE ANALYSIS CONTEXT:
Features detected: Task management, team collaboration, user auth
Tech stack: Next.js 14, TypeScript, PostgreSQL, Prisma
Database: 3 tables (users, tasks, teams)
Components: 23 components (5 pages, 12 features, 6 UI)

TRANSCRIPT:

Q: I can see your app does task management with team collaboration. What specific problem does this solve?
A: Busy parents forget household tasks because they track on paper and lose notes. This causes stress and family conflicts.

Q: Who specifically are these busy parents? Describe one real person.
A: Sarah, 35, working mom, 2 kids ages 5 and 8, uses phone for everything but struggles with paper lists

Q: How is Sarah solving this today without your app?
A: Paper lists on fridge + phone reminders, but things fall through cracks between the two systems

Q: What's the cost when tasks fall through the cracks?
A: Stress, arguments, missed activities, late bills

Q: What would 'success' look like in 6 months?
A: 10,000 active families using it weekly, App Store feature

Q: How do you measure 'active'?
A: Family completes at least 5 tasks per week using the app

Q: I detected 5 main features. Which is most critical?
A: Task management - everything else is secondary

Q: Why team sharing before profile features?
A: The whole point is family collaboration

TOPICS COVERED:
✓ Problem statement - Complete
✓ Target users - Complete
✓ Success metrics - Complete
⊙ Feature priorities - Partial (need more on roadmap)
✗ Database changes - Not asked yet
✗ Design rationale - Not asked yet
✗ Roadmap - Not asked yet

KEY INSIGHTS:
- Primary user: Working parents (25-45)
- Core pain: Paper + digital systems don't sync
- Success metric: 10K families, 5+ tasks/week
- Business model: Freemium with family plan
- Core feature: Task management with family sharing

NEXT ACTION: Continue gap-filling - ask about database changes and roadmap
```

## REVERSE-ENGINEER Complete

```
---
PHASE: REVERSE-ENGINEER
---

STATUS: complete
started: 2026-02-15T10:30:00Z
completed: 2026-02-15T11:45:00Z
duration: 1h 15m

ENTRY POINT: auto_detected_codebase

ANALYSIS SUMMARY:
files_analyzed: 487
features_detected: 5
framework: Next.js 14.0.0
database: PostgreSQL via Prisma
overall_confidence: 92%

GAP-FILLING SUMMARY:
questions_asked: 15
topics_covered: 8/8
key_insights:
  - Problem: Busy parents forget tasks tracked on paper
  - Users: Working parents 25-45, mobile-first
  - Success: 10K families, 5 tasks/week
  - Model: Freemium with family plan

ALL DOCS GENERATED:
✓ TECH_STACK.md (from code)
✓ BACKEND_STRUCTURE.md (from code)
✓ FRONTEND_GUIDELINES.md (from code)
✓ DESIGN_SYSTEM.md (code + Q&A enhanced)
✓ APP_FLOW.md (code + Q&A enhanced)
✓ PRD.md (Q&A + code)
✓ IMPLEMENTATION_PLAN.md (Q&A roadmap + code)
✓ CLAUDE.md (code + Q&A context)

NEXT OPTIONS PRESENTED:
1. Add features (IDEATE)
2. Improve code (BUILD)
3. Just keep docs (Exit)

user_choice: [awaiting]

NEXT ACTION: Await user choice for next phase
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
