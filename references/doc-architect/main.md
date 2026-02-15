# Doc Architect Phase

Generate canonical documentation from interrogation requirements.

**CRITICAL RULE: ONE DOCUMENT AT A TIME - NEVER GENERATE MULTIPLE IN PARALLEL**

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

**After CLAUDE.md (8/8) is approved:**

```
🎉 DOCUMENTATION PHASE COMPLETE!

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
