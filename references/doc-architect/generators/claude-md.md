# CLAUDE.md Generator

<purpose>
The AI agent instruction file. Read automatically at the start of every session. This is the governance layer. Contains project rules, constraints, workflow orchestration, and protection rules.
</purpose>

---

## Template Structure

```markdown
# [APP NAME] — Agent Instructions

## Project Overview

**Name:** [App name]
**Description:** [One sentence]
**Tech Stack:** [Summary from TECH_STACK.md]

---

## Canonical Documents

These are law. Read them. Follow them. Do not deviate.

| Document | Purpose | When to Reference |
|----------|---------|-------------------|
| PRD.md | Features & requirements | Before implementing any feature |
| APP_FLOW.md | Screens & navigation | Before building any screen |
| TECH_STACK.md | Technologies & versions | Before adding dependencies |
| DESIGN_SYSTEM.md | Visual tokens | Before any styling |
| FRONTEND_GUIDELINES.md | Code patterns | Before writing components |
| BACKEND_STRUCTURE.md | Database & API | Before any backend work |
| IMPLEMENTATION_PLAN.md | Build order | To know what's next |

---

## Session Startup Sequence

At the start of EVERY session, read in this order:

1. **This file** (CLAUDE.md) — Your rules
2. **progress.txt** — Where is the project now?
3. **IMPLEMENTATION_PLAN.md** — What phase/step is next?
4. **LESSONS.md** — What mistakes to avoid?
5. **Write tasks/todo.md** — Plan this session's work
6. **Verify with user** — Before executing

---

## Workflow Orchestration

### 1. Plan Mode Default
- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately
- Use plan mode for verification steps, not just building
- Write detailed specs upfront to reduce ambiguity

### 2. Subagent Strategy
- Use subagents liberally to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One task per subagent for focused execution

### 3. Self-Improvement Loop
- After ANY correction from user: update LESSONS.md with the pattern
- Write rules for yourself that prevent the same mistake
- Ruthlessly iterate on these lessons until mistake rate drops
- Review lessons at session start

### 4. Verification Before Done
- Never mark a task complete without proving it works
- Diff behavior between main and your changes when relevant
- Ask yourself: "Would a staff engineer approve this?"
- Run tests, check logs, demonstrate correctness

### 5. Demand Elegance (Balanced)
- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky: implement the elegant solution
- Skip this for simple, obvious fixes — don't over-engineer
- Challenge your own work before presenting it

### 6. Autonomous Bug Fixing
- When given a bug report: just fix it. Don't ask for hand-holding
- Point at logs, errors, failing tests — then resolve them
- Zero context switching required from the user
- Go fix failing CI tests without being told how

---

## Protection Rules

### No Regressions
- Before modifying any existing file, diff what exists against what you're changing
- Never break working functionality to implement new functionality
- If a change touches more than one system, verify each system still works after
- When in doubt, ask before overwriting

### No File Overwrites
- Never overwrite existing documentation files
- Create new timestamped versions when documentation needs updating
- Canonical docs maintain history — never destroy previous versions

### No Assumptions
- If you encounter anything not explicitly covered by documentation, STOP and ask
- Do not infer. Do not guess. Do not fill gaps with "reasonable defaults"
- Every undocumented decision gets escalated to the user before implementation
- Silence is not permission

### Design System Enforcement
- Before creating ANY component, check DESIGN_SYSTEM.md first
- Never invent colors, spacing values, border radii, shadows, or tokens not in the file
- If a design need arises that isn't covered, flag it and wait for user to update DESIGN_SYSTEM.md
- Consistency is non-negotiable. Every pixel references the system.

### Mobile-First Mandate
- Every component starts as a mobile layout
- Desktop is the enhancement, not the default
- Breakpoint behavior is defined in DESIGN_SYSTEM.md — follow it exactly
- Test mental model: "Does this work on a phone first?"

---

## Task Management

1. **Plan First:** Write plan to tasks/todo.md with checkable items
2. **Verify Plan:** Check in with user before starting implementation
3. **Track Progress:** Mark items complete as you go
4. **Explain Changes:** High-level summary at each step
5. **Document Results:** Add review section to tasks/todo.md
6. **Capture Lessons:** Update LESSONS.md after corrections

---

## Core Principles

### Simplicity First
Make every change as simple as possible. Impact minimal code.

### No Laziness
Find root causes. No temporary fixes. Senior developer standards.

### Minimal Impact
Changes should only touch what's necessary. Avoid introducing bugs.

---

## Naming Conventions

[Copy from FRONTEND_GUIDELINES.md]

---

## File Structure

[Copy from FRONTEND_GUIDELINES.md]

---

## Forbidden Actions

- [ ] Adding dependencies not in TECH_STACK.md
- [ ] Creating colors not in DESIGN_SYSTEM.md
- [ ] Implementing features not in PRD.md
- [ ] Skipping phases in IMPLEMENTATION_PLAN.md
- [ ] Modifying IMPLEMENTATION_PLAN.md during execution
- [ ] Overwriting documentation files
- [ ] Guessing when documentation is unclear

---

## When Stuck

1. Re-read the relevant canonical document
2. Check LESSONS.md for similar past issues
3. If still unclear, ask the user — do not guess
4. Document the resolution in LESSONS.md

---

## Progress Tracking

- Update progress.txt after every completed feature
- Reference IMPLEMENTATION_PLAN.md phase numbers
- Include: what's done, what's in progress, what's blocked
```

---

## Generation Rules

1. **Reference all canonical docs** — They are law
2. **Include startup sequence** — Exactly as specified
3. **Workflow rules verbatim** — Don't paraphrase
4. **Protection rules verbatim** — Don't paraphrase
5. **Project-specific naming/structure** — From other docs
6. **Forbidden actions are explicit** — Clear boundaries

---

## Validation Checklist

- [ ] All canonical docs referenced
- [ ] Startup sequence complete
- [ ] All workflow rules included
- [ ] All protection rules included
- [ ] Task management process clear
- [ ] Forbidden actions listed
- [ ] When stuck process defined
