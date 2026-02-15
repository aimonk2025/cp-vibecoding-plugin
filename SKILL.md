---
name: vibe-coding
description: |
  Complete vibe coding system for building software from idea to shipped product.
  Handles the entire development lifecycle through 5 phases: ideation, documentation,
  building, debugging, and shipping. Use when:
  (1) User wants to build ANY software project ("build me an app", "create app", "new project")
  (2) User says "vibe", "vibe coding", "vibe code this", or "help me build"
  (3) User needs requirements gathering ("what should I build", "plan my app")
  (4) User needs documentation ("create PRD", "write specs", "generate docs")
  (5) User has bugs ("fix this", "debug", "not working", "error")
  (6) User wants to deploy ("ship", "deploy", "launch", "go live")
  (7) User asks "what's next?", "where am I?", "continue", "resume"
---

# Vibe Coding

Build software from vague idea to shipped product through 5 phases.

## Instructions

### Step 1: Determine Phase

Ask user or detect from their message:

| User Says | Phase | Load |
|-----------|-------|------|
| "new idea", "want to build", "plan" | IDEATE | `references/interrogator/main.md` |
| "create docs", "PRD", "specs" | DOCUMENT | `references/doc-architect/main.md` |
| "start coding", "build", "implement" | BUILD | `references/engineer/main.md` |
| "bug", "broken", "error", "fix" | DEBUG | `references/debugger/main.md` |
| "ship", "deploy", "launch" | SHIP | `references/shipper/main.md` |
| "continue", "resume", "status" | CHECK | Read user's `progress.txt` |

If unclear, show phase selector:

```
Which phase?

[1] IDEATE    - Have idea, need requirements (~50 questions)
[2] DOCUMENT  - Know what to build, need specs
[3] BUILD     - Have docs, ready to code
[4] DEBUG     - Something broken, need fix
[5] SHIP      - Ready to deploy
[6] CONTINUE  - Resume previous session
```

### Step 2: Load Phase Reference

Load ONLY the main.md for the selected phase. Each main.md contains:
- Phase-specific workflow
- When to load sub-files within that phase
- Handoff instructions to next phase

### Step 3: Execute Phase Workflow

Follow the loaded phase's instructions. Key behaviors:
- IDEATE: Ask exhaustive questions, one category at a time
- DOCUMENT: Generate docs one at a time, get approval
- BUILD: Implement features step by step
- DEBUG: Investigate, fix, verify
- SHIP: Pre-flight checks, deploy, monitor

### Step 4: Track Progress

Create/update `progress.txt` in user's project:

```
phase: BUILD
step: 3/8
last_action: Implemented auth
next_action: Build dashboard
```

## Examples

### Example 1: New Project

User says: "I want to build a task management app"

Actions:
1. Detect IDEATE phase (new project)
2. Load `references/interrogator/main.md`
3. Show category menu, ask questions exhaustively
4. Generate summary, transition to DOCUMENT phase

Result: Complete requirements captured, ready for documentation

### Example 2: Resume Session

User says: "continue where we left off"

Actions:
1. Read `progress.txt` from project
2. Determine current phase and step
3. Load appropriate phase main.md
4. Resume from last action

Result: Seamless continuation of previous session

### Example 3: Fix Bug

User says: "the login isn't working"

Actions:
1. Detect DEBUG phase (bug report)
2. Load `references/debugger/main.md`
3. Investigate, reproduce, analyze
4. Fix and verify

Result: Bug fixed with no regressions

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

### Phase References (load one at a time based on phase)

- `references/interrogator/main.md` - IDEATE phase workflow
- `references/doc-architect/main.md` - DOCUMENT phase workflow
- `references/engineer/main.md` - BUILD phase workflow
- `references/debugger/main.md` - DEBUG phase workflow
- `references/shipper/main.md` - SHIP phase workflow

### Within Each Phase

Each phase's main.md tells you when to load its sub-files. For example:
- In IDEATE: Load one category file at a time (core-concept.md, users.md, etc.)
- In DOCUMENT: Load one generator at a time (prd.md, app-flow.md, etc.)

See each phase's main.md for specific guidance.
