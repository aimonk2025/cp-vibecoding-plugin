# Session Startup Protocol

Read these files in this exact order at the start of every session. No exceptions.

## Reading Order

1. **Operating rules file** (CLAUDE.md or .cursorrules)
2. **progress.txt** - Where the project stands right now
3. **IMPLEMENTATION_PLAN.md** - What phase and step is next
4. **LESSONS.md** - Mistakes to avoid this session
5. **PRD.md** - Feature requirements
6. **APP_FLOW.md** - User journey through the app
7. **TECH_STACK.md** - Exact versions of technologies
8. **DESIGN_SYSTEM.md** - Exact design tokens
9. **FRONTEND_GUIDELINES.md** - Component engineering patterns
10. **BACKEND_STRUCTURE.md** - Data and API patterns

## After Reading

Write formal session plan to `tasks/todo.md` with:
- Checkable items for the session
- Reference to IMPLEMENTATION_PLAN.md phase numbers
- Clear scope boundaries

## Verification Gate

```
Before writing any code, verify the plan with the user:

SESSION PLAN:
1. [task] — references [doc section]
2. [task] — references [doc section]

→ Approve this plan or redirect me.
```

## Session End Protocol

When ending a session:

1. Update `progress.txt` with:
   - What was built
   - What's in progress
   - What's blocked
   - What's next
   - Reference to IMPLEMENTATION_PLAN.md phase numbers

2. `tasks/todo.md` has served its purpose - `progress.txt` carries state forward

## Missing Documentation

If any required file is missing, STOP and ask:

```
Missing required documentation: [filename]

I cannot proceed without this file. Please provide it or confirm
this project doesn't use [purpose of file].
```
