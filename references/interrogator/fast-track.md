# Fast-Track Interrogation

For users who know what they want and want to skip the long conversation.

## Detection

User says:
- "Skip the long questions"
- "I know what I want, just make docs"
- "Fast track this"
- "I don't have time for 50 questions"

## Approach

Instead of 10 topics with deep dives, ask **10 essential questions** covering all critical areas.

## The 10 Essential Questions

### 1. Core Description
**Q:** "In 2-3 sentences, what are you building and what problem does it solve?"

Get: Basic concept, problem, solution

### 2. Target User
**Q:** "Who will use this? Describe one specific person."

Get: Primary persona, their situation

### 3. Must-Have Features
**Q:** "What 3-5 features MUST be in v1 for this to be useful?"

Get: Core feature set, priorities

### 4. Success Metric
**Q:** "How will you measure if this is successful? What number matters most?"

Get: Primary KPI, success criteria

### 5. Current Alternative
**Q:** "How are people solving this problem today, and why isn't that good enough?"

Get: Competitive context, differentiation

### 6. Tech Preference
**Q:** "Any tech stack preferences or constraints? (e.g., must use React, budget limits)"

Get: Technical constraints, preferences

### 7. Timeline & Resources
**Q:** "What's your timeline and who's building this?"

Get: Deadline, team size, resources

### 8. Data
**Q:** "What data needs to be stored? (users, posts, etc.)"

Get: Core data model

### 9. Access Control
**Q:** "Who can do what? Any roles or permissions?"

Get: Auth requirements, user roles

### 10. Explicitly Out of Scope
**Q:** "What features are you explicitly NOT building in v1?"

Get: Scope boundaries

## Workflow

```
User: "Skip the long questions, I know what I want"

Claude:
"Got it! I'll ask 10 essential questions instead of the full conversation.
This will take about 10 minutes. Ready?"

User: "Yes"

Claude:
"Question 1 of 10:
In 2-3 sentences, what are you building and what problem does it solve?"

[User answers]

Claude:
"Question 2 of 10:
Who will use this? Describe one specific person."

[Continue through all 10...]

Claude:
"All 10 questions answered! Let me generate your requirements summary..."

[Generates summary]

"Does this capture everything? (Y/add more/N)"

If Y → Move to DOCUMENT phase
If "add more" → Ask follow-ups
If N → Switch to full interrogation
```

## Quality Check

After 10 questions, validate completeness:

```
FAST-TRACK ASSESSMENT:

✓ Problem: Clear
✓ Users: Defined
✓ Features: Prioritized
✓ Success: Measurable
⚠️ Data model: Vague
⚠️ Tech stack: No preference stated

Recommendation:
"I have enough to generate docs, but 2 areas are unclear.
May I ask 3 more questions about data and tech? (Y/skip/full interrogation)"
```

## When Fast-Track Isn't Enough

If answers are too vague after 10 questions:

```
"Based on your answers, I think we need more detail to build quality docs.

Options:
1. Let me ask 10 more targeted questions (~10 min)
2. Switch to full conversation mode (~30 min, more thorough)
3. Generate docs now with what we have (may need revisions)

Which would you prefer?"
```

## Progress Tracking

```
PHASE: IDEATE
mode: fast-track
questions_asked: 10
duration: 12 minutes
quality_score: 75% (Solid)

KEY INSIGHTS:
Problem: [captured]
Users: [captured]
Features: [captured]
Success: [captured]

NEXT ACTION: Generate summary and transition to DOCUMENT
```

## Comparison: Full vs Fast-Track

| Aspect | Full Interrogation | Fast-Track |
|--------|-------------------|------------|
| Duration | 30-45 minutes | 10-15 minutes |
| Questions | ~50 across 10 topics | 10 essential questions |
| Depth | Deep dives per topic | Broad coverage |
| Output Quality | 90-100% | 70-85% |
| Best For | Complex projects | Simple/clear ideas |
| Follow-ups | Automatic | Manual if needed |

## Example Session

```
User: "I want to build a habit tracker. Skip the long questions."

Claude: "Got it! 10 essential questions coming up.

Q1: In 2-3 sentences, what are you building and what problem does it solve?"
User: "A simple habit tracker where users log daily habits like 'exercise' or 'read'. Problem is existing apps are too gamified and distracting."

Q2: Who will use this? Describe one specific person.
User: "Sarah, 32, wants to build better habits without game mechanics. Uses her phone in the morning to check what to do."

Q3: What 3-5 features MUST be in v1?
User: "Add habits, daily check-off, see streak count, that's it."

Q4: How will you measure success?
User: "Users complete 80%+ of their daily habits consistently."

Q5: How are people solving this today?
User: "Paper journals or gamified apps like Habitica. Paper gets lost, apps are overwhelming."

Q6: Tech stack preferences?
User: "React for web, maybe React Native for mobile later. Budget $500."

Q7: Timeline and who's building?
User: "Just me, part-time. Want v1 in 2 months."

Q8: What data needs to be stored?
User: "Users, habits (name, frequency), daily completions (date, habit, done/not)."

Q9: Who can do what? Any roles?
User: "Just one user type. Everyone can only see their own data."

Q10: What are you NOT building in v1?
User: "No social features, no reminders/notifications, no analytics beyond streaks."

Claude: "Perfect! I have everything I need. Generating summary..."

[Shows summary]

"This looks complete! Moving to DOCUMENT phase to generate your 8 canonical docs. Proceed? (Y/N)"
```
