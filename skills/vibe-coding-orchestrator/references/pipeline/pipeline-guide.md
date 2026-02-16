# Pipeline Guide

Complete documentation of the vibe coding pipeline.

## Table of Contents

- [Pipeline Overview](#pipeline-overview) - High-level flow
- [Phase 1: IDEATE](#phase-1-ideate-vibe-interrogator) - Requirements gathering
- [Phase 2: DOCUMENT](#phase-2-document-vibe-doc-architect) - Doc generation
- [Phase 3: BUILD](#phase-3-build-vibe-engineer) - Implementation
- [Phase 4: DEBUG](#phase-4-debug-vibe-debugger) - Bug fixing
- [Phase 5: SHIP](#phase-5-ship-vibe-shipper) - Deployment
- [Pipeline Loops](#pipeline-loops) - Flow patterns
- [Phase Transitions](#phase-transitions) - Handoff triggers
- [State Persistence](#state-persistence) - progress.txt, lessons.md

---

## Pipeline Overview

The vibe coding pipeline transforms a vague idea into a shipped product through 5 distinct phases:

```
IDEA → DOCS → CODE → FIX → SHIP → LIVE
```

Each phase has a dedicated skill optimized for that specific task.

## Phase 1: IDEATE (vibe-interrogator)

### Purpose
Extract clear requirements from a vague idea through structured questioning.

### When to Use
- Starting a brand new project
- Pivoting an existing project significantly
- Unclear on what exactly to build

### What Happens
1. Skill asks 50+ structured questions across categories:
   - Core concept & users
   - Features & functionality
   - Data & authentication
   - Design & tech stack
   - Edge cases & integrations

2. You answer each question

3. Output: Clear, documented requirements ready for doc generation

### Completion Criteria
- All critical questions answered
- No major ambiguities remaining
- Ready to generate documentation

### Next Phase
→ vibe-doc-architect

---

## Phase 2: DOCUMENT (vibe-doc-architect)

### Purpose
Generate the 6 canonical documentation files from interrogation answers.

### When to Use
- After completing ideation
- When you have clear requirements but no docs
- Starting a project with existing specs

### What Happens
1. Takes interrogation answers as input
2. Generates structured documentation:

```
docs/
├── PRD.md                    - Product requirements
├── APP_FLOW.md               - User journeys & navigation
├── TECH_STACK.md             - Technologies & versions
├── FRONTEND_GUIDELINES.md    - Design system & components
├── BACKEND_STRUCTURE.md      - Database & API contracts
├── IMPLEMENTATION_PLAN.md    - Step-by-step build order

root/
├── CLAUDE.md                 - AI operating rules
└── progress.txt              - Session state tracking
```

3. You review and approve each document

### Completion Criteria
- All 6 docs generated
- User has reviewed and approved
- CLAUDE.md configured
- progress.txt initialized

### Next Phase
→ vibe-engineer

---

## Phase 3: BUILD (vibe-engineer)

### Purpose
Implement features following the documentation and implementation plan.

### When to Use
- Docs are complete and approved
- Ready to write actual code
- Continuing development on existing project

### What Happens
1. Session startup: Read docs in order
2. Write session plan to tasks/todo.md
3. Build features step by step from IMPLEMENTATION_PLAN.md
4. Follow all guidelines (design, frontend, backend)
5. Update progress.txt after each feature

### Sub-Phases
- **Session Start** - Read docs, create plan
- **Planning** - Break down tasks, clarify requirements
- **Building** - Implement with protection rules
- **Reviewing** - Verify against completion checklist

### Completion Criteria
- All steps in IMPLEMENTATION_PLAN.md complete
- Core functionality working
- Tests passing
- Ready for ship verification

### Next Phase
→ vibe-shipper (or vibe-debugger if bugs found)

---

## Phase 4: DEBUG (vibe-debugger)

### Purpose
Fix bugs surgically without creating new problems.

### When to Use
- Something is broken
- Tests failing
- User-reported bugs
- Unexpected behavior

### What Happens
1. Reproduce the bug first
2. Research blast radius
3. Present findings before fixing
4. Determine root cause vs symptom
5. Propose fix, get approval
6. Implement and verify
7. Update lessons.md

### Key Principle
Fix ONLY what's broken. Touch nothing else. Working code is sacred.

### Completion Criteria
- Bug verified fixed
- No regressions introduced
- lessons.md updated
- Back to stable state

### Next Phase
→ Back to vibe-engineer (continue building) or vibe-shipper (if ready)

---

## Phase 5: SHIP (vibe-shipper)

### Purpose
Verify everything works and deploy to production.

### When to Use
- Core features complete
- Ready to go live
- Need pre-ship verification
- Deploying updates

### What Happens
1. **Scope Check** - Verify MVP complete, no feature creep
2. **Pre-ship Checklist** - Mobile, errors, security, performance
3. **Deployment** - Push to Vercel/production
4. **Post-ship** - Monitor, iterate, maintain

### Completion Criteria
- All pre-ship checks pass
- Successfully deployed
- Core flow works on production
- Monitoring in place

### Next Phase
→ LIVE! Then back to BUILD for iterations or DEBUG for bug fixes

---

## Pipeline Loops

### Normal Flow
```
IDEATE → DOCUMENT → BUILD → SHIP
```

### Bug Found During Build
```
BUILD → DEBUG → BUILD (continue)
```

### Post-Ship Iterations
```
SHIP → User Feedback → BUILD → SHIP
```

### Major Pivot
```
SHIP → Major Change Needed → IDEATE → DOCUMENT → BUILD → SHIP
```

---

## Phase Transitions

### IDEATE → DOCUMENT
Trigger: All interrogation questions answered
Check: Requirements clear and complete

### DOCUMENT → BUILD
Trigger: All 6 docs generated and approved
Check: CLAUDE.md and progress.txt exist

### BUILD → SHIP
Trigger: IMPLEMENTATION_PLAN.md complete
Check: Core features working

### BUILD ↔ DEBUG
Trigger: Bug discovered / Bug fixed
Check: Reproduction confirmed / Fix verified

### SHIP → BUILD
Trigger: User feedback received
Check: Feedback triaged and prioritized

---

## State Persistence

### progress.txt
Tracks current state across sessions:
```
CURRENT PHASE: BUILD
CURRENT STEP: 3.2 of IMPLEMENTATION_PLAN.md

COMPLETED:
- [x] Ideation
- [x] Documentation
- [ ] Build (in progress)

LAST SESSION:
- Built: Contact list component
- Next: Contact detail page

BLOCKERS:
- None
```

### tasks/lessons.md
Accumulates learnings:
```
## Lesson: API Error Handling
- Bug: Blank screen on API failure
- Cause: No error boundary
- Rule: Always add error states before happy path
```

### Session Handoff
End each session:
1. Update progress.txt
2. Note current phase
3. List next steps

Start each session:
1. Read progress.txt
2. Resume from last state
3. Continue pipeline
