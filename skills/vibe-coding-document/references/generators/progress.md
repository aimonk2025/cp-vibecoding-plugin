# progress.txt Generator

<purpose>
The cross-session bridge. Tracks what's built, what's in progress, what's blocked, what's next. References IMPLEMENTATION_PLAN.md phase numbers. Updated after every completed feature. Read at the start of every new session. AI has no memory between sessions. This file is the persistent memory.
</purpose>

<note>
This generates a .txt file, not .md — simpler format for quick reading.
</note>

---

## Template Structure

```
================================================================================
[APP NAME] — Progress Tracker
================================================================================

Last Updated: [YYYY-MM-DD HH:MM]
Current Phase: [X] of [Total]
Current Step: [X.X]

================================================================================
COMPLETED
================================================================================

Phase 1: Project Setup ✓
  [x] Step 1.1: Initialize Project (2024-01-15)
  [x] Step 1.2: Configure Project Structure (2024-01-15)
  [x] Step 1.3: Database Setup (2024-01-15)

Phase 2: Backend Core ✓
  [x] Step 2.1: API Client Setup (2024-01-16)
  [x] Step 2.2: Database Access Layer (2024-01-16)

================================================================================
IN PROGRESS
================================================================================

Phase 3: Authentication
  [x] Step 3.1: Auth Configuration (2024-01-17)
  [ ] Step 3.2: Auth API Routes ← CURRENT
      - /register endpoint done
      - /login endpoint in progress
      - /logout endpoint pending
      - /me endpoint pending
  [ ] Step 3.3: Auth UI

================================================================================
BLOCKED
================================================================================

None currently.

(Example format if blocked:)
Step 5.3: Payment Integration
  BLOCKED BY: Waiting for Stripe API keys from client
  BLOCKED SINCE: 2024-01-18
  ACTION NEEDED: Client to provide production API keys

================================================================================
UP NEXT
================================================================================

After current step:
1. Step 3.3: Auth UI
2. Phase 4: Frontend Foundation
3. Step 4.1: Layouts

================================================================================
SESSION NOTES
================================================================================

2024-01-17:
- Completed auth config
- Started API routes
- Issue: JWT refresh logic needs review (see LESSONS.md)

2024-01-16:
- Backend core complete
- Database queries optimized
- Ready for auth phase

================================================================================
METRICS
================================================================================

Features Completed: 2 / 15 (13%)
Screens Completed: 0 / 8 (0%)
Tests Passing: 24 / 24
Build Status: ✓ Passing

================================================================================
```

---

## Update Rules

### When to Update
- After completing ANY step
- When something becomes blocked
- When a block is resolved
- At the end of every session

### What to Include
1. **Timestamp** — When updated
2. **Current position** — Phase and step
3. **Completed items** — With dates
4. **In-progress details** — Sub-tasks within current step
5. **Blocks** — With reason, date, and action needed
6. **Session notes** — What happened, what to remember

### Format Rules
- Use [x] for completed, [ ] for pending
- Include dates for completed items
- Keep session notes brief but useful
- Update metrics if tracked

---

## Reading This File

At session start, AI should:
1. Find current phase/step
2. Read what's in progress
3. Check for blocks
4. Know what's next
5. Review recent session notes

---

## Example: Block Resolution

```
================================================================================
BLOCKED
================================================================================

Step 5.3: Payment Integration
  BLOCKED BY: Waiting for Stripe API keys from client
  BLOCKED SINCE: 2024-01-18
  ACTION NEEDED: Client to provide production API keys

---

(After resolution, move to completed and note:)

Phase 5: Features
  [x] Step 5.3: Payment Integration (2024-01-20)
      Note: Used test keys until 2024-01-19, production keys received 2024-01-20

================================================================================
BLOCKED
================================================================================

None currently.
```

---

## Generation Rules

1. **Format is .txt** — Not markdown, simpler parsing
2. **Sections are clear** — Visual separators
3. **Current position obvious** — Can find in 2 seconds
4. **Blocks are actionable** — What's needed to unblock
5. **History preserved** — Session notes accumulate
6. **Dates on everything** — When did it happen

---

## Initial Generation

When first creating progress.txt:

```
================================================================================
[APP NAME] — Progress Tracker
================================================================================

Last Updated: [TODAY'S DATE]
Current Phase: 1 of 7
Current Step: 1.1

================================================================================
COMPLETED
================================================================================

(None yet — project starting)

================================================================================
IN PROGRESS
================================================================================

Phase 1: Project Setup
  [ ] Step 1.1: Initialize Project ← CURRENT
  [ ] Step 1.2: Configure Project Structure
  [ ] Step 1.3: Database Setup

================================================================================
BLOCKED
================================================================================

None currently.

================================================================================
UP NEXT
================================================================================

After current step:
1. Step 1.2: Configure Project Structure
2. Step 1.3: Database Setup
3. Phase 2: Backend Core

================================================================================
SESSION NOTES
================================================================================

[TODAY'S DATE]:
- Project documentation complete
- Starting implementation
- Phase 1 beginning

================================================================================
METRICS
================================================================================

Features Completed: 0 / [TOTAL FROM PRD]
Screens Completed: 0 / [TOTAL FROM APP_FLOW]
Tests Passing: 0 / 0
Build Status: Not started

================================================================================
```
