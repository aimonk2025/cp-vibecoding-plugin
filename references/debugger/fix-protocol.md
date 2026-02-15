# Fix Protocol

Propose. Get approval. Implement. Verify. No shortcuts.

## Step 5: Propose the Fix

**Rule: Present the exact fix before implementing. Wait for approval.**

### Fix Proposal Format

```
PROPOSED FIX:

CHANGES:
- [file]: [specific change]
- [file]: [specific change]

NOT TOUCHING (scope discipline):
- [file]: [why not touching]
- [file]: [why not touching]

RISK ASSESSMENT:
- Risk: [what could go wrong]
- Mitigation: [how to catch/prevent it]
- Rollback: [how to undo if needed]

VERIFICATION PLAN:
- [ ] [how you'll verify fix works]
- [ ] [regression checks to perform]
- [ ] [connected systems to test]

ESTIMATED IMPACT:
- Lines changed: ~[number]
- Files modified: [count]
- Test updates needed: [yes/no]

→ Approve this fix?
```

### Trivial Fix Exception

For trivial, obvious fixes (typo, missing import, wrong variable name):

```
TRIVIAL FIX - IMPLEMENTING IMMEDIATELY:

Issue: [description]
Fix: [one-line description]
File: [file:line]

Change:
- [old]: [what it was]
+ [new]: [what it is now]

Verification: [quick check performed]

This was trivial and obvious. Let me know if you disagree.
```

### Waiting for Approval

For non-trivial fixes:

```
FIX PROPOSED - AWAITING APPROVAL

I will not implement until you confirm.

Options:
1. "Approve" - I'll implement as proposed
2. "Modify" - Tell me what to change
3. "Reject" - Explain concerns, I'll re-analyze
```

## Step 6: Implement and Verify

**Rule: Reproduce the fix success just like you reproduced the bug.**

### Implementation Protocol

1. Make the change (minimal, surgical)
2. Run the reproduction steps
3. Confirm bug is fixed
4. Check nothing else broke
5. Run relevant tests

### Change Report

```
CHANGES MADE:

[file]:
```diff
- [old code]
+ [new code]
```
Reason: [why this change fixes the bug]

[file]:
```diff
- [old code]
+ [new code]
```
Reason: [why this change was needed]

THINGS I DIDN'T TOUCH:
- [file]: [intentionally left alone because...]
- [file]: [verified not involved]
```

### Verification Report

```
VERIFICATION:

Bug reproduction test:
- Steps: [same as original reproduction]
- Result: [FIXED - bug no longer occurs]
- Evidence: [screenshot, log, etc.]

Regression checks:
- [related feature]: [PASS/FAIL]
- [connected system]: [PASS/FAIL]
- [edge case]: [PASS/FAIL]

Test suite:
- Existing tests: [PASS/FAIL - X/Y passing]
- New tests added: [yes/no - if yes, what]

POTENTIAL CONCERNS:
- [any risks to monitor post-fix]
- [any follow-up work needed]
```

### If Verification Fails

```
VERIFICATION FAILED:

What I tried: [the fix]
Expected: [bug to be resolved]
Actual: [what happened]

Analysis:
- [why the fix didn't work]
- [what I learned from this attempt]

Next steps:
1. [alternative approach]
2. [additional investigation needed]

Attempt count: [X/2]
```

After 2 failed attempts:

```
STUCK AFTER 2 ATTEMPTS:

Tried:
1. [approach 1]: Failed because [reason]
2. [approach 2]: Failed because [reason]

Current theory: [what I think is happening]

I need:
- [specific help or information]
- [or permission to try more invasive approach]

→ How should I proceed?
```

## Scope Discipline During Fix

### Allowed

- Changing code directly related to the bug
- Adding tests for the fixed behavior
- Updating comments that were incorrect

### NOT Allowed

- Refactoring "while I'm here"
- Cleaning up adjacent code
- Upgrading dependencies (unless bug requires it)
- Adding features
- Fixing other bugs you noticed

If you notice other issues:

```
UNRELATED ISSUE NOTICED:

While implementing the fix, I saw:
- [issue] in [file]

This is NOT part of the current bug fix.
Noted for separate attention. Continuing with current fix.
```

## No Regressions Rule

Before considering fix complete:

```
REGRESSION CHECK:

[ ] Original bug is fixed
[ ] Reproduction steps now pass
[ ] Connected systems still work:
    - [system]: [verified how]
    - [system]: [verified how]
[ ] Test suite passes
[ ] No new errors in logs
[ ] No new console warnings

All checks pass → Fix complete
Any check fails → Investigate before proceeding
```
