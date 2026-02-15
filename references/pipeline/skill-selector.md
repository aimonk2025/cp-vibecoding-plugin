# Skill Selector

Interactive guide to choosing the right vibe skill.

## Table of Contents

- [Quick Decision Tree](#quick-decision-tree) - Visual flow
- [Skill Profiles](#skill-profiles) - Each skill's purpose
- [Situational Guide](#situational-guide) - Common scenarios
- [Skill Combinations](#skill-combinations) - Sequential, parallel, loop
- [Override Commands](#override-commands) - Direct skill access
- [FAQ](#faq) - Common questions

---

## Quick Decision Tree

```
START
  │
  ├─ Do you have a clear idea of what to build?
  │    │
  │    ├─ NO → vibe-interrogator
  │    │       "Let's figure out what you're building"
  │    │
  │    └─ YES → Do you have documentation?
  │              │
  │              ├─ NO → vibe-doc-architect
  │              │       "Let's create your project docs"
  │              │
  │              └─ YES → Is something broken?
  │                        │
  │                        ├─ YES → vibe-debugger
  │                        │        "Let's fix that bug"
  │                        │
  │                        └─ NO → Ready to ship?
  │                                 │
  │                                 ├─ YES → vibe-shipper
  │                                 │        "Let's deploy"
  │                                 │
  │                                 └─ NO → vibe-engineer
  │                                          "Let's build"
```

## Skill Profiles

### vibe-interrogator

**Best for:**
- "I have an idea but it's vague"
- "I want to build something like X"
- "Not sure where to start"
- "Need to flesh out requirements"

**Triggers:**
- New project from scratch
- Major pivot of existing project
- Unclear requirements

**Output:**
- Answered questions (50+)
- Clear requirements
- Ready for documentation

**Example prompts:**
- "I want to build a CRM for freelancers"
- "Help me figure out what this app should do"
- "I have an idea for a task manager"

---

### vibe-doc-architect

**Best for:**
- "I know what to build, need docs"
- "Generate my project documentation"
- "Create PRD and tech stack"

**Triggers:**
- After ideation complete
- Have requirements, need structure
- Starting with existing specs

**Output:**
- PRD.md
- APP_FLOW.md
- TECH_STACK.md
- FRONTEND_GUIDELINES.md
- BACKEND_STRUCTURE.md
- IMPLEMENTATION_PLAN.md
- CLAUDE.md

**Example prompts:**
- "Generate docs from our interrogation"
- "Create the canonical documentation"
- "I need a PRD for this project"

---

### vibe-engineer

**Best for:**
- "Let's start coding"
- "Build this feature"
- "Implement step 3.2"
- "Continue where we left off"

**Triggers:**
- Docs complete and approved
- Ready to write code
- Continuing development

**Output:**
- Working features
- Updated progress.txt
- Completed implementation steps

**Example prompts:**
- "Start building the dashboard"
- "Implement the user auth flow"
- "Continue from where we left off"
- "Build step 4 of the implementation plan"

---

### vibe-debugger

**Best for:**
- "This is broken"
- "Fix this error"
- "Why isn't this working?"
- "Tests are failing"

**Triggers:**
- Bug discovered
- Error messages
- Unexpected behavior
- CI/test failures

**Output:**
- Fixed bug
- Root cause documented
- lessons.md updated
- No regressions

**Example prompts:**
- "The form doesn't submit"
- "Getting this error: [error]"
- "It works locally but breaks on Vercel"
- "Fix the failing tests"

---

### vibe-shipper

**Best for:**
- "Ready to deploy"
- "Ship this to production"
- "Is this ready to launch?"
- "Do pre-ship checks"

**Triggers:**
- Features complete
- Ready for production
- Need verification
- Post-launch maintenance

**Output:**
- Verified checklist
- Deployed application
- Production URL
- Post-ship monitoring

**Example prompts:**
- "Deploy to Vercel"
- "Is this ready to ship?"
- "Run pre-ship verification"
- "We're live, now what?"

---

## Situational Guide

### "I just opened Claude and want to work on my project"

```
SITUATION: Returning to existing project

Ask yourself:
1. Is something broken? → vibe-debugger
2. Ready to ship? → vibe-shipper
3. Otherwise → vibe-engineer

Say: "continue" to auto-detect from progress.txt
```

### "I have a new idea"

```
SITUATION: Starting fresh

Path: vibe-interrogator → vibe-doc-architect → vibe-engineer

Say: "new project" or "I want to build [idea]"
```

### "Client sent me requirements"

```
SITUATION: External specs exist

Path: vibe-doc-architect (may skip interrogator)

Say: "I have requirements, need to create docs"
```

### "Something broke in production"

```
SITUATION: Live bug

Path: vibe-debugger → vibe-shipper (redeploy)

Say: "production bug" or "users reporting [issue]"
```

### "I'm stuck and don't know what to do"

```
SITUATION: Lost

Path: vibe-orchestrator will help

Say: "help", "where am I?", or "what should I do next?"
```

---

## Skill Combinations

### Sequential (Normal Flow)
```
interrogator → doc-architect → engineer → shipper
```

### Parallel (During Build)
```
engineer ←→ debugger (switch as needed)
```

### Loop (Iteration)
```
shipper → feedback → engineer → shipper
```

### Reset (Major Change)
```
any phase → interrogator (start over)
```

---

## Override Commands

Jump directly to any skill:

| Command | Skill |
|---------|-------|
| `/ideate` | vibe-interrogator |
| `/docs` | vibe-doc-architect |
| `/build` | vibe-engineer |
| `/debug` | vibe-debugger |
| `/ship` | vibe-shipper |
| `/status` | Show current progress |
| `/help` | Show this selector |

---

## FAQ

**Q: Can I skip phases?**
A: Yes, but not recommended. Each phase builds on the previous.

**Q: What if I have partial docs?**
A: vibe-doc-architect can fill gaps. Tell it what exists.

**Q: Can I use debugger during ideation?**
A: No bugs to fix yet! Debugger is for code issues.

**Q: When do I use orchestrator vs specific skill?**
A: Orchestrator when unsure. Specific skill when you know what you need.
