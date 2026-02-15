# Vibe Coding Plugin for Claude Code

Build software from vague idea to shipped product through 5 structured phases with **interactive conversation** and **complete state tracking**.

## What is This?

Vibe Coding is a Claude Code plugin that guides you through the entire software development lifecycle with a conversational, adaptive approach:

```
IDEA --> DOCS --> CODE --> FIX --> SHIP --> LIVE
         ↑
    REVERSE-ENGINEER (NEW!)
    (from existing codebase)
```

**Key Innovations:**
- **Interactive Conversation**: Asks **ONE question at a time**, adapts based on your answers
- **Flexible Entry Points**: Start from scratch, existing PRD, OR existing codebase
- **Reverse-Engineering**: Auto-detects and generates docs from your existing code
- **Complete State Tracking**: Everything tracked in `progress.txt` for seamless session recovery

## Flexible Entry Points (Start Anywhere!)

Vibe Coding adapts to what you already have:

| You Have | Entry Point | What Happens |
|----------|-------------|--------------|
| **Just an idea** | IDEATE (full) | 30-min interactive conversation, 10 topics |
| **Existing codebase** | REVERSE-ENGINEER (NEW!) | Auto-detect → analyze → generate docs → fill gaps |
| **Existing PRD** | DOCUMENT (PRD import) | Validate PRD quality → enhance if needed → generate other 7 docs |
| **Want to skip questions** | IDEATE (fast-track) | 10 essential questions instead of full conversation |

## The 5 Phases + Reverse-Engineering

| Phase | Name | What Happens |
|-------|------|--------------|
| 0 | **REVERSE-ENGINEER** (NEW!) | Analyze existing code → generate tech docs → fill business context gaps |
| 1 | **IDEATE** | Interactive Q&A conversation covering 10 topics naturally (not a questionnaire!) |
| 2 | **DOCUMENT** | Generate 8 canonical docs (PRD, App Flow, Tech Stack, etc.) with approval workflow |
| 3 | **BUILD** | Implement features step-by-step with continuous progress tracking |
| 4 | **DEBUG** | Fix bugs surgically with investigation logs and lessons learned |
| 5 | **SHIP** | Pre-flight checks, deploy, and post-launch monitoring |

## Features

### 🆕 NEW: Reverse-Engineering from Existing Code
- **Auto-detects codebases** - Recognizes frameworks when plugin activates
- **8-area deep analysis** - Features, architecture, database, auth, APIs, middleware, UX, business logic
- **Confidence scoring** - Shows HIGH/MEDIUM/LOW confidence with user verification
- **Tech docs from code** - Generates TECH_STACK, BACKEND_STRUCTURE, FRONTEND_GUIDELINES directly from code
- **Business context Q&A** - Fills gaps code can't reveal (problem statement, users, goals)
- **Framework support** - Next.js, React, Vue, Express, Django, Rails, Laravel, FastAPI, and more
- **Flexible exit paths** - Add features (IDEATE), improve code (BUILD), or keep docs and exit

### 🎯 Interactive Conversation System
- **ONE question at a time** - No more overwhelming question dumps
- **Adaptive follow-ups** - Next question based on your previous answer
- **Natural dialogue** - Feels like talking to a senior product manager
- **Gap detection** - Automatically identifies vague or missing information

### 💾 Complete State Management
- **progress.txt** - Single source of truth for all workflow state
- **Full conversation transcript** - Every Q&A preserved with timestamps
- **Session recovery** - Resume from exact point, even days later
- **Phase transitions** - Automatic validation before moving to next phase

### 🔄 Workflow Engine
- **State machine** - Formal phase transitions with completion criteria
- **Hooks system** - Auto-save progress after every interaction
- **Quality gates** - Can't skip required steps or incomplete phases
- **Error recovery** - Graceful handling of bugs during BUILD phase

### 🎨 Design & Documentation
- **Interactive Brand Colors** - Mood-based palette suggestions with industry context
- **Design System Generation** - CSS variables, Tailwind config, and token definitions
- **8 Canonical Docs** - Complete documentation suite generated from conversation
- **Cross-referenced** - Docs stay consistent with each other

### 🛡️ Protection & Learning
- **Protection Rules** - Guardrails prevent regressions and scope creep
- **Lessons Learned** - Mistakes captured to avoid repeating them
- **Progressive Disclosure** - Information loads only when needed
- **Documentation is Law** - Code implementation follows docs exactly

## Installation

### Method 1: Direct GitHub Installation (Recommended)

**Step 1:** Open Claude Code in your terminal

```bash
claude
```

**Step 2:** Install the plugin using the `/plugin` command

```bash
/plugin install github:aimonk2025/cp-vibecoding-plugin
```

**Step 3:** Start using the plugin

Simply say: "I want to build a task management app" or use any of the [trigger phrases](#trigger-phrases) below.

### Method 2: Local Development/Testing

Use this method if you want to modify the plugin or test changes locally.

**Step 1:** Clone the repository

```bash
git clone https://github.com/aimonk2025/cp-vibecoding-plugin.git
cd cp-vibecoding-plugin
```

**Step 2:** Run Claude Code with the plugin directory flag

```bash
claude --plugin-dir ./
```

**Step 3:** Start using the plugin

In Claude Code, say: "I want to build a task management app" or use any of the [trigger phrases](#trigger-phrases) below.

### Full Installation Guide

See [GETTING_STARTED.md](GETTING_STARTED.md) for complete installation and usage instructions.

### Quick Reference

See [QUICKSTART.md](QUICKSTART.md) for commands, examples, and troubleshooting.

## What You'll Experience

### NEW: Reverse-Engineering Existing Code

```
You: "Generate docs for my Next.js app"

Claude: [Auto-detects codebase]
"I detected an existing Next.js project with 487 code files.

DETECTED:
- Framework: Next.js 14 (App Router)
- Language: TypeScript
- Database: PostgreSQL (Prisma)
- Auth: NextAuth.js

Would you like me to reverse-engineer this and generate complete docs?"

You: "Yes"

Claude: [Deep analysis of 8 areas]
"Analyzing features, architecture, database, auth, APIs...

FOUND (with 95% confidence):
- 12 features: Auth, Dashboard, User profiles, Blog posts, etc.
- 3 database tables: users, posts, comments
- REST API with 15 endpoints
- NextAuth.js authentication

Is this correct? Any corrections?"

You: "Looks right"

Claude: [Generates 5 tech docs from code]
"Generated TECH_STACK.md, BACKEND_STRUCTURE.md, FRONTEND_GUIDELINES.md...

Now I need business context. Let me ask a few questions:

Q: What problem does this blog solve that others don't?"

[10 min Q&A about business context]

Claude: "Complete! Generated all 8 docs. What's next?
1. Add features (plan new functionality)
2. Improve code (refactor, add tests)
3. Done (keep docs)"

You: "Add features"

Claude: "Great! Let's plan new features. What would you like to add?"
```

### Starting a New Project

```
You: "I want to build a habit tracking app"

Claude: "What's the one-sentence description of what you want to build?"

You: "An app where users track daily habits and see their streaks"

Claude: "What specific problem are people having with existing habit trackers?"

You: "They're too gamified. People want something simple."

Claude: "Which habit trackers have you tried, and what felt too gamified?"

[Natural conversation continues...]
[progress.txt automatically tracks everything]
[After ~20-30 minutes of conversation, all requirements are clear]

Claude: "Requirements complete. Here's your summary..."
[Shows complete summary of everything discussed]

You: "Looks good"

Claude: "Moving to DOCUMENT phase. Generating PRD.md..."
```

### Resuming Days Later

```
You: "continue"

Claude: [reads progress.txt]
"Resuming DOCUMENT phase. Last time we approved PRD.md and APP_FLOW.md.
Next up: TECH_STACK.md. Based on your requirements for a simple habit tracker,
I recommend..."
```

No context lost. Perfect continuity.

## Trigger Phrases

Start a session by saying:

**New Projects:**
- "I want to build..." / "Build me..."
- "New project" / "Start a project"
- "Vibe code this"

**Existing Code (NEW):**
- "Generate docs from my code"
- "Document this codebase"
- "Create PRD from code"
- "Reverse engineer this"
- "Analyze my code"
- Or just activate plugin in directory with code (auto-detects)

**Resume/Continue:**
- "Continue" / "Resume" / "Where were we?"

**Other Phases:**
- "Fix this bug" / "Debug this"
- "Ship it" / "Deploy"

**Manual Commands:**
- `/vibe-coding:reverse-engineer` - Force reverse-engineering
- `/vibe-coding:ideate` - Start IDEATE phase
- `/vibe-coding:document` - Start DOCUMENT phase
- `/vibe-coding:build` - Start BUILD phase
- `/vibe-coding:status` - Show current progress

## Plugin Structure

```
cp-vibe-coding/
├── .claude-plugin/
│   └── plugin.json             # Plugin manifest
├── skills/
│   └── vibe-coding/
│       └── SKILL.md            # Main workflow orchestration
├── hooks/
│   └── hooks.json              # Auto-save and validation hooks
├── references/
│   ├── interrogator/           # IDEATE phase
│   │   ├── main.md             # Interactive conversation workflow
│   │   ├── conversation-engine.md  # Adaptive questioning system
│   │   ├── reverse-engineer-questions.md  # NEW: Business context gap-filling
│   │   ├── core-concept.md
│   │   ├── users.md
│   │   ├── features.md
│   │   ├── data.md
│   │   ├── auth.md
│   │   ├── tech-stack.md
│   │   ├── business.md
│   │   ├── edge-cases.md
│   │   ├── integrations.md
│   │   ├── design.md
│   │   ├── brand-colors.md
│   │   └── summary-template.md
│   ├── doc-architect/          # DOCUMENT phase
│   │   ├── main.md
│   │   ├── codebase-analysis.md     # NEW: Reverse-engineering workflow
│   │   ├── reverse-engineer/        # NEW: Code analysis tools
│   │   │   ├── analysis-engine.md   # 8-area deep analysis
│   │   │   ├── code-detectors.md    # Framework detection
│   │   │   └── doc-generation-from-code.md  # Code-to-doc templates
│   │   └── generators/         # 8 doc generators
│   ├── engineer/               # BUILD phase
│   │   ├── main.md
│   │   ├── protection-rules.md
│   │   ├── communication.md
│   │   └── ...
│   ├── debugger/               # DEBUG phase
│   │   ├── main.md
│   │   ├── investigation.md
│   │   └── ...
│   ├── shipper/                # SHIP phase
│   │   └── main.md
│   └── pipeline/               # Workflow management
│       ├── entry-point-detection.md  # UPDATED: Auto-detection
│       ├── state-management.md       # UPDATED: REVERSE-ENGINEER state
│       ├── workflow-state-machine.md # UPDATED: New transitions
│       ├── progress-templates.md     # UPDATED: Reverse-engineering templates
│       └── hooks-design.md
├── commands/                   # Manual commands
│   ├── reverse-engineer.md     # NEW: /reverse-engineer command
│   ├── ideate.md
│   ├── document.md
│   ├── build.md
│   └── ...
├── README.md                   # This file
├── GETTING_STARTED.md          # Installation & usage
├── QUICKSTART.md               # Quick reference
└── IMPROVEMENTS.md             # What we fixed
```

## What Gets Generated

### During Your Conversation (IDEATE Phase)
**`progress.txt`** - Created automatically in your project root:
- Full conversation transcript with timestamps
- All questions and answers preserved
- Topics covered checklist
- Key insights extracted
- Next action for resuming

### Documentation Suite (DOCUMENT Phase)

All 8 canonical docs are generated whether you start from scratch OR reverse-engineer existing code:

| Document | Generated From Scratch | Generated From Code |
|----------|------------------------|---------------------|
| `PRD.md` | Interrogation conversation | Code features + business Q&A |
| `APP_FLOW.md` | User journey questions | Routes/navigation + UX Q&A |
| `TECH_STACK.md` | Tech preferences Q&A | package.json, dependencies, config files |
| `DESIGN_SYSTEM.md` | Design preferences + mood | CSS/Tailwind analysis + rationale Q&A |
| `BACKEND_STRUCTURE.md` | Data model questions | Schema, models, API routes |
| `FRONTEND_GUIDELINES.md` | Component preferences | Component patterns, file structure |
| `IMPLEMENTATION_PLAN.md` | Build sequence plan | Future features roadmap |
| `CLAUDE.md` | Project-specific rules | Project-specific rules |

### During BUILD Phase
- Feature implementation tracking in `progress.txt`
- Files changed log
- Test results
- Lessons learned in `tasks/lessons.md`

## Supported Frameworks for Reverse-Engineering

The reverse-engineering system detects and analyzes:

**Frontend:**
- Next.js (12, 13, 14 - both Pages and App Router)
- React (Create React App, Vite)
- Vue 3
- Nuxt 3
- Svelte / SvelteKit

**Backend:**
- Express.js
- NestJS
- Django
- FastAPI
- Ruby on Rails
- Laravel

**Databases:**
- Prisma
- TypeORM
- Mongoose
- Sequelize
- Django ORM
- ActiveRecord

**More frameworks added regularly!**

## Requirements

- [Claude Code](https://code.claude.com) installed and authenticated
- Claude Code version 1.0.33 or later
- Any operating system (Windows, macOS, Linux)

## Documentation

- **[GETTING_STARTED.md](GETTING_STARTED.md)** - Installation and detailed usage guide
- **[QUICKSTART.md](QUICKSTART.md)** - Quick reference and examples
- **[IMPROVEMENTS.md](IMPROVEMENTS.md)** - What we fixed and why

## Troubleshooting

### Plugin Not Recognized

If you see "Unknown skill: vibe-coding" or "Unknown slash command":

1. **Verify installation:**
   ```bash
   ls ~/.claude/plugins/marketplaces/cp-vibe-coding
   ```
   (On Windows: `dir C:\Users\<username>\.claude\plugins\marketplaces\cp-vibe-coding`)

2. **Reload Claude Code:**
   - Restart your Claude Code session
   - OR run: `/plugin reload vibe-coding`

3. **Check plugin list:**
   ```bash
   /plugin list
   ```
   You should see "vibe-coding" in the list.

4. **Manual activation (if needed):**
   ```bash
   /plugin activate vibe-coding
   ```

### Trigger Phrases Not Working

If typing "generate docs for my app" doesn't work:

**Use these exact phrases:**
- "generate docs from my code"
- "analyze my code and create documentation"
- "reverse engineer this codebase"
- "document this project"

**Or use the direct command:**
```
/reverse-engineer
```

### Commands Available

All slash commands (work regardless of trigger phrases):
- `/ideate` - Start requirements gathering
- `/document` - Create documentation
- `/build` - Implement features
- `/reverse-engineer` - Analyze existing code
- `/status` - Check progress
- `/show` - Display generated docs

## Support

- **Issues**: [GitHub Issues](https://github.com/aimonk2025/cp-vibecoding-plugin/issues)
- **Discussions**: [GitHub Discussions](https://github.com/aimonk2025/cp-vibecoding-plugin/discussions)

## License

MIT

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

See issues for areas that need help.
