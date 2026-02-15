---
name: vibe-coding
description: |
  Complete vibe coding system for building software from idea to shipped product.
  Handles the entire development lifecycle through 5 phases with FLEXIBLE ENTRY POINTS.
  Use when:
  (1) User wants to build ANY software project ("build me an app", "new project")
  (2) User has existing PRD/requirements ("use this PRD", "I have requirements")
  (3) User has existing codebase ("generate docs from my code/app/codebase/project", "document this project/codebase/app", "create PRD from code/app", "reverse engineer", "analyze my code/app/project")
  (4) User wants fast-track ("skip the questions", "I know what I want")
  (5) User needs documentation ("create PRD", "write specs", "generate docs")
  (6) User has bugs ("fix this", "debug", "not working", "error")
  (7) User wants to deploy ("ship", "deploy", "launch")
  (8) User asks "what's next?", "where am I?", "continue", "resume"

  AUTO-DETECTS existing code when plugin activates and offers to reverse-engineer it.

  CAN START FROM ANY PHASE - detects what user has and adapts workflow accordingly.
---

# Vibe Coding

Build software from vague idea to shipped product through 5 phases with complete state tracking.

## Critical: Progress File

**`progress.txt` is the single source of truth for all workflow state.**

### First Action (Always):
When user starts any vibe coding session:
1. Check if `progress.txt` exists
2. **If NO:** Create it using template from `references/pipeline/progress-templates.md`
3. **If YES:** Read it to determine current phase and resume point

### Continuous Updates:
Update progress.txt after EVERY interaction. This file must contain:
- Full conversation transcript (IDEATE)
- All Q&A exchanges with timestamps
- Topic completion status
- Documents generated and their approval status
- Features implemented and files changed
- Debug sessions and fixes applied
- Deployment steps and status
- Always: NEXT ACTION for resuming

### Why This Matters:
- Sessions can be resumed seamlessly
- Nothing is lost between sessions
- User can see exactly where they are
- Workflow is stateless and recoverable

## Instructions

### Step 1: Detect Entry Point (CRITICAL - Read First!)

**Load:** `references/pipeline/entry-point-detection.md`

Users can start from ANY phase. Detect what they have:

| User Says | Entry Point | Action |
|-----------|-------------|--------|
| "new idea", "want to build" | IDEATE (full) | Load `interrogator/main.md` + `conversation-engine.md` |
| "I have a PRD", "use this spec" | DOCUMENT (from PRD) | Load `doc-architect/prd-import.md` |
| "generate docs for my code" | DOCUMENT (reverse) | Load `doc-architect/codebase-analysis.md` |
| "skip the questions" | IDEATE (fast-track) | Load `interrogator/fast-track.md` |
| "I have docs, let's build" | BUILD | Validate docs, load `engineer/main.md` |
| "bug", "broken", "error" | DEBUG | Load `debugger/main.md` |
| "ship", "deploy" | SHIP | Load `shipper/main.md` |
| "continue", "resume" | RESUME | Read `progress.txt` and resume |

**VALIDATION REQUIRED:**
- If user provides PRD → Validate quality (0-100%)
- If user has partial docs → Check what's missing
- If user wants to build → Verify required docs exist
- If PRD incomplete → Enhance through targeted questions

**Example Detections:**

User: "I have this PRD: [pastes content]"
→ Read PRD, validate quality, enhance if needed, generate other docs

User: "Generate docs for my Next.js app"
→ Scan codebase, generate tech docs from code, ask questions for PRD

User: "Skip the 50 questions, I know what I want"
→ Fast-track mode: 10 essential questions instead of full conversation

### Step 2: Load Phase Reference

Load ONLY the main.md for the selected phase. Each main.md contains:
- Phase-specific workflow
- When to load sub-files within that phase
- Handoff instructions to next phase

### Step 3: Execute Phase Workflow

Follow the loaded phase's instructions. Key behaviors:

**IDEATE: Interactive Conversation**
- ONE question at a time, adapt based on answers
- Do NOT dump lists of questions
- Ask ONE question, wait for answer
- Analyze for gaps, vagueness, assumptions
- Ask follow-up based on what you learned
- Build context progressively

**DOCUMENT: Sequential Document Generation**
- **CRITICAL: ONE document at a time - NEVER parallel**
- Generate doc → Show summary → WAIT for approval
- After approval → Announce next doc → WAIT for "continue"
- Repeat for all 8 documents
- After doc 8/8 approved → Announce BUILD phase ready
- See `references/doc-architect/sequential-workflow-example.md`

**BUILD: Step-by-Step Implementation**
- Implement features step by step
- Update progress.txt after each feature
- Follow IMPLEMENTATION_PLAN.md exactly

**DEBUG: Systematic Investigation**
- Investigate, fix, verify
- Log session in progress.txt

**SHIP: Pre-Flight and Deploy**
- Pre-flight checks, deploy, monitor
- Track deployment steps

### Step 4: Track Progress (CRITICAL - DO CONTINUOUSLY)

**MANDATORY: Update progress.txt after EVERY significant action.**

#### When to Update progress.txt:
- After asking a question (IDEATE)
- After receiving an answer (IDEATE)
- After completing a topic (IDEATE)
- After generating a document (DOCUMENT)
- After doc approval/revision (DOCUMENT)
- After implementing a feature (BUILD)
- After fixing a bug (DEBUG)
- After deployment step (SHIP)

#### Initial Creation:
When starting IDEATE, create `progress.txt` using template from `references/pipeline/progress-templates.md`

#### Update Pattern:
1. Read current progress.txt
2. Parse relevant section for current phase
3. Append new information (Q&A, doc status, feature completion, etc.)
4. Update timestamps
5. Set NEXT ACTION
6. Write back to progress.txt

#### Example Updates:

**IDEATE:**
```
INTERROGATION TRANSCRIPT:
Q: What's the one-sentence description of what you want to build?
A: A task management app for busy parents

TOPICS COVERED:
✓ Core Concept - Complete
⊙ Users - In progress

NEXT ACTION: Continue interrogation - ask about user personas
```

**DOCUMENT:**
```
DOCS COMPLETED:
✓ PRD.md - Approved 2025-02-15T13:00:00Z
⊙ APP_FLOW.md - Awaiting approval

NEXT ACTION: Wait for user approval of APP_FLOW.md
```

**BUILD:**
```
FEATURES COMPLETED:
✓ Phase 1, Step 1: Project setup
⊙ Phase 2, Step 3: User Dashboard (in progress)

FILES CHANGED:
- src/components/Dashboard.tsx (created)

NEXT ACTION: Complete Dashboard component and tests
```

**See `references/pipeline/progress-templates.md` for complete templates.**

## Examples

### Example 1: New Project (Full Interrogation)

User: "I want to build a task management app"

Actions:
1. Detect entry point: New project (no existing materials)
2. Load `interrogator/main.md` + `conversation-engine.md`
3. Ask opening question: "What's the one-sentence description?"
4. Continue adaptive conversation (ONE question at a time)
5. Generate summary → Move to DOCUMENT phase

Result: Complete requirements from natural 30-min conversation

### Example 2: User Has Existing PRD

User: "I have a PRD. Here it is: [pastes content]"

Actions:
1. Detect entry point: User-provided PRD
2. Load `doc-architect/prd-import.md`
3. Parse and validate PRD (calculate quality score)
4. If 42% (Basic) → Ask 15 targeted questions to enhance
5. Rebuild PRD with enhanced content
6. Generate remaining 7 docs

Result: Complete doc suite from basic PRD + 15-min Q&A

### Example 3: Existing Codebase

User: "Generate docs for my Next.js project"

Actions:
1. Detect entry point: Existing codebase
2. Load `doc-architect/codebase-analysis.md`
3. Scan code: Find React, PostgreSQL, 15 components
4. Generate TECH_STACK, BACKEND_STRUCTURE, FRONTEND_GUIDELINES from code
5. Ask questions about "why" (problem, users, goals)
6. Generate PRD, APP_FLOW from code + Q&A

Result: Full doc suite reverse-engineered from code + 20-min Q&A

### Example 4: Fast-Track Mode

User: "Skip the long questions, I know what I want"

Actions:
1. Detect entry point: Fast-track request
2. Load `interrogator/fast-track.md`
3. Ask 10 essential questions (not 50)
4. Generate summary → Move to DOCUMENT phase

Result: Requirements captured in 10 minutes instead of 30

### Example 5: Resume Session

User: "continue"

Actions:
1. Read `progress.txt`
2. Find: "DOCUMENT phase, 5/8 docs done, next: DESIGN_SYSTEM.md"
3. Load `doc-architect/main.md`
4. Resume generating DESIGN_SYSTEM.md

Result: Seamless continuation from exact stopping point

### Example 6: Fix Bug

User: "the login isn't working"

Actions:
1. Detect entry point: Bug report
2. Load `debugger/main.md`
3. Investigate → Fix → Verify
4. Update progress.txt with debug session

Result: Bug fixed, lesson learned captured

## Troubleshooting

### Skill doesn't trigger

Cause: User request too vague

Solution: Add explicit trigger phrases like "vibe code", "build me", "new project"

### Wrong phase detected

Cause: Ambiguous user intent

Solution: Show phase selector and ask user to choose

### Progress lost between sessions

Cause: No progress.txt file

Solution: Always create/update progress.txt after each significant action

### Phase transition confusion

Cause: Unclear handoff

Solution: Each phase main.md has explicit "Completion" section with handoff instructions

## Reference Files

### Entry Point & Workflow Management (NEW - Load First!)

- `references/pipeline/entry-point-detection.md` - Flexible entry point system
- `references/pipeline/state-management.md` - Progress file management
- `references/pipeline/workflow-state-machine.md` - Phase transitions
- `references/pipeline/progress-templates.md` - progress.txt templates

### Phase References (load based on detected entry point)

- `references/interrogator/main.md` - IDEATE phase (full conversation)
- `references/interrogator/conversation-engine.md` - Adaptive questioning system
- `references/interrogator/fast-track.md` - 10-question fast mode
- `references/doc-architect/main.md` - DOCUMENT phase workflow
- `references/doc-architect/prd-import.md` - Import & enhance user PRDs
- `references/doc-architect/codebase-analysis.md` - Generate docs from code
- `references/engineer/main.md` - BUILD phase workflow
- `references/debugger/main.md` - DEBUG phase workflow
- `references/shipper/main.md` - SHIP phase workflow

### Within Each Phase

Each phase's main.md tells you when to load its sub-files. For example:
- In IDEATE: Load category files as conversation flows (core-concept.md, users.md, etc.)
- In DOCUMENT: Load generator templates one at a time (prd.md, app-flow.md, etc.)
- In BUILD: Load protection-rules.md, engineering-standards.md as needed

## Key Capabilities Summary

✅ **Start from Anywhere** - New project, existing PRD, existing code, or any phase
✅ **Smart Validation** - PRD quality check (0-100%), enhances if incomplete
✅ **Reverse Engineering** - Generate docs from existing codebase
✅ **Fast-Track Mode** - 10 questions instead of 50 for quick starts
✅ **Session Recovery** - Resume from exact point via progress.txt
✅ **Interactive Conversation** - ONE question at a time, adapts based on answers
✅ **Complete State Tracking** - Full transcript, decisions, and next actions preserved
