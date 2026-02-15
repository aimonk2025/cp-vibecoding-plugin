# Skills Integration

Claude Skills extend capabilities with specialized knowledge and tools. Use them as powerful subagents.

## What Are Skills?

Skills are modular packages that provide:
- Specialized workflows for specific domains
- Tool integrations (file formats, APIs)
- Domain expertise (schemas, business logic)
- Bundled resources (scripts, templates)

## When to Use Skills

### Use a Skill When:

- Task matches a skill's specialized domain
- Skill has scripts/tools that avoid rewriting code
- Domain knowledge is needed (formats, APIs, conventions)
- Repetitive pattern that skill handles efficiently

### Don't Use a Skill When:

- Task is simple enough to do directly
- Skill adds overhead without benefit
- You need custom behavior the skill doesn't support

## Invoking Skills

### Check Available Skills

Before implementing, check if a relevant skill exists:

```
SKILL CHECK:
Task: [what I need to do]
Relevant skills: [list any that might apply]
Decision: [use skill / implement manually] because [reason]
```

### Skill Invocation Pattern

```
INVOKING SKILL: [skill-name]
PURPOSE: [why this skill is appropriate]
INPUT: [what I'm passing to the skill]
EXPECTED OUTPUT: [what I need back]
```

## Common Skill Categories

### Document Processing
- **pdf** - PDF manipulation, form filling, text extraction
- **docx** - Word document creation/editing
- **xlsx** - Spreadsheet creation/analysis
- **pptx** - Presentation creation/editing

### Development
- **frontend-design** - UI components, styling
- **webapp-testing** - Playwright testing, screenshots
- **mcp-builder** - MCP server development

### Content Creation
- **canvas-design** - Visual art, posters
- **algorithmic-art** - Generative art with p5.js
- **slack-gif-creator** - Animated GIFs for Slack

## Skill Chaining

For complex tasks, chain multiple skills:

```
SKILL CHAIN:

1. [skill-a] → Extract data from PDF
   OUTPUT: structured JSON

2. [skill-b] → Process data
   INPUT: JSON from step 1
   OUTPUT: analysis results

3. [skill-c] → Generate report
   INPUT: analysis from step 2
   OUTPUT: formatted DOCX
```

## Project-Specific Skills

Define which skills are relevant for this project in `CLAUDE.md`:

```
PROJECT SKILLS:
- [skill-name]: [when to use in this project]
- [skill-name]: [when to use in this project]

SKILL OVERRIDES:
- For [task type], always use [skill] instead of manual implementation
- Never use [skill] for [reason]
```

## Skills vs. Subagents

| Aspect | Skills | Subagents |
|--------|--------|-----------|
| Scope | Specialized domain | Focused task |
| Persistence | Reusable across projects | Session-specific |
| Resources | Bundled scripts/templates | Context loading |
| Invocation | Explicit skill call | Spawn as needed |

**Rule of thumb**:
- Use **skills** for domain expertise + tooling
- Use **subagents** for task decomposition + parallel work

## Creating Project Skills

For truly recurring patterns, consider creating a project-specific skill:

```
SKILL CANDIDATE IDENTIFIED:
Pattern: [what keeps repeating]
Frequency: [how often]
Complexity: [why manual is painful]

RECOMMENDATION: Create skill for [pattern]?
```

See skill-creator documentation for building custom skills.

## Interactive Skill Selection

When uncertain which skill to use:

```
SKILL OPTIONS FOR [task]:

| Skill | Fit | Trade-off |
|-------|-----|-----------|
| [skill-a] | [how well it fits] | [limitation] |
| [skill-b] | [how well it fits] | [limitation] |
| Manual | [when appropriate] | [effort required] |

RECOMMENDATION: [choice] because [reason]
→ Confirm or redirect.
```
