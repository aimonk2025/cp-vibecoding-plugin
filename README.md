# Vibe Coding Skills for Claude

Build software from idea to shipped product through 7 specialized skills with **interactive conversation** and **complete state tracking**.

## What is This?

Vibe Coding is a collection of Claude skills that guide you through the entire software development lifecycle:

```
IDEA → DOCS → CODE → FIX → SHIP → LIVE
        ↑
   REVERSE-ENGINEER
   (from existing code)
```

**Key Features:**
- **7 Composable Skills** - Each phase is independent, works standalone or together
- **Natural Language** - No commands needed, just describe what you want
- **Context Handoff** - Seamless transitions between skills via progress.txt
- **Flexible Entry** - Start from scratch, PRD, or existing codebase
- **Complete Tracking** - Everything saved in progress.txt for perfect session recovery

## The 7 Skills

| Skill | Purpose | Natural Language Triggers |
|-------|---------|--------------------------|
| **vibe-coding-orchestrator** | Entry point, routing, status | "build me an app", "continue", "show status" |
| **vibe-coding-reverse-engineer** | Analyze existing code → docs | "generate docs from my code", "document this app" |
| **vibe-coding-ideate** | Requirements gathering | "let's ideate", "plan features", "I have an idea" |
| **vibe-coding-document** | Generate 8 canonical docs | "generate docs", "create PRD" |
| **vibe-coding-build** | Implementation | "let's build", "start coding" |
| **vibe-coding-debug** | Bug fixing | "it's broken", "fix this bug" |
| **vibe-coding-ship** | Deployment | "deploy", "ship it", "launch" |

## Quick Start

### Install Skills

```bash
# Clone the repository
git clone https://github.com/aimonk2025/cp-vibe-coding.git
cd cp-vibe-coding

# Copy skills to Claude skills directory
cp -r skills/* ~/.claude/skills/

# Or on Windows
xcopy /E /I skills\* %USERPROFILE%\.claude\skills\
```

### Use Skills

**New Project:**
```
You: I want to build a habit tracking app

Claude: [vibe-coding-orchestrator activates → routes to vibe-coding-ideate]
What's the one-sentence description of what you want to build?
```

**Existing Codebase:**
```
You: Generate docs from my Next.js app

Claude: [Auto-detects codebase → vibe-coding-reverse-engineer activates]
I detected a Next.js project with 487 files...
```

**Resume Session:**
```
You: continue

Claude: [Reads progress.txt → activates appropriate skill]
Resuming DOCUMENT phase. Next: TECH_STACK.md...
```

## How It Works

### Context Handoff (Hybrid Approach)

**1. progress.txt (Shared State)**
```
VIBE CODING PROGRESS
====================
CURRENT STATE:
phase: DOCUMENT
step: generating_tech_stack
next_action: Generate TECH_STACK.md
active_skill: vibe-coding-document

---
PHASE: IDEATE
---
STATUS: complete
[full conversation transcript...]

---
PHASE: DOCUMENT
---
STATUS: in_progress
docs_completed: 2/8
[document details...]
```

**2. Orchestrator (Workflow Control)**
- Detects entry points
- Auto-detects existing codebases
- Validates phase transitions
- Routes to appropriate skills

**3. Skill References (Knowledge Base)**
- Each skill has its own `references/` folder with domain-specific knowledge
- Progressive disclosure - loaded only when needed
- Cross-skill references when features overlap

## Architecture

```
cp-vibe-coding/
├── skills/
│   ├── vibe-coding-orchestrator/    # Entry point & routing
│   │   ├── SKILL.md
│   │   └── references/
│   │       └── pipeline/            # Workflow orchestration
│   │
│   ├── vibe-coding-ideate/          # Requirements gathering
│   │   ├── SKILL.md
│   │   └── references/              # Interrogation engine
│   │
│   ├── vibe-coding-document/        # Doc generation
│   │   ├── SKILL.md
│   │   └── references/              # Doc templates & generators
│   │
│   ├── vibe-coding-build/           # Implementation
│   │   ├── SKILL.md
│   │   └── references/              # Engineering standards
│   │
│   ├── vibe-coding-debug/           # Bug fixing
│   │   ├── SKILL.md
│   │   └── references/              # Debug protocols
│   │
│   ├── vibe-coding-ship/            # Deployment
│   │   ├── SKILL.md
│   │   └── references/              # Deployment checklists
│   │
│   └── vibe-coding-reverse-engineer/ # Codebase analysis
│       ├── SKILL.md
│       └── references/              # Code detectors & analyzers
│
└── README.md                         # This file
```

## What Gets Generated

### 8 Canonical Documents

Generated whether you start from scratch OR reverse-engineer existing code:

1. **PRD.md** - Product Requirements Document
2. **APP_FLOW.md** - User Journeys and Screen Flows
3. **TECH_STACK.md** - Technologies and Versions
4. **DESIGN_SYSTEM.md** - Colors, Typography, Components
5. **BACKEND_STRUCTURE.md** - Database Schema and API Endpoints
6. **FRONTEND_GUIDELINES.md** - Component Patterns
7. **IMPLEMENTATION_PLAN.md** - Step-by-Step Build Roadmap
8. **CLAUDE.md** - Project-Specific AI Assistant Rules

### State Tracking

**progress.txt** - Single source of truth:
- Full conversation transcript with timestamps
- Phase status and transitions
- Files changed log
- Lessons learned

## Entry Points

Start from anywhere based on what you have:

| You Have | Entry Point | Time |
|----------|-------------|------|
| **Just an idea** | vibe-coding-ideate (full) | ~30-45 min |
| **Existing codebase** | vibe-coding-reverse-engineer | ~20-30 min |
| **Existing PRD** | vibe-coding-document (import) | ~15-25 min |
| **Want fast mode** | vibe-coding-ideate (fast-track) | ~10-15 min |

## Supported Frameworks

**Reverse-Engineering Auto-Detection:**

- **Frontend:** Next.js, React, Vue, Nuxt, Svelte, SvelteKit
- **Backend:** Express, NestJS, Django, FastAPI, Rails, Laravel
- **Databases:** Prisma, TypeORM, Mongoose, Sequelize, Django ORM, ActiveRecord

## Installation Options

### Option 1: Local Installation (Recommended)

```bash
# Clone repository
git clone https://github.com/aimonk2025/cp-vibe-coding.git
cd cp-vibe-coding

# Copy all skills
cp -r skills/* ~/.claude/skills/
```

### Option 2: Individual Skills

Install only the skills you need:

```bash
# Just the orchestrator and ideate
cp -r skills/vibe-coding-orchestrator ~/.claude/skills/
cp -r skills/vibe-coding-ideate ~/.claude/skills/
```

### Option 3: Claude.ai Upload

1. Zip each skill folder individually
2. Upload via Settings > Capabilities > Skills
3. Enable the skills you want to use

### Option 4: Organization Deployment

Admins can deploy workspace-wide for automatic updates.

## Requirements

- **Claude.ai** account OR **Claude Code** v1.0.33+
- Any OS (Windows, macOS, Linux)
- For reverse-engineering: Dependency file in project (package.json, requirements.txt, etc.)

## Troubleshooting

### Skills Not Activating

1. **Verify installation:**
   ```bash
   ls ~/.claude/skills/vibe-coding-orchestrator
   ```

2. **Try explicit phrases:**
   - "build me an app"
   - "let's ideate"
   - "generate docs from my code"

3. **Check Claude.ai:** Settings > Capabilities > Skills

### Context Not Transferring

1. Check `progress.txt` exists in project directory
2. Verify `CURRENT STATE` section has correct `active_skill`
3. Say: "continue where we left off"

### Auto-Detection Not Working

Requires:
- Dependency file (package.json, requirements.txt, etc.)
- At least 10 code files
- Skills activated in project directory

## Examples

### Example 1: New App from Scratch

```
You: Build me a task management app

Claude: [orchestrator → ideate]
What's the one-sentence description?

You: An app for teams to track tasks with Kanban boards

Claude: What problem do existing tools have?

[30 min conversation → 8 docs generated → ready to build]
```

### Example 2: Document Existing Code

```
You: Document this Next.js project

Claude: [orchestrator detects code → reverse-engineer]

Detected: Next.js 14, TypeScript, 487 files
- Framework: Next.js (App Router)
- Database: PostgreSQL (Prisma)
- Auth: NextAuth.js

Shall I reverse-engineer and generate docs?

[Analysis → tech docs → business Q&A → 8 complete docs]
```

### Example 3: Resume After Interruption

```
You: continue

Claude: [orchestrator reads progress.txt → document]

Resuming DOCUMENT phase.
Completed: PRD.md, APP_FLOW.md
Next: Generating TECH_STACK.md...
```

## Contributing

Contributions welcome!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with all 7 skills
5. Submit a pull request

See [issues](https://github.com/aimonk2025/cp-vibe-coding/issues) for areas needing help.

## Support

- **Issues:** [GitHub Issues](https://github.com/aimonk2025/cp-vibe-coding/issues)
- **Discussions:** [GitHub Discussions](https://github.com/aimonk2025/cp-vibe-coding/discussions)

## License

MIT

## Credits

Built following [Agent Skills best practices](https://docs.anthropic.com/claude/docs/skills) and the Claude Agent SDK patterns.
