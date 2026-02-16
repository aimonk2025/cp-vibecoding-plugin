# tasks/todo.md Generator

<purpose>
The in-session work plan. Created at the start of each task. Contains checkable items for the current session's work. AI checks boxes as it completes items. When the session ends and progress.txt is updated, this file has served its purpose.
</purpose>

---

## Template Structure

```markdown
# Session Todo — [DATE]

## Context

**Current Phase:** [From progress.txt]
**Current Step:** [From progress.txt]
**Goal:** [What this session should accomplish]

---

## Pre-Flight Checklist

- [ ] Read CLAUDE.md
- [ ] Read progress.txt
- [ ] Read IMPLEMENTATION_PLAN.md for current step
- [ ] Read LESSONS.md for relevant patterns
- [ ] Verify plan with user

---

## Session Tasks

### [Step X.X]: [Step Name]

**Files to create/modify:**
- [ ] `path/to/file.tsx` — [What to do]
- [ ] `path/to/file.ts` — [What to do]

**Implementation:**
- [ ] [Specific task 1]
- [ ] [Specific task 2]
- [ ] [Specific task 3]

**Verification:**
- [ ] [How to verify it works]
- [ ] [How to verify it works]

---

## Discovered Tasks

(Add tasks here as they're discovered during implementation)

- [ ] [Task discovered during work]
- [ ] [Task discovered during work]

---

## Blockers Encountered

(Document any blocks that arise)

- **Block:** [What's blocked]
  - **Reason:** [Why]
  - **Action:** [What's needed]

---

## Session Review

### Completed
- [x] [What got done]
- [x] [What got done]

### Not Completed
- [ ] [What didn't get done] — Reason: [Why]

### Lessons Learned
- [Pattern/mistake to add to LESSONS.md]

### Next Session Should
1. [First thing to do next time]
2. [Second thing]

---

## Handoff to progress.txt

**Update progress.txt with:**
- Step X.X: [Status]
- Session notes: [Key points]
- Blocks: [If any]
```

---

## Creation Rules

### When to Create
- At the start of every session
- After receiving a new task
- When switching to a different phase/step

### What to Include
1. **Context** — Where we are in the plan
2. **Pre-flight** — Standard checks
3. **Tasks** — From IMPLEMENTATION_PLAN.md current step
4. **Space for discoveries** — Things found during work
5. **Blockers section** — Ready for issues
6. **Review section** — End-of-session summary

### Task Granularity
- Each checkbox = ~5-15 minutes of work
- Too big: Break down further
- Too small: Combine related items
- Just right: Can verify it's done

---

## During Session

### As You Work
```markdown
### [Step X.X]: [Step Name]

**Files to create/modify:**
- [x] `src/components/Button.tsx` — Created base button ✓
- [ ] `src/components/Input.tsx` — [What to do]

**Implementation:**
- [x] Button variants (primary, secondary, ghost)
- [x] Button sizes (sm, md, lg)
- [ ] Button loading state
```

### When Discovering New Work
```markdown
## Discovered Tasks

- [ ] Button needs aria-label for icon-only variant
- [ ] Input component needs error state styling
```

### When Blocked
```markdown
## Blockers Encountered

- **Block:** Can't test payment flow
  - **Reason:** No Stripe test keys in .env
  - **Action:** Need user to add STRIPE_SECRET_KEY
```

---

## End of Session

### Fill Review Section
```markdown
## Session Review

### Completed
- [x] Created Button component with all variants
- [x] Created Input component with validation
- [x] Added form styling tokens to globals.css

### Not Completed
- [ ] Button loading state — Reason: Discovered need for spinner component first

### Lessons Learned
- Input focus ring color wasn't in DESIGN_SYSTEM.md — added --color-focus token

### Next Session Should
1. Create Spinner component
2. Add loading state to Button
3. Continue to Step 4.4
```

### Update progress.txt
After review, transfer key info to progress.txt so it persists.

---

## File Lifecycle

```
Session Start
    ↓
Create tasks/todo.md (from IMPLEMENTATION_PLAN.md)
    ↓
Work through tasks (checking boxes)
    ↓
Document discoveries and blockers
    ↓
Fill session review
    ↓
Update progress.txt
    ↓
Session End (todo.md has served its purpose)
    ↓
Next Session: Create new tasks/todo.md
```

---

## Generation Rules

1. **One per session** — Fresh start each time
2. **Tasks from IMPLEMENTATION_PLAN.md** — Not invented
3. **Checkboxes are verifiable** — Can prove done
4. **Review section filled** — Before session ends
5. **Handoff is explicit** — What goes to progress.txt
