---
name: vibe-coding-debug
description: |
  Systematic bug investigation and surgical fixing with investigation logging and lessons learned.
  Creates debug sessions, reproduces bugs, analyzes root cause, applies minimal fixes, verifies resolution, then resumes BUILD.
  Use when: (1) Bug reports - user says "it's broken", "fix this bug", "error", "not working", "something's wrong", "this isn't working",
  (2) Test failures - user says "tests failing", "test errors", "tests broken", "CI is red", "tests don't pass",
  (3) Debug requests - user says "help me debug", "investigate this", "find the bug", "why is this happening?", "figure out what's wrong",
  (4) Orchestrator delegates DEBUG phase based on workflow state,
  (5) BUILD phase encounters blocking error - orchestrator temporarily interrupts BUILD to create debug session.
  Creates numbered debug sessions (#1, #2, etc.) with full investigation logs. Applies surgical fixes (minimal changes).
  Logs lessons learned in progress.txt to prevent repeat issues. Returns to BUILD phase after verification complete.
---

# Vibe Coding DEBUG Phase

Systematic bug fixing with investigation logging.

## Debug Protocol

1. **Create Debug Session**
   - Assign session ID
   - Record issue description
   - Save current BUILD state (to resume later)

2. **Investigate**
   - Reproduce the bug
   - Analyze root cause
   - Log investigation steps

3. **Fix**
   - Apply surgical fix (minimal changes)
   - Follow protection rules

4. **Verify**
   - Test the fix
   - Check for regressions
   - Confirm resolution

5. **Document**
   - Log lesson learned
   - Update progress.txt

6. **Resume BUILD**
   - Return to saved BUILD state
   - Continue where left off

## Investigation Workflow

**Load:** `references/investigation.md`

```
DEBUG SESSION #[X]
Triggered from: [BUILD Phase X, Step Y]
Issue: [description]
Started: [timestamp]

INVESTIGATION LOG:
[timestamp] - Reproduced bug
[timestamp] - Found error in [file]
[timestamp] - Root cause: [explanation]

FIX APPLIED:
[description of fix]

VERIFICATION:
✓ Bug resolved
✓ Tests passing
✓ No regressions

LESSON LEARNED:
[what we learned for future]

RESUME: Return to BUILD Phase X, Step Y
```

## Reference Files

- `references/main.md` - Debug orchestration
- `references/debug-startup.md` - Session initialization
- `references/investigation.md` - Investigation protocol
- `references/fix-protocol.md` - Fix guidelines
- `references/closure.md` - Verification and closure

## Hand-off Back to BUILD

When bug fixed and verified:

```
DEBUG SESSION #[X] - COMPLETE
completed: [timestamp]
bug_fixed: true
tests_passing: true

---
PHASE: BUILD
---
Resume from: [saved state]
```

Activate vibe-coding-build skill and exit.
