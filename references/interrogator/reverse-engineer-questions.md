# Reverse-Engineer Gap-Filling Questions

This file contains the question bank for extracting business context that code analysis cannot reveal. After analyzing a codebase, use these questions to fill gaps and generate complete documentation.

## Table of Contents

1. [Overview](#overview)
2. [Opening Context](#opening-context)
3. [Question Categories](#question-categories)
4. [Adaptive Questioning Techniques](#adaptive-questioning-techniques)
5. [Exit Criteria](#exit-criteria)

---

## Overview

### Purpose

Code analysis reveals WHAT the app does, but not WHY. This question bank helps extract:
- Problem statement and motivation
- Target users and personas
- Business goals and success metrics
- Feature priorities and rationale
- Future roadmap
- Design decisions and rationale
- Database evolution needs

### Integration with Conversation Engine

Use alongside `conversation-engine.md` for:
- ONE question at a time
- Adaptive follow-ups based on answers
- Depth-first exploration of each topic
- Skipping questions that code already answers

### Estimated Time

10-20 questions total, approximately 15-20 minutes

---

## Opening Context

After code analysis is complete, set context before starting questions:

```
"I've analyzed your codebase and found:

FEATURES DETECTED:
- [Feature 1] (routes: X, API endpoints: Y)
- [Feature 2] (routes: X, API endpoints: Y)
- [Feature 3] (routes: X, API endpoints: Y)
- [Feature 4] (routes: X, API endpoints: Y)
- [Feature 5] (routes: X, API endpoints: Y)

TECH STACK:
- Framework: [Framework] [Version]
- Database: [Database] via [ORM]
- Auth: [Auth Method]
- Styling: [CSS Framework]

DATABASE:
- [N] tables with [M] relationships

Now I need to understand the WHY behind this code.
I'll ask about 10-15 questions, one at a time.
Let's start..."
```

---

## Question Categories

### Category 1: Problem Statement (CRITICAL)

Code shows WHAT, not WHY. These questions extract the core problem being solved.

#### Primary Questions

**Q1.1: Problem Discovery**
```
"I can see your app does [detected main feature]. What specific problem does this solve that existing solutions don't?"
```

**Follow-ups based on answer:**
- If vague ("helps people"): "Helps them do what specifically? What's the pain point?"
- If broad ("makes things easier"): "Easier than what? What's hard about the current way?"
- If feature-focused: "That's a feature. What problem does that feature solve?"

**Q1.2: Problem Validation**
```
"Who specifically has this problem? Can you describe one real person?"
```

**Follow-ups:**
- If hypothetical ("people who..."): "Have you talked to actual people with this problem?"
- If too broad ("everyone"): "Which segment feels this pain most acutely?"

**Q1.3: Current Solutions**
```
"How are people solving this today without your app?"
```

**Follow-ups:**
- If "they can't": "What do they do instead? What's their workaround?"
- If competitor mentioned: "What's specifically painful about using [competitor]?"

**Q1.4: Pain Intensity**
```
"What happens if this problem isn't solved? What's the cost of the status quo?"
```

#### Exit Criteria for Problem Statement

Can confidently answer:
- [ ] Clear problem statement (one sentence)
- [ ] Specific person/persona who has this problem
- [ ] How they're solving it today
- [ ] Why current solutions are inadequate

---

### Category 2: Target Users (CRITICAL)

Code shows capabilities but not WHO uses them.

#### Primary Questions

**Q2.1: Primary User**
```
"I see you have [detected roles/user types]. Who is the PRIMARY user - the person who uses this daily?"
```

**Follow-ups:**
- If multiple: "If you could only serve one type, which would it be?"
- If vague: "Walk me through a day in their life when they'd use this."

**Q2.2: User Profile**
```
"Describe this primary user: their job/role, tech comfort level, and typical device."
```

**Follow-ups:**
- If technical: "Do they code? Do they use command line?"
- If non-technical: "What's the most complex app they use regularly?"

**Q2.3: Usage Frequency**
```
"How often would they use this? Daily? Weekly? Monthly?"
```

**Follow-ups:**
- If daily: "Multiple times per day? What triggers each use?"
- If rarely: "What event triggers them to use it?"

**Q2.4: Secondary Users**
```
"Besides [primary user], who else interacts with this system?"
```

**Follow-ups:**
- For each role: "What's their main action? How often?"

#### Exit Criteria for Target Users

Can confidently write:
- [ ] Primary user persona (name, role, tech level, device)
- [ ] Usage frequency and triggers
- [ ] Secondary user personas (if any)
- [ ] User journeys for each persona

---

### Category 3: Business Goals (CRITICAL)

Code shows features but not business objectives.

#### Primary Questions

**Q3.1: Business Model**
```
"What's the business goal here? Is this for revenue, user growth, efficiency, or something else?"
```

**Follow-ups:**
- If revenue: "How does it make money? Subscription? One-time? Freemium?"
- If internal: "Which department benefits most? What cost does it reduce?"

**Q3.2: Success Definition**
```
"What would 'success' look like in 6 months? Be specific."
```

**Follow-ups:**
- If vague ("lots of users"): "How many users? 100? 10,000? 1 million?"
- If feature-focused: "That's a milestone. What business outcome does it drive?"

**Q3.3: Success Metrics**
```
"How do you measure success? What metrics matter most?"
```

**Follow-ups:**
- If NPS/satisfaction: "What score would be 'good'?"
- If engagement: "What's a 'good' session length or frequency?"
- If revenue: "What's the target ARR/MRR?"

**Q3.4: Failure Scenario**
```
"What would make this project a failure? What are you most worried about?"
```

#### Exit Criteria for Business Goals

Can confidently write:
- [ ] Primary business objective
- [ ] Quantified success metrics (with targets)
- [ ] Timeline for success measurement
- [ ] Key risks identified

---

### Category 4: Feature Priorities (WHY)

Code shows features exist, not why they were prioritized.

#### Primary Questions

**Q4.1: Feature Ranking**
```
"I detected [N] main features. Which is most critical to users? Rank them."
```

**Follow-ups:**
- For #1: "Why is this the most important?"
- For lowest: "Would the app work without this?"

**Q4.2: Build Order Rationale**
```
"Why did you build [Feature A] before [Feature B]?"
```

**Follow-ups:**
- If dependency: "What would break without this order?"
- If user request: "How many users asked for this?"

**Q4.3: Feature Usage**
```
"Are there features in the code that users don't actually use much?"
```

**Follow-ups:**
- If yes: "Why do you think that is? Consider removing?"
- If no: "Which feature has surprised you with its popularity?"

**Q4.4: Missing Features**
```
"What feature is NOT in the code yet that users ask for most?"
```

#### Exit Criteria for Feature Priorities

Can confidently write:
- [ ] Feature priority ranking with rationale
- [ ] Core vs nice-to-have distinction
- [ ] Feature usage insights
- [ ] Missing features identified

---

### Category 5: Database Evolution

Code shows current schema, not future needs.

#### Primary Questions

**Q5.1: Schema Limitations**
```
"Looking at your database schema, have you hit any limitations?"
```

**Follow-ups:**
- If yes: "What specifically is limiting? Missing fields? Wrong relationships?"
- If no: "Any upcoming features that would require schema changes?"

**Q5.2: Data Growth**
```
"How much data do you have now, and how fast is it growing?"
```

**Follow-ups:**
- If growing fast: "Any performance concerns?"
- If small: "What happens when it's 100x larger?"

**Q5.3: Migration Plans**
```
"Do you need to change the database structure? Add tables? Change relationships?"
```

**Follow-ups:**
- If yes: "What changes are needed?"
- If considering: "What's blocking the decision?"

**Q5.4: Data Ownership**
```
"Who owns the data? Are there compliance requirements (GDPR, HIPAA, etc.)?"
```

#### Exit Criteria for Database

Can confidently write:
- [ ] Current schema limitations (if any)
- [ ] Planned schema evolution
- [ ] Data growth expectations
- [ ] Compliance requirements

---

### Category 6: Auth & Security Context

Code shows implementation, not requirements.

#### Primary Questions

**Q6.1: Auth Method Rationale**
```
"I see you're using [detected auth method]. Why this approach?"
```

**Follow-ups:**
- If OAuth: "Why social login? What % of users use each provider?"
- If email/password: "Any plans for social login or SSO?"

**Q6.2: Security Requirements**
```
"Are there security requirements beyond basic authentication?"
```

**Follow-ups:**
- If yes: "2FA? SSO? Specific compliance?"
- If unclear: "Who else can see user data? Admins? Support?"

**Q6.3: Compliance**
```
"Any compliance requirements? (GDPR, HIPAA, SOC2, PCI)"
```

**Follow-ups:**
- If GDPR: "Are you handling data deletion requests?"
- If HIPAA: "Is PHI properly encrypted?"

#### Exit Criteria for Auth

Can confidently write:
- [ ] Auth method rationale
- [ ] Security requirements
- [ ] Compliance requirements (if any)
- [ ] Permission levels and access control

---

### Category 7: Design Rationale

Code shows design choices, not the reasoning.

#### Primary Questions

**Q7.1: Brand Identity**
```
"I extracted your brand colors: [primary], [secondary]. What's the design philosophy?"
```

**Follow-ups:**
- If none: "What feeling should the app evoke?"
- If reference: "Which apps or brands inspired this look?"

**Q7.2: Design Inspiration**
```
"Which apps or brands inspired the design?"
```

**Follow-ups:**
- For each: "What specifically did you like about them?"

**Q7.3: Accessibility**
```
"Are there accessibility requirements? (WCAG, screen readers, color blindness)"
```

**Q7.4: Design Constraints**
```
"Any design constraints I should know about? Brand guidelines? Legacy compatibility?"
```

#### Exit Criteria for Design

Can confidently write:
- [ ] Design philosophy/feeling
- [ ] Design inspirations
- [ ] Accessibility requirements
- [ ] Design constraints

---

### Category 8: Roadmap & Future

Code shows present, not future.

#### Primary Questions

**Q8.1: Next Features**
```
"What features are you planning to add next?"
```

**Follow-ups:**
- For each: "Why this priority? User demand or strategic?"

**Q8.2: Out of Scope**
```
"What's explicitly OUT of scope for this product?"
```

**Follow-ups:**
- If unclear: "What have you said 'no' to?"

**Q8.3: Integrations**
```
"Any integrations planned? Third-party services to add?"
```

**Follow-ups:**
- For each: "Why this integration? What value does it add?"

**Q8.4: Scale Plans**
```
"How do you see this scaling? More users? More features? Enterprise?"
```

#### Exit Criteria for Roadmap

Can confidently write:
- [ ] Planned features (prioritized)
- [ ] Out of scope items
- [ ] Planned integrations
- [ ] Scale/growth strategy

---

## Adaptive Questioning Techniques

### Skip Rules

**Skip question if code already answers:**
- Q: "What database are you using?" - SKIP if Prisma schema found
- Q: "What auth method?" - SKIP if NextAuth config found
- Q: "What framework?" - SKIP if package.json analyzed

**Reference analysis in questions:**
```
"I see you're using Prisma with PostgreSQL. [Question about database plans]"
```

### Depth-First Approach

Stay on one topic until complete before moving to next:

```
Topic: Problem Statement
Q1: What problem does this solve?
A: "It helps teams collaborate"
Q2: "Teams collaborate on what specifically?" [FOLLOW-UP]
A: "On tasks and projects"
Q3: "What's painful about how they do this today?" [FOLLOW-UP]
A: "They use multiple tools and things get lost"
Q4: "Which tools? What gets lost?" [FOLLOW-UP]
A: "Slack, email, spreadsheets. Action items get buried."
[Now problem is clear - move to next topic]
```

### Vagueness Detection

Watch for vague answers that need follow-up:

| Vague Pattern | Follow-Up |
|--------------|-----------|
| "Helps people" | "Helps them do what specifically?" |
| "Makes things easier" | "Easier than what? How?" |
| "Everyone" | "Which segment most acutely?" |
| "Lots of users" | "How many exactly?" |
| "Soon" | "By when? This quarter? This year?" |
| "Better" | "Better in what measurable way?" |
| "Important" | "Important to whom? Why?" |

### Context-Aware Questions

Reference detected features in questions:

```
Bad: "What features does your app have?"
Good: "I see you have task management, team collaboration, and user profiles. Which is most critical to users?"

Bad: "What database are you using?"
Good: "I detected PostgreSQL with 3 tables. Are you planning to add more tables for [detected upcoming feature]?"
```

---

## Exit Criteria

### Minimum Viable Understanding

Before ending gap-filling, ensure you can write:

1. **Problem Statement**
   - [ ] Clear one-sentence problem
   - [ ] Who has this problem
   - [ ] Why existing solutions fail

2. **Target Users**
   - [ ] Primary persona with specifics
   - [ ] Usage frequency
   - [ ] Device/context of use

3. **Business Goals**
   - [ ] Primary objective
   - [ ] Quantified success metrics
   - [ ] Timeline

4. **Feature Priorities**
   - [ ] Ranked feature list
   - [ ] Core vs nice-to-have

5. **Roadmap**
   - [ ] Next planned features
   - [ ] Out of scope items

### Question Count Targets

| Category | Min Questions | Max Questions |
|----------|--------------|---------------|
| Problem Statement | 2 | 5 |
| Target Users | 2 | 4 |
| Business Goals | 2 | 4 |
| Feature Priorities | 1 | 3 |
| Database | 1 | 3 |
| Auth/Security | 1 | 2 |
| Design | 1 | 3 |
| Roadmap | 1 | 3 |
| **TOTAL** | **11** | **27** |

**Target:** 15-20 questions for a complete picture

### Self-Test Before Completion

Before transitioning to doc generation, ask yourself:

```
"Could I write a complete PRD right now?"

- [ ] I know the exact problem being solved
- [ ] I can describe the primary user in detail
- [ ] I understand why each feature exists
- [ ] I know what success looks like (with numbers)
- [ ] I understand the technical constraints
- [ ] I know what's planned vs out of scope
```

If any checkbox is uncertain, continue questioning.

---

## Progress Tracking

Track gap-filling progress in `progress.txt`:

```
GAP-FILLING INTERROGATION:

status: in_progress
started: [timestamp]
questions_asked: 12
estimated_remaining: 5-8

TRANSCRIPT:

Q: I can see your app does task management. What specific problem does this solve?
A: Busy parents forget household tasks because they track on paper and lose notes

Q: Who specifically are these busy parents? Describe one person.
A: Sarah, 35, working mom, 2 kids ages 5 and 8, uses phone for everything

[... more Q&As ...]

TOPICS COVERED:
✓ Problem statement - Complete
✓ Target users - Complete
✓ Business goals - Complete
⊙ Feature priorities - Partial
✗ Database changes - Not asked
✗ Design rationale - Not asked
✗ Roadmap - Not asked

KEY INSIGHTS:
- Primary user: Working parents (25-45)
- Core pain: Paper + digital systems don't sync
- Success metric: 80% task completion rate
- Business model: Freemium with family plan

NEXT ACTION: Continue with feature priorities
```

---

## Example Complete Session

```
Claude: "I've analyzed your codebase and found:

FEATURES DETECTED:
- User Authentication (email/password, Google OAuth)
- Task Management (CRUD, categories, due dates)
- Team Collaboration (invite, share, comments)
- Dashboard (analytics, recent tasks)
- User Profile (avatar, settings)

TECH STACK:
- Framework: Next.js 14.0.0 with App Router
- Database: PostgreSQL via Prisma
- Auth: NextAuth.js
- Styling: Tailwind CSS

DATABASE:
- 3 tables (users, tasks, teams) with 2 relationships

Now I need to understand the WHY behind this code.
I'll ask about 10-15 questions, one at a time.

What specific problem does this task management app solve that existing solutions don't?"

User: "Busy parents forget household tasks"

Claude: "Who specifically are these busy parents? Can you describe one real person who has this problem?"

User: "Sarah, 35, working mom, 2 kids ages 5 and 8. She juggles work meetings and kid activities. Uses her phone for everything but paper lists on the fridge for household tasks."

Claude: "How is Sarah solving this today without your app?"

User: "Paper lists on the fridge plus phone reminders. Things fall through the cracks between the two systems. Her husband doesn't see the phone reminders."

Claude: "What's the cost when tasks fall through the cracks? What happens?"

User: "Stress, arguments with husband about who was supposed to do what, kids miss activities, bills get paid late."

Claude: "I understand the problem clearly now. Moving to business goals...

What would 'success' look like for this app in 6 months?"

User: "10,000 active families using it weekly, and getting featured in App Store parenting category."

Claude: "How do you measure 'active'? What's the minimum engagement?"

User: "Family completes at least 5 tasks per week using the app."

Claude: "Perfect. Now about features...

I detected 5 main features. Which is most critical to users - the one they couldn't live without?"

[... continues for 15-20 questions total ...]

Claude: "Gap-filling complete! I now understand:

SUMMARY:
- Problem: Busy parents lose track of household tasks split between paper and digital
- User: Working parents 25-45, tech-comfortable, primarily mobile
- Success: 10K families, 5+ tasks/week per family, App Store feature
- Core Features: Task management > Team sharing > Dashboard
- Roadmap: Calendar sync, shopping lists, chore assignments for kids

I'm ready to generate the complete documentation. Starting with PRD.md..."
```

---

## Integration Notes

**Load with:**
- `conversation-engine.md` - For questioning technique
- `codebase-analysis.md` - For analysis context

**Output feeds into:**
- `doc-generation-from-code.md` - Combined code + Q&A → Docs
- PRD.md generator
- APP_FLOW.md generator (enhanced)
- DESIGN_SYSTEM.md generator (enhanced)
