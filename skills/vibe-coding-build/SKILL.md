---
name: vibe-coding-build
description: |
  Step-by-step software implementation following IMPLEMENTATION_PLAN.md with protection rules to prevent regressions.
  Implements features sequentially, one phase/step at a time, with continuous progress tracking and testing.
  Use when: (1) Starting implementation - user says "let's build", "start coding", "implement", "begin development", "time to code",
  (2) All 8 docs approved - orchestrator delegates BUILD phase after DOCUMENT phase complete,
  (3) Adding features - user says "add this feature", "enhance the app", "implement [feature name]", "build [specific feature]",
  (4) Continuing implementation - user says "continue building", "next step", "keep coding", "what's next?", "proceed",
  (5) Resuming after debug - orchestrator returns to BUILD after debug session complete.
  Requires IMPLEMENTATION_PLAN.md and all canonical docs. Reads protection-rules.md before ANY code changes.
  Updates progress.txt after each step completion. Transitions to DEBUG on errors or SHIP when all phases complete.
---

# Vibe Coding BUILD Phase

Implement features step-by-step following IMPLEMENTATION_PLAN.md.

## Prerequisites

**Required:**
- IMPLEMENTATION_PLAN.md exists in ./docs/
- All 8 canonical docs approved
- progress.txt shows DOCUMENT phase complete

## Build Workflow

1. **Read IMPLEMENTATION_PLAN.md**
2. **Identify current phase and step**
3. **Implement current step**
4. **Update progress.txt**
5. **Move to next step**
6. **Repeat until all phases complete**

## Implementation Pattern

```
FOR each phase in IMPLEMENTATION_PLAN:
  FOR each step in phase:
    1. Announce step
    2. Read protection rules (../../references/engineer/protection-rules.md)
    3. Implement step
    4. Test/verify
    5. Update progress.txt
    6. Mark step complete
  Mark phase complete
```

## Protection Rules

**CRITICAL - Load before ANY code changes:**
- `references/protection-rules.md`

**Never:**
- Overwrite existing files without reading first
- Make parallel changes (one step at a time)
- Skip testing after changes
- Modify generated docs

## Progress Tracking

```
PHASE: BUILD
STATUS: in_progress
current_phase: [Phase X]
current_step: [Step Y]
feature: [Feature Name]

PHASES STATUS:
✓ Phase 1: Project Setup - Complete
⊙ Phase 2: Core Features - Step 3/5
✗ Phase 3-5: Not Started

FILES CHANGED:
- [list of modified files]

NEXT ACTION: [specific next step from plan]
```

## Reference Files

- `references/main.md` - Main build orchestration
- `references/planning.md` - Planning approach
- `references/protection-rules.md` - Safety rules
- `references/engineering-standards.md` - Code quality standards
- `references/completion-checklist.md` - Done criteria

## Hand-off to SHIP

When all phases complete:

```
PHASE: BUILD
STATUS: complete
completed: [timestamp]
all_tests_passing: true

NEXT ACTION: Deploy to production

---
PHASE: SHIP
---
STATUS: ready_to_start
```

Activate vibe-coding-ship skill and exit.
