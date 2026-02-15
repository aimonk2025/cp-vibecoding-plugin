---
description: Start DOCUMENT phase (generate 8 canonical documentation files)
---

# Document Command

Start the DOCUMENT phase - generate all 8 canonical documents.

## Instructions

### Step 1: Validate Prerequisites

Check if IDEATE phase is complete OR PRD exists:

**Option A: Check progress.txt**
- If IDEATE complete → Proceed
- If IDEATE incomplete → Ask to finish first

**Option B: Check for existing PRD**
- If PRD.md exists → Can start
- If no PRD → Must complete IDEATE first

### Step 2: Handle Missing Prerequisites

If no PRD and IDEATE not complete:
```
CANNOT START DOCUMENT PHASE

Requirements not ready yet.

Missing:
✗ IDEATE phase not complete
✗ No PRD file found

Options:
1. Complete IDEATE first (type "/vibe-coding:ideate")
2. Import existing PRD (type "/vibe-coding:import-prd [path]")
3. Use fast-track mode (type "/vibe-coding:fast-track")

What would you like to do?
```

### Step 3: If Already in DOCUMENT Phase

Read progress.txt to see current doc.

```
DOCUMENT PHASE IN PROGRESS

Progress: [X/8] documents complete

✓ [Completed docs]
⊙ [Current doc] - [status]
[ ] [Pending docs]

Options:
1. "continue" - Resume from current doc
2. "restart" - Regenerate all docs from scratch
3. "show progress" - Detailed status

What would you like?
```

### Step 4: Start DOCUMENT Phase

**Load:** `references/doc-architect/main.md`

Initialize progress.txt:
```
PHASE: DOCUMENT
STATUS: in_progress
started: [timestamp]
current_doc: none
docs_to_generate: 8

DOCS PENDING:
- PRD.md (if not imported)
- APP_FLOW.md
- TECH_STACK.md
- DESIGN_SYSTEM.md
- BACKEND_STRUCTURE.md
- FRONTEND_GUIDELINES.md
- IMPLEMENTATION_PLAN.md
- CLAUDE.md

NEXT ACTION: Generate first document
```

### Step 5: Begin Sequential Generation

```
DOCUMENT PHASE STARTED
======================

I'll generate 8 canonical documents, ONE at a time.

Documents to create:
1. PRD.md - Product Requirements
2. APP_FLOW.md - User Journeys
3. TECH_STACK.md - Technologies
4. DESIGN_SYSTEM.md - Design Tokens
5. BACKEND_STRUCTURE.md - Database & APIs
6. FRONTEND_GUIDELINES.md - Component Patterns
7. IMPLEMENTATION_PLAN.md - Build Roadmap
8. CLAUDE.md - Project Rules

After each document:
- I'll show you a summary
- You approve or request changes
- We move to the next document

Total time: ~30-40 minutes

Ready to start with PRD.md? (Type "continue")
```

**[STOP AND WAIT]**

Follow sequential workflow from doc-architect/main.md.
