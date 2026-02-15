---
description: Start IDEATE phase (requirements gathering through interactive conversation)
---

# Ideate Command

Start the IDEATE phase - interactive requirements gathering.

## Instructions

Jump directly to IDEATE phase and begin interactive interrogation.

### Step 1: Check Current State

Read progress.txt (if exists).

If already in IDEATE:
```
ALREADY IN IDEATE PHASE

Current progress:
[Show topics covered]

Options:
1. "continue" - Resume current interrogation
2. "restart" - Start fresh interrogation
3. "fast-track" - Switch to 10-question mode

What would you like?
```

If in a different phase:
```
PHASE TRANSITION WARNING

You're currently in [CURRENT PHASE].

Starting IDEATE will:
- Create new requirements from scratch
- Override existing progress

Are you sure? (yes/no)
```

### Step 2: Load IDEATE Phase

**Load:** `references/interrogator/main.md` and `references/interrogator/conversation-engine.md`

### Step 3: Initialize Progress File

Create/update progress.txt:
```
PHASE: IDEATE
STATUS: in_progress
started: [timestamp]
mode: full

NEXT ACTION: Ask opening question
```

### Step 4: Start Interactive Conversation

```
IDEATE PHASE STARTED
====================

I'll gather complete requirements through interactive conversation.

This takes about 30-45 minutes.
I'll ask ONE question at a time and adapt based on your answers.

We'll cover:
- Core Concept (problem/solution)
- Users & Personas
- Features
- Data & Storage
- Auth & Security
- Tech Stack
- Business Constraints
- Edge Cases
- Integrations
- Design & UX

Ready? Let's start:

Q: What's the one-sentence description of what you want to build?
```

**[WAIT FOR ANSWER]**

Then follow conversation-engine.md adaptive questioning.

## Alternative: Fast-Track

If user wants faster mode:
```
User: /vibe-coding:ideate fast

Claude:
FAST-TRACK MODE

10 essential questions instead of full conversation.
Takes 10-15 minutes instead of 30-45.

Ready? Let's start:

Question 1 of 10:
In 2-3 sentences, what are you building and what problem does it solve?
```

Then follow fast-track.md workflow.
