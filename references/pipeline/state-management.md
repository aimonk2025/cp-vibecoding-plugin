# State Management System

## The Progress File

**File:** `progress.txt` (created in user's project root)

This file is the **single source of truth** for workflow state. It tracks:
- Current phase and step
- All Q&A from interrogation
- Documents generated
- Features built
- Bugs fixed
- Deployment status

## Progress File Structure

```
VIBE CODING PROGRESS
====================

CURRENT STATE:
phase: IDEATE
step: interrogation_in_progress
started: 2025-02-15T10:30:00Z
last_updated: 2025-02-15T10:45:00Z

---
PHASE: IDEATE
---

STATUS: in_progress
started: 2025-02-15T10:30:00Z

INTERROGATION TRANSCRIPT:
[All questions and answers in conversation order]

Q: What's the one-sentence description of what you want to build?
A: A task management app for busy parents

Q: What specific problem with existing task managers are you solving?
A: They're too complicated and have features parents don't need

Q: Which task managers have you tried?
A: Todoist, Asana, Microsoft To Do

[...continues...]

TOPICS COVERED:
✓ Core Concept - Complete
✓ Users - Complete  
⊙ Features - Partial (need validation)
✗ Data - Not started
✗ Auth - Not started
✗ Tech Stack - Not started
✗ Business - Not started
✗ Edge Cases - Not started
✗ Integrations - Not started
✗ Design - Not started

KEY INSIGHTS:
- Target user: Busy parents with kids under 10
- Problem: Existing tools too complex
- Current solution: Paper lists + phone reminders
- Pain point: Things fall through cracks
- V1 scope: Simple task list with family sharing
- Out of scope: Advanced features, integrations

NEXT ACTION:
Continue interrogation - focus on Features topic

---
PHASE: DOCUMENT
---

STATUS: not_started

[Empty until phase starts]

---
PHASE: BUILD
---

STATUS: not_started

[Empty until phase starts]

---
PHASE: DEBUG
---

[Debug sessions tracked here]

---
PHASE: SHIP
---

STATUS: not_started
```

## State Transitions

```
IDEATE → DOCUMENT:
  Trigger: All topics covered, summary approved
  Action: Mark IDEATE complete, start DOCUMENT
  
DOCUMENT → BUILD:
  Trigger: All 8 canonical docs approved
  Action: Mark DOCUMENT complete, start BUILD
  
BUILD → DEBUG (temporary):
  Trigger: Bug found during build
  Action: Pause BUILD, start DEBUG session
  
DEBUG → BUILD:
  Trigger: Bug fixed and verified
  Action: Resume BUILD from last step
  
BUILD → SHIP:
  Trigger: All implementation steps complete
  Action: Mark BUILD complete, start SHIP
  
SHIP → MONITOR:
  Trigger: Deployed to production
  Action: Mark SHIP complete, enter monitoring mode
```

## Auto-Save Triggers

Progress file should be updated after:
1. Every Q&A exchange during IDEATE
2. Every topic completion
3. Every document generation in DOCUMENT
4. Every feature implementation in BUILD
5. Every bug fix in DEBUG
6. Every deployment step in SHIP

## Reading Progress

When user says "continue" or "resume":
1. Read `progress.txt`
2. Parse current phase and step
3. Load appropriate phase main.md
4. Resume from `NEXT ACTION`

## Progress Queries

User can ask:
- "Where are we?" → Show CURRENT STATE section
- "What's next?" → Show NEXT ACTION
- "What did we discuss?" → Show INTERROGATION TRANSCRIPT
- "Show progress" → Show TOPICS COVERED checklist
