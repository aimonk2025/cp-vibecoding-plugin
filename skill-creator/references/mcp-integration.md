# Skills for MCP Integration

If you already have a working MCP server, you've done the hard part. Skills are the knowledge layer on top - capturing the workflows and best practices you already know, so Claude can apply them consistently.

## The Kitchen Analogy

Think of it like a professional kitchen:

**MCP provides the professional kitchen:**
- Access to tools
- Fresh ingredients
- Professional equipment

**Skills provide the recipes:**
- Step-by-step instructions
- How to create something valuable
- When to use which tools

Together, they enable users to accomplish complex tasks without needing to figure out every step themselves.

## How They Work Together

| MCP (Connectivity) | Skills (Knowledge) |
|-------------------|-------------------|
| Connects Claude to your service (Notion, Asana, Linear, etc.) | Teaches Claude how to use your service effectively |
| Provides real-time data access and tool invocation | Captures workflows and best practices |
| **What Claude can do** | **How Claude should do it** |

## Why This Matters for Your MCP Users

### Without Skills

When users connect your MCP but don't have skills:

- ❌ Users connect your MCP but don't know what to do next
- ❌ Support tickets asking "how do I do X with your integration"
- ❌ Each conversation starts from scratch
- ❌ Inconsistent results because users prompt differently each time
- ❌ Users blame your connector when the real issue is workflow guidance
- ❌ Low activation rate - users connect but don't use it

### With Skills

When users have both your MCP and accompanying skills:

- ✅ Pre-built workflows activate automatically when needed
- ✅ Consistent, reliable tool usage
- ✅ Best practices embedded in every interaction
- ✅ Lower learning curve for your integration
- ✅ Higher user satisfaction and retention
- ✅ Reduced support burden

## Choosing Your Approach: Problem-First vs. Tool-First

Think of it like Home Depot. You might walk in with a problem ("I need to fix a kitchen cabinet") and an employee points you to the right tools. Or you might pick out a new drill and ask how to use it for your specific job.

Skills work the same way:

### Problem-First Approach

**Best for:** When users have a clear goal but don't know the technical steps

**Pattern:**
- User describes desired outcome
- Skill orchestrates the right MCP calls in the right sequence
- Users focus on what they want, skill handles how

**Example:** "I need to set up a project workspace"
- Skill handles: Create project → Add team members → Set up databases → Apply template

**When to use:**
- Complex multi-step workflows
- Multiple decision points
- Domain expertise required
- Onboarding workflows

### Tool-First Approach

**Best for:** When users know your tools but need guidance on best practices

**Pattern:**
- Users have MCP connected and understand basic capabilities
- Skill provides optimal workflows and expertise
- Users drive the interaction, skill provides guardrails

**Example:** "I have Notion MCP connected, help me organize my workspace"
- Skill provides: Best practices, templates, organizational patterns, common workflows

**When to use:**
- Power user features
- Optimization and best practices
- Advanced configurations
- Quality improvements

Most skills lean one direction. Knowing which framing fits your use case helps you design better workflows.

## MCP-Specific Skill Patterns

### Pattern 1: Single MCP Workflow Orchestration

**Use when:** Your skill guides users through workflows using one MCP server

**Example structure:**

```markdown
# Notion Workspace Setup

## Workflow Overview

1. Create workspace structure
2. Set up databases
3. Apply templates
4. Configure permissions

## Step 1: Create Workspace Structure

Call MCP tool: `create_page`
Parameters: workspace_name, parent_page_id

## Step 2: Set Up Databases

For each required database:
- Call MCP tool: `create_database`
- Apply schema from references/schemas.md
- Configure views

## Step 3: Apply Templates

Call MCP tool: `duplicate_template`
Templates: defined in assets/templates/

## Step 4: Configure Permissions

Call MCP tool: `set_permissions`
Apply team-specific access rules
```

**Key techniques:**
- Explicit step ordering
- Dependencies between steps
- Validation at each stage
- Rollback instructions for failures

### Pattern 2: Multi-MCP Coordination

**Use when:** Workflows span multiple services (most powerful pattern for integration)

**Example: Design-to-Development Handoff**

```markdown
# Design Handoff Workflow

## Overview

Coordinates Figma, Google Drive, Linear, and Slack to streamline design handoffs.

## Phase 1: Design Export (Figma MCP)

1. Export design assets from Figma
   - Call: `figma.export_assets`
   - Get: asset URLs and specifications
2. Generate design specifications
   - Call: `figma.get_component_details`
   - Document: spacing, colors, typography
3. Create asset manifest
   - List all exported files
   - Note component relationships

## Phase 2: Asset Storage (Drive MCP)

1. Create project folder in Drive
   - Call: `drive.create_folder`
   - Structure: Project > Design > Handoff
2. Upload all assets
   - Call: `drive.upload_file` for each asset
   - Maintain folder structure
3. Generate shareable links
   - Call: `drive.create_share_link`
   - Set permissions: view-only for engineers

## Phase 3: Task Creation (Linear MCP)

1. Create development tasks
   - Call: `linear.create_issue` for each component
   - Template: Component name, design specs, asset links
2. Attach asset links to tasks
   - Add Drive links to issue descriptions
   - Reference Figma design files
3. Assign to engineering team
   - Call: `linear.assign_issue`
   - Set: priority, sprint, labels

## Phase 4: Notification (Slack MCP)

1. Post handoff summary to #engineering
   - Call: `slack.post_message`
   - Include: project name, number of tasks, Drive link
2. Include asset links and task references
   - Link to Linear project
   - Link to Drive folder
   - Tag relevant team members
```

**Key techniques:**
- Clear phase separation
- Data passing between MCPs
- Validation before moving to next phase
- Centralized error handling
- Comprehensive outcome notification

**Benefits:**
- Eliminates manual coordination
- Ensures consistency across tools
- Reduces context switching
- Embeds best practices

### Pattern 3: Domain-Specific Intelligence

**Use when:** Your skill adds specialized knowledge beyond tool access

**Example: Financial Compliance**

```markdown
# Payment Processing with Compliance

## Before Processing (Compliance Check)

CRITICAL: Always run compliance checks before processing payments.

1. Fetch transaction details via MCP
   - Call: `payments.get_transaction`
   - Retrieve: amount, recipient, jurisdiction

2. Apply compliance rules:
   - Check sanctions lists
     - Call: `compliance.check_sanctions`
     - Verify against OFAC, EU, UN lists
   - Verify jurisdiction allowances
     - Call: `compliance.check_jurisdiction`
     - Confirm legal to process in recipient country
   - Assess risk level
     - Call: `risk.calculate_score`
     - Factors: amount, history, recipient type

3. Document compliance decision
   - Log all checks performed
   - Record risk score and decision
   - Save audit trail

## Processing

IF compliance passed:
  - Call payment processing MCP tool: `payments.process`
  - Apply appropriate fraud checks
    - Call: `fraud.screen_transaction`
  - Process transaction
    - Call: `payments.execute`
  - Generate confirmation
    - Call: `notifications.send_receipt`

ELSE:
  - Flag for review
    - Call: `compliance.flag_for_review`
    - Include: reason, risk factors, required actions
  - Create compliance case
    - Call: `compliance.create_case`
    - Assign to compliance team
  - Notify stakeholders
    - Call: `notifications.alert_compliance_team`

## Audit Trail

- Log all compliance checks
  - Timestamp, results, decision factors
- Record processing decisions
  - Approved/rejected, reasons, risk score
- Generate audit report
  - Call: `compliance.generate_audit_log`
  - Format: required for regulatory compliance
```

**Key techniques:**
- Domain expertise embedded in logic
- Compliance before action (never bypass)
- Comprehensive documentation
- Clear governance rules
- Audit trail generation

**Benefits:**
- Reduces compliance errors
- Embeds expert knowledge
- Consistent application of rules
- Regulatory requirement satisfaction

## Building MCP Skills: Step-by-Step

### Step 1: Identify Top Workflows

List the 3-5 most common tasks users perform with your MCP:

```
Example for Notion MCP:
1. Set up new workspace for team
2. Create project tracking database
3. Sync content from external source
4. Generate status reports
5. Archive completed projects
```

### Step 2: Document Current User Experience

For each workflow, document how users currently do it:

```
Workflow: Set up new workspace

Current experience (without skill):
1. User: "How do I set up a Notion workspace?"
2. Claude: "I can help. What structure do you need?"
3. User: "Just a standard project workspace"
4. Claude: "What pages should I create?"
5. User: "Create pages for tasks, documents, and meetings"
6. Claude: *creates pages one by one*
7. User: "Can you add a database for tasks?"
8. Claude: *creates database*
9. User: "Actually, can you use our standard template?"
10. Claude: "Which template?"
... and so on (15+ messages)
```

### Step 3: Design Ideal Experience with Skill

Design how it should work with a skill:

```
Workflow: Set up new workspace

Ideal experience (with skill):
1. User: "Set up a new Notion workspace for Q4 planning"
2. Skill: *automatically executes*
   - Creates workspace structure (3 main pages)
   - Sets up task database with standard schema
   - Applies company template
   - Configures permissions
   - Creates welcome page with navigation
3. Claude: "I've set up your Q4 planning workspace with:
   - Task database (20 fields configured)
   - Documents page with template
   - Meeting notes page
   - Team permissions applied
   Here's the link: [workspace URL]"
```

### Step 4: Map MCP Tools to Workflow Steps

For each step in ideal experience, identify which MCP tools to call:

```
Step: Create workspace structure
- MCP tool: create_page
- Parameters: parent_page_id, title, type
- Call 3 times for 3 main pages

Step: Set up task database
- MCP tool: create_database
- Parameters: schema (from references/schema.md)
- MCP tool: configure_database_views
- Parameters: view_type, filters, sorts

Step: Apply company template
- MCP tool: duplicate_template
- Parameters: template_id, destination_page_id

Step: Configure permissions
- MCP tool: set_page_permissions
- Parameters: page_id, user_groups, permission_level
```

### Step 5: Create the Skill

Structure your SKILL.md with the workflow:

```markdown
---
name: notion-workspace-setup
description: Automated Notion workspace setup including page structure,
databases, templates, and permissions. Use when user asks to "set up Notion
workspace", "create Notion project", or mentions "new Notion space".
---

# Notion Workspace Setup

## Quick Start

When user requests a new workspace, execute this workflow automatically.

## Workflow

[Document each step with MCP tool calls]
```

### Step 6: Add Domain Expertise

Include non-obvious knowledge users wouldn't know:

```markdown
## Best Practices

- Always create databases before pages that reference them
- Apply templates AFTER creating base structure (prevents conflicts)
- Set permissions last (ensures all content exists first)
- Use consistent naming: "Tasks DB" not "tasks" or "Task Database"

## Common Gotchas

- Notion API has rate limits: 3 requests per second
  - Add delays between bulk operations
- Template duplication copies permissions
  - Reset permissions after template application
- Databases need parent pages
  - Create parent page first, then database
```

## Testing MCP Skills

### Test 1: MCP Connection

Before testing skill, verify MCP works independently:

```
Ask Claude: "Use Notion MCP to list my workspaces"

If this fails:
- MCP server not connected
- Authentication issues
- API key problems

Fix MCP first, then test skill.
```

### Test 2: Tool Call Accuracy

Verify skill calls correct MCP tools:

```
Enable skill, test workflow, check:
- Are the right tools called?
- Are parameters correct?
- Is the sequence logical?
- Are there any failed calls?
```

### Test 3: Error Handling

Test what happens when MCP calls fail:

```
Scenarios to test:
- Network timeout
- Invalid parameters
- Rate limit hit
- Authentication expired
- Resource not found

Does skill:
- Detect the error?
- Provide helpful message?
- Suggest remediation?
- Avoid cascading failures?
```

## MCP Skill Troubleshooting

### Skill loads but MCP calls fail

**Checklist:**

1. Verify MCP server is connected
   - Claude.ai: Settings > Extensions > [Your Service]
   - Should show "Connected" status

2. Check authentication
   - API keys valid and not expired
   - Proper permissions/scopes granted
   - OAuth tokens refreshed

3. Test MCP independently
   - Ask Claude to call MCP directly (without skill)
   - Example: "Use [Service] MCP to fetch my projects"
   - If this fails, issue is MCP not skill

4. Verify tool names
   - Skill references correct MCP tool names
   - Check MCP server documentation
   - Tool names are case-sensitive

5. Check parameters
   - Parameter names match MCP tool expectations
   - Required parameters provided
   - Parameter types correct (string vs. int vs. object)

### Skill doesn't coordinate multiple MCPs

**Common issues:**

1. **Data not passing between MCPs**
   - Store outputs from MCP 1
   - Pass as inputs to MCP 2
   - Example: Store `file_id` from Drive, use in Linear

2. **Phase separation unclear**
   - Use clear headers for each MCP phase
   - Wait for phase completion before next
   - Validate phase output before continuing

3. **Error in one MCP breaks workflow**
   - Add validation after each MCP phase
   - Include rollback instructions
   - Provide alternative paths

## Distribution for MCP Builders

When you distribute your MCP, include the skill:

### In Your MCP Documentation

```markdown
# MyService MCP

## Installation

[MCP installation steps]

## Recommended Skill

For the best experience, install the MyService skill alongside this MCP.

**Why use both:**
- MCP provides data access
- Skill provides workflow automation
- Together: 10x better user experience

**Download skill:** [link to skill repository]

**Installation:**
1. Download skill folder
2. Upload to Claude.ai (Settings > Capabilities > Skills)
3. Test: "Set up a new project in MyService"
```

### GitHub Repository Structure

```
myservice-mcp/
├── README.md (MCP documentation)
├── server/ (MCP server code)
└── skills/ (Companion skills)
    └── myservice-setup/
        └── SKILL.md
```

### Positioning Together

**Example messaging:**

```
MyService MCP + Skill = Complete Integration

MCP alone:
- Access to your MyService data
- Manual workflow construction
- User guides Claude step-by-step

MCP + Skill:
- Automated workflows
- Best practices built-in
- One command to complete complex tasks

Example: "Set up new project" becomes a single command instead of 15 messages.
```

## Real-World Example: Sentry + GitHub Integration

From the official guide, here's how Sentry built their MCP skill:

```yaml
name: sentry-code-review
description: Automatically analyzes and fixes detected bugs in GitHub Pull
Requests using Sentry's error monitoring data via their MCP server.
```

**What it does:**
1. Fetches errors from Sentry MCP
2. Analyzes related code in GitHub MCP
3. Suggests fixes based on error patterns
4. Creates code review comments in GitHub MCP

**Value proposition:**
- Sentry MCP alone: Can query error data
- GitHub MCP alone: Can review PRs
- Skill + both MCPs: Automatically connects errors to code and suggests fixes

**Result:**
- Faster bug detection
- Automated code review
- Embedded Sentry expertise
- Higher MCP activation rate

## Best Practices for MCP Skills

1. **Start with one workflow:** Don't try to handle everything at once
2. **Test MCP first:** Ensure MCP works before building skill
3. **Document tool calls:** List all MCP tools your skill uses
4. **Handle errors gracefully:** MCP calls can fail, plan for it
5. **Version together:** Update skill when MCP tools change
6. **Provide examples:** Show concrete workflows in SKILL.md
7. **Embed expertise:** Include domain knowledge users wouldn't have
8. **Coordinate carefully:** For multi-MCP, validate between phases
9. **Test independently:** Test each MCP separately, then together
10. **Distribute together:** Recommend skill with MCP installation

## Summary

Skills make your MCP integration complete:

- **MCP provides:** Access to tools and data
- **Skills provide:** Workflows and best practices
- **Together:** They create a seamless, automated user experience

For MCP builders, skills are how you turn raw API access into valuable, repeatable workflows that users love.
