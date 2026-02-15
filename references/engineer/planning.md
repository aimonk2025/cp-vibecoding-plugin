# Planning Mode

## When to Enter Plan Mode

- ANY non-trivial task (3+ steps or architectural decisions)
- When something goes sideways - STOP and re-plan immediately
- For verification steps, not just building
- When detailed specs needed upfront to reduce ambiguity

## Before Writing Any Code

### Step 1: Clarifying Questions

Always ask 1-3 clarifying questions first:

```
CLARIFYING QUESTIONS:

1. [Question about edge cases]
2. [Question about constraints/requirements]
3. [Question about non-functional requirements]

→ Answer these before I proceed.
```

Examples of good clarifying questions:
- "Should this handle [edge case] or fail gracefully?"
- "Is there a performance constraint (e.g., <100ms response)?"
- "Does this need to be backwards-compatible with [X]?"
- "Should errors be logged, thrown, or silently handled?"

### Step 2: Acceptance Criteria

Define testable success criteria before implementation:

```
ACCEPTANCE CRITERIA:

1. [ ] [Specific, verifiable outcome]
2. [ ] [Specific, verifiable outcome]
3. [ ] [Specific, verifiable outcome]

TEST SCENARIOS:
- Given [context], when [action], then [result]
- Given [context], when [action], then [result]
```

### Step 3: Implementation Plan

```
PLAN:
1. [step] — [why]
2. [step] — [why]
3. [step] — [why]

ACCEPTANCE CRITERIA: [reference above]
→ Executing unless you redirect.
```

## Multiple Approaches

When multiple valid approaches exist, present options:

```
APPROACH OPTIONS:

| Option | Pros | Cons |
|--------|------|------|
| A: [approach] | [benefits] | [drawbacks] |
| B: [approach] | [benefits] | [drawbacks] |
| C: [approach] | [benefits] | [drawbacks] |

RECOMMENDATION: Option [X] because [reason].
→ Confirm or redirect.
```

Never silently pick one approach. Surface trade-offs.

## Pre-Implementation Checkpoint

Before implementing non-trivial logic, verify:

```
PRE-IMPLEMENTATION CHECKLIST:
[ ] Clarifying questions answered
[ ] Acceptance criteria defined
[ ] Failing test written (if non-trivial)
[ ] Approach selected from options (if multiple valid)
[ ] Relevant skill loaded (if applicable)

→ Proceeding with implementation.
```

## Subagent Strategy

Use subagents liberally to keep main context clean:

- Offload research, exploration, parallel analysis
- For complex problems, use more subagents
- One task per subagent for focused execution
- Use named subagents for recurring patterns

See [subagents.md](subagents.md) for defined subagent types.

## Self-Improvement Loop

After ANY correction from the user:

1. Update `tasks/lessons.md` with the pattern
2. Write guardrail rules that prevent the same mistake
3. **Also capture positive patterns**: "This worked well because..."
4. Review lessons at session start before touching code

### Guardrail Rules

Add override rules to lessons.md for project-specific constraints:

```
GUARDRAIL RULES:
- NO HARDCODING EVER - use config/env
- Always prefer composition over inheritance unless [exception]
- Never use [antipattern] in this codebase
```

## Verification Before Done

Never mark a task complete without proving it works:

- Diff behavior between main and your changes
- Ask: "Would a staff engineer approve this?"
- Run tests, check logs, demonstrate correctness
- Re-run entire relevant test suite after changes

## Demand Elegance (Balanced)

1. First implement the obviously-correct simple version
2. Verify correctness
3. THEN ask: "Is there a more elegant way?"
4. Optimize while preserving behavior

**Explicitly forbidden:**
- Over-abstraction without explicit request
- Future-proofing for hypothetical requirements
- Unnecessary layers or generics
- "Clever" solutions when boring works

Skip elegance pass for simple, obvious fixes. Correctness first.

## Task Management Workflow

1. **Plan First** - Write plan to `tasks/todo.md` with:
   - Checkable items
   - Clarifying Questions section
   - Acceptance Tests block

2. **Verify Plan** - Check in with user before starting

3. **Track Progress** - Mark items complete as you go

4. **Explain Changes** - Use before/after code blocks:
   ```
   BEFORE:
   [old code]

   AFTER:
   [new code]

   WHY: [explanation]
   ```

5. **Document Results** - Add review section to `tasks/todo.md`

6. **Capture Lessons** - Update `tasks/lessons.md`:
   - Mistakes to avoid (negative patterns)
   - What worked well (positive patterns)
