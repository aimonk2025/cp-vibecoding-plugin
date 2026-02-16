# Sequential Document Generation - Example Flow

This shows exactly how the DOCUMENT phase works with user confirmations.

## Complete Example Session

### Starting DOCUMENT Phase

```
[After IDEATE phase complete, or after PRD imported/enhanced]

Claude:
"IDEATE phase complete! Moving to DOCUMENT phase.

I'll now generate 8 canonical documents, one at a time.
Each document takes 3-5 minutes to generate.

The documents are:
1. PRD.md - Product Requirements
2. APP_FLOW.md - User Journeys
3. TECH_STACK.md - Technologies
4. DESIGN_SYSTEM.md - Design Tokens
5. BACKEND_STRUCTURE.md - Database & APIs
6. FRONTEND_GUIDELINES.md - Component Patterns
7. IMPLEMENTATION_PLAN.md - Build Roadmap
8. CLAUDE.md - Project Rules

We'll do them one at a time, with your approval before moving to the next.

Ready to start with PRD.md? (Type 'continue')"
```

**[STOPS AND WAITS]**

---

### Document 1: PRD.md

```
User: "continue"

Claude:
"Generating PRD.md (1/8)...

[Generates document]

Done! PRD.md created at docs/PRD.md

DOCUMENT SUMMARY:
- Executive Summary
- Problem Statement: Busy parents lose track of tasks
- Target Users: 2 personas (Sarah, Mike)
- Core Features: 12 features (must/should/could)
- Success Metrics: 80% task completion rate
- V1 Scope: Simple task list with family sharing
- Out of Scope: Advanced features, integrations

Length: 1,200 words

Review the document in docs/PRD.md

Is this acceptable? (approve/revise/show me [section])"
```

**[STOPS AND WAITS]**

---

### User Reviews and Approves

```
User: "approve"

Claude:
"✓ PRD.md approved (1/8 complete)

Updating progress.txt...

NEXT DOCUMENT: APP_FLOW.md (2/8)

APP_FLOW.md will map out all user journeys and screens based
on the features in PRD.md.

Ready to generate? (Type 'continue')"
```

**[STOPS AND WAITS]**

---

### Document 2: APP_FLOW.md

```
User: "continue"

Claude:
"Generating APP_FLOW.md (2/8)...

[Generates document]

Done! APP_FLOW.md created at docs/APP_FLOW.md

DOCUMENT SUMMARY:
- Authentication Flow
- Main Dashboard Screen
- Task Creation Flow
- Task Completion Flow
- Family Sharing Flow
- Settings Screen
- Navigation Map

Screens defined: 8 screens
User journeys: 5 complete flows

Review the document in docs/APP_FLOW.md

Is this acceptable? (approve/revise/show me [section])"
```

**[STOPS AND WAITS]**

---

### User Wants Revision

```
User: "revise the task creation flow - it should be faster"

Claude:
"Revising task creation flow in APP_FLOW.md...

Changed from 3-step to 1-step:
- Before: Screen → Form → Confirmation
- After: Inline quick-add with Enter key

Updated APP_FLOW.md saved.

Review the updated task creation flow.

Is this acceptable? (approve/revise more)"
```

**[STOPS AND WAITS]**

---

### User Approves After Revision

```
User: "approve"

Claude:
"✓ APP_FLOW.md approved (2/8 complete)

Updating progress.txt...

NEXT DOCUMENT: TECH_STACK.md (3/8)

TECH_STACK.md will define all technologies, frameworks,
and tools based on your requirements and constraints.

Ready to generate? (Type 'continue')"
```

**[STOPS AND WAITS]**

---

### Continuing Through All Documents

```
[This pattern repeats for documents 3-7]

Each time:
1. User types "continue"
2. Claude generates document
3. Shows summary
4. Waits for approval
5. After approval, announces next doc
6. Waits for "continue"
```

---

### Final Document: CLAUDE.md

```
User: "continue"

Claude:
"Generating CLAUDE.md (8/8)...

[Generates document]

Done! CLAUDE.md created at docs/CLAUDE.md

DOCUMENT SUMMARY:
- Project context and goals
- Code style preferences
- File structure rules
- Testing requirements
- Deployment guidelines

This is the LAST document!

Review docs/CLAUDE.md

Is this acceptable? (approve/revise)"
```

**[STOPS AND WAITS]**

---

### Completion - All 8 Done

```
User: "approve"

Claude:
"✓ CLAUDE.md approved (8/8 complete)

🎉 DOCUMENTATION PHASE COMPLETE!

All 8 canonical documents generated and approved:

✓ PRD.md
✓ APP_FLOW.md
✓ TECH_STACK.md
✓ DESIGN_SYSTEM.md
✓ BACKEND_STRUCTURE.md
✓ FRONTEND_GUIDELINES.md
✓ IMPLEMENTATION_PLAN.md
✓ CLAUDE.md

All saved to: docs/

---

YOU ARE NOW READY TO BUILD!

Your IMPLEMENTATION_PLAN.md has 5 phases with 28 steps total.
We'll follow it exactly during the BUILD phase.

Would you like to:
1. Start BUILD phase now (type 'continue' or 'start building')
2. Review any doc first (type 'show me [doc name]')
3. Take a break and resume later (type 'pause')

What would you like to do?"
```

**[STOPS AND WAITS FOR USER DECISION]**

---

### User Starts BUILD Phase

```
User: "start building"

Claude:
"TRANSITIONING: DOCUMENT → BUILD

Updating progress.txt...

Loading BUILD phase workflow...
Reading IMPLEMENTATION_PLAN.md...
Reading TECH_STACK.md...

BUILD PHASE READY

Current: Phase 1, Step 1 - Project Setup
Next: Initialize project with chosen tech stack

Type 'continue' to start building."
```

---

## Key Points

### Never Generate Multiple Docs in Parallel

❌ **WRONG:**
```
Claude:
"Generating all 8 documents...
[Generates all 8 at once]
Here they all are!"
```

✅ **CORRECT:**
```
Claude:
"Ready to generate PRD.md?"
[Wait for continue]
[Generate PRD only]
[Wait for approval]
"Ready for APP_FLOW.md?"
[Wait for continue]
[Repeat...]
```

### Always Wait for "continue"

After EVERY approval:
```
"✓ Document X approved.

NEXT: Document Y

Ready to generate? (Type 'continue')"
[STOP AND WAIT]
```

### Clear Completion Signal

After document 8/8:
```
"🎉 DOCUMENTATION PHASE COMPLETE!

YOU ARE NOW READY TO BUILD!

Type 'continue' to start BUILD phase."
```

### Progress Always Visible

Show after each approval:
```
"✓ PRD.md approved (1/8 complete)"
"✓ APP_FLOW.md approved (2/8 complete)"
"✓ TECH_STACK.md approved (3/8 complete)"
...
"✓ CLAUDE.md approved (8/8 complete)"
```

## Handling Edge Cases

### User Says "continue" Without Approval

```
Claude: "Is this acceptable? (approve/revise)"
User: "continue"

Claude:
"I need your approval first.

Options:
- 'approve' - Accept this document as-is
- 'revise [section]' - I'll update a specific section
- 'show me [section]' - Display a section for review

What would you like to do?"
```

### User Wants to Skip a Document

```
User: "skip this one"

Claude:
"I can't skip documents - each one is needed for the BUILD phase.

However, I can generate a minimal version if you're in a hurry.

Options:
- 'approve minimal' - I'll create a basic version
- 'approve' - Accept current version
- 'revise' - Let's improve it

What would you like to do?"
```

### User Leaves Mid-Process

```
[User leaves after approving 3/8 docs]

Next session:
User: "continue"

Claude:
[Reads progress.txt]

"Resuming DOCUMENT phase.

Completed: 3/8 documents
- ✓ PRD.md
- ✓ APP_FLOW.md
- ✓ TECH_STACK.md

NEXT: DESIGN_SYSTEM.md (4/8)

Ready to generate DESIGN_SYSTEM.md? (Type 'continue')"
```
