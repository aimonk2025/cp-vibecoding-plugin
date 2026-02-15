# Workflow State Machine

## State Diagram

```
START
  ↓
  ├─ [New project] → IDEATE
  ├─ [Has PRD] → IDEATE (validation) or DOCUMENT
  └─ [Has code / Auto-detected] → REVERSE-ENGINEER

REVERSE-ENGINEER (codebase analysis) ──── NEW ────
  ├─ quick_scan_in_progress
  ├─ quick_scan_complete
  ├─ deep_analysis_in_progress
  ├─ deep_analysis_complete
  ├─ confidence_verification_pending
  ├─ confidence_verified
  ├─ tech_docs_generating
  ├─ tech_docs_complete
  ├─ gap_filling_in_progress
  ├─ gap_filling_complete
  ├─ complete_docs_generating
  └─ all_docs_complete → [User Choice]
      ├─ "Add features" → IDEATE (add features mode)
      ├─ "Improve code" → BUILD (enhancement mode)
      └─ "Done" → EXIT

IDEATE (interrogation)
  ├─ interrogation_started
  ├─ topic_in_progress [topic_name]
  ├─ topic_complete [topic_name]
  ├─ summary_generated
  └─ summary_approved → DOCUMENT
  
DOCUMENT (documentation)
  ├─ doc_in_progress [doc_name]
  ├─ doc_awaiting_approval [doc_name]
  ├─ doc_approved [doc_name]
  └─ all_docs_approved → BUILD

BUILD (implementation)
  ├─ phase_in_progress [phase_name]
  ├─ feature_in_progress [feature_name]
  ├─ feature_complete [feature_name]
  ├─ phase_complete [phase_name]
  ├─ bug_detected → DEBUG (temporary)
  └─ all_phases_complete → SHIP

DEBUG (bug fixing)
  ├─ investigating
  ├─ reproducing
  ├─ analyzing
  ├─ fixing
  ├─ verifying
  └─ verified → BUILD (resume)

SHIP (deployment)
  ├─ pre_flight_checks
  ├─ environment_setup
  ├─ deploying
  ├─ verifying_deployment
  ├─ smoke_tests
  └─ deployed → MONITOR

MONITOR (post-launch)
  ├─ monitoring
  ├─ issue_detected → DEBUG
  └─ stable
```

## State Transition Rules

### REVERSE-ENGINEER Internal Transitions

```
quick_scan_in_progress
  ↓ [scan complete]
quick_scan_complete
  ↓ [start deep analysis]
deep_analysis_in_progress
  ↓ [all 8 areas analyzed]
deep_analysis_complete
  ↓ [show summary]
confidence_verification_pending
  ↓ [user confirms or corrects]
confidence_verified
  ↓ [start doc generation]
tech_docs_generating
  ↓ [5 docs generated and approved]
tech_docs_complete
  ↓ [start gap-filling]
gap_filling_in_progress
  ↓ [all questions answered]
gap_filling_complete
  ↓ [generate remaining docs]
complete_docs_generating
  ↓ [all 8 docs complete]
all_docs_complete
  ↓ [present options]
[User Choice]
```

### REVERSE-ENGINEER → IDEATE

**Trigger:**
- User chooses "Add features" after reverse-engineering complete

**Conditions:**
- All 8 docs generated and approved
- Gap-filling complete

**Actions:**
1. Update progress.txt:
   ```
   PHASE: REVERSE-ENGINEER
   STATUS: complete
   completed: [timestamp]
   next_phase: IDEATE
   mode: add_features
   ```
2. Initialize IDEATE with context:
   ```
   PHASE: IDEATE
   STATUS: in_progress
   mode: add_features
   existing_features: [list from analysis]
   existing_docs: [PRD, APP_FLOW, ...]
   ```
3. Load `references/interrogator/main.md`
4. Set context: "Adding features to existing app"
5. Start interrogation focused on NEW features

### REVERSE-ENGINEER → BUILD

**Trigger:**
- User chooses "Improve code" after reverse-engineering complete

**Conditions:**
- All 8 docs generated and approved
- Gap-filling complete

**Actions:**
1. Update progress.txt:
   ```
   PHASE: REVERSE-ENGINEER
   STATUS: complete
   completed: [timestamp]
   next_phase: BUILD
   mode: enhancement
   ```
2. Initialize BUILD with context:
   ```
   PHASE: BUILD
   STATUS: in_progress
   mode: enhancement
   available_actions: [refactor, add_tests, improve_performance, fix_bugs, implement_planned]
   ```
3. Load `references/engineer/main.md`
4. Present improvement options
5. Start enhancement workflow

### REVERSE-ENGINEER → EXIT

**Trigger:**
- User chooses "Just keep docs" after reverse-engineering complete

**Actions:**
1. Update progress.txt:
   ```
   PHASE: REVERSE-ENGINEER
   STATUS: complete
   completed: [timestamp]
   outcome: docs_only
   ```
2. Show summary of generated docs
3. Exit workflow

### IDEATE → DOCUMENT

**Conditions:**
- All 10 topics marked complete
- Summary generated
- User approved summary

**Actions:**
1. Update progress.txt:
   ```
   PHASE: IDEATE
   STATUS: complete
   completed: [timestamp]
   ```
2. Initialize DOCUMENT phase:
   ```
   PHASE: DOCUMENT
   STATUS: in_progress
   started: [timestamp]
   current_doc: none
   docs_to_generate: [PRD, APP_FLOW, TECH_STACK, ...]
   ```
3. Load `references/doc-architect/main.md`
4. Start with first doc (PRD)

### DOCUMENT → BUILD

**Conditions:**
- All 8 canonical docs generated
- All docs approved by user
- IMPLEMENTATION_PLAN.md exists

**Actions:**
1. Mark DOCUMENT complete
2. Initialize BUILD phase
3. Load `references/engineer/main.md`
4. Read IMPLEMENTATION_PLAN.md
5. Start with Phase 1, Step 1

### BUILD → DEBUG (temporary)

**Trigger:**
- Error detected during build
- Test failure
- Bug reported

**Actions:**
1. Pause BUILD (save current step)
2. Create DEBUG session:
   ```
   DEBUG SESSION #1
   triggered_from: BUILD - Phase 2, Step 3
   issue: [description]
   status: investigating
   ```
3. Load `references/debugger/main.md`
4. Begin investigation

### DEBUG → BUILD (resume)

**Conditions:**
- Bug fixed
- Tests passing
- No regressions

**Actions:**
1. Mark DEBUG session complete
2. Update progress.txt with fix details
3. Resume BUILD from saved step
4. Continue implementation

### BUILD → SHIP

**Conditions:**
- All implementation phases complete
- All tests passing
- No critical bugs

**Actions:**
1. Mark BUILD complete
2. Initialize SHIP phase
3. Load `references/shipper/main.md`
4. Run pre-flight checklist

## State Persistence

Every state change writes to progress.txt:

```
STATE_HISTORY:
[2025-02-15 10:30] IDEATE started
[2025-02-15 10:35] IDEATE topic_in_progress: core-concept
[2025-02-15 10:45] IDEATE topic_complete: core-concept
[2025-02-15 10:46] IDEATE topic_in_progress: users
[2025-02-15 11:00] IDEATE topic_complete: users
[2025-02-15 11:30] IDEATE summary_generated
[2025-02-15 11:32] IDEATE summary_approved
[2025-02-15 11:32] DOCUMENT started
[2025-02-15 11:35] DOCUMENT doc_in_progress: PRD
```

## Recovery Protocol

On session start:
1. Read progress.txt
2. Parse CURRENT STATE
3. Parse STATE_HISTORY (last entry = current state)
4. Load appropriate phase main.md
5. Show user: "Resuming [PHASE] from [STEP]"
6. Continue from NEXT ACTION

## Workflow Commands

Users can control workflow with:

| Command | Action |
|---------|--------|
| "continue" | Resume from NEXT ACTION |
| "where are we?" | Show CURRENT STATE |
| "go back" | Revert to previous state |
| "restart phase" | Reset current phase |
| "skip to BUILD" | Force transition (with warning) |
| "show history" | Display STATE_HISTORY |

## Error States

### Stuck in Phase

**Detection:**
- Same state for > 30 minutes
- User says "I'm stuck"

**Recovery:**
1. Show progress in current phase
2. Offer options:
   - Continue current topic
   - Skip to next topic
   - Get help with current step
   - Restart phase

### Invalid Transition

**Detection:**
- User requests transition before conditions met

**Action:**
1. Show missing conditions
2. Offer to complete them
3. Block transition until ready

Example:
```
User: "Let's start building"
Claude: "Cannot transition to BUILD yet. Missing:
  - DOCUMENT phase not complete
  - 3 docs still need approval: TECH_STACK, BACKEND_STRUCTURE, FRONTEND_GUIDELINES
  
  Would you like to:
  1. Continue reviewing docs
  2. Approve all remaining docs
  3. Go back and revise a doc"
```
