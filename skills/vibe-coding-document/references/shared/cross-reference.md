# Cross-Reference Guide

<purpose>
Defines how all documents connect. Use this to verify references are correct across the documentation suite.
</purpose>

---

## Document Dependency Chain

```
PRD.md (Features: FEAT-XXX)
    │
    ├──→ APP_FLOW.md (Screens: SCREEN-XXX)
    │       │
    │       └──→ references FEAT-XXX for each screen
    │
    ├──→ BACKEND_STRUCTURE.md (API endpoints)
    │       │
    │       └──→ endpoints support FEAT-XXX
    │
    └──→ IMPLEMENTATION_PLAN.md (Build order)
            │
            └──→ steps reference FEAT-XXX and SCREEN-XXX

TECH_STACK.md (Technologies)
    │
    ├──→ FRONTEND_GUIDELINES.md (uses these technologies)
    │
    ├──→ BACKEND_STRUCTURE.md (uses these technologies)
    │
    └──→ IMPLEMENTATION_PLAN.md (setup phases use versions)

DESIGN_SYSTEM.md (Visual tokens)
    │
    └──→ FRONTEND_GUIDELINES.md (references tokens)
            │
            └──→ APP_FLOW.md (states use design tokens)

CLAUDE.md (Governance)
    │
    ├──→ References ALL canonical docs
    │
    └──→ progress.txt → tasks/todo.md → LESSONS.md
```

---

## ID Systems

### Feature IDs (PRD.md)
**Format:** `FEAT-XXX`
**Example:** `FEAT-001`, `FEAT-002`
**Used in:** APP_FLOW.md, BACKEND_STRUCTURE.md, IMPLEMENTATION_PLAN.md

### Screen IDs (APP_FLOW.md)
**Format:** `SCREEN-XXX`
**Example:** `SCREEN-001`, `SCREEN-002`
**Used in:** IMPLEMENTATION_PLAN.md, tasks/todo.md

### Modal IDs (APP_FLOW.md)
**Format:** `MODAL-XXX`
**Example:** `MODAL-001`, `MODAL-002`
**Used in:** IMPLEMENTATION_PLAN.md

### Lesson IDs (LESSONS.md)
**Format:** `LESSON-XXX`
**Example:** `LESSON-001`, `LESSON-002`
**Used in:** Quick reference, session reviews

### Pattern IDs (LESSONS.md)
**Format:** `PATTERN-XXX`
**Example:** `PATTERN-001`, `PATTERN-002`
**Used in:** Code reference

---

## Cross-Reference Matrix

| Document | References | Referenced By |
|----------|------------|---------------|
| PRD.md | - | APP_FLOW, BACKEND, IMPL_PLAN |
| APP_FLOW.md | PRD (FEAT-XXX) | IMPL_PLAN, FRONTEND_GUIDE |
| TECH_STACK.md | - | FRONTEND_GUIDE, BACKEND, IMPL_PLAN, CLAUDE |
| DESIGN_SYSTEM.md | - | FRONTEND_GUIDE, APP_FLOW |
| FRONTEND_GUIDELINES.md | TECH_STACK, DESIGN_SYSTEM | CLAUDE, IMPL_PLAN |
| BACKEND_STRUCTURE.md | PRD (FEAT-XXX), TECH_STACK | IMPL_PLAN, APP_FLOW |
| IMPLEMENTATION_PLAN.md | ALL canonical docs | progress.txt, CLAUDE |
| CLAUDE.md | ALL docs | - |
| progress.txt | IMPL_PLAN (phases) | tasks/todo.md |
| tasks/todo.md | IMPL_PLAN (steps), progress.txt | LESSONS.md |
| LESSONS.md | - | CLAUDE, tasks/todo.md |

---

## Verification Checklist

### After Creating PRD.md
- [ ] All features have unique FEAT-XXX IDs
- [ ] No duplicate IDs

### After Creating APP_FLOW.md
- [ ] All screens have unique SCREEN-XXX IDs
- [ ] Every screen references at least one FEAT-XXX
- [ ] All FEAT-XXX from PRD are covered by screens

### After Creating BACKEND_STRUCTURE.md
- [ ] All API endpoints support PRD features
- [ ] All data types from PRD are modeled

### After Creating IMPLEMENTATION_PLAN.md
- [ ] All FEAT-XXX from PRD have implementation steps
- [ ] All SCREEN-XXX from APP_FLOW have implementation steps
- [ ] Phase dependencies are logical

### After Creating CLAUDE.md
- [ ] All canonical docs are referenced
- [ ] Session startup sequence includes all session docs
- [ ] Protection rules reference correct doc names

### Full Suite Verification
- [ ] Run: Search for all FEAT-XXX — verify each exists in PRD
- [ ] Run: Search for all SCREEN-XXX — verify each exists in APP_FLOW
- [ ] Run: Search for all token names — verify each exists in DESIGN_SYSTEM
- [ ] Run: Search for all technology names — verify versions match TECH_STACK

---

## Reference Format Standards

### Referencing Features
```
Implements: FEAT-001, FEAT-002
See PRD.md: FEAT-001
Per PRD.md FEAT-001 acceptance criteria
```

### Referencing Screens
```
Screen: SCREEN-001 (Dashboard)
See APP_FLOW.md: SCREEN-001
Navigation to SCREEN-002
```

### Referencing Tokens
```
Color: var(--color-primary) per DESIGN_SYSTEM.md
Spacing: --space-4 (16px) per DESIGN_SYSTEM.md
```

### Referencing Technologies
```
React 18.2.0 per TECH_STACK.md
Using Prisma 5.8.0 per TECH_STACK.md
```

### Referencing Implementation Steps
```
See IMPLEMENTATION_PLAN.md Phase 3, Step 3.2
Current: Phase 3, Step 3.2 per progress.txt
```

---

## Common Reference Errors

### ❌ Wrong
```
"the login feature" — vague
"on the dashboard" — no ID
"use a nice blue" — no token
"latest React" — no version
```

### ✅ Correct
```
"FEAT-003 (User Login)" — specific ID
"SCREEN-001 (Dashboard)" — with ID
"var(--color-primary)" — exact token
"React 18.2.0" — locked version
```
