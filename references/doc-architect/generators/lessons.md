# LESSONS.md Generator

<purpose>
Mistakes made, patterns discovered, things that broke and why. Each entry includes what went wrong, why it happened, and the rule that prevents it from happening again. Updated after every correction. Reviewed at the start of every session so the AI doesn't repeat errors.
</purpose>

---

## Template Structure

```markdown
# [APP NAME] — Lessons Learned

## Overview

This document captures mistakes, corrections, and patterns discovered during development. Read at the start of every session. Learn from the past. Don't repeat errors.

**Total Lessons:** [Number]
**Last Updated:** [Date]

---

## Critical Lessons (Read Every Session)

### LESSON-001: [Short Title]
**Date:** [When it happened]
**Category:** [Code | Design | Process | Architecture]
**Severity:** Critical

**What Happened:**
[Describe the mistake or issue]

**Why It Happened:**
[Root cause analysis]

**The Fix:**
[How it was resolved]

**The Rule:**
> [Clear, actionable rule to prevent recurrence]

**Example:**
```
// ❌ Wrong
[Code or pattern that caused the issue]

// ✅ Correct
[Code or pattern that fixes it]
```

---

## Code Lessons

### LESSON-002: [Title]
**Date:** [Date]
**Category:** Code
**Severity:** Medium

**What Happened:**
[Description]

**The Rule:**
> [Rule]

---

### LESSON-003: [Title]
...

---

## Design Lessons

### LESSON-010: [Title]
**Date:** [Date]
**Category:** Design
**Severity:** Low

**What Happened:**
[Description]

**The Rule:**
> [Rule]

---

## Process Lessons

### LESSON-020: [Title]
**Date:** [Date]
**Category:** Process
**Severity:** Medium

**What Happened:**
[Description]

**The Rule:**
> [Rule]

---

## Architecture Lessons

### LESSON-030: [Title]
**Date:** [Date]
**Category:** Architecture
**Severity:** High

**What Happened:**
[Description]

**The Rule:**
> [Rule]

---

## Patterns That Work

### PATTERN-001: [Title]
**Discovered:** [Date]
**Category:** [Category]

**The Pattern:**
[What works well]

**When to Use:**
[Situations where this applies]

**Example:**
```
[Code or process example]
```

---

## Quick Reference Rules

(Extracted from lessons for fast scanning)

### Code
- [ ] [Rule from LESSON-XXX]
- [ ] [Rule from LESSON-XXX]

### Design
- [ ] [Rule from LESSON-XXX]
- [ ] [Rule from LESSON-XXX]

### Process
- [ ] [Rule from LESSON-XXX]
- [ ] [Rule from LESSON-XXX]

### Architecture
- [ ] [Rule from LESSON-XXX]
- [ ] [Rule from LESSON-XXX]

---

## Lesson Index

| ID | Title | Category | Severity | Date |
|----|-------|----------|----------|------|
| LESSON-001 | | | | |
| LESSON-002 | | | | |

```

---

## Entry Rules

### When to Add Entry
- After ANY correction from user
- After discovering unexpected behavior
- After finding a better pattern
- After debugging a tricky issue

### Entry Components
1. **Unique ID** — LESSON-XXX or PATTERN-XXX
2. **Date** — When it happened
3. **Category** — Code, Design, Process, Architecture
4. **Severity** — Critical, High, Medium, Low
5. **What Happened** — Factual description
6. **Why It Happened** — Root cause (for lessons)
7. **The Rule** — Actionable prevention
8. **Example** — Code/process illustration

### Severity Levels

| Level | Definition |
|-------|------------|
| Critical | Broke production or lost work |
| High | Significant rework required |
| Medium | Noticeable issue, moderate fix |
| Low | Minor issue, easy fix |

---

## Example Entries

### Code Lesson Example
```markdown
### LESSON-005: Don't Use Index as React Key
**Date:** 2024-01-18
**Category:** Code
**Severity:** Medium

**What Happened:**
List items were re-rendering incorrectly when items were reordered. State was getting attached to wrong items.

**Why It Happened:**
Used array index as key in map(). When order changed, React associated state with index position, not actual item.

**The Fix:**
Changed key from index to item.id (unique identifier).

**The Rule:**
> Always use unique, stable identifiers as React keys. Never use array index for lists that can reorder, filter, or have items added/removed.

**Example:**
```tsx
// ❌ Wrong
{items.map((item, index) => <Item key={index} {...item} />)}

// ✅ Correct
{items.map((item) => <Item key={item.id} {...item} />)}
```
```

### Design Lesson Example
```markdown
### LESSON-012: Check Design System Before Inventing
**Date:** 2024-01-19
**Category:** Design
**Severity:** High

**What Happened:**
Created a new blue color (#0066CC) for links that wasn't in DESIGN_SYSTEM.md. Later had to refactor 12 components when the actual link color (--color-primary) was specified.

**Why It Happened:**
Didn't check DESIGN_SYSTEM.md before styling. Assumed a "reasonable" blue.

**The Fix:**
Replaced all instances of #0066CC with var(--color-primary).

**The Rule:**
> Before using ANY color, spacing, or visual value, check DESIGN_SYSTEM.md. If it's not there, ask — don't invent.
```

### Pattern Example
```markdown
### PATTERN-003: API Error Handling Shape
**Discovered:** 2024-01-20
**Category:** Code

**The Pattern:**
Consistent error response shape across all API endpoints:
```ts
{
  error: string,      // Error code (e.g., "VALIDATION_ERROR")
  message: string,    // Human-readable message
  details?: array     // Field-level errors for forms
}
```

**When to Use:**
All API error responses. Frontend can reliably parse any error.

**Example:**
```ts
// API
return res.status(400).json({
  error: "VALIDATION_ERROR",
  message: "Invalid input",
  details: [{ field: "email", message: "Invalid email format" }]
})

// Frontend
if (error.details) {
  error.details.forEach(d => setFieldError(d.field, d.message))
}
```
```

---

## Maintenance

### Session Start
1. Read Critical Lessons section
2. Scan Quick Reference Rules
3. Check for lessons related to today's work

### Session End
1. Review any corrections received
2. Add new lessons if applicable
3. Update Quick Reference if new rule added

### Periodic Review
- Every 5 sessions: Review all lessons for relevance
- Archive lessons that no longer apply
- Promote repeated patterns to Quick Reference

---

## Initial Generation

When first creating LESSONS.md:

```markdown
# [APP NAME] — Lessons Learned

## Overview

This document captures mistakes, corrections, and patterns discovered during development. Read at the start of every session.

**Total Lessons:** 0
**Last Updated:** [TODAY'S DATE]

---

## Critical Lessons (Read Every Session)

(None yet — document lessons as they occur)

---

## Code Lessons

(None yet)

---

## Design Lessons

(None yet)

---

## Process Lessons

(None yet)

---

## Architecture Lessons

(None yet)

---

## Patterns That Work

(None yet)

---

## Quick Reference Rules

### Code
(To be populated)

### Design
(To be populated)

### Process
(To be populated)

### Architecture
(To be populated)

---

## Lesson Index

| ID | Title | Category | Severity | Date |
|----|-------|----------|----------|------|
| (None yet) | | | | |
```
