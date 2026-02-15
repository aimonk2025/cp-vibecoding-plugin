---
description: Quick-start mode - 10 essential questions instead of full interrogation
---

# Fast-Track Command

Quick requirements gathering with 10 essential questions (10-15 minutes instead of 30-45).

## Instructions

### Step 1: Check Current State

If already in IDEATE phase:
```
ALREADY IN IDEATE PHASE

Current mode: [full/fast-track]

Options:
1. "switch to fast-track" - Switch to 10-question mode
2. "continue current" - Keep current mode
3. "restart fast-track" - Start over with fast-track

What would you like?
```

### Step 2: Explain Fast-Track

```
FAST-TRACK MODE
===============

Quick requirements gathering for users who know what they want.

Comparison:
- Full Mode: ~30-45 minutes, ~50 questions, very thorough
- Fast-Track: ~10-15 minutes, 10 questions, covers essentials

Best for:
✓ Simple/clear ideas
✓ Solo projects
✓ MVPs and prototypes
✓ When you're in a hurry

Not ideal for:
✗ Complex enterprise projects
✗ Projects with many stakeholders
✗ When requirements are unclear

Proceed with fast-track? (yes/no)
```

**[WAIT FOR CONFIRMATION]**

### Step 3: Load Fast-Track Workflow

**Load:** `references/interrogator/fast-track.md`

### Step 4: Initialize Progress

Create/update progress.txt:
```
PHASE: IDEATE
STATUS: in_progress
mode: fast-track
started: [timestamp]
questions_planned: 10

NEXT ACTION: Ask question 1 of 10
```

### Step 5: Start 10 Essential Questions

```
FAST-TRACK INTERROGATION
========================

I'll ask 10 essential questions covering all critical areas.
This will take about 10-15 minutes.

Ready? Let's begin:

Question 1 of 10:
In 2-3 sentences, what are you building and what problem does it solve?
```

**[WAIT FOR ANSWER]**

After answer, update progress.txt and ask question 2:
```
Question 2 of 10:
Who will use this? Describe one specific person.
```

Continue through all 10 questions from fast-track.md.

### Step 6: After All 10 Questions

```
FAST-TRACK COMPLETE
===================

All 10 questions answered in [X] minutes!

Validating completeness...

Quality Assessment: [score]%

[If score >= 70%]
✓ Sufficient detail to generate docs

Summary:
- Problem: [captured]
- Users: [captured]
- Features: [captured]
- Success: [captured]
[...all 10 areas...]

Next: Generate 8 canonical documents

Proceed to DOCUMENT phase? (Type "continue")

[If score < 70%]
⚠ Some areas need more detail

Missing/Vague:
- [area 1]
- [area 2]

Options:
1. Ask 5-10 more questions to fill gaps
2. Proceed anyway (may need to revise docs)
3. Switch to full interrogation mode

What would you like?
```
