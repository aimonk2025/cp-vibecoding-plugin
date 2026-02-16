# Doc Architect Phase

Generate canonical documentation from interrogation requirements OR existing codebase.

**CRITICAL RULE: ONE DOCUMENT AT A TIME - NEVER GENERATE MULTIPLE IN PARALLEL**

## Entry Mode Detection

Before generating docs, detect where the input comes from:

### Mode 1: From IDEATE (Standard Flow)
- Source: Interrogation conversation
- Has: Full requirements from Q&A
- Generate: All 8 docs from scratch using interrogation context

### Mode 2: From REVERSE-ENGINEER (Code Analysis Flow)
- Source: Codebase analysis + gap-filling Q&A
- Has: Technical analysis + business context
- Generate: Tech docs from code, business docs from Q&A
- **Load:** `reverse-engineer/doc-generation-from-code.md`

### Mode 3: From PRD Import
- Source: User-provided PRD
- Has: PRD (validated/enhanced) + partial requirements
- Generate: PRD already exists, generate remaining 7 docs
- **Load:** `prd-import.md`

### Detect Mode From Progress File

Read progress.txt and check:
```
IF progress.txt shows:
  phase: REVERSE-ENGINEER
  status: tech_docs_complete OR gap_filling_complete
THEN:
  mode = "reverse-engineer"
  Load: reverse-engineer/doc-generation-from-code.md
  Use: Code analysis data + gap-filling answers

ELSE IF progress.txt shows:
  entry_point: user_provided_prd
THEN:
  mode = "prd-import"
  Load: prd-import.md
  Use: Enhanced PRD + targeted Q&A

ELSE:
  mode = "standard"
  Use: IDEATE interrogation context
```

## The 8 Canonical Docs

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

## Mode-Specific Generation Order

### Standard Mode (from IDEATE)
Generate all 8 in order above - each from interrogation context.

### Reverse-Engineer Mode (from Code Analysis)

**Phase 1: Tech Docs from Code (5 docs)**
These are generated directly from code analysis:
1. TECH_STACK.md - from detected frameworks, dependencies
2. BACKEND_STRUCTURE.md - from schema, routes, models
3. FRONTEND_GUIDELINES.md - from components, patterns
4. DESIGN_SYSTEM.md (partial) - from CSS/styling analysis
5. APP_FLOW.md (partial) - from routes, navigation

**Phase 2: Complete Docs from Code + Q&A (3 docs + enhancements)**
After gap-filling interrogation:
6. PRD.md - from code features + business context Q&A
7. DESIGN_SYSTEM.md (complete) - enhance with rationale
8. APP_FLOW.md (complete) - enhance with user intent
9. IMPLEMENTATION_PLAN.md - for future features/improvements
10. CLAUDE.md - project-specific rules

**Load:** `reverse-engineer/doc-generation-from-code.md` for templates

### PRD Import Mode
1. PRD.md - already exists (enhanced if needed)
2. Generate remaining 7 docs using PRD as primary source

## Progressive Loading Rules

1. Load ONE generator template at a time
2. Generate that doc, present for review
3. User approves or requests changes
4. Move to next doc
5. Use `shared/cross-reference.md` to ensure consistency

## Workflow (STRICTLY SEQUENTIAL - ONE DOC AT A TIME)

**CRITICAL: Generate ONE document, STOP, wait for user to say "continue"**

### For Each Document:

#### Step 1: Announce What's Next
```
NEXT DOCUMENT: PRD.md (1/8)

I'm about to generate your Product Requirements Document.
This will take about 3-5 minutes.

Proceed? (Type "continue" or "yes")
```

**WAIT FOR USER RESPONSE. DO NOT PROCEED WITHOUT IT.**

#### Step 2: Generate Document
```
Generating PRD.md...

[Generate document from interrogation context]

Done! Writing to: docs/PRD.md
```

#### Step 3: Show Document Summary
```
PRD.md GENERATED

Sections included:
✓ Executive Summary
✓ Problem Statement
✓ Target Users (2 personas)
✓ Core Features (12 features, prioritized)
✓ Success Metrics
✓ Technical Constraints
✓ Scope Definition
✓ User Journeys

Length: 1,200 words
Location: docs/PRD.md

Please review the document.
```

#### Step 4: Wait for Approval
```
Is this PRD acceptable?

Options:
- "approve" or "looks good" → Move to next doc
- "revise [section]" → I'll update that section
- "show me [section]" → I'll display that section
```

**STOP HERE. WAIT FOR USER RESPONSE.**

#### Step 5: Handle Response

**If approved:**
```
✓ PRD.md approved and saved

Progress: 1/8 documents complete

NEXT DOCUMENT: APP_FLOW.md (2/8)

Ready to generate APP_FLOW.md?
Type "continue" when ready.
```

**STOP. WAIT FOR "continue".**

**If changes needed:**
```
Revising [section] in PRD.md...

Updated PRD.md saved.

Please review the changes.
Approve? (yes/revise more)
```

**STOP. WAIT FOR APPROVAL.**

### Repeat for All 8 Documents

This pattern repeats for each document:
1. Announce → WAIT
2. Generate → Show summary
3. Wait for approval → STOP
4. If approved → Announce next doc → WAIT for "continue"

## Progress Tracking (DO AFTER EVERY DOC OPERATION)

After generating/revising/approving a doc:
1. Read progress.txt
2. Update DOCUMENT section with:
   - Doc name and status
   - Approval timestamp
   - Next doc to generate
3. Write back to progress.txt

Example:
```
PHASE: DOCUMENT
STATUS: in_progress
current_doc: TECH_STACK.md
current_doc_status: awaiting_approval

DOCS COMPLETED:
✓ PRD.md - Approved 2025-02-15T11:45:00Z
✓ APP_FLOW.md - Approved 2025-02-15T12:10:00Z

DOCS IN PROGRESS:
⊙ TECH_STACK.md - Awaiting approval

DOCS PENDING:
- DESIGN_SYSTEM.md
- BACKEND_STRUCTURE.md
- FRONTEND_GUIDELINES.md
- IMPLEMENTATION_PLAN.md
- CLAUDE.md

NEXT ACTION: Wait for user to approve TECH_STACK.md
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

## Completion (After All 8 Docs Approved)

### Standard/PRD Import Mode

**After CLAUDE.md (8/8) is approved:**

```
DOCUMENTATION PHASE COMPLETE!

All 8 canonical documents generated and approved:

✓ PRD.md - Product requirements and scope
✓ APP_FLOW.md - User journeys and screens
✓ TECH_STACK.md - Technologies and versions
✓ DESIGN_SYSTEM.md - Colors, typography, components
✓ BACKEND_STRUCTURE.md - Database and APIs
✓ FRONTEND_GUIDELINES.md - Component patterns
✓ IMPLEMENTATION_PLAN.md - Step-by-step build sequence
✓ CLAUDE.md - Project-specific rules

All documents saved to: docs/

---

YOU ARE NOW READY TO BUILD!

The IMPLEMENTATION_PLAN.md has a complete roadmap.
We'll follow it step-by-step during the BUILD phase.

Would you like to:
1. Start BUILD phase now (type "continue" or "start building")
2. Review the docs first (type "show me [doc name]")
3. Revise any doc (type "revise [doc name]")

What would you like to do?
```

**STOP. WAIT FOR USER DECISION.**

**If user says "continue" or "start building":**
```
TRANSITIONING: DOCUMENT → BUILD

Loading BUILD phase workflow...
Reading IMPLEMENTATION_PLAN.md...

[Load references/engineer/main.md]

BUILD PHASE STARTING
[Continue with BUILD phase]
```

**If user wants to review:**
```
[Show requested document]

Anything to change? (yes/no/start building)
```

**If user wants to revise:**
```
[Revise requested document]

Updated!

All docs still complete. Ready to build?
Type "continue" to start BUILD phase.
```

### Reverse-Engineer Mode Completion

**After all docs generated from code + gap-filling:**

```
REVERSE-ENGINEERING COMPLETE!

8 documents generated from your codebase:

FROM CODE ANALYSIS:
✓ TECH_STACK.md - Technologies detected
✓ BACKEND_STRUCTURE.md - Database & API structure
✓ FRONTEND_GUIDELINES.md - Component patterns
✓ DESIGN_SYSTEM.md - Styling system
✓ APP_FLOW.md - User journeys mapped

FROM CODE + YOUR ANSWERS:
✓ PRD.md - Product requirements
✓ IMPLEMENTATION_PLAN.md - Future roadmap
✓ CLAUDE.md - Project rules

All docs saved to: docs/

---

WHAT'S NEXT?

Your codebase is now fully documented. Options:

1. ADD FEATURES
   Start IDEATE phase to plan new functionality
   Type: "add features" or "ideate"

2. IMPROVE CODE
   Start BUILD phase to enhance existing code
   - Refactor for better patterns
   - Add tests
   - Improve performance
   - Fix technical debt
   Type: "improve code" or "build"

3. DONE
   Keep the docs and exit workflow
   Type: "done" or "exit"

What would you like to do?
```

**[WAIT FOR USER DECISION]**

**If "add features":**
```
TRANSITIONING: REVERSE-ENGINEER → IDEATE

You already have docs for your existing features.
Now let's plan NEW features to add.

Loading IDEATE phase...
Mode: Add Features (existing codebase)

[Load references/interrogator/main.md with mode=add_features]
```

**If "improve code":**
```
TRANSITIONING: REVERSE-ENGINEER → BUILD

Your codebase is documented. Let's improve it.

Options:
1. Refactor - Better patterns, cleaner code
2. Add Tests - Increase coverage
3. Performance - Optimize slow areas
4. Security - Harden auth, fix vulnerabilities
5. Implement Planned - Build features in IMPLEMENTATION_PLAN.md

Which improvement area? (1-5 or describe)
```

**If "done":**
```
WORKFLOW COMPLETE

Your documentation is saved in docs/

Files created:
- docs/PRD.md
- docs/APP_FLOW.md
- docs/TECH_STACK.md
- docs/DESIGN_SYSTEM.md
- docs/BACKEND_STRUCTURE.md
- docs/FRONTEND_GUIDELINES.md
- docs/IMPLEMENTATION_PLAN.md
- docs/CLAUDE.md

You can return anytime with:
- /vibe-coding:reverse-engineer - Re-analyze codebase
- /vibe-coding:ideate - Plan new features
- /vibe-coding:build - Start building

Goodbye!
```
