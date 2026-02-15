# Progress Tracker

Managing state across the vibe coding pipeline.

## Table of Contents

- [Progress File Structure](#progress-file-structure) - progress.txt format
- [Progress Commands](#progress-commands) - Check, update, session start/end
- [Phase Tracking](#phase-tracking) - Track each phase
- [Multi-Session Workflow](#multi-session-workflow) - Session examples
- [Recovery Scenarios](#recovery-scenarios) - Lost context, phase mismatch
- [Progress Visualization](#progress-visualization) - Pipeline, feature, time views

---

## Progress File Structure

### progress.txt (Required)

The central state file for your project:

```
================================================================================
                              PROJECT PROGRESS
================================================================================

PROJECT: [Project Name]
STARTED: [Date]
LAST UPDATED: [Date/Time]

================================================================================
                              PIPELINE STATUS
================================================================================

CURRENT PHASE: [IDEATE | DOCUMENT | BUILD | DEBUG | SHIP]
CURRENT STEP: [Specific step reference]

PHASE COMPLETION:
[✓] IDEATE      - Completed [date]
[✓] DOCUMENT    - Completed [date]
[→] BUILD       - In Progress (Step X of Y)
[ ] DEBUG       - As needed
[ ] SHIP        - Pending

================================================================================
                              SESSION LOG
================================================================================

LAST SESSION: [Date]
WORKED ON:
- [What was built/fixed]
- [What was built/fixed]

NEXT SESSION:
- [What to work on next]
- [What to work on next]

================================================================================
                              BLOCKERS & NOTES
================================================================================

BLOCKERS:
- [Any blocking issues]

NOTES:
- [Important context for next session]

================================================================================
                              FEATURE STATUS
================================================================================

CORE FEATURES:
[✓] [Feature 1] - Complete
[→] [Feature 2] - In Progress
[ ] [Feature 3] - Not Started

NICE-TO-HAVE:
[ ] [Feature A] - Backlog
[ ] [Feature B] - Backlog
```

---

## Progress Commands

### Check Progress

```
PROGRESS CHECK:

Reading progress.txt...

Current State:
- Phase: BUILD
- Step: 3.2 - Building Contact Detail Page
- Last session: 2024-01-15
- Features: 2/5 complete

Recommendation: Continue with step 3.2
```

### Update Progress

After completing work:

```
PROGRESS UPDATE:

Updating progress.txt...

Changes:
- Step 3.2: COMPLETE
- Moving to: Step 3.3
- Features: 3/5 complete

Added to session log:
- Built Contact Detail Page
- Connected to API
- Added loading states
```

### Session Start

When beginning a session:

```
SESSION START PROTOCOL:

1. Reading progress.txt...
   → Last session: 2024-01-15
   → Phase: BUILD
   → Step: 3.2

2. Reading CLAUDE.md...
   → Project rules loaded

3. Reading lessons.md...
   → 3 lessons from previous sessions

4. Current state understood

READY TO CONTINUE:
- Resume step 3.2
- Or tell me what you'd like to do
```

### Session End

When ending a session:

```
SESSION END PROTOCOL:

Before closing, let's update progress:

1. What did we accomplish?
   → [list completions]

2. What's next?
   → [list next steps]

3. Any blockers?
   → [list blockers or "none"]

Updating progress.txt...
Done. Ready for next session.
```

---

## Phase Tracking

### Ideation Progress

```
IDEATION PROGRESS:

Categories completed:
[✓] Core Concept (5/5 questions)
[✓] Users (4/4 questions)
[→] Features (3/6 questions)
[ ] Data (0/5 questions)
[ ] Auth (0/3 questions)
[ ] Design (0/8 questions)
[ ] Tech Stack (0/6 questions)
[ ] Edge Cases (0/7 questions)

Overall: 12/44 questions (27%)
```

### Documentation Progress

```
DOCUMENTATION PROGRESS:

Files generated:
[✓] PRD.md - Complete, approved
[✓] APP_FLOW.md - Complete, approved
[→] TECH_STACK.md - Generated, needs review
[ ] FRONTEND_GUIDELINES.md - Not started
[ ] BACKEND_STRUCTURE.md - Not started
[ ] IMPLEMENTATION_PLAN.md - Not started

Setup files:
[✓] CLAUDE.md - Configured
[✓] progress.txt - Initialized

Overall: 2/6 docs complete (33%)
```

### Build Progress

```
BUILD PROGRESS:

Implementation Plan Status:
[✓] Phase 1: Setup (3/3 steps)
[✓] Phase 2: Auth (4/4 steps)
[→] Phase 3: Core Features (2/5 steps)
[ ] Phase 4: Polish (0/3 steps)
[ ] Phase 5: Testing (0/2 steps)

Current: Phase 3, Step 2 - Contact Detail Page

Overall: 9/17 steps (53%)
```

### Ship Progress

```
SHIP PROGRESS:

Pre-ship Checklist:
[✓] Mobile testing
[✓] Error states
[→] Security audit
[ ] Performance check
[ ] Cross-browser

Deployment:
[ ] Env vars configured
[ ] Build passing
[ ] Preview tested
[ ] Production deployed

Overall: 2/9 checks (22%)
```

---

## Multi-Session Workflow

### Session 1: Ideation
```
progress.txt:
CURRENT PHASE: IDEATE
COMPLETED: Core concept, users, features questions
NEXT: Data, auth, design questions
```

### Session 2: Complete Ideation + Start Docs
```
progress.txt:
CURRENT PHASE: DOCUMENT
COMPLETED: All ideation, PRD.md, APP_FLOW.md
NEXT: TECH_STACK.md, FRONTEND_GUIDELINES.md
```

### Session 3: Complete Docs + Start Build
```
progress.txt:
CURRENT PHASE: BUILD
COMPLETED: All docs, Phase 1 setup
NEXT: Phase 2 - Auth implementation
```

### Session 4: Continue Build
```
progress.txt:
CURRENT PHASE: BUILD
COMPLETED: Phase 1-2, Phase 3 step 1
NEXT: Phase 3 step 2 - Contact Detail
```

### Session N: Ship
```
progress.txt:
CURRENT PHASE: SHIP
COMPLETED: All build phases, pre-ship checks
NEXT: Deploy to production
```

---

## Recovery Scenarios

### Lost Context

If progress.txt is missing or outdated:

```
CONTEXT RECOVERY:

progress.txt not found or stale.

Let me check what exists:
- [✓] CLAUDE.md found
- [✓] docs/ folder with 6 files
- [✓] src/ folder with components
- [ ] progress.txt missing

Based on codebase state:
- Docs: Complete
- Build: Partially complete (auth done, features in progress)

RECOMMENDATION:
1. I'll create progress.txt from current state
2. Let's identify where to resume

What was the last thing you worked on?
```

### Phase Mismatch

If trying to do wrong phase:

```
PHASE MISMATCH DETECTED:

You're asking to: Ship the project
Current phase: BUILD (step 3 of 8)

Build is not complete yet:
- 5 more steps in IMPLEMENTATION_PLAN.md
- Core features still in progress

OPTIONS:
1. Continue BUILD - Complete remaining steps
2. Force SHIP - Ship MVP (not recommended)
3. Update plan - Reduce scope, then ship

Which would you like?
```

---

## Progress Visualization

### Pipeline View
```
PIPELINE:
[====IDEATE====][====DOCS====][====BUILD====][DEBUG][SHIP]
     ✓              ✓            ▶ 53%
```

### Feature View
```
FEATURES:
Auth        [██████████] 100%
Contacts    [██████░░░░]  60%
Dashboard   [░░░░░░░░░░]   0%
Settings    [░░░░░░░░░░]   0%
```

### Time View
```
TIMELINE:
Day 1: Ideation ✓
Day 2: Docs ✓
Day 3-5: Build (in progress)
Day 6: Ship (planned)
```
