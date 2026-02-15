# YAML Frontmatter Complete Reference

This document provides comprehensive documentation for all YAML frontmatter fields in SKILL.md files.

## Minimal Required Format

The absolute minimum frontmatter for a valid skill:

```yaml
---
name: your-skill-name
description: What it does. Use when user asks to [specific phrases].
---
```

That's all you need to start. Everything else is optional.

## Required Fields

### `name` (required)

The skill's identifier. Must follow strict naming conventions.

**Format:** kebab-case (lowercase letters, digits, and hyphens only)

**Rules:**
- Lowercase letters (a-z)
- Digits (0-9)
- Hyphens (-) allowed
- NO spaces
- NO underscores
- NO capitals
- Cannot start or end with hyphen
- Cannot have consecutive hyphens
- Maximum 64 characters
- Should match folder name exactly

**Valid examples:**
```yaml
name: my-skill
name: data-analyzer
name: pdf-editor-2024
name: frontend-design
```

**Invalid examples:**
```yaml
name: My Skill          # ✗ Has spaces
name: MySkill           # ✗ Has capitals
name: my_skill          # ✗ Has underscores
name: -my-skill         # ✗ Starts with hyphen
name: my--skill         # ✗ Consecutive hyphens
name: claude-helper     # ✗ Reserved word "claude"
```

**Reserved words:**
- Cannot use "claude" in name (reserved)
- Cannot use "anthropic" in name (reserved)

### `description` (required)

The most critical field. Determines when Claude loads your skill.

**Purpose:** Provides triggering information for Claude to decide skill relevance

**Format:** Plain text, no markdown

**Structure:** Must include BOTH:
1. What the skill does (capabilities)
2. When to use it (trigger phrases)

**Requirements:**
- Maximum 1024 characters (hard limit)
- Target 200-400 characters (ideal range)
- No XML angle brackets (< or >)
- Valid YAML (escape quotes if needed)
- Must be clear to someone unfamiliar with skill

**Formula:**
```
[What it does] + [When to use it] + [Key capabilities]
```

**Example (good):**
```yaml
description: Analyzes Figma design files and generates developer handoff
documentation. Use when user uploads .fig files, asks for "design specs",
"component documentation", or "design-to-code handoff".
```

**Best practices:**
- Include 3-5 specific trigger phrases
- Mention file types if relevant (.docx, .pdf, .csv)
- Use user-facing language (not technical jargon)
- Include action words ("create", "analyze", "generate")
- Add domain-specific terms if applicable
- Specify when NOT to use (if needed to prevent overtriggering)

**See also:** references/description-best-practices.md for extensive examples

## Optional Fields

### `license` (optional)

Specifies the license for open-source skills.

**Purpose:** Legal terms for skill distribution and use

**Format:** String (license identifier or "Complete terms in [file]")

**Common values:**
- `MIT`
- `Apache-2.0`
- `GPL-3.0`
- `BSD-3-Clause`
- `Complete terms in LICENSE.txt` (reference to file)

**Examples:**
```yaml
license: MIT
```

```yaml
license: Complete terms in LICENSE.txt
```

**When to include:**
- When making skill open source
- When distributing publicly
- When license is required by your organization

**When to omit:**
- Internal/private skills
- Proprietary skills
- Default copyright assumed

### `allowed-tools` (optional)

Restricts which tools Claude can use when this skill is active.

**Purpose:** Security and safety - limit tool access for specialized skills

**Format:** Space-separated string of tool patterns

**Pattern syntax:**
- `ToolName` - Allow specific tool
- `ToolName(pattern:*)` - Allow tool with pattern matching
- Multiple tools: Space-separated list

**Examples:**

```yaml
# Allow only specific Bash commands
allowed-tools: "Bash(python:*) Bash(npm:*) WebFetch"
```

```yaml
# Allow only Read and Write (no Bash execution)
allowed-tools: "Read Write Edit"
```

```yaml
# Allow all tools (default if omitted)
# Just omit the field
```

**Common patterns:**
- `Bash(python:*)` - Python scripts only
- `Bash(npm:*)` - npm commands only
- `Bash(git:*)` - git commands only

**When to use:**
- Skills that should only execute specific safe commands
- Security-sensitive environments
- Skills with limited scope

**When to omit:**
- Most skills (default allows all tools)
- Skills that need flexibility
- Internal skills with trusted users

**Security note:** This is a safety feature, not a security boundary.

### `compatibility` (optional)

Indicates environment requirements or restrictions.

**Purpose:** Inform users about where/how skill can run

**Format:** String, 1-500 characters

**What to include:**
- Required product (Claude.ai, Claude Code, API)
- System packages needed
- Network access requirements
- Platform restrictions (Windows, Mac, Linux)
- MCP server dependencies

**Examples:**

```yaml
compatibility: Requires Claude Code. Uses Bash commands for git operations.
```

```yaml
compatibility: Requires Python 3.8+ and pdfplumber package. Works on all platforms.
```

```yaml
compatibility: Requires Linear MCP server connection. Claude.ai or Claude Code only.
```

```yaml
compatibility: API only. Requires Code Execution Tool beta enabled.
```

**When to include:**
- Skill has specific environment requirements
- Requires external dependencies
- Only works in certain products
- Needs MCP server connection

**When to omit:**
- Works everywhere without dependencies
- No special requirements
- Pure instruction-based skill

### `metadata` (optional)

Custom key-value pairs for additional information.

**Purpose:** Store arbitrary metadata about the skill

**Format:** YAML object (key-value pairs)

**Common fields (suggested, not required):**
- `author` - Creator or organization name
- `version` - Skill version number
- `mcp-server` - Associated MCP server name
- `category` - Skill category or type
- `tags` - List of keywords
- `documentation` - URL to documentation
- `support` - Support email or URL
- `updated` - Last update date

**Examples:**

```yaml
metadata:
  author: Acme Corp
  version: 1.2.0
  mcp-server: acme-crm
```

```yaml
metadata:
  author: John Doe
  version: 1.0.0
  category: document-processing
  tags:
    - pdf
    - forms
    - automation
  documentation: https://example.com/docs
  support: support@example.com
```

```yaml
metadata:
  author: Company Name
  version: 2.1.0
  mcp-server: projecthub
  updated: 2026-01-15
  license-url: https://example.com/license
```

**Validation:**
- All keys under `metadata` must be valid YAML identifiers
- Values can be strings, numbers, lists, or objects
- No reserved words for keys
- No size limit, but keep reasonable

**When to include:**
- Tracking versions
- Attribution
- Associating with MCP server
- Adding discovery metadata

**When to omit:**
- Simple personal skills
- No version tracking needed
- No MCP association

**Accessing metadata:**
- Users can see metadata in skill info
- Helpful for searching/filtering skills
- Version tracking for updates

## Complete Example with All Fields

```yaml
---
name: project-management-pro
description: Manages Linear project workflows including sprint planning, task
  creation, status tracking, and team coordination. Use when user mentions "sprint",
  "Linear tasks", "project planning", "backlog", or asks to "create tickets",
  "plan iteration", or "organize work".
license: MIT
allowed-tools: "Bash(python:*) WebFetch Read Write"
compatibility: Requires Linear MCP server connection and Python 3.8+.
metadata:
  author: Linear Inc
  version: 2.0.1
  mcp-server: linear
  category: project-management
  tags:
    - agile
    - sprint-planning
    - task-management
  documentation: https://linear.app/docs/skills
  support: skills@linear.app
  updated: 2026-02-01
---
```

## Security Restrictions

### Forbidden Content

**No XML angle brackets:**
```yaml
# ✗ INVALID
description: Use this skill to process <data> and generate <output>

# ✓ VALID
description: Use this skill to process data and generate output
```

**Why:** Frontmatter appears in Claude's system prompt. Angle brackets could be used for prompt injection.

**No reserved skill names:**
```yaml
# ✗ INVALID
name: claude-helper
name: anthropic-tool

# ✓ VALID
name: my-helper
name: custom-tool
```

**Why:** "claude" and "anthropic" are reserved to prevent impersonation.

### YAML Format Requirements

**Quote escaping:**
```yaml
# ✗ INVALID (unescaped quote)
description: This skill processes "special" data

# ✓ VALID (escaped or different quotes)
description: This skill processes \"special\" data
description: 'This skill processes "special" data'
```

**Multi-line strings:**
```yaml
# ✓ VALID (literal block)
description: |
  Manages complex workflows including
  task creation, sprint planning, and reporting.

# ✓ VALID (folded block)
description: >
  Manages complex workflows including
  task creation, sprint planning, and reporting.
```

**Delimiters required:**
```yaml
# ✗ INVALID (no delimiters)
name: my-skill
description: Does things

# ✓ VALID (with delimiters)
---
name: my-skill
description: Does things
---
```

## Validation

### Automated Validation

Run validation script to check frontmatter:

```bash
python scripts/quick_validate.py your-skill-folder/
```

**Checks performed:**
- YAML syntax valid
- Required fields present (name, description)
- Name follows kebab-case rules
- Description under 1024 characters
- No XML brackets in description
- No reserved words in name
- Allowed properties only

### Manual Validation Checklist

Before finalizing frontmatter:

- [ ] Frontmatter starts and ends with `---` on separate lines
- [ ] `name` field present and kebab-case
- [ ] `name` matches folder name exactly
- [ ] `description` field present
- [ ] `description` includes "what it does"
- [ ] `description` includes "when to use"
- [ ] `description` has 3-5 trigger phrases
- [ ] `description` under 1024 characters (ideally 200-400)
- [ ] No angle brackets (< >) anywhere
- [ ] No reserved words ("claude", "anthropic") in name
- [ ] All quotes properly closed
- [ ] Valid YAML (no syntax errors)
- [ ] Optional fields used correctly if included

## Common Mistakes

### Mistake 1: Missing delimiters

```yaml
# ✗ WRONG
name: my-skill
description: Does things
# First line of body

# ✓ CORRECT
---
name: my-skill
description: Does things
---

# First line of body
```

### Mistake 2: Wrong name format

```yaml
# ✗ WRONG
name: My Cool Skill

# ✓ CORRECT
name: my-cool-skill
```

### Mistake 3: Vague description

```yaml
# ✗ WRONG (too vague)
description: Helps with projects

# ✓ CORRECT (specific)
description: Manages Linear project workflows including sprint planning and task
  creation. Use when user mentions "sprint", "Linear tasks", or asks to "create
  tickets".
```

### Mistake 4: Description too long

```yaml
# ✗ WRONG (way over 1024 characters)
description: This is a very comprehensive skill that does many things including
  processing documents, analyzing data, generating reports, creating visualizations,
  managing workflows, coordinating teams, and much more... [900 more characters]

# ✓ CORRECT (concise)
description: Processes documents and generates analytical reports. Use when user
  uploads .pdf or .docx files, asks to "analyze document", or mentions "generate
  report".
```

### Mistake 5: Unknown fields

```yaml
# ✗ WRONG (invalid field)
---
name: my-skill
description: Does things
author: John Doe          # Wrong! Should be in metadata
version: 1.0.0            # Wrong! Should be in metadata
---

# ✓ CORRECT
---
name: my-skill
description: Does things
metadata:
  author: John Doe        # Correct location
  version: 1.0.0          # Correct location
---
```

## Field Priority for Triggering

Claude reads frontmatter fields in this priority for triggering:

1. **`description`** - Primary triggering mechanism (90% of decision)
2. **`name`** - Secondary signal (10% of decision)
3. Other fields - Not used for triggering (only for metadata)

**Implication:** Spend most effort on writing a great description.

## Updating Frontmatter

When updating an existing skill:

### Version Tracking

If using `metadata.version`, follow semantic versioning:

```yaml
metadata:
  version: 2.1.3
  # 2 = major version (breaking changes)
  # 1 = minor version (new features)
  # 3 = patch version (bug fixes)
```

**When to increment:**
- Patch (2.1.3 → 2.1.4): Bug fixes, small improvements
- Minor (2.1.3 → 2.2.0): New features, backward compatible
- Major (2.1.3 → 3.0.0): Breaking changes, incompatible updates

### Description Updates

Update description when:
- Skill adds new capabilities
- Trigger phrases found to be missing
- Undertriggering or overtriggering issues
- User feedback about confusion

**Best practice:** Keep old trigger phrases when adding new ones (for backward compatibility).

```yaml
# Before
description: Manages projects. Use when user mentions "project".

# After (adds triggers, keeps old one)
description: Manages projects including task creation and tracking. Use when user
  mentions "project", "tasks", "sprint planning", or asks to "create ticket".
```

## Examples by Skill Type

### Document Processing Skill

```yaml
---
name: pdf-form-filler
description: Fills PDF forms and generates completed documents. Use when user uploads
  .pdf forms, asks to "fill PDF", "complete form", or mentions "PDF form fields".
license: MIT
metadata:
  author: FormPro Inc
  version: 1.0.0
  category: document-processing
---
```

### MCP Integration Skill

```yaml
---
name: notion-workspace-setup
description: Automated Notion workspace setup including pages, databases, and
  permissions. Use when user asks to "set up Notion", "create Notion workspace",
  or mentions "new Notion project". Requires Notion MCP connection.
compatibility: Requires Notion MCP server connection. Works in Claude.ai or Claude Code.
metadata:
  author: Notion
  version: 2.1.0
  mcp-server: notion
  documentation: https://notion.com/skills/setup
---
```

### Workflow Automation Skill

```yaml
---
name: customer-onboarding
description: Complete customer onboarding workflow including account creation,
  payment setup, and welcome communication. Use when user asks to "onboard customer",
  "set up new account", or mentions "customer activation".
metadata:
  author: Acme Corp
  version: 1.5.2
  category: workflow-automation
  tags:
    - onboarding
    - customer-success
    - automation
---
```

## Summary

**Required fields (2):**
- `name` - Kebab-case identifier
- `description` - What + When + Capabilities

**Optional fields (4):**
- `license` - License information
- `allowed-tools` - Tool restrictions
- `compatibility` - Environment requirements
- `metadata` - Custom key-value pairs

**Most important:** Description field determines triggering. Invest time in writing a clear, comprehensive description with specific trigger phrases.

**Security:** No XML brackets, no reserved words, valid YAML only.

**Validation:** Run `quick_validate.py` before packaging.
