# Protection Rules

## Table of Contents

- [No Regressions](#no-regressions) - Don't break working code
- [No File Overwrites](#no-file-overwrites) - Preserve docs
- [No Assumptions](#no-assumptions) - Escalate gaps
- [No Hallucinated Design](#no-hallucinated-design) - Use design system
- [No Reference Bleed](#no-reference-bleed) - Extract only what's asked
- [Mobile-First Mandate](#mobile-first-mandate) - Phone layout first
- [Scope Discipline](#scope-discipline) - Touch only what's asked
- [Confusion Management](#confusion-management) - Handle conflicts
- [Error Recovery](#error-recovery) - When stuck

---

## No Regressions

- Before modifying any file, diff what exists against your changes
- Never break working functionality for new functionality
- If change touches multiple systems, verify each still works
- When in doubt, ask before overwriting

## No File Overwrites

- Never overwrite existing documentation files
- Create timestamped versions when docs need updating
- Canonical docs maintain history - never destroy previous versions

## No Assumptions

If anything isn't explicitly documented, STOP:

```
UNDOCUMENTED DECISION ENCOUNTERED:
[describe the gap]

Options I see:
A. [option]
B. [option]

I will not proceed until you clarify.
```

- Do not infer, guess, or fill gaps with "reasonable defaults"
- Every undocumented decision escalates before implementation
- Silence is not permission

## No Hallucinated Design

Before creating ANY component:

1. Check `DESIGN_SYSTEM.md` first
2. Never invent colors, spacing, border-radii, shadows, or tokens
3. If design need isn't covered, flag it and wait for user to update docs

```
DESIGN GAP:
I need [design element] but it's not in DESIGN_SYSTEM.md.

Please add it to the design system or tell me what to use.
```

Consistency is non-negotiable. Every pixel references the system.

## No Reference Bleed

When given reference images or videos:

1. Extract ONLY the specific feature/functionality requested
2. Do not infer unrelated design elements
3. Do not assume colors, typography, spacing unless explicitly asked

```
EXTRACTING FROM REFERENCE:
I'm taking [specific element] from this reference.
NOT taking: colors, fonts, spacing (unless you confirm).

→ Correct me if I should extract more/less.
```

## Mobile-First Mandate

- Every component starts as mobile layout
- Desktop is enhancement, not default
- Follow breakpoint behavior from `DESIGN_SYSTEM.md` exactly
- Mental model: "Does this work on a phone first?"

## Scope Discipline

Touch only what you're asked to touch:

- Do not remove comments you don't understand
- Do not "clean up" code outside current task
- Do not refactor adjacent systems as side effects
- Do not delete "unused" code without explicit approval

Your job is surgical precision, not unsolicited renovation.

## Confusion Management

When encountering conflicting information:

```
CONFLICT DETECTED:
I see [X] in [file A] but [Y] in [file B].

Which takes precedence?
```

Do not silently pick one interpretation. Wait for resolution.

## Error Recovery

When code throws errors during implementation:

1. Don't silently retry the same approach
2. State what failed, what you tried, why you think it failed

```
IMPLEMENTATION ERROR:
Tried: [approach]
Failed because: [reason]
My theory: [analysis]

Attempting alternative: [new approach]
```

If stuck after two attempts:
```
STUCK:
Tried [X] and [Y], both failed because [Z].
Here's what I think the issue is: [analysis]

I need help to proceed.
```
