---
name: vibe-coding-document
description: |
  Generate 8 canonical documentation files from requirements or existing codebase - ONE document at a time with approval workflow.
  Creates: PRD, APP_FLOW, TECH_STACK, DESIGN_SYSTEM, BACKEND_STRUCTURE, FRONTEND_GUIDELINES, IMPLEMENTATION_PLAN, and CLAUDE.md.
  Use when: (1) Generating documentation - user says "generate docs", "create PRD", "make documentation", "write the docs", "document this",
  (2) IDEATE phase complete - orchestrator delegates after requirements summary approved,
  (3) Importing PRD - user says "I have a PRD", "use this spec", "import requirements", "here's my requirements doc", validates quality (0-100%) and enhances if needed,
  (4) Continuing doc generation - user says "next doc", "continue docs", "keep going", "approve" after reviewing a document,
  (5) After reverse-engineering - generates remaining 3 business docs (PRD, enhanced APP_FLOW, IMPLEMENTATION_PLAN) since tech docs already created from code.
  Supports 3 entry modes: standard (from ideate), PRD import (with validation), and post-reverse-engineering.
  Outputs all 8 docs to ./docs/ directory with sequential approval workflow before transitioning to BUILD phase.
---

# Vibe Coding DOCUMENT Phase

Generate 8 canonical documentation files, ONE at a time.

## Entry Modes

**Mode 1: After IDEATE (Standard)**
- Read interrogation transcript from progress.txt
- Generate all 8 docs sequentially

**Mode 2: PRD Import**
- Validate imported PRD quality (0-100% scoring)
- Enhance if needed (ask gap-filling questions)
- Generate remaining 7 docs

**Mode 3: After Reverse-Engineer**
- Tech docs already generated (5 docs)
- Generate remaining 3 business docs (PRD, APP_FLOW, IMPLEMENTATION_PLAN)

## 8 Canonical Documents (In Order)

1. **PRD.md** - Product Requirements Document
2. **APP_FLOW.md** - User Journeys and Screen Flows
3. **TECH_STACK.md** - Technologies and Versions
4. **DESIGN_SYSTEM.md** - Colors, Typography, Components
5. **BACKEND_STRUCTURE.md** - Database Schema and API Endpoints
6. **FRONTEND_GUIDELINES.md** - Component Patterns and File Structure
7. **IMPLEMENTATION_PLAN.md** - Step-by-Step Build Roadmap
8. **CLAUDE.md** - Project-Specific AI Assistant Rules

## Sequential Workflow

**CRITICAL:** Generate ONE document at a time. Wait for approval before next.

```
FOR each document:
  1. Announce which doc you're generating
  2. Generate the document
  3. Save to ./docs/[DOC_NAME].md
  4. Show summary (first 20 lines)
  5. Ask for approval
  6. WAIT for user response
  7. If approved: Update progress.txt, move to next doc
  8. If revision requested: Revise and re-show
```

## Progress Tracking

**After generating EACH document:**

```
PHASE: DOCUMENT
STATUS: in_progress
current_doc: [DOC_NAME]

DOCS COMPLETED:
✓ PRD.md - Approved [timestamp]
✓ APP_FLOW.md - Approved [timestamp]

DOCS PENDING:
⊙ TECH_STACK.md - Awaiting Approval
✗ DESIGN_SYSTEM.md - Not Started
[...remaining docs...]

NEXT ACTION: [Wait for approval OR Generate next doc]
```

## PRD Import Mode

**When user provides PRD:**

1. **Read PRD file or pasted content**
2. **Validate quality (0-100%):**
   - Problem Statement: 0-20 pts
   - Target Users: 0-20 pts
   - Core Features: 0-20 pts
   - Success Metrics: 0-15 pts
   - Technical Constraints: 0-10 pts
   - Scope Definition: 0-15 pts

3. **Handle based on score:**
   - 86-100%: Complete → Generate remaining 7 docs
   - 61-85%: Solid → Ask 5-10 questions → Generate 7 docs
   - 31-60%: Basic → Ask 15 questions → Enhance PRD → Generate 7 docs
   - 0-30%: Stub → Recommend full IDEATE instead

## Reference Files

- `references/main.md` - Main doc generation logic
- `references/prd-import.md` - PRD validation and enhancement
- `references/generators/prd.md` - PRD generation template
- `references/generators/app-flow.md` - APP_FLOW template
- `references/generators/tech-stack.md` - TECH_STACK template
- `references/generators/design-system.md` - DESIGN_SYSTEM template
- `references/generators/backend-structure.md` - BACKEND template
- `references/generators/frontend-guidelines.md` - FRONTEND template
- `references/generators/implementation-plan.md` - PLAN template
- `references/generators/claude-md.md` - CLAUDE.md template

## Hand-off to BUILD

When all 8 docs approved:

```
PHASE: DOCUMENT
STATUS: complete
completed: [timestamp]
docs_generated: 8
all_approved: true

NEXT ACTION: Start BUILD phase

---
PHASE: BUILD
---
STATUS: ready_to_start
```

Activate vibe-coding-build skill and exit.
