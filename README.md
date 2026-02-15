# Vibe Coding Plugin for Claude Code

Build software from vague idea to shipped product through 5 structured phases with **interactive conversation** and **complete state tracking**.

## What is This?

Vibe Coding is a Claude Code plugin that guides you through the entire software development lifecycle with a conversational, adaptive approach:

```
IDEA --> DOCS --> CODE --> FIX --> SHIP --> LIVE
```

**Key Innovation:** Unlike traditional requirement gathering that dumps 50 questions at once, Vibe Coding asks **ONE question at a time**, adapts based on your answers, and tracks everything in `progress.txt` so you can resume seamlessly across sessions.

## The 5 Phases

| Phase | Name | What Happens |
|-------|------|--------------|
| 1 | **IDEATE** | Interactive Q&A conversation covering 10 topics naturally (not a questionnaire!) |
| 2 | **DOCUMENT** | Generate 8 canonical docs (PRD, App Flow, Tech Stack, etc.) with approval workflow |
| 3 | **BUILD** | Implement features step-by-step with continuous progress tracking |
| 4 | **DEBUG** | Fix bugs surgically with investigation logs and lessons learned |
| 5 | **SHIP** | Pre-flight checks, deploy, and post-launch monitoring |

## Features

### 🎯 New: Interactive Conversation System
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

Install directly from GitHub:

```bash
/plugin install github:aimonk2025/cp-vibecoding-plugin
```

After installation, start using it by saying: "I want to build a task management app"

### Method 2: Local Development/Testing

For plugin development or local testing, use the `--plugin-dir` flag:

```bash
# Clone the repository
git clone https://github.com/aimonk2025/cp-vibecoding-plugin.git

# Run Claude Code with the plugin
claude --plugin-dir ./cp-vibecoding-plugin

# Start using it
# In Claude Code, just say: "I want to build a task management app"
```

### Full Installation Guide

See [GETTING_STARTED.md](GETTING_STARTED.md) for complete installation and usage instructions.

### Quick Reference

See [QUICKSTART.md](QUICKSTART.md) for commands, examples, and troubleshooting.

## What You'll Experience

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

- "I want to build..." / "Build me..."
- "New project" / "Start a project"
- "Vibe code this"
- "Continue" / "Resume" / "Where were we?"
- "Fix this bug" / "Debug this"
- "Ship it" / "Deploy"

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
│   │   ├── conversation-engine.md  # NEW: Adaptive questioning system
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
│   └── pipeline/               # NEW: Workflow management
│       ├── state-management.md
│       ├── workflow-state-machine.md
│       ├── hooks-design.md
│       └── progress-templates.md
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

| Document | Purpose |
|----------|---------|
| `PRD.md` | Product requirements with feature IDs and acceptance criteria |
| `APP_FLOW.md` | Every screen, route, and user journey |
| `TECH_STACK.md` | Technologies with exact versions and reasoning |
| `DESIGN_SYSTEM.md` | Colors, typography, spacing, components |
| `BACKEND_STRUCTURE.md` | Database schema, API contracts, auth logic |
| `FRONTEND_GUIDELINES.md` | Component architecture, patterns, conventions |
| `IMPLEMENTATION_PLAN.md` | Numbered phases and steps for the entire build |
| `CLAUDE.md` | Project-specific rules for Claude |

### During BUILD Phase
- Feature implementation tracking in `progress.txt`
- Files changed log
- Test results
- Lessons learned in `tasks/lessons.md`

## Requirements

- [Claude Code](https://code.claude.com) installed and authenticated
- Claude Code version 1.0.33 or later
- Any operating system (Windows, macOS, Linux)

## Documentation

- **[GETTING_STARTED.md](GETTING_STARTED.md)** - Installation and detailed usage guide
- **[QUICKSTART.md](QUICKSTART.md)** - Quick reference and examples
- **[IMPROVEMENTS.md](IMPROVEMENTS.md)** - What we fixed and why

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
