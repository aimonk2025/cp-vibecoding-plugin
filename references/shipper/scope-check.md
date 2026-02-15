# Scope Check

A never-ending feature list kills more projects than bad code.

## Table of Contents

- [The Honest Questions](#the-honest-questions) - Core feature, creep, usage, MVP
- [Scope Decision Matrix](#scope-decision-matrix) - Decision flow
- [Common Scope Traps](#common-scope-traps) - Pitfalls to avoid
- [Scope Check Summary](#scope-check-summary) - Final status
- [The Golden Rule](#the-golden-rule) - Ship > perfect

---

## The Honest Questions

Answer these truthfully before deciding to ship:

### Question 1: Core Feature Test

```
CORE FEATURE CHECK:

What is THE core action users take in your app?
→ [describe in one sentence]

Can users complete this action right now?
[ ] YES - it works end to end
[ ] PARTIALLY - some parts work
[ ] NO - core feature incomplete

If NO or PARTIALLY:
What's the ONE thing blocking the core feature?
→ [describe blocker]

Fix that ONE thing. Then re-evaluate.
```

### Question 2: Feature Creep Detection

```
FEATURE CREEP CHECK:

List what you're currently working on:
1. [task]
2. [task]
3. [task]

For each task, classify:
[ ] CORE - Required for main user action
[ ] NICE-TO-HAVE - Improves experience but not essential
[ ] SCOPE CREEP - User didn't ask, you want to add

If any SCOPE CREEP items exist:
→ STOP working on them
→ Ship core first
→ Add them in v2 based on user feedback
```

### Question 3: The Usage Test

```
USAGE TEST:

Would YOU use this app right now for its intended purpose?

[ ] YES - Ship it
[ ] NO - Why not?

If NO, what's the SINGLE blocker?
→ [describe]

That blocker is your only priority.
Everything else is distraction.
```

### Question 4: MVP Definition

```
MVP CHECK:

Minimum Viable Product = smallest version that provides value

Your MVP includes:
[ ] [feature 1 - essential]
[ ] [feature 2 - essential]
[ ] [feature 3 - essential]

These are NOT in MVP (v2+):
- [feature - nice to have]
- [feature - nice to have]
- [feature - nice to have]

Is your current build at MVP?
[ ] YES - Ship
[ ] NO - What essential feature is missing?
```

## Scope Decision Matrix

```
┌─────────────────────────────────────────────────────────────┐
│                    SCOPE DECISION                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Core feature works?                                        │
│       │                                                     │
│       ├── NO → Fix core feature only. Nothing else.         │
│       │                                                     │
│       └── YES → Are you adding non-essential features?      │
│                    │                                        │
│                    ├── YES → STOP. Ship now. Add later.     │
│                    │                                        │
│                    └── NO → Run pre-ship checklist → Ship   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Common Scope Traps

### Trap 1: "Just One More Feature"

```
SYMPTOM: "I'll ship after I add [feature]"

REALITY: There's always one more feature.
You're avoiding shipping because shipping is scary.

FIX: Ship now. Add feature in v1.1 tomorrow.
```

### Trap 2: "It's Not Pretty Enough"

```
SYMPTOM: Tweaking CSS instead of shipping

REALITY: Users care about function > form.
An ugly app that works beats a pretty app that doesn't exist.

FIX: Ship functional. Polish in production.
```

### Trap 3: "What If Users Need X?"

```
SYMPTOM: Building features no one asked for

REALITY: You're guessing what users want.
Real feedback > imagined requirements.

FIX: Ship. Ask users. Build what they actually need.
```

### Trap 4: "The Code Isn't Clean"

```
SYMPTOM: Refactoring before shipping

REALITY: Working messy code > perfect unshipped code.
You can refactor after users validate the idea.

FIX: Ship. If it works, then clean it up.
```

## Scope Check Summary

```
SCOPE CHECK COMPLETE:

Core feature status: [WORKING / NOT WORKING]
Current work classified as: [CORE / NICE-TO-HAVE / SCOPE CREEP]
Would use it yourself: [YES / NO]
At MVP: [YES / NO]

DECISION: [SHIP NOW / FIX [specific thing] THEN SHIP]

If shipping:
→ Proceed to pre-ship checklist

If not shipping:
→ ONE blocker to fix: [describe]
→ Timeline: [when will this be done?]
→ After fixing, return to this scope check
```

## The Golden Rule

```
The best app you never ship is worse than
the average app that's live.

Ship → Learn → Iterate → Repeat
```
