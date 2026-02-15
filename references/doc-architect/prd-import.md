# PRD Import & Enhancement

Handle user-provided PRDs of any quality level.

## Import Methods

### Method 1: File Path
```
User: "Use this PRD: ./docs/requirements.md"

Claude:
1. Read file at path
2. Parse content
3. Run validation
4. Proceed based on quality
```

### Method 2: Paste Content
```
User: "Here's my PRD: [pastes 500 words]"

Claude:
1. Capture pasted content
2. Parse structure
3. Run validation
4. Proceed based on quality
```

### Method 3: URL
```
User: "Use this PRD: https://docs.google.com/..."

Claude:
1. Fetch URL content (if accessible)
2. Parse content
3. Run validation
4. Proceed based on quality
```

## Validation Rubric

### Section Checks

**Problem Statement (0-20 points)**
- 0: Missing or "TBD"
- 5: Vague ("users have issues")
- 10: General ("current tools are bad")
- 15: Specific ("freelancers waste 2hrs/day on invoicing")
- 20: Quantified with validation ("interviewed 50 freelancers, 80% report...")

**Target Users (0-20 points)**
- 0: Missing
- 5: Generic ("businesses", "people")
- 10: Segmented ("small businesses")
- 15: Persona with demographics ("Sarah, 35, freelance designer")
- 20: Multiple detailed personas with behaviors

**Core Features (0-20 points)**
- 0: Missing
- 5: Vague list ("user management", "dashboards")
- 10: Specific features ("login with email/password")
- 15: Prioritized (must/should/could)
- 20: Prioritized with acceptance criteria

**Success Metrics (0-15 points)**
- 0: Missing
- 5: Qualitative ("users are happy")
- 10: Quantitative ("100 users in month 1")
- 15: Specific KPIs with targets ("80% task completion rate")

**Technical Constraints (0-10 points)**
- 0: Missing
- 5: Mentioned ("need to be fast")
- 10: Specific ("budget $500, 2-month timeline, mobile-first")

**Scope Definition (0-15 points)**
- 0: Missing
- 5: Vague ("start simple")
- 10: In scope defined
- 15: In + out of scope clearly defined

**Total: 100 points**

### Quality Levels
- 0-30: Stub (start over)
- 31-60: Basic (major enhancement needed)
- 61-85: Solid (minor gaps)
- 86-100: Complete (ready to use)

## Enhancement Workflows

### For Stub PRDs (0-30%)

```
PRD QUALITY: 12% (STUB)

This PRD is too incomplete. Let's build it properly.

Switching to full IDEATE interrogation...

Q: What's the one-sentence description of what you want to build?
[Full conversation workflow]
```

### For Basic PRDs (31-60%)

```
PRD QUALITY: 45% (BASIC)

Found:
✓ Feature list (contact management, deals)
✗ Problem not defined
✗ Users not specified
✗ No success metrics

I'll ask targeted questions to complete this (~15 minutes):

--- PROBLEM ---
Q: What specific problem do users have that this solves?
A: [user answers]

Q: How are they solving it today?
A: [user answers]

Q: What's painful about that solution?
A: [user answers]

--- USERS ---
Q: Who specifically would use this? Describe one person.
A: [user answers]

Q: How often would they use it?
A: [user answers]

[Continue until all gaps filled]

PRD ENHANCED:
- Problem: Small businesses lose deals due to poor follow-up tracking
- Users: Sales teams of 3-10 people in service businesses
- Success: 20% more closed deals, 0 missed follow-ups

UPDATED QUALITY: 82% (SOLID)

Minor gaps remain. Continuing...
```

### For Solid PRDs (61-85%)

```
PRD QUALITY: 75% (SOLID)

This is mostly complete! Just need clarification on:
✗ Success metrics mentioned but not quantified
✗ Technical constraints not specified

Quick questions:

Q: You mentioned "high user satisfaction" - how will you measure that?
A: NPS score above 40

Q: Any technical constraints? Budget, timeline, platform?
A: $1000 budget, 3 months, web + mobile

UPDATED QUALITY: 91% (COMPLETE)

Perfect! Generating remaining docs...
```

### For Complete PRDs (86-100%)

```
PRD QUALITY: 93% (COMPLETE)

Excellent PRD! I found:
✓ Clear problem with validation
✓ Detailed user personas
✓ Prioritized features with criteria
✓ Quantified success metrics
✓ Well-defined scope

Proceeding to generate:
- APP_FLOW.md
- TECH_STACK.md
- DESIGN_SYSTEM.md
- BACKEND_STRUCTURE.md
- FRONTEND_GUIDELINES.md
- IMPLEMENTATION_PLAN.md
- CLAUDE.md

This will take ~20 minutes. Start? (Y/N)
```

## Enhancement Question Bank

### If Missing: Problem
```
PROBLEM QUESTIONS:
1. What specific problem does this solve?
2. Who has this problem?
3. How are they solving it today without your solution?
4. What's painful/expensive/slow about current solutions?
5. How often does this problem occur?
6. What's the cost of NOT solving it?
```

### If Missing: Users
```
USER QUESTIONS:
1. Describe one specific person who would use this
2. What's their role/job/situation?
3. How tech-savvy are they?
4. What device will they primarily use?
5. How often would they use this?
6. What would make them switch to your solution?
```

### If Missing: Success Metrics
```
SUCCESS QUESTIONS:
1. How will you know if this is successful?
2. What numbers/metrics matter?
3. What's a realistic target for month 1? Month 6?
4. What behavior change are you hoping to see?
```

### If Missing: Scope
```
SCOPE QUESTIONS:
1. What's the minimum viable version?
2. What features are must-have for launch?
3. What nice-to-haves can wait for v2?
4. What will you explicitly NOT build?
```

## Rebuilding PRD

After enhancement questions, regenerate PRD:

```
GENERATING ENHANCED PRD:

Using:
- Original PRD (user-provided)
- Enhancement Q&A (12 questions)
- Best practices (PRD structure)

Sections:
✓ Executive Summary
✓ Problem Statement (enhanced)
✓ Target Users (added personas)
✓ Features (prioritized with acceptance criteria)
✓ Success Metrics (quantified)
✓ Technical Constraints (added)
✓ Scope (in/out defined)
✓ User Journeys (inferred from features)

Writing to: PRD.md

Done! Please review:
[Shows enhanced PRD]

Approve? (Y/edit/N)
```

## Progress Tracking

```
ENTRY POINT: User-provided PRD
prd_source: ./docs/requirements.md
prd_initial_quality: 42% (Basic)

ENHANCEMENT SESSION:
questions_asked: 15
topics_covered: [problem, users, metrics, scope]
duration: 18 minutes

prd_final_quality: 89% (Complete)

SECTIONS ENHANCED:
- Problem: Added specificity and validation
- Users: Created 2 detailed personas
- Success Metrics: Added quantified KPIs
- Scope: Defined in/out of scope

NEXT ACTION: Generate APP_FLOW.md based on enhanced PRD
```
