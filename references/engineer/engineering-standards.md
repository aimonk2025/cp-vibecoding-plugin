# Engineering Standards

## Test-First Discipline

For non-trivial logic, write failing tests first:

### Workflow

1. **Define** - Write test that describes expected behavior
2. **Fail** - Run test, confirm it fails (proves test works)
3. **Implement** - Write minimal code to pass
4. **Verify** - Run test, confirm it passes
5. **Refactor** - Clean up while keeping tests green

### Test-First Checkpoint

Before implementing non-trivial logic:

```
TEST-FIRST CHECKLIST:
[ ] Failing test exists that defines success
[ ] Test name describes expected behavior
[ ] Test covers main path + key edge cases

→ Skip only for trivial changes (<10 lines, no branching logic)
```

### Structured Test Output

When reporting test results, use structured format:

```
TEST RESULTS:

| Test | Status | Notes |
|------|--------|-------|
| should_handle_valid_input | ✓ PASS | |
| should_reject_empty_input | ✓ PASS | |
| should_timeout_after_5s | ✗ FAIL | Returns after 10s |

Coverage: 87% (+3% from baseline)
```

## Code Quality

### Do

- Match existing codebase style, patterns, naming conventions
- Use meaningful variable names with context
- Prefer boring, obvious solutions
- Add comments only where logic isn't self-evident
- Favor readability, type safety, and maintainability

### Don't

- No bloated abstractions
- No premature generalization
- No clever tricks without explanatory comments
- No `temp`, `data`, `result` without context
- No 1000 lines when 100 suffice

Cleverness is expensive. Boring is maintainable.

## Explicitly Forbidden

These require explicit user request to override:

- **Over-abstraction** - No unnecessary layers or generics
- **Future-proofing** - No code for hypothetical requirements
- **Premature optimization** - Profile first, then optimize
- **Magic numbers without context** - Always name or comment

```
VIOLATION DETECTED:
I'm about to [forbidden pattern] because [reason].
This is normally forbidden. Proceed anyway? (Y/N)
```

## Dead Code Hygiene

After refactoring or implementing changes:

1. Identify code that is now unreachable
2. List it explicitly
3. Ask before removing:

```
DEAD CODE IDENTIFIED:
- [file:line] - [function/variable]
- [file:line] - [function/variable]

Should I remove these now-unused elements?
```

Don't leave corpses. Don't delete without asking.

## Minimal Changes

- Only make changes directly requested or clearly necessary
- Don't add features beyond what was asked
- Don't refactor surrounding code during bug fixes
- Don't add docstrings/comments/types to unchanged code

A bug fix doesn't need surrounding cleanup.
A simple feature doesn't need extra configurability.

## Autonomous Bug Fixing

When given a bug report:

### Workflow

1. **Read** - Full stack trace / CI output
2. **Trace** - Identify root cause (not symptoms)
3. **Fix** - Propose minimal fix patch
4. **Verify** - Re-run entire relevant test suite
5. **Explain** - Document exactly which lines changed and why

```
BUG FIX REPORT:

ROOT CAUSE:
[file:line] - [explanation of why this caused the bug]

FIX APPLIED:
```diff
- [old code]
+ [new code]
```

VERIFICATION:
- [X] Related tests pass
- [X] No regressions in [related area]
- [X] CI pipeline green

WHY THIS WORKS:
[explanation]
```

### Before/After Diffs

Always show changes with context:

```
CHANGES TO [filename]:

BEFORE (line 45-52):
```
[original code]
```

AFTER:
```
[new code]
```

REASON: [why this change fixes the issue]
```

## Security

Avoid introducing OWASP top 10 vulnerabilities:
- Command injection
- XSS
- SQL injection
- etc.

If you notice insecure code you wrote, fix it immediately.

## Style Matching

Match existing code unless documentation explicitly overrides:
- Indentation
- Naming conventions
- File organization
- Import patterns
- Error handling patterns

Documentation defines ideal. Existing code defines reality. Match reality unless docs say otherwise.

## Root Cause Discipline

Never fix symptoms. Always trace to structural cause:

```
SYMPTOM: [what user reported]
INVESTIGATION: [what I checked]
ROOT CAUSE: [actual source of problem]
FIX: [addresses root cause, not symptom]
```

Prefer authoritative data sources. Question assumptions about data lineage.
