# Doc Architect Phase

Generate canonical documentation from interrogation requirements.

## The 6 Canonical Docs

Generate in this order (dependencies matter):

| # | Doc | Purpose | Generator |
|---|-----|---------|-----------|
| 1 | PRD.md | Features, scope, requirements | `generators/prd.md` |
| 2 | APP_FLOW.md | User journeys, screens, navigation | `generators/app-flow.md` |
| 3 | TECH_STACK.md | Technologies, versions, why | `generators/tech-stack.md` |
| 4 | DESIGN_SYSTEM.md | Colors, typography, spacing, components | `generators/design-system.md` |
| 5 | BACKEND_STRUCTURE.md | Database, APIs, auth | `generators/backend-structure.md` |
| 6 | FRONTEND_GUIDELINES.md | Components, patterns, styling | `generators/frontend-guidelines.md` |
| 7 | IMPLEMENTATION_PLAN.md | Step-by-step build sequence | `generators/implementation-plan.md` |

Also generate: `CLAUDE.md` (from `generators/claude-md.md`)

## Progressive Loading Rules

1. Load ONE generator template at a time
2. Generate that doc, present for review
3. User approves or requests changes
4. Move to next doc
5. Use `shared/cross-reference.md` to ensure consistency

## Workflow

```
For each doc in order:
1. Load generators/[doc].md template
2. Generate doc from interrogation data
3. Show to user for review
4. Approved? → Next doc
5. Changes needed? → Revise, re-review
```

## Progress Display

```
DOCUMENTATION PROGRESS

[x] PRD.md - Approved
[x] APP_FLOW.md - Approved
[>] TECH_STACK.md - In Review
[ ] DESIGN_SYSTEM.md
[ ] BACKEND_STRUCTURE.md
[ ] FRONTEND_GUIDELINES.md
[ ] IMPLEMENTATION_PLAN.md
[ ] CLAUDE.md

Progress: 2/8
```

## Completion

When all docs approved:

```
DOCUMENTATION COMPLETE

All canonical docs generated:
- PRD.md
- APP_FLOW.md
- TECH_STACK.md
- DESIGN_SYSTEM.md
- BACKEND_STRUCTURE.md
- FRONTEND_GUIDELINES.md
- IMPLEMENTATION_PLAN.md
- CLAUDE.md

Proceed to BUILD phase?
Loading: references/engineer/main.md
```
