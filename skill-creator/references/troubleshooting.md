# Troubleshooting Guide for Skills

This guide covers common issues you'll encounter when building and deploying skills, with specific solutions for each problem.

## Upload and Installation Issues

### Error: "Could not find SKILL.md in uploaded folder"

**Cause:** File not named exactly SKILL.md (case-sensitive)

**Solution:**
1. Rename file to exactly `SKILL.md` (all capitals)
2. Verify with file explorer or `ls -la` command
3. Common mistakes:
   - `skill.md` (wrong case)
   - `SKILL.MD` (wrong extension case on some systems)
   - `Skill.md` (mixed case)
   - File in wrong location (must be at root of skill folder)

**Verification:**
```bash
# On command line
ls -la your-skill-folder/

# Should show:
# SKILL.md (not skill.md or Skill.md)
```

### Error: "Invalid frontmatter"

**Cause:** YAML formatting issue in frontmatter

**Common mistakes:**

```yaml
# WRONG - missing delimiters
name: my-skill
description: Does things

# WRONG - unclosed quotes
name: my-skill
description: "Does things

# WRONG - special characters not escaped
description: This skill uses <tools> to process data

# CORRECT
---
name: my-skill
description: Does things with proper formatting
---
```

**Solution:**
1. Ensure frontmatter starts and ends with `---` on separate lines
2. Close all quotes properly
3. Escape or remove special characters (< > must be removed)
4. Use YAML validator online to check syntax
5. Run validation script: `python scripts/quick_validate.py your-skill-folder/`

### Error: "Invalid skill name"

**Cause:** Name has spaces, capitals, or invalid characters

**Examples:**

```yaml
# WRONG - has spaces
name: My Cool Skill

# WRONG - has capitals
name: MyCoolSkill

# WRONG - has underscores
name: my_cool_skill

# WRONG - starts with hyphen
name: -my-skill

# WRONG - consecutive hyphens
name: my--cool--skill

# CORRECT
name: my-cool-skill
```

**Solution:**
- Use kebab-case only: lowercase letters, digits, hyphens
- No spaces, underscores, or capitals
- Can't start/end with hyphen
- Can't have consecutive hyphens
- Max 64 characters
- Should match folder name exactly

### Error: "Description too long"

**Cause:** Description exceeds 1024 character limit

**Solution:**
1. Count characters in description
2. Trim to essentials (aim for 200-400 characters)
3. Remove verbose explanations
4. Focus on "what" and "when to use"
5. Move detailed info to SKILL.md body

**Before (too long):**
```yaml
description: This is a comprehensive skill that helps users create
amazing documentation with lots of features including table of contents
generation, automated formatting, style checking, spell checking, grammar
checking, and much more. It can handle multiple file formats and provides
extensive customization options for every aspect of document creation.
[... 800 more characters ...]
```

**After (concise):**
```yaml
description: Creates professional documentation with automated formatting,
TOC generation, and style checking. Use when user asks to "create docs",
"generate documentation", uploads .md files, or mentions "technical writing".
```

## Triggering Issues

### Problem: Skill doesn't trigger when it should (Undertriggering)

**Symptoms:**
- Skill doesn't load for relevant queries
- Users need to manually enable it
- Support questions: "When do I use this skill?"

**Diagnosis:**

Test trigger phrases:
```
1. Try exact phrase from description - does it trigger?
2. Try paraphrased version - does it trigger?
3. Try related but different wording - does it trigger?
```

If 2/3 don't trigger, you have undertriggering.

**Solutions:**

**1. Add more trigger phrases to description**

```yaml
# Before (undertriggers)
description: Helps with project management

# After (improved)
description: Manages Linear project workflows including sprint planning,
task creation, and status tracking. Use when user mentions "sprint",
"Linear tasks", "project planning", "backlog", "create tickets", or asks
to "plan iteration" or "organize work".
```

**2. Include file types if relevant**

```yaml
# Before (undertriggers)
description: Processes spreadsheet data

# After (improved)
description: Processes and analyzes spreadsheet data including formulas,
formatting, and pivot tables. Use when user uploads .xlsx, .csv, or .tsv
files, asks to "analyze spreadsheet", or mentions "Excel data" or "CSV file".
```

**3. Add technical terms users might say**

```yaml
# Before (undertriggers for technical users)
description: Manages cloud deployments

# After (improved)
description: Manages AWS cloud deployments including EC2, S3, Lambda, and
RDS. Use when user mentions "AWS deployment", "cloud infrastructure",
"EC2 instances", "Lambda functions", or asks to "deploy to cloud".
```

**4. Include domain-specific vocabulary**

```yaml
# Before (undertriggers for domain experts)
description: Handles financial workflows

# After (improved)
description: Handles financial compliance including sanctions screening,
KYC verification, and risk assessment. Use when user mentions "OFAC check",
"sanctions screening", "KYC", "AML compliance", or asks to "verify transaction".
```

### Problem: Skill triggers too often (Overtriggering)

**Symptoms:**
- Skill loads for irrelevant queries
- Users disable the skill
- Confusion about skill's purpose
- Skill conflicts with other skills

**Solutions:**

**1. Add negative triggers**

```yaml
description: Advanced data analysis for CSV files including regression,
clustering, and hypothesis testing. Use for complex statistical modeling.
Do NOT use for simple data exploration (use data-viz skill instead) or
basic spreadsheet operations (use xlsx skill instead).
```

**2. Be more specific about scope**

```yaml
# Too broad (overtriggers)
description: Processes documents

# More specific (better targeting)
description: Processes PDF legal documents for contract review including
clause extraction, risk assessment, and compliance checking. Use when user
uploads .pdf contracts, asks to "review contract", or mentions "legal document
analysis".
```

**3. Clarify the domain**

```yaml
# Too generic (overtriggers)
description: PayFlow integration

# Domain-specific (better targeting)
description: PayFlow payment processing for e-commerce transactions. Use
specifically for online payment workflows, not for general financial queries,
accounting, or reporting (use finance-reporting skill instead).
```

**4. Specify when NOT to use**

```yaml
description: Enterprise SQL query builder for PostgreSQL databases. Use
for complex multi-table joins, aggregations, and window functions. Do NOT
use for simple SELECT queries or database schema questions.
```

### Problem: Skill triggers inconsistently

**Symptoms:**
- Sometimes triggers, sometimes doesn't
- Works for some phrasings but not others
- Unpredictable behavior

**Diagnosis:**

Create test suite:
```
Test 1: "create a new project" - triggers? YES/NO
Test 2: "set up new project" - triggers? YES/NO
Test 3: "initialize project" - triggers? YES/NO
Test 4: "start new project" - triggers? YES/NO
Test 5: "make a project" - triggers? YES/NO
```

If results are inconsistent (some YES, some NO), you need more coverage.

**Solution:**

Include ALL common variations in description:

```yaml
description: Creates new project workspaces in ProjectHub. Use when user
asks to "create project", "set up project", "initialize project", "start
project", "make project", "new project workspace", or mentions "ProjectHub
setup".
```

## Execution and Behavior Issues

### Problem: Instructions not followed consistently

**Symptoms:**
- Claude doesn't follow skill instructions
- Inconsistent results across runs
- Steps skipped or done in wrong order

**Diagnosis:**

Which type of inconsistency?
1. Instructions ignored completely → Too verbose or buried
2. Instructions followed sometimes → Ambiguous language
3. Steps skipped → Not marked as critical
4. Wrong order → Dependencies unclear

**Solutions by cause:**

**1. Instructions too verbose**

```markdown
# Before (too verbose - instructions ignored)
## Processing Workflow

This section describes the comprehensive workflow for processing documents.
The workflow is designed to ensure high quality outputs by following a
systematic approach that has been developed through extensive testing and
refinement. The process involves multiple stages, each with specific
objectives and validation criteria.

First, we begin by analyzing the input document to understand its structure...
[5 more paragraphs of explanation]

# After (concise - instructions followed)
## Processing Workflow

1. Analyze document structure (run analyze.py)
2. Extract key sections (run extract.py)
3. Validate completeness (run validate.py)
4. Generate output (run generate.py)
```

**2. Critical instructions buried**

```markdown
# Before (buried - instruction missed)
## Workflow Overview

[3 paragraphs of context]

After processing, make sure to validate the output using the validation script.

[5 more paragraphs]

# After (prominent - instruction followed)
## CRITICAL: Validation Required

Before finalizing ANY output:
1. Run validation script: scripts/validate.py
2. Check all validation errors
3. Fix any issues found
4. Re-run validation until clean

## Workflow Overview
[rest of content]
```

**3. Ambiguous language**

```markdown
# Before (ambiguous - inconsistent behavior)
Make sure to validate things properly before proceeding.

# After (specific - consistent behavior)
CRITICAL: Before calling create_project, verify:
- Project name is non-empty string
- At least one team member assigned
- Start date is not in the past
- Budget is positive number

Run: python scripts/validate_project.py
```

**4. Model "laziness" or skipping steps**

Add explicit encouragement:

```markdown
## Performance Notes

- Take your time to complete this thoroughly
- Quality is more important than speed
- Do NOT skip any validation steps
- Complete all steps even if they seem redundant
```

**Note:** Adding this to user prompts is often more effective than in SKILL.md.

### Problem: Scripts not executing or failing

**Symptoms:**
- Script errors during execution
- "Script not found" errors
- Permission denied errors

**Solutions:**

**1. Verify script path in SKILL.md**

```markdown
# WRONG - relative path from wrong location
Run: validate.py

# CORRECT - path from skill root
Run: scripts/validate.py

# ALSO CORRECT - with python explicit
Run: python scripts/validate.py
```

**2. Check script permissions**

```bash
# Make script executable
chmod +x scripts/validate.py

# Verify
ls -la scripts/
# Should show: -rwxr-xr-x for executable scripts
```

**3. Test scripts independently**

Before using in skill, test each script:

```bash
cd your-skill-folder
python scripts/validate.py --test

# Should run without errors
```

**4. Add error handling in SKILL.md**

```markdown
## Running Validation

Run validation script:
```bash
python scripts/validate.py --input data.csv
```

If script fails:
- Check Python version (requires Python 3.8+)
- Install dependencies: pip install -r requirements.txt
- Verify input file exists and is readable
```

## MCP Integration Issues

### Problem: Skill loads but MCP calls fail

**Symptoms:**
- Skill triggers correctly
- MCP tool calls fail
- Error messages about connection or authentication

**Diagnosis steps:**

**Step 1: Verify MCP server connection**

In Claude.ai:
1. Go to Settings > Extensions
2. Find your MCP server
3. Check status shows "Connected"
4. If not connected, reconnect

**Step 2: Test MCP independently**

Without skill enabled, ask Claude:
```
"Use [Service] MCP to list my projects"
```

If this fails:
- Issue is MCP server, not skill
- Fix MCP first, then test skill

If this works:
- Issue is how skill calls MCP
- Continue diagnosis

**Step 3: Check tool names**

```markdown
# In SKILL.md, check tool names match MCP exactly

# If MCP tool is: myservice.create_project
Call MCP tool: myservice.create_project  # ✓ Correct

# Common mistakes:
Call MCP tool: create_project  # ✗ Missing prefix
Call MCP tool: CreateProject   # ✗ Wrong case
Call MCP tool: myservice_create_project  # ✗ Wrong separator
```

**Step 4: Verify parameters**

```markdown
# Check MCP documentation for required parameters

# If MCP tool expects: create_project(name: str, owner: str)

# Correct:
Call: create_project
Parameters:
- name: "Project Name"
- owner: "user@example.com"

# Wrong:
Call: create_project
Parameters:
- projectName: "Project Name"  # ✗ Wrong parameter name
- owner: 12345                  # ✗ Wrong type (should be string)
```

**Solutions:**

**1. Update skill to match MCP tool names exactly**

Reference MCP server documentation for exact tool names and parameters.

**2. Add MCP connection validation**

```markdown
## Before Starting

Verify MCP connection:
1. Check Settings > Extensions > [Service Name]
2. Ensure status is "Connected"
3. If not connected, click "Reconnect"
4. Test with simple query: "Use [Service] to list items"
```

**3. Handle authentication errors**

```markdown
## If MCP authentication fails:

1. Check API key is valid
   - Go to [Service] dashboard
   - Verify API key not expired
   - Regenerate if needed

2. Update credentials in Claude
   - Settings > Extensions > [Service]
   - Click "Reconnect"
   - Enter new API key

3. Verify permissions
   - API key needs scopes: read, write, admin
   - Check service dashboard for permissions
```

**4. Add retry logic for rate limits**

```markdown
## Rate Limit Handling

[Service] MCP has rate limits: 3 requests/second

For bulk operations:
- Process items in batches of 3
- Add 1-second delay between batches
- If rate limit error, wait 5 seconds and retry
```

### Problem: Multi-MCP coordination fails

**Symptoms:**
- First MCP works, second fails
- Data not passing between MCPs
- Workflow incomplete

**Solutions:**

**1. Validate phase completion**

```markdown
## Phase 1: Export from Source (MCP 1)

1. Call MCP1: export_data
2. Verify export succeeded
3. CRITICAL: Confirm file_id returned before proceeding

## Phase 2: Import to Destination (MCP 2)

**Validation before starting:**
- Check file_id from Phase 1 exists
- Verify file is accessible
- If validation fails, stop and report error

1. Call MCP2: import_data
   Parameters:
   - file_id: [value from Phase 1]
```

**2. Store outputs explicitly**

```markdown
## Data Flow Between MCPs

Phase 1 Output: Store these values
- project_id (from ProjectHub MCP)
- folder_id (from Drive MCP)
- task_ids (list from Linear MCP)

Phase 2 Input: Use stored values
- Pass project_id to notification MCP
- Pass folder_id to asset upload
- Pass task_ids to status update
```

**3. Add rollback for failures**

```markdown
## Error Handling

If Phase 2 fails after Phase 1 completed:

1. Rollback Phase 1 changes:
   - Call MCP1: delete_project(project_id)
   - Clean up any created resources

2. Report error to user:
   - What failed: [specific error]
   - What was rolled back: [list of changes reverted]
   - How to retry: [instructions]
```

## Performance and Context Issues

### Problem: Skill seems slow or responses degraded

**Symptoms:**
- Long delays before responses
- Quality of responses drops
- Claude seems to lose track

**Causes:**
1. SKILL.md too large
2. Too many skills enabled simultaneously
3. All content loaded instead of progressive disclosure

**Solutions:**

**1. Optimize SKILL.md size**

Target: Keep SKILL.md under 5,000 words (rough target, not hard limit)

```markdown
# Instead of putting everything in SKILL.md:

# SKILL.md (concise - 500 words)
---
name: my-skill
description: ...
---

# Overview
Quick start guide here.

For detailed API reference: see references/api-reference.md
For workflow examples: see references/examples.md
For troubleshooting: see references/troubleshooting.md

# When SKILL.md gets large:

# Before (10,000 words in SKILL.md)
- All API documentation inline
- All examples inline
- All troubleshooting inline
→ Context bloat, slower performance

# After (500 words in SKILL.md + references)
- SKILL.md: Core workflow only
- references/api-docs.md: Detailed API reference
- references/examples.md: 20+ examples
- references/troubleshooting.md: All error scenarios
→ Lean context, Claude reads references as needed
```

**2. Use progressive disclosure**

```markdown
# In SKILL.md (always loaded):
For CSV processing: see references/csv-guide.md
For JSON processing: see references/json-guide.md
For XML processing: see references/xml-guide.md

# Claude only reads the relevant reference file when needed
```

**3. Reduce enabled skills**

If users have 50+ skills enabled:
- Performance can degrade
- Recommend selective enablement
- Group related skills into "packs"
- Disable skills not actively used

**4. Add grep patterns for large references**

```markdown
# For references/ files over 10,000 words

Add search guidance in SKILL.md:

## Finding Information in References

The API reference is large (15,000 words). Use grep to find what you need:

- Authentication: grep "auth" references/api-reference.md
- Rate limits: grep "rate limit" references/api-reference.md
- Error codes: grep "error" references/api-reference.md
```

## Debugging Workflow

When skill doesn't work as expected:

### Step 1: Isolate the issue

- [ ] Does skill trigger? (Test with exact description phrases)
- [ ] Do scripts run? (Test scripts independently)
- [ ] Do MCP calls work? (Test MCP without skill)
- [ ] Are instructions followed? (Check if skill loads but behavior wrong)

### Step 2: Check fundamentals

- [ ] SKILL.md exists and is named correctly
- [ ] YAML frontmatter is valid
- [ ] Description includes trigger phrases
- [ ] No XML brackets in description
- [ ] Skill name is kebab-case
- [ ] All referenced files exist

### Step 3: Test components individually

- [ ] Test each script in scripts/ folder
- [ ] Verify each MCP call separately
- [ ] Check each reference file is readable
- [ ] Validate each asset file exists

### Step 4: Review with validation script

```bash
python scripts/quick_validate.py your-skill-folder/
```

Fix any reported errors.

### Step 5: Iterate based on findings

- Undertriggering → Add more trigger phrases
- Overtriggering → Add negative triggers, be more specific
- Execution errors → Simplify instructions, add validation
- MCP failures → Check connection, tool names, parameters
- Performance issues → Move content to references, reduce size

## Getting Help

If you've tried these solutions and still have issues:

1. **Check skill-creator**:
   Use the skill-creator skill to review your skill:
   ```
   "Review my skill and identify potential issues"
   ```

2. **Simplify and test**:
   - Create minimal version with just core functionality
   - Test if minimal version works
   - Add features back one by one
   - Identify what breaks it

3. **Compare with examples**:
   - Look at example skills in public repository
   - Compare structure and approach
   - Identify differences

4. **Community support**:
   - Claude Developers Discord
   - anthropics/skills GitHub issues
   - Include: skill name, error message, steps to reproduce

## Checklist: Before Asking for Help

When reporting issues, include:

- [ ] Skill name and category
- [ ] Exact error message
- [ ] Steps to reproduce
- [ ] What you've tried already
- [ ] Validation script output
- [ ] YAML frontmatter (redact sensitive info)
- [ ] Triggering test results (what phrases work/don't work)
- [ ] MCP connection status (if applicable)
- [ ] Screenshots if relevant

This information helps others diagnose and solve your issue faster.
