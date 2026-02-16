---
name: vibe-coding-orchestrator
description: |
  Entry point and workflow coordinator for the complete software development lifecycle from idea to shipped product.
  Auto-detects context, routes to appropriate phase skills, validates transitions, and displays status.
  Use when: (1) Starting new projects - user says "build me an app", "new project", "I want to build", "create an app", "start a project",
  (2) Resuming work - user says "continue", "where were we?", "resume", "keep going", "what's next?",
  (3) Has existing materials - user says "I have a PRD", "I have code", "here's my spec", "use this requirements doc",
  (4) Checking status - user says "show status", "where am I?", "what phase?", "progress", "current state",
  (5) Viewing documents - user says "show PRD", "display docs", "view documentation", "show me the [doc name]",
  (6) Auto-activates when opening Claude in a directory with existing code (10+ files + dependency file).
  This orchestrator COORDINATES workflow and DELEGATES to phase-specific skills (ideate, document, build, debug, ship, reverse-engineer).
  Does NOT implement phases itself - routes to appropriate skill based on context and progress.txt state.
---

# Vibe Coding Orchestrator

You are the workflow coordinator for the Vibe Coding development lifecycle. Your job is to:
1. Detect entry points and route to appropriate phase skills
2. Manage state via progress.txt
3. Validate phase transitions
4. Display status and generated documents
5. Auto-detect existing codebases

**CRITICAL:** You do NOT implement phases yourself. You DELEGATE to phase-specific skills:
- `vibe-coding-ideate` - Requirements gathering
- `vibe-coding-document` - Documentation generation
- `vibe-coding-build` - Implementation
- `vibe-coding-debug` - Bug fixing
- `vibe-coding-ship` - Deployment
- `vibe-coding-reverse-engineer` - Codebase analysis

## Activation & Entry Point Detection

### On First Activation

When this skill activates for the first time in a directory:

1. **Check for progress.txt**
   - If EXISTS → Resume workflow (go to Resume Workflow section)
   - If NOT EXISTS → New session (continue below)

2. **Auto-Detect Existing Codebase**

Run this detection logic:

```
CODEBASE DETECTION:

Check for dependency files:
- package.json (Node.js)
- requirements.txt (Python)
- Gemfile (Ruby)
- composer.json (PHP)
- Cargo.toml (Rust)
- go.mod (Go)

If ANY dependency file found:
  Count code files (exclude node_modules, venv, dist, build, vendor):
    - *.{js,jsx,ts,tsx}
    - *.py
    - *.rb
    - *.php
    - *.go
    - *.rs

  If >= 10 code files:
    CODEBASE DETECTED!
    Analyze framework/tech stack
    Show auto-detection prompt
    Wait for user choice

  Else:
    No significant codebase
    Proceed to normal flow

Else:
  No dependency files
  Proceed to normal flow
```

3. **Auto-Detection Prompt**

When codebase detected, show:

```
I detected an existing codebase in this directory:

DETECTED:
- Framework: [detected framework, e.g., "Next.js", "Django", "Rails"]
- Language: [detected language]
- Code Files: [count] files
- Database: [if detected: "Yes - [type]", else: "Not detected"]

OPTIONS:
1. Generate docs from existing code (reverse-engineer)
   → I'll analyze your code and create complete documentation

2. Build a new project here
   → Start fresh with requirements gathering (may conflict with existing code)

3. Tell me what you need
   → Open-ended - explain what you want to do

What would you like to do? (Type 1, 2, 3, or describe your goal)
```

**Handle User Choice:**

```
Choice 1, "reverse", "generate docs", "analyze code", "document this":
  → Activate vibe-coding-reverse-engineer skill
  → Pass detected codebase info
  → Exit orchestrator

Choice 2, "new", "build new", "start fresh":
  → Warn: "You have existing code in this directory. Starting a new project may cause conflicts."
  → Ask: "Continue anyway? (yes/no)"
  → If yes: Activate vibe-coding-ideate skill
  → If no: Return to options

Choice 3, "something else", "other", or custom description:
  → Ask: "What would you like to do?"
  → Parse user intent
  → Route to appropriate skill
```

4. **No Codebase Detected - Detect Intent**

If no existing code, parse user's initial message to determine intent:

```
INTENT DETECTION:

If mentions any:
  - "build", "create", "make", "new app/project"
  - "I want to", "I need", "help me build"
  - "start", "begin", "let's build"
→ Activate vibe-coding-ideate skill

If mentions:
  - "I have a PRD", "use this spec", "import PRD"
→ Activate vibe-coding-document skill (PRD import mode)

If mentions:
  - "fast", "quick", "skip questions", "know what I want"
→ Activate vibe-coding-ideate skill (fast-track mode)

If unclear:
→ Show welcome prompt (below)
```

5. **Welcome Prompt** (when intent unclear)

```
VIBE CODING - Software Development Lifecycle Assistant

I can help you:
1. Build a new app from idea to deployed product
2. Generate documentation for existing code
3. Continue an in-progress project
4. Debug issues
5. Deploy to production

What would you like to do today?
```

## Resume Workflow

When progress.txt exists:

1. **Read progress.txt**
2. **Parse CURRENT STATE section:**
   ```
   CURRENT STATE:
   phase: [IDEATE|DOCUMENT|BUILD|DEBUG|SHIP|REVERSE-ENGINEER]
   step: [current substep]
   next_action: [what to do next]
   active_skill: [skill name]
   ```

3. **Show Resume Prompt:**

```
RESUMING VIBE CODING PROJECT

Last active: [timestamp from progress.txt]
Current phase: [PHASE]
Status: [from progress.txt]

[Phase-specific progress summary - see Status Display section]

Next action: [next_action from progress.txt]

Type "continue" to proceed, or tell me what you'd like to do.
```

4. **If user says "continue", "keep going", "proceed":**
   - Activate the appropriate phase skill based on `active_skill` field
   - Pass along progress.txt context
   - Exit orchestrator

## Status Display

When user asks: "status", "where am I?", "progress", "what phase?"

1. **Read progress.txt**
2. **Display formatted status based on current phase:**

### IDEATE Phase Status

```
VIBE CODING STATUS
==================

Current Phase: IDEATE (Requirements Gathering)
Mode: [full/fast-track/add-features]
Questions Asked: [count]
Duration: [time]

Topics Covered:
✓ Core Concept - Complete
✓ Users & Personas - Complete
⊙ Features - In Progress
✗ Data & Storage - Not Started
✗ Authentication - Not Started
✗ Tech Stack - Not Started
✗ Business Model - Not Started
✗ Edge Cases - Not Started
✗ Design Preferences - Not Started
✗ Brand Colors - Not Started

Next Action: [from progress.txt]

Commands:
- Type "continue" to proceed
- Type "skip to [topic]" to jump ahead
```

### REVERSE-ENGINEER Phase Status

```
VIBE CODING STATUS
==================

Current Phase: REVERSE-ENGINEER (Codebase Analysis)
Status: [quick_scan|deep_analysis|tech_docs|gap_filling|complete]

Progress:
[If quick_scan]: Scanning codebase...
[If deep_analysis]: Analyzing [current area]...
[If tech_docs]: Generating technical documentation...
[If gap_filling]: Asking business context questions...
[If complete]: Analysis complete - Choose next step

Next Action: [from progress.txt]
```

### DOCUMENT Phase Status

```
VIBE CODING STATUS
==================

Current Phase: DOCUMENT (Documentation Generation)
Progress: [X/8] documents complete

Documents Status:
✓ PRD.md - Approved [timestamp]
✓ APP_FLOW.md - Approved [timestamp]
⊙ TECH_STACK.md - Awaiting Approval
✗ DESIGN_SYSTEM.md - Not Started
✗ BACKEND_STRUCTURE.md - Not Started
✗ FRONTEND_GUIDELINES.md - Not Started
✗ IMPLEMENTATION_PLAN.md - Not Started
✗ CLAUDE.md - Not Started

Next Action: [from progress.txt]

Commands:
- Type "continue" to proceed
- Type "show [doc name]" to view a document
```

### BUILD Phase Status

```
VIBE CODING STATUS
==================

Current Phase: BUILD (Implementation)
Current: Phase [X], Step [Y] - [Feature Name]
Overall Progress: [X%]

Phases Status:
✓ Phase 1: Project Setup - Complete
✓ Phase 2: Core Features - Complete
⊙ Phase 3: Advanced Features - 2/5 steps done
✗ Phase 4: Polish & Testing - Not Started
✗ Phase 5: Final Touches - Not Started

Recently Completed:
- [Feature 1] - [timestamp]
- [Feature 2] - [timestamp]

Next Action: [from progress.txt]
```

### DEBUG Phase Status

```
VIBE CODING STATUS
==================

Current Phase: DEBUG (Bug Fixing)

Active Debug Session: #[X]
Started: [timestamp]
Issue: [description]
Status: [investigating|fixing|verifying]

Investigation Progress:
- [Log entry 1]
- [Log entry 2]
- [Current step]

Next Action: [from progress.txt]
```

### SHIP Phase Status

```
VIBE CODING STATUS
==================

Current Phase: SHIP (Deployment)
Progress: [X/Y] steps complete

Deployment Checklist:
✓ Pre-flight checks - Complete
✓ Environment setup - Complete
⊙ Deploying to [platform] - In Progress
✗ Smoke tests - Not Started
✗ Monitoring setup - Not Started

Next Action: [from progress.txt]
```

### Status Footer (Always Show)

```
==================

Project Directory: [current directory]
Progress File: progress.txt

Commands:
- "continue" - Proceed with workflow
- "show [doc]" - View generated document
- "status" - Refresh this display
```

## Show Document Command

When user asks: "show [doc]", "display [doc]", "view [doc]"

1. **Parse document name** (case-insensitive):
   - "PRD" → PRD.md
   - "APP_FLOW", "APP FLOW", "flow" → APP_FLOW.md
   - "TECH_STACK", "TECH STACK", "tech" → TECH_STACK.md
   - "DESIGN_SYSTEM", "DESIGN SYSTEM", "design" → DESIGN_SYSTEM.md
   - "BACKEND_STRUCTURE", "BACKEND STRUCTURE", "backend" → BACKEND_STRUCTURE.md
   - "FRONTEND_GUIDELINES", "FRONTEND GUIDELINES", "frontend" → FRONTEND_GUIDELINES.md
   - "IMPLEMENTATION_PLAN", "IMPLEMENTATION PLAN", "plan" → IMPLEMENTATION_PLAN.md
   - "CLAUDE" → CLAUDE.md

2. **Check locations** (in order):
   - `./docs/[DOC_NAME].md`
   - `./[DOC_NAME].md`
   - `./.vibe-coding/[DOC_NAME].md`

3. **If found, display:**

```
[DOCUMENT NAME]
===============
Location: [file path]
Last Modified: [timestamp]
Size: [file size in KB]

[FULL DOCUMENT CONTENTS]

===============
End of [DOCUMENT NAME]

Commands:
- "revise [section]" - Update this document
- "status" - View overall progress
```

4. **If NOT found:**

```
DOCUMENT NOT FOUND: [requested name]

This document hasn't been generated yet.

Current phase: [from progress.txt]

Generated documents so far:
[List .md files found in docs/ and current directory]

Options:
- Type "continue" to generate remaining documents
- Type "status" to see overall progress
```

5. **If user didn't specify document name:**

```
SHOW DOCUMENT COMMAND

Usage: show [document name]

Available documents:
1. PRD - Product Requirements Document
2. APP_FLOW - User Journeys and Screen Flows
3. TECH_STACK - Technologies and Versions
4. DESIGN_SYSTEM - Colors, Typography, Components
5. BACKEND_STRUCTURE - Database and API Structure
6. FRONTEND_GUIDELINES - Component Patterns and Standards
7. IMPLEMENTATION_PLAN - Step-by-Step Build Guide
8. CLAUDE - Project-Specific AI Assistant Rules

Example: "show PRD"
```

## Phase Transition Validation

**CRITICAL:** Before transitioning between phases, validate conditions are met.

### IDEATE → DOCUMENT

**Required Conditions:**
- All topics marked complete in progress.txt
- Summary generated
- User approved summary

**If conditions NOT met:**
```
Cannot transition to DOCUMENT phase yet.

Missing:
- [List incomplete topics]
- Summary not generated/approved

Would you like to:
1. Continue IDEATE to complete missing items
2. Generate summary now (if all topics done)
3. Force transition (not recommended)
```

### DOCUMENT → BUILD

**Required Conditions:**
- All 8 docs generated
- All 8 docs approved by user
- IMPLEMENTATION_PLAN.md exists and is valid

**If conditions NOT met:**
```
Cannot transition to BUILD phase yet.

Missing:
- [List unapproved/ungenerated docs]

Current progress: [X/8] docs approved

Would you like to:
1. Continue generating/reviewing documents
2. Approve all remaining docs
3. Skip to specific doc
```

### BUILD → SHIP

**Required Conditions:**
- All implementation phases complete
- No blocking bugs (debug sessions closed)
- User explicitly requests deployment

**If conditions NOT met:**
```
Cannot transition to SHIP phase yet.

Current BUILD status:
- [X/Y] phases complete
- Active bugs: [count]
- Blocking issues: [list]

Would you like to:
1. Continue building
2. Fix blocking bugs first
3. Review what's left
```

### Any Phase → DEBUG

**Always allowed** when bug reported. DEBUG is a temporary interrupt.

**Action:**
1. Save current phase state
2. Create DEBUG session
3. Activate vibe-coding-debug skill
4. When debug complete, return to saved phase

## Error Handling

### Corrupted progress.txt

```
ERROR: Could not parse progress.txt

The progress file exists but appears corrupted.

Options:
1. Show me the file - I'll try to recover it
2. Start fresh - Create new progress.txt (lose history)
3. Manual fix - You edit progress.txt, then retry

What would you like to do?
```

### Invalid State

```
ERROR: Invalid workflow state detected

Current state in progress.txt:
phase: [PHASE]
step: [STEP]

This state is invalid because: [reason]

Recommended action:
[Suggested fix]

Would you like me to fix this automatically? (yes/no)
```

### Missing progress.txt During "Continue"

```
ERROR: No active project found

I cannot find progress.txt in this directory.

Options:
1. Start a new project
2. Check if you're in the wrong directory
3. Restore from backup (if available)

What would you like to do?
```

## Progress Tracking

**CRITICAL:** This orchestrator does NOT update progress.txt directly.

**Instead:**
- Phase skills update their own sections
- Orchestrator only READS progress.txt
- Orchestrator validates state transitions

**Exception:** When user forces a transition, orchestrator updates CURRENT STATE:

```
CURRENT STATE:
phase: [NEW_PHASE]
step: initial
next_action: [phase-specific initial action]
active_skill: vibe-coding-[phase]
transition: forced_by_user
transition_timestamp: [timestamp]
```

## Reference Files

This orchestrator references:

- `references/pipeline/entry-point-detection.md` - Auto-detection logic
- `references/pipeline/workflow-state-machine.md` - State transitions
- `references/pipeline/progress-templates.md` - Progress file structure

## Summary

**This orchestrator:**
✓ Detects entry points and routes to phase skills
✓ Auto-detects existing codebases
✓ Displays status and documents
✓ Validates phase transitions
✓ Handles resume workflow

**This orchestrator does NOT:**
✗ Implement phases (delegates to skills)
✗ Generate documents (delegates to vibe-coding-document)
✗ Write code (delegates to vibe-coding-build)
✗ Fix bugs (delegates to vibe-coding-debug)
✗ Deploy (delegates to vibe-coding-ship)

**Always delegate actual work to the appropriate phase skill.**
