# Getting Started with Vibe Coding

This guide walks you through installing and using the Vibe Coding plugin for Claude Code.

## What Makes This Different?

Traditional requirement gathering tools dump 50+ questions at once. **Vibe Coding is different:**

✅ **One question at a time** - Natural conversation, not a questionnaire
✅ **Adaptive follow-ups** - Next question based on your previous answer
✅ **Complete state tracking** - progress.txt preserves everything
✅ **Session recovery** - Resume from exact point, days later
✅ **Workflow validation** - Can't skip critical steps
✅ **5-phase system** - From vague idea to deployed product

**Example conversation:**
```
You: "I want to build a task app"
Claude: "What specific problem with existing task managers are you solving?"
[Not: "Here are 50 questions about your task app..."]
```

## Prerequisites

1. **Claude Code** installed and authenticated
2. Claude Code version **1.0.33 or later** (run `claude --version` to check)

## Installation

### Option 1: Via Marketplace (Recommended)

The easiest way to install and keep the plugin updated:

```bash
# 1. Add the CP Vibe Coding marketplace
/plugin marketplace add aimonk2025/cp-vibecoding-plugin

# 2. Install the plugin
/plugin install vibe-coding@cp-vibe-coding
```

### Option 2: Direct GitHub Installation

Install directly from the GitHub repository:

```bash
/plugin install github:aimonk2025/cp-vibecoding-plugin
```

### Option 3: Local Development/Testing

For plugin development or local testing:

```bash
# Clone the repository anywhere
git clone https://github.com/aimonk2025/cp-vibecoding-plugin.git cp-vibe-coding

# Load the plugin directly
claude --plugin-dir ./cp-vibe-coding
```

### Option 4: Manual Installation

1. Download the repository as a ZIP from GitHub
2. Extract to a directory (e.g., `E:\Claude Skills\cp-vibe-coding\`)
3. Load with: `claude --plugin-dir "E:\Claude Skills\cp-vibe-coding"`

### Verify Installation

In Claude Code, the plugin should load automatically. Try:

```
I want to build a simple note-taking app
```

Claude should respond with the opening interrogation question, not a list of 50 questions.

## Usage

### Starting a New Project

Simply tell Claude what you want to build:

```
I want to build a task management app for freelancers
```

Or be explicit:

```
vibe code a CRM for small businesses
```

Claude will:
1. Detect you're starting a new project
2. Load the IDEATE phase
3. Begin asking structured questions

### Phase Navigation

| To Do This | Say This |
|------------|----------|
| Start new project | "I want to build..." or "new project" |
| Generate docs | "Create the documentation" or "generate PRD" |
| Start coding | "Let's build" or "start implementing" |
| Fix a bug | "This is broken" or "fix the error" |
| Deploy | "Ship it" or "deploy to production" |
| Resume work | "Continue" or "where did we leave off?" |

### The IDEATE Phase (Interactive Conversation)

**How it works NOW:**
Claude asks **ONE question at a time**, listens to your answer, and adapts the next question based on what you said.

```
Claude: "What's the one-sentence description of what you want to build?"
You: "A note-taking app for students"

Claude: "What specific problem with existing note apps are you solving?"
You: "They're too cluttered for simple class notes"

Claude: "Which note apps have you tried, and what felt cluttered?"
You: "Notion and Evernote - too many features I don't need"

Claude: "Who specifically would use this simpler version?"
[Conversation continues naturally...]
```

**Topics covered naturally** (not as a menu):
1. Core Concept - Problem and solution
2. Users - Who and why
3. Features - Must-haves vs nice-to-haves
4. Data - What to store
5. Auth - Who can access what
6. Tech Stack - How to build it
7. Business - Constraints and timeline
8. Edge Cases - What could go wrong
9. Integrations - External services
10. Design - Look and feel

**Key difference:** No question dumps! Just a natural conversation where Claude digs deeper based on your answers.

### Interactive Brand Colors

During the Design category, you'll get an interactive color selection flow:

```
Do you have existing brand colors?

[1] Yes, I have specific colors (hex codes)
[2] No, help me choose colors
[3] I have a primary color but need the rest
```

If you choose "help me choose", you'll select:
- **Mood**: Professional, Energetic, Calm, Modern, Playful, or Luxury
- **Industry**: Technology, Healthcare, Finance, E-commerce, etc.

Claude will suggest 3 complete palettes tailored to your choices.

### The DOCUMENT Phase

After ideation, Claude generates 7 canonical documents:

```
DOCUMENTATION PROGRESS

[x] PRD.md - Approved
[x] APP_FLOW.md - Approved
[>] TECH_STACK.md - In Review
[ ] DESIGN_SYSTEM.md
[ ] BACKEND_STRUCTURE.md
[ ] FRONTEND_GUIDELINES.md
[ ] IMPLEMENTATION_PLAN.md

Progress: 2/7
```

Each document is generated one at a time. Review and approve before moving on.

### The BUILD Phase

Once docs are approved, implementation follows `IMPLEMENTATION_PLAN.md`:

```
BUILD PROGRESS

[x] Phase 1: Setup (3/3 steps)
[x] Phase 2: Auth (4/4 steps)
[>] Phase 3: Core Features (2/5 steps)
[ ] Phase 4: Polish
[ ] Phase 5: Deploy

Current: Phase 3, Step 2 - Contact Detail Page
```

Claude reads your docs at the start of each session and follows them exactly.

### Session Persistence & Recovery

**Everything is saved in `progress.txt`** (created automatically in your project):

```
VIBE CODING PROGRESS
====================

CURRENT STATE:
phase: BUILD
step: Phase 2, Step 3 - User Dashboard
next_action: Complete Dashboard component and tests
last_updated: 2025-02-15T14:45:00Z

---
PHASE: IDEATE
---
STATUS: complete

INTERROGATION TRANSCRIPT:
Q: What's the one-sentence description of what you want to build?
A: A simple task app for busy parents
[Full conversation preserved...]

KEY INSIGHTS:
- Target user: Busy parents with kids under 10
- Problem: Existing tools too complex
- V1 scope: Simple family task sharing

---
PHASE: BUILD
---
STATUS: in_progress

FEATURES COMPLETED:
✓ Phase 1, Step 1: Project setup
✓ Phase 2, Step 3: User Dashboard (in progress)

FILES CHANGED:
- src/components/Dashboard.tsx (created)

NEXT ACTION: Complete Dashboard component and tests
```

**To resume:** Just say `"continue"` and Claude reads progress.txt and picks up exactly where you left off, even days later!

### The DEBUG Phase

When something breaks:

```
The login form isn't submitting
```

Claude will:
1. Reproduce the bug first
2. Research what's affected
3. Present findings before fixing
4. Propose a fix and get approval
5. Implement and verify
6. Update lessons learned

### The SHIP Phase

When ready to deploy:

```
Let's ship this
```

Claude runs:
1. **Scope Check** - Is MVP actually complete?
2. **Pre-Ship Checklist** - Mobile, errors, security, performance
3. **Deployment** - Push to Vercel/hosting
4. **Post-Deploy Verification** - Confirm it works live

## Tips for Best Results

### 1. Answer Naturally in Conversation

**Good:**
```
Claude: "What problem does this solve?"
You: "My students forget homework deadlines because they write them on random pieces of paper"
```

**Less helpful:**
```
You: "Organization"
```

The more context you give, the better Claude understands and adapts the next question.

### 2. Don't Feel Rushed

This is a conversation, not a race. Take time to think through your answers. Claude will wait.

### 3. Ask Claude to Dig Deeper

If you're unsure about something:
```
You: "I'm not sure which tech stack to use. What would you recommend for my use case?"
```

Claude will ask clarifying questions to help you decide.

### 4. Use "Continue" to Resume

Starting a new session? Just say:
```
You: "continue"
```

Claude reads `progress.txt` and resumes exactly where you left off, even if it's been days or weeks.

### 5. Trust the Progress File

Your `progress.txt` contains everything:
- Full conversation transcript
- All decisions made
- Current phase and step
- Next action

You can read it anytime to see where you are.

### 6. Review Generated Docs

During DOCUMENT phase, actually read what gets generated. These docs become **law** during BUILD phase. If something's wrong in the PRD, the code will implement it wrong.

### 7. Don't Skip Phases

The workflow enforces quality:
- IDEATE ensures you build the right thing
- DOCUMENT ensures everyone understands what to build
- BUILD follows the blueprint
- DEBUG fixes issues systematically
- SHIP ensures production-readiness

Skipping = rework later.

## Troubleshooting

### Skill Not Loading

1. Check skill is in correct directory (`~/.claude/skills/vibe-coding/`)
2. Verify `SKILL.md` exists at root
3. Restart Claude Code

### Wrong Phase Detected

Be explicit:

```
I want to go to the BUILD phase
```

Or use the phase selector:

```
Which phase should we be in?
```

### Progress Lost

If `progress.txt` is missing, Claude will analyze your codebase and recreate state:

```
I don't see progress.txt. Let me check what exists and figure out where we are.
```

### Docs Out of Sync

If you manually edited docs and they conflict:

```
CONFLICT DETECTED:
PRD says X but IMPLEMENTATION_PLAN says Y.
Which is correct?
```

Always resolve conflicts before continuing.

## Support

- **Issues**: [GitHub Issues](https://github.com/aimonk2025/cp-vibecoding-plugin/issues)
- **Discussions**: [GitHub Discussions](https://github.com/aimonk2025/cp-vibecoding-plugin/discussions)
