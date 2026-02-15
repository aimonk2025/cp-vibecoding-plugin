# Description Field Best Practices

The description field in your YAML frontmatter is the most critical part of your skill. It's how Claude decides whether to load your skill. Get this right, and your skill triggers at the right times. Get it wrong, and your skill will be ignored or overused.

## Why the Description Matters

From Anthropic's engineering blog: "This metadata provides just enough information for Claude to know when each skill should be used without loading all of it into context."

The description is the **first level of progressive disclosure**:
1. **Description** (always loaded) - Claude reads this to decide if skill is relevant
2. **SKILL.md body** (loaded when triggered) - Full instructions
3. **References/scripts** (loaded as needed) - Additional resources

If your description is vague, Claude won't know when to use your skill. If it's too broad, it'll trigger on irrelevant queries.

## Required Structure

Every effective description follows this formula:

```
[What it does] + [When to use it] + [Key capabilities]
```

**What it does:** Clear statement of the skill's purpose
**When to use it:** Specific trigger conditions - phrases users say, file types, tasks
**Key capabilities:** Main features or operations supported

## Character Limits

- Maximum: 1024 characters
- Target: 200-400 characters for clarity
- Under 1024 characters is required; aim for concise and comprehensive

## Security Restrictions

- No XML angle brackets (< or >)
- Cannot contain "claude" or "anthropic" in skill name
- Must be valid YAML (no unescaped quotes)

## Good Examples

These examples demonstrate effective descriptions:

### Example 1: Figma Design Handoff

```yaml
description: Analyzes Figma design files and generates developer handoff
documentation. Use when user uploads .fig files, asks for "design specs",
"component documentation", or "design-to-code handoff".
```

**Why this works:**
- ✅ Clear purpose: "analyzes Figma files and generates documentation"
- ✅ Specific triggers: .fig files, "design specs", "component documentation"
- ✅ File type mentioned: .fig files
- ✅ User-facing language: phrases users actually say

### Example 2: Linear Project Management

```yaml
description: Manages Linear project workflows including sprint planning,
task creation, and status tracking. Use when user mentions "sprint",
"Linear tasks", "project planning", or asks to "create tickets".
```

**Why this works:**
- ✅ Clear purpose: "manages Linear project workflows"
- ✅ Specific capabilities: sprint planning, task creation, status tracking
- ✅ Multiple trigger phrases: "sprint", "Linear tasks", "project planning"
- ✅ Action phrases: "create tickets"

### Example 3: PayFlow Customer Onboarding

```yaml
description: End-to-end customer onboarding workflow for PayFlow. Handles
account creation, payment setup, and subscription management. Use when user
says "onboard new customer", "set up subscription", or "create PayFlow account".
```

**Why this works:**
- ✅ Clear purpose: "end-to-end customer onboarding for PayFlow"
- ✅ Specific workflow steps: account creation, payment setup, subscription
- ✅ Service-specific: mentions "PayFlow" for context
- ✅ Action-oriented triggers: "onboard", "set up", "create"

### Example 4: DOCX Document Processing

```yaml
description: Comprehensive document creation, editing, and analysis with
support for tracked changes, comments, formatting preservation, and text
extraction. Use when Claude needs to work with professional documents (.docx
files) for: (1) Creating new documents, (2) Modifying or editing content,
(3) Working with tracked changes, (4) Adding comments, or any other document tasks.
```

**Why this works:**
- ✅ Comprehensive capability list: creation, editing, analysis, tracked changes
- ✅ File type explicit: .docx files
- ✅ Numbered use cases: makes triggers clear
- ✅ Catch-all included: "or any other document tasks"

### Example 5: Frontend Design System

```yaml
description: Create distinctive, production-grade frontend interfaces with
high design quality. Use this skill when the user asks to build web components,
pages, artifacts, posters, or applications (examples include websites, landing
pages, dashboards, React components, HTML/CSS layouts, or when styling/
beautifying any web UI).
```

**Why this works:**
- ✅ Quality statement: "distinctive, production-grade"
- ✅ Extensive examples: websites, landing pages, dashboards, React components
- ✅ Multiple phrasings: "build", "styling", "beautifying"
- ✅ Technology mentions: React, HTML/CSS

### Example 6: BigQuery Data Analysis

```yaml
description: Query and analyze data from BigQuery with knowledge of company
schemas, tables, and relationships. Use when user asks about metrics, asks to
"query BigQuery", mentions specific table names, or requests data analysis for
revenue, users, or product analytics.
```

**Why this works:**
- ✅ Domain-specific: mentions BigQuery and company schemas
- ✅ Trigger phrases: "query BigQuery", specific metrics
- ✅ Use case categories: revenue, users, product analytics
- ✅ Table name triggers: activates when specific tables mentioned

## Bad Examples

These examples show common mistakes:

### Bad Example 1: Too Vague

```yaml
# ❌ Bad
description: Helps with projects.
```

**Why this fails:**
- ❌ No specific capabilities
- ❌ No trigger phrases
- ❌ "Projects" is too generic
- ❌ Doesn't explain what "helps" means

**How to fix:**
```yaml
# ✅ Good
description: Manages Asana project workflows including task creation, sprint
planning, and team coordination. Use when user mentions "Asana", "project tasks",
"sprint planning", or asks to "create project" or "assign tasks".
```

### Bad Example 2: Missing Triggers

```yaml
# ❌ Bad
description: Creates sophisticated multi-page documentation systems.
```

**Why this fails:**
- ❌ No "when to use" guidance
- ❌ No file types mentioned
- ❌ No trigger phrases
- ❌ Too technical, not user-facing

**How to fix:**
```yaml
# ✅ Good
description: Creates multi-page documentation systems with navigation, search,
and formatting. Use when user asks to "create documentation", "build a docs site",
uploads markdown files, or mentions "technical writing" or "API docs".
```

### Bad Example 3: Too Technical

```yaml
# ❌ Bad
description: Implements the Project entity model with hierarchical
relationships.
```

**Why this fails:**
- ❌ Technical jargon: "entity model", "hierarchical relationships"
- ❌ No user-facing triggers
- ❌ Doesn't explain what users can do
- ❌ Implementation detail, not capability

**How to fix:**
```yaml
# ✅ Good
description: Organizes projects with parent-child relationships and nested
tasks. Use when user asks to "create project structure", "organize tasks
hierarchically", or mentions "sub-projects" or "task dependencies".
```

## Best Practices Checklist

Use this checklist when writing your description:

### Content Requirements
- [ ] Explains what the skill does clearly
- [ ] Includes specific "when to use" triggers
- [ ] Mentions file types if relevant (.docx, .pdf, .csv, etc.)
- [ ] Uses user-facing language, not technical jargon
- [ ] Includes phrases users would actually say
- [ ] Lists key capabilities or features

### Trigger Phrase Guidelines
- [ ] Includes at least 3-5 trigger phrases
- [ ] Covers different ways users might ask for the same thing
- [ ] Mentions action words ("create", "analyze", "generate", "build")
- [ ] Includes domain-specific terms if applicable
- [ ] Specifies when NOT to use (if needed to prevent overtriggering)

### Format Requirements
- [ ] Under 1024 characters (required)
- [ ] No XML angle brackets (< or >)
- [ ] Proper YAML formatting (quotes escaped if needed)
- [ ] No "claude" or "anthropic" in name field

### Quality Indicators
- [ ] A new user could understand when to use this skill
- [ ] Covers the main use cases without being exhaustive
- [ ] Specific enough to avoid overtriggering
- [ ] Broad enough to catch all relevant queries

## Common Patterns

### Pattern 1: File Type Skills

When your skill handles specific file types:

```yaml
description: [Action] [file type] files for [purpose]. Use when user uploads
[.extension] files, asks to "[action] [file type]", or mentions "[file-specific
task]".
```

Example:
```yaml
description: Edit and analyze PDF files including form filling, text extraction,
and page manipulation. Use when user uploads .pdf files, asks to "edit PDF",
"fill PDF form", or mentions "extract text from PDF".
```

### Pattern 2: Service Integration Skills

When your skill integrates with a specific service:

```yaml
description: [Action] [service name] [workflows/data] including [capability 1],
[capability 2], and [capability 3]. Use when user mentions "[service name]",
asks to "[common action]", or requests "[specific feature]".
```

Example:
```yaml
description: Manage Notion workspaces including page creation, database queries,
and content organization. Use when user mentions "Notion", asks to "create Notion
page", "query Notion database", or "organize Notion content".
```

### Pattern 3: Domain-Specific Skills

When your skill provides domain expertise:

```yaml
description: [Domain] [capability] with knowledge of [specific expertise]. Use
when user asks about [domain topic], mentions "[technical terms]", or requests
[domain-specific task].
```

Example:
```yaml
description: Financial compliance checking with knowledge of sanctions lists,
jurisdiction rules, and risk assessment. Use when user asks about "payment
compliance", mentions "sanctions check", or requests "transaction risk analysis".
```

### Pattern 4: Workflow Automation Skills

When your skill automates multi-step processes:

```yaml
description: [Workflow name] automation including [step 1], [step 2], and
[step 3]. Use when user asks to "[start workflow]", mentions "[workflow name]",
or requests "[workflow outcome]".
```

Example:
```yaml
description: Customer onboarding automation including account creation, payment
setup, and welcome email. Use when user asks to "onboard customer", "set up new
account", or mentions "customer activation".
```

## Trigger Phrase Guidelines

### Include These Types of Phrases:

1. **Action verbs:** "create", "analyze", "generate", "build", "process", "convert"
2. **File types:** ".docx", ".pdf", ".csv", "spreadsheet", "document"
3. **Service names:** "Linear", "Notion", "GitHub", "Figma"
4. **Domain terms:** "sprint planning", "design handoff", "contract review"
5. **User goals:** "onboard customer", "analyze data", "create report"

### Test Your Triggers:

Ask yourself: "Would someone actually say this?"

✅ Good: "create a landing page"
❌ Bad: "instantiate frontend artifact"

✅ Good: "analyze my CSV file"
❌ Bad: "perform tabular data ingestion and analysis"

## Negative Triggers (When Needed)

Sometimes you need to explicitly state when NOT to use your skill to prevent overtriggering:

```yaml
description: Advanced statistical analysis for CSV files including regression,
clustering, and hypothesis testing. Use for complex data science tasks. Do NOT
use for simple data exploration (use data-viz skill instead) or basic spreadsheet
operations (use xlsx skill instead).
```

**When to add negative triggers:**
- You have multiple related skills that might conflict
- Your skill is specialized but has a generic-sounding name
- Testing shows overtriggering on simple tasks

## Description Writing Process

1. **Draft initial version:** Start with the formula [What] + [When] + [Capabilities]
2. **List trigger phrases:** Write down 10+ phrases users might say
3. **Include top 5 triggers:** Add the most common/important phrases to description
4. **Add file types:** If applicable, mention specific file extensions
5. **Test for clarity:** Read it aloud - would a new user understand?
6. **Check length:** Ensure under 1024 characters
7. **Validate format:** No XML brackets, valid YAML
8. **Test triggering:** Try the skill with various queries to verify triggering

## Testing Your Description

After writing your description, test it:

### Triggering Tests

Ask Claude these questions WITH your skill enabled:

1. Rephrase your main use case 5 different ways - does it trigger?
2. Use trigger phrases from your description - does it trigger?
3. Ask about unrelated topics - does it NOT trigger?

### Clarity Test

Show your description to someone unfamiliar with the skill:

- Can they explain what it does?
- Can they give 3 examples of when to use it?
- Do they understand what tasks it handles?

### Iteration

If undertriggering: Add more trigger phrases, be more inclusive
If overtriggering: Add negative triggers, be more specific
If unclear: Simplify language, add concrete examples

## Examples by Skill Category

### Category 1: Document & Asset Creation

```yaml
description: Generate high-quality PowerPoint presentations with professional
design, consistent branding, and effective layouts. Use when user asks to
"create presentation", "make slides", uploads .pptx files, or mentions "pitch
deck", "slide deck", or "PowerPoint".
```

### Category 2: Workflow Automation

```yaml
description: Sprint planning workflow for Jira including backlog refinement,
story pointing, and sprint creation. Use when user mentions "sprint planning",
"plan sprint", "Jira sprint", or asks to "create sprint" or "organize backlog".
```

### Category 3: MCP Enhancement

```yaml
description: GitHub code review automation using Sentry error data. Analyzes
pull requests, identifies bugs from Sentry, and suggests fixes. Use when user
mentions "review PR", "Sentry errors", or asks to "analyze pull request" or
"fix bugs from Sentry".
```

## Final Checklist

Before finalizing your description, verify:

- [ ] I can explain what this skill does in one sentence
- [ ] I've included 3-5 specific trigger phrases users would say
- [ ] File types are mentioned if relevant
- [ ] The description is under 1024 characters
- [ ] No XML brackets or YAML formatting errors
- [ ] A new user would understand when to use this skill
- [ ] The description focuses on user benefits, not technical implementation
- [ ] I've tested triggering with at least 5 different phrasings

## Common Mistakes to Avoid

1. **Too generic:** "Helps with documents" → Be specific about what you do with documents
2. **No triggers:** Listing capabilities without "Use when..." → Always include trigger guidance
3. **Too technical:** "Implements CRUD operations" → Use user-facing language
4. **Missing file types:** Not mentioning .docx, .pdf, etc. → Include extensions for clarity
5. **Too long:** Over 1024 characters → Keep it concise
6. **Buried triggers:** Putting "when to use" at the end → Lead with it
7. **Vague actions:** "Processes files" → Specify what processing means
8. **No examples:** Abstract description only → Include concrete trigger phrases
