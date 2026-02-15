# Debug Startup

Read these before touching anything. No exceptions.

## Required Reading (Debug-Scoped)

| Priority | File | Why |
|----------|------|-----|
| 1 | `progress.txt` | What was built recently, current project state |
| 2 | `tasks/lessons.md` | Has this bug happened before? Existing rules? |
| 3 | `docs/TECH_STACK.md` | Exact versions, dependencies, constraints |
| 4 | `docs/FRONTEND_GUIDELINES.md` | Component architecture (if UI bug) |
| 5 | `docs/BACKEND_STRUCTURE.md` | Database, APIs, auth (if backend bug) |
| 6 | `docs/DESIGN_SYSTEM.md` | Visual tokens (if styling bug) |

## What NOT to Read

- **IMPLEMENTATION_PLAN.md** - Unless bug requires feature-level context
- **PRD.md** - Unless bug involves requirements ambiguity
- **Full codebase** - Stay scoped to the broken part

You are not here to understand the whole app. You are here to understand the broken part.

## Pre-Debug Checklist

Before investigating:

```
DEBUG STARTUP CHECKLIST:
[ ] Read progress.txt - understand recent changes
[ ] Check lessons.md - similar bug before?
[ ] Note tech stack versions - could be version issue?
[ ] Identify bug category (UI / API / data / auth / other)

Ready to investigate? (Y/N)
```

## Bug Category Routing

Based on bug type, focus your reading:

| Bug Type | Primary Docs | Secondary |
|----------|--------------|-----------|
| UI/Visual | DESIGN_SYSTEM, FRONTEND_GUIDELINES | - |
| API/Backend | BACKEND_STRUCTURE, TECH_STACK | - |
| Data/State | BACKEND_STRUCTURE, FRONTEND_GUIDELINES | - |
| Auth/Security | BACKEND_STRUCTURE | TECH_STACK |
| Build/Deploy | TECH_STACK | progress.txt |
| Unknown | progress.txt, lessons.md | Investigate first |

## Gathering Bug Context

Ask for these if not provided:

```
BUG CONTEXT NEEDED:

1. REPRODUCTION:
   - Exact steps to trigger the bug
   - Environment (browser, OS, device)
   - Frequency (always, sometimes, specific conditions)

2. EVIDENCE:
   - Error messages (exact text)
   - Console logs
   - Network requests (if applicable)
   - Screenshots/recordings

3. TIMELINE:
   - When did it start happening?
   - What changed recently?
   - Did it ever work correctly?

4. SCOPE:
   - Affects all users or specific ones?
   - All environments or specific (dev/staging/prod)?
```

## Quick Start Flow

```
1. User reports bug
   ↓
2. Read progress.txt + lessons.md (2 min)
   ↓
3. Identify bug category
   ↓
4. Read relevant docs for that category
   ↓
5. Gather missing context from user
   ↓
6. → Proceed to INVESTIGATION phase
```
