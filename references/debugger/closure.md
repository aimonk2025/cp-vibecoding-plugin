# Closure Phase

Update knowledge base. Prevent recurrence. Hand off cleanly.

## Step 7: Update Knowledge Base

**Rule: Your build agent learns from your debugging agent.**

### Update lessons.md

After every fix, add an entry:

```
LESSON ENTRY:

## [Date] - [Bug Title]

### What Broke
[Brief description of the bug]

### Root Cause
[The actual cause, not the symptom]

### Pattern to Avoid
[The coding pattern or decision that led to this bug]

### Prevention Rule
[Guardrail rule to prevent this in future]

### Related Files
- [file]: [what to be careful about]
```

### Lesson Template Examples

**Example 1: Race Condition**
```
## 2024-01-15 - User data showing stale after update

### What Broke
User profile showed old data after saving changes

### Root Cause
State update was async but component read state immediately
after dispatch without waiting for update to complete

### Pattern to Avoid
Reading state immediately after dispatching an update
without awaiting or using the callback

### Prevention Rule
Always use await with async state updates, or use
useEffect to react to state changes, never read
state synchronously after dispatch

### Related Files
- hooks/useUser.ts: async state pattern
- components/Profile.tsx: consumer of this hook
```

**Example 2: Missing Validation**
```
## 2024-01-15 - Crash on empty array input

### What Broke
App crashed when API returned empty results array

### Root Cause
Component assumed array always had at least one element,
accessed [0] without checking length

### Pattern to Avoid
Accessing array indices without bounds checking,
especially with external data

### Prevention Rule
Always validate array length before accessing indices.
For external data, assume it can be empty, null, or malformed.

### Related Files
- utils/dataTransform.ts: add defensive checks
- All components using API data
```

### Update progress.txt

Add a fix entry:

```
PROGRESS UPDATE:

## [Date] - Bug Fix

FIXED: [brief description]
- Root cause: [what was actually wrong]
- Files changed: [list]
- Verified: [how you confirmed fix works]

CURRENT STATE:
- [what's working now]
- [any follow-up tasks created]

NEXT:
- [what should happen next]
```

## Documentation Gap Detection

If the bug revealed missing documentation:

```
DOCUMENTATION GAP DETECTED:

The bug involved: [scenario]
But documentation didn't cover: [gap]

Affected doc: [which file]
Suggested addition: [what should be added]

Want me to draft the documentation update?
```

### Common Documentation Gaps

| Bug Type | Likely Doc Gap |
|----------|----------------|
| Edge case crash | Missing error handling guidance |
| Wrong behavior | Ambiguous requirements |
| Integration failure | Missing API contract details |
| Data bug | Undocumented data constraints |
| Auth issue | Missing permission documentation |

## Handoff Checklist

Before closing the debug session:

```
DEBUG CLOSURE CHECKLIST:

[ ] Bug is verified fixed
[ ] No regressions introduced
[ ] lessons.md updated with:
    - What broke
    - Root cause (not symptom)
    - Pattern to avoid
    - Prevention rule
[ ] progress.txt updated
[ ] Documentation gaps flagged (if any)
[ ] Follow-up tasks created (if any)
[ ] Tests added for the fix

→ Debug session complete.
```

## Follow-Up Task Creation

If symptom fix was applied (root cause deferred):

```
FOLLOW-UP TASK:

Created because: Symptom fix applied, root cause needs proper fix

Task: Fix root cause of [bug]
Root cause: [description]
Current state: Symptom patched in [file]
Proper fix requires: [scope]
Risk if not addressed: [consequences]

Priority: [suggested priority]
```

If other issues were noticed during debugging:

```
FOLLOW-UP TASK:

Created because: Unrelated issue noticed during debugging

Task: [description]
Location: [file:line]
Severity: [low/medium/high]
Observed: [what you saw]

Note: Not related to the bug that was just fixed.
```

## Debug Session Summary

At session end, provide summary:

```
DEBUG SESSION SUMMARY:

Bug: [original report]
Root Cause: [what was actually wrong]
Fix: [what was changed]
Verified: [how]

Lessons Added: [count]
Docs Flagged: [count]
Follow-ups Created: [count]

Time from report to fix: [if trackable]

Session complete. Knowledge base updated.
```
