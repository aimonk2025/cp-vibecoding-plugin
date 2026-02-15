# Workflow Patterns for Skills

This guide covers proven workflow patterns for building effective skills. Use these patterns as templates when designing your skill's workflow logic.

## Pattern 1: Sequential Workflow Orchestration

**Use when:** Your users need multi-step processes in a specific order.

**Best for:** Workflows with clear dependencies, where step N must complete before step N+1.

**Example structure:**

```markdown
# Workflow: Onboard New Customer

## Overview

This workflow handles complete customer onboarding from account creation through welcome communication.

## Step 1: Create Account

Call MCP tool: `create_customer`
Parameters:
- name: Customer name (string)
- email: Customer email (string)
- company: Company name (string)

Validation:
- Confirm customer_id returned
- Verify email is unique
- Check account created successfully

## Step 2: Setup Payment

**Prerequisites:**
- customer_id from Step 1 must exist
- Customer must have valid email

Call MCP tool: `setup_payment_method`
Parameters:
- customer_id: (from Step 1)
- payment_method: Credit card or ACH

Wait for: payment method verification
- May take 30-60 seconds
- Check verification_status field
- If failed, report error and stop

## Step 3: Create Subscription

**Prerequisites:**
- customer_id from Step 1
- verified payment_method from Step 2

Call MCP tool: `create_subscription`
Parameters:
- plan_id: Selected subscription plan
- customer_id: (from Step 1)
- payment_method_id: (from Step 2)

Validation:
- Confirm subscription_id returned
- Verify subscription status is "active"

## Step 4: Send Welcome Email

**Prerequisites:**
- All above steps completed successfully
- customer_id and subscription_id available

Call MCP tool: `send_email`
Parameters:
- customer_id: (from Step 1)
- template: welcome_email_template
- variables:
  - subscription_plan: (from Step 3)
  - billing_date: (from Step 3)

Final validation:
- Email sent successfully
- Customer account fully active
- Report completion to user with account details
```

**Key techniques:**
- Explicit step ordering (Step 1, Step 2, Step 3...)
- Clear prerequisites listed before each step
- Dependencies between steps documented
- Validation at each stage
- Rollback instructions for failures

**When this pattern works well:**
- Onboarding workflows
- Setup and configuration processes
- Data migration tasks
- Report generation pipelines

## Pattern 2: Multi-MCP Coordination

**Use when:** Workflows span multiple services and require data passing between them.

**Best for:** Integration tasks, cross-system automation, complex pipelines.

**Example: Design-to-Development Handoff**

```markdown
# Design Handoff Workflow

## Overview

Coordinates Figma, Google Drive, Linear, and Slack to automate design handoffs to engineering teams.

## Phase 1: Design Export (Figma MCP)

**Goal:** Extract design assets and specifications from Figma

1. Export design assets from Figma
   - Call: `figma.export_assets`
   - Parameters: file_id, component_ids
   - Output: List of asset URLs

2. Generate design specifications
   - Call: `figma.get_component_details`
   - Extract: spacing, colors, typography, dimensions
   - Document all specs in structured format

3. Create asset manifest
   - List all exported files with descriptions
   - Note component relationships and hierarchy
   - Prepare for storage phase

**Phase 1 Outputs (store these):**
- asset_urls: List of exported asset URLs
- design_specs: JSON with all component specifications
- component_manifest: Structured list of components

## Phase 2: Asset Storage (Drive MCP)

**Goal:** Store all design assets in organized Drive structure

**Prerequisites:**
- asset_urls from Phase 1
- design_specs from Phase 1

1. Create project folder in Drive
   - Call: `drive.create_folder`
   - Structure: Company > Projects > [Project Name] > Design > Handoff
   - Store: folder_id for next steps

2. Upload all assets
   - For each URL in asset_urls:
     - Download asset temporarily
     - Call: `drive.upload_file`
     - Parameters: file_content, folder_id, filename
   - Maintain folder structure matching Figma organization

3. Upload design specs document
   - Format design_specs as readable document
   - Call: `drive.upload_file`
   - Filename: "Design_Specifications.md"

4. Generate shareable links
   - Call: `drive.create_share_link` for folder
   - Set permissions: view-only for engineering team
   - Store: shared_folder_url

**Phase 2 Outputs (store these):**
- folder_id: Drive folder ID
- shared_folder_url: Public link to all assets
- uploaded_files: List of uploaded file IDs

## Phase 3: Task Creation (Linear MCP)

**Goal:** Create development tasks for each component

**Prerequisites:**
- design_specs from Phase 1
- shared_folder_url from Phase 2

1. Parse components from design_specs
   - Identify unique components to implement
   - Group related components
   - Estimate complexity for each

2. Create development tasks
   - For each component:
     - Call: `linear.create_issue`
     - Title: "Implement [Component Name]"
     - Description template:
       ```
       Component: [name]
       Design specs: [link to specific section]
       Assets: [shared_folder_url]

       Requirements:
       - [list from design_specs]

       Acceptance criteria:
       - Matches design specifications
       - Responsive behavior defined
       - Accessible (WCAG 2.1)
       ```
     - Labels: "design-handoff", "frontend"
     - Priority: from complexity analysis

3. Group tasks into project
   - Call: `linear.create_project`
   - Name: "[Project Name] - Design Implementation"
   - Add all created tasks to project

4. Assign to engineering team
   - Call: `linear.assign_issue` for each task
   - Distribute based on team capacity
   - Set sprint/cycle if applicable

**Phase 3 Outputs (store these):**
- task_ids: List of created Linear task IDs
- project_id: Linear project ID
- project_url: Link to Linear project

## Phase 4: Notification (Slack MCP)

**Goal:** Notify team that handoff is complete

**Prerequisites:**
- All previous phases completed
- project_url from Phase 3
- shared_folder_url from Phase 2

1. Compose handoff summary
   - Project name
   - Number of components
   - Number of tasks created
   - Links to assets and tasks

2. Post to #engineering channel
   - Call: `slack.post_message`
   - Channel: #engineering
   - Message template:
     ```
     :art: Design Handoff Complete: [Project Name]

     Ready for implementation:
     • Components: [count]
     • Tasks created: [count]
     • Linear project: [project_url]
     • Design assets: [shared_folder_url]

     cc @frontend-team
     ```

3. Send DM to engineering lead
   - Call: `slack.send_dm`
   - Recipient: Engineering lead
   - Include additional context, blockers, timeline

## Error Handling

**If Phase 1 fails:**
- Report Figma connection issue
- Verify file_id is correct
- Check Figma MCP authentication

**If Phase 2 fails:**
- Assets exported but not stored
- Retry Drive upload for failed files
- Don't re-export from Figma

**If Phase 3 fails:**
- Assets stored but tasks not created
- Can retry task creation without re-exporting
- Use stored design_specs and shared_folder_url

**If Phase 4 fails:**
- Everything complete but notification missed
- Manually notify team with stored URLs
- Workflow still successful
```

**Key techniques:**
- Clear phase separation (Phase 1, 2, 3, 4)
- Data passing between MCPs explicitly documented
- Store outputs from each phase for use in next phase
- Validation before moving to next phase
- Centralized error handling with retry logic
- Graceful degradation (later phases can fail without breaking earlier work)

**When this pattern works well:**
- Cross-system workflows
- Tool integration automation
- Multi-step publishing pipelines
- Coordinated team workflows

## Pattern 3: Iterative Refinement

**Use when:** Output quality improves through iteration and validation loops.

**Best for:** Content generation, report creation, quality-dependent workflows.

**Example: Report Generation**

```markdown
# Iterative Report Creation

## Overview

Generates high-quality reports through iterative refinement with quality checks at each step.

## Initial Draft

1. Fetch data via MCP
   - Call: `analytics.get_data`
   - Parameters: date_range, metrics, dimensions
   - Validate: data returned is complete

2. Generate first draft report
   - Analyze data for key insights
   - Create report sections:
     - Executive summary
     - Key findings (top 5)
     - Detailed metrics
     - Recommendations
   - Format: Use report template from assets/

3. Save to temporary file
   - Write draft to temp location
   - Preserve for comparison with iterations

## Quality Check Loop

Run validation script: `scripts/check_report.py`

The script checks for:
- Missing sections (executive summary, findings, recommendations required)
- Inconsistent formatting (headers, spacing, bullet points)
- Data validation errors (metrics sum correctly, percentages add to 100%)
- Completeness (all requested metrics included)
- Clarity (each finding has supporting data)

**Script output format:**
```json
{
  "issues": [
    {
      "severity": "error",
      "section": "Key Findings",
      "message": "Finding #3 lacks supporting data"
    },
    {
      "severity": "warning",
      "section": "Formatting",
      "message": "Inconsistent bullet point style"
    }
  ],
  "score": 75
}
```

## Refinement Loop

**For each issue identified:**

1. Analyze the issue
   - Understand what's wrong
   - Identify what data/content is missing
   - Determine fix approach

2. Make targeted fix
   - Address the specific issue
   - Don't rewrite entire report
   - Preserve working sections

3. Re-validate section
   - Run validation on fixed section only
   - Confirm issue resolved
   - Check no new issues introduced

**Iteration limit:** Maximum 3 refinement cycles
- After 3 iterations, present best version to user
- Note any remaining issues that couldn't be resolved

## Quality Threshold

**Target score: 90+**

Continue refinement loop until:
- Validation score ≥ 90, OR
- 3 iterations completed, OR
- No more fixable issues

**When to stop iterating:**
- All critical errors fixed (severity: "error")
- Score plateaus (no improvement in last iteration)
- Remaining issues are subjective or unfixable

## Finalization

1. Apply final formatting
   - Consistent typography
   - Proper heading hierarchy
   - Professional layout
   - Company branding

2. Generate summary
   - Report metadata (date, metrics covered, data sources)
   - Quality score from validation
   - Key highlights (top 3 findings)

3. Save final version
   - Store in designated location
   - Name: Report_[Date]_[Topic]_v[iteration].pdf
   - Provide download link to user

## Example Iteration

**Iteration 1:**
- Issues found: 5 (3 errors, 2 warnings)
- Score: 65
- Fixes applied: Added missing data, fixed formatting
- Time: 30 seconds

**Iteration 2:**
- Issues found: 2 (0 errors, 2 warnings)
- Score: 85
- Fixes applied: Improved clarity, consistent styling
- Time: 20 seconds

**Iteration 3:**
- Issues found: 0
- Score: 95
- Finalized and delivered
- Total time: 90 seconds
```

**Key techniques:**
- Explicit quality criteria
- Automated validation (script-based)
- Iterative improvement with clear loop
- Know when to stop iterating (threshold + max iterations)
- Track progress across iterations

**When this pattern works well:**
- Report generation
- Content creation (blog posts, documentation)
- Code generation with quality requirements
- Data cleaning and validation
- Any output with measurable quality criteria

## Pattern 4: Context-Aware Tool Selection

**Use when:** Same outcome can be achieved with different tools depending on context.

**Best for:** Flexible workflows, optimization decisions, resource allocation.

**Example: Intelligent File Storage**

```markdown
# Smart File Storage

## Decision Tree

For each file the user wants to store, determine the best storage location based on file characteristics.

## Analysis Phase

1. Analyze file characteristics
   - File size (get from file metadata)
   - File type (extension, MIME type)
   - Intended use (from user request or context)
   - Collaboration needs (single user vs. team)
   - Lifespan (temporary vs. permanent)

2. Determine optimal storage

**Storage Decision Logic:**

IF file size > 10MB:
  → Use cloud storage (S3, Drive, Dropbox)
  → Reason: Local/temp storage inefficient for large files

ELSE IF file type in [.md, .docx, .gdoc, .pdf] AND collaboration = true:
  → Use Notion or Google Docs
  → Reason: Built-in collaboration features

ELSE IF file type in [.py, .js, .ts, .java] OR project = "code":
  → Use GitHub repository
  → Reason: Version control essential for code

ELSE IF lifespan = "temporary" OR intended_use = "draft":
  → Use local storage or temp folder
  → Reason: Temporary files don't need permanent storage

ELSE IF project has existing storage location:
  → Use existing project location
  → Reason: Keep related files together

ELSE:
  → Use default cloud storage (Drive)
  → Reason: Safe default for general files

## Execution Phase

Based on decision from analysis:

### For Cloud Storage (S3/Drive):

```bash
1. Call appropriate MCP
   - Drive: drive.upload_file
   - S3: s3.put_object
   - Dropbox: dropbox.upload

2. Configure based on file characteristics
   - Large files: Use resumable upload
   - Shared files: Set permissions to "anyone with link"
   - Private files: Set permissions to owner only

3. Generate access method
   - Public files: Shareable link
   - Private files: Direct path only
   - Team files: Share with team group
```

### For Collaborative Docs (Notion/Docs):

```bash
1. Convert file if needed
   - Markdown → Notion page
   - Word doc → Google Doc
   - PDF → view-only Notion embed

2. Create in appropriate workspace
   - Call: notion.create_page OR docs.create
   - Set parent: Relevant project/folder
   - Set permissions: Team or specific users

3. Configure collaboration features
   - Enable comments
   - Set up sharing
   - Add to team workspace
```

### For Code Files (GitHub):

```bash
1. Determine repository
   - Check if project has existing repo
   - Create new repo if needed

2. Add to repository
   - Call: github.create_or_update_file
   - Path: Appropriate directory structure
   - Commit message: Descriptive message

3. Create PR if needed
   - If adding to existing project: Create PR
   - If new project: Commit to main
```

### For Temporary Files:

```bash
1. Use local temp storage
   - No API calls needed
   - Store in temp directory

2. Set expiration
   - Auto-delete after 24 hours
   - Or when user session ends

3. Provide immediate access
   - Return local file path
   - User can move if needed later
```

## Provide Context to User

Always explain the storage decision:

```
I've stored your file in [location] because [reason].

File: design_mockup.pdf
Location: Google Drive > Projects > Q4 Website
Reason: Large file (15MB) that needs team collaboration
Link: [shareable_link]
Access: Anyone in your organization can view
```

**Alternative considered:**
- Local storage: File too large
- GitHub: Not a code file
- Notion: PDF better suited for Drive

## Edge Cases

**Multiple valid options:**
- When 2+ options equally good, explain tradeoffs
- Ask user preference
- Remember preference for next time

**No clear best option:**
- Default to safest choice (Drive)
- Explain why it was ambiguous
- Suggest user specify preference

**User override:**
- If user specifies location, use it
- Even if not optimal by logic
- Explain why different choice might be better

## Learning from User Feedback

Track user overrides:
- If user frequently changes storage choice
- Update decision logic to match user preferences
- Note patterns for future decisions
```

**Key techniques:**
- Clear decision criteria (file size, type, collaboration needs)
- Explicit decision tree logic (IF/ELSE)
- Fallback options (default storage)
- Transparency about choices (explain to user)
- Context-aware optimization
- Learning from user feedback

**When this pattern works well:**
- Resource allocation decisions
- Tool selection from multiple options
- Optimization workflows
- Intelligent routing/dispatching
- Adaptive workflows

## Pattern 5: Domain-Specific Intelligence

**Use when:** Your skill embeds specialized knowledge that goes beyond simple tool access.

**Best for:** Regulated industries, compliance workflows, expert systems, quality assurance.

**Example: Financial Compliance for Payment Processing**

```markdown
# Payment Processing with Compliance Intelligence

## Critical Compliance Rules

This skill embeds financial compliance expertise. ALL rules must be followed without exception.

## Before Processing (Mandatory Compliance Checks)

**CRITICAL:** Never process a payment without completing ALL compliance checks.

### Step 1: Fetch Transaction Details

Call MCP: `payments.get_transaction`
Parameters:
- transaction_id: ID to process

Required data:
- Amount and currency
- Recipient information (name, location, entity type)
- Sender information
- Transaction purpose
- Payment method

### Step 2: Sanctions Screening (MANDATORY)

**Why this matters:** Processing payments to sanctioned entities is illegal and carries severe penalties.

Call MCP: `compliance.check_sanctions`
Parameters:
- recipient_name: Full legal name
- recipient_country: ISO country code
- entity_type: "individual" or "organization"

**Check against ALL lists:**
- OFAC (US Office of Foreign Assets Control)
- EU Consolidated List
- UN Security Council Sanctions List
- Country-specific lists (based on sender location)

**Match levels:**
- Exact match → BLOCK immediately
- Partial match (80%+ similarity) → Flag for manual review
- No match → Proceed to next check

**Special cases:**
- Common names: Require additional identifier (DOB, address)
- Organization names: Check alternate spellings, acronyms
- Foreign characters: Check transliterations

### Step 3: Jurisdiction Verification

**Why this matters:** Some countries prohibit certain types of transactions.

Call MCP: `compliance.check_jurisdiction`
Parameters:
- sender_country: Sender's country
- recipient_country: Recipient's country
- transaction_type: "personal", "business", "donation", etc.
- amount: Transaction amount

**Verify legal to process:**
- Cross-border transaction allowed between these countries
- Transaction type permitted (some countries ban donations, gambling, etc.)
- Amount within legal limits (many countries have thresholds)
- Required licenses/permits in place

**Restricted jurisdictions:**
- High-risk countries (FATF list)
- Embargoed countries
- Countries with capital controls

**Decision logic:**
- If prohibited → BLOCK with explanation
- If restricted → Require additional documentation
- If permitted → Proceed to risk assessment

### Step 4: Risk Assessment

**Why this matters:** High-risk transactions require enhanced due diligence.

Call MCP: `risk.calculate_score`
Parameters:
- transaction_amount: Amount in USD
- sender_history: Previous transaction count and volume
- recipient_type: Individual, business, nonprofit
- transaction_purpose: Stated purpose
- payment_method: Card, wire, ACH, etc.

**Risk factors (each adds to score):**
- Large amount (>$10,000): +30 points
- New recipient (first transaction): +20 points
- High-risk country: +40 points
- Unusual pattern (different from sender history): +25 points
- High-risk purpose (cash withdrawal, gambling): +35 points
- Cryptocurrency involved: +30 points

**Risk score interpretation:**
- 0-30: Low risk → Proceed with standard processing
- 31-60: Medium risk → Enhanced monitoring
- 61-80: High risk → Manager approval required
- 81+: Very high risk → Compliance team review mandatory

### Step 5: Enhanced Due Diligence (if required)

**Triggered when:** Risk score > 60 OR Partial sanctions match

Additional checks:
- Verify business legitimacy (for business recipients)
- Check source of funds (for large transactions)
- Verify transaction purpose (require documentation)
- Screen beneficial owners (for organizations)

Call MCP: `compliance.enhanced_due_diligence`
Parameters:
- transaction_id
- risk_factors: List of concerning factors
- additional_docs: Any documents provided

**Outcome:**
- Approved with conditions → Proceed with monitoring
- Rejected → Block transaction, explain reason
- Escalated → Compliance team review

### Step 6: Document Compliance Decision

**Critical for audit trail**

Call MCP: `compliance.log_decision`
Parameters:
- transaction_id
- checks_performed: [sanctions, jurisdiction, risk]
- results: Results from each check
- decision: "approved", "rejected", "flagged"
- decision_reason: Explanation
- reviewer: Automated or manual
- timestamp: Current time

**Audit log must include:**
- Which lists were checked
- Risk score and contributing factors
- Any manual reviews or overrides
- Final decision and reason
- Regulatory citations if applicable

## Processing Phase

### IF Compliance Checks PASSED:

```markdown
1. Apply fraud screening
   - Call: `fraud.screen_transaction`
   - Real-time fraud detection
   - Device fingerprinting
   - Behavioral analysis

2. Process payment
   - Call: `payments.execute`
   - Parameters: transaction_id, compliance_token
   - Compliance token proves checks completed

3. Enhanced monitoring (if medium/high risk)
   - Flag for post-transaction review
   - Monitor recipient for suspicious activity
   - Set up alerts for related transactions

4. Generate confirmation
   - Call: `notifications.send_receipt`
   - Include compliance reference number
   - Save confirmation for records
```

### IF Compliance Checks FAILED:

```markdown
1. Block transaction immediately
   - Do NOT process under any circumstances
   - Even if user insists

2. Flag for compliance review
   - Call: `compliance.flag_for_review`
   - Severity: Based on which check failed
   - Required action: What compliance team needs to do

3. Create compliance case
   - Call: `compliance.create_case`
   - Assign to: Compliance team
   - Include: All check results, risk factors
   - Priority: Based on severity

4. Notify stakeholders
   - User: Transaction cannot be processed, reason (without revealing too much)
   - Compliance team: Alert about flagged transaction
   - Manager: If escalation required

5. Document rejection
   - Call: `compliance.log_rejection`
   - Reason: Specific compliance violation
   - Regulatory basis: Which regulation requires blocking
```

## Post-Processing Audit Trail

After every transaction (approved or rejected):

```markdown
1. Generate compliance report
   - Call: `compliance.generate_audit_log`
   - Include ALL checks performed
   - Format: Required for regulatory reporting

2. Store for regulatory retention
   - Retention period: 7 years (regulatory requirement)
   - Format: Immutable, timestamped
   - Location: Compliance audit database

3. Update risk models
   - Feed results to ML risk models
   - Improve future risk assessment
   - Track accuracy of risk predictions
```

## Regulatory Knowledge Embedded

**This skill encodes expert knowledge:**

- OFAC regulations (US sanctions)
- EU anti-money laundering directives
- FATF recommendations
- Bank Secrecy Act (BSA) requirements
- Know Your Customer (KYC) standards
- PCI DSS for payment card data
- GDPR for personal data handling

**Users don't need to know these regulations** - the skill enforces them automatically.

## Error Handling

**If compliance service unavailable:**
- BLOCK all transactions
- Cannot process without compliance checks
- Report outage to compliance team

**If check timeout:**
- Default to REJECT (fail-safe)
- Log timeout for investigation
- Retry once, then escalate

**Never bypass compliance:**
- Even for trusted customers
- Even for small amounts
- Even if "urgent"
- Regulatory compliance is not optional
```

**Key techniques:**
- Domain expertise embedded in logic (sanctions, jurisdiction, risk)
- Compliance before action (never bypass)
- Comprehensive documentation (audit trail)
- Clear governance rules (when to block, when to escalate)
- Regulatory citations (which laws apply)
- Fail-safe defaults (block if uncertain)
- Expert knowledge users don't have

**When this pattern works well:**
- Regulated industries (finance, healthcare, legal)
- Compliance workflows
- Quality assurance systems
- Safety-critical applications
- Expert decision systems
- Industries with legal/regulatory requirements

## Choosing the Right Pattern

Use this guide to select the appropriate pattern:

| Your Need | Pattern | Example |
|-----------|---------|---------|
| Linear multi-step process | Pattern 1: Sequential Workflow | Customer onboarding, setup wizards |
| Multiple services/tools | Pattern 2: Multi-MCP Coordination | Design handoff, publishing pipeline |
| Quality iteration needed | Pattern 3: Iterative Refinement | Reports, content generation |
| Different tools for different contexts | Pattern 4: Context-Aware Selection | File storage, resource allocation |
| Specialized expertise required | Pattern 5: Domain Intelligence | Compliance, medical, legal workflows |

**Combining patterns:**

Most real-world skills combine multiple patterns:

- **E-commerce order fulfillment:**
  - Pattern 1 (sequential): Order → Payment → Fulfillment → Shipping
  - Pattern 5 (compliance): Tax calculation, fraud check
  - Pattern 2 (multi-MCP): Payment processor + inventory + shipping

- **Content publishing:**
  - Pattern 3 (iterative): Draft → Review → Revise → Finalize
  - Pattern 4 (context-aware): Choose publishing platform based on content type
  - Pattern 1 (sequential): Write → Edit → Format → Publish

**Start simple:**
- Begin with one pattern
- Add complexity only when needed
- Test thoroughly before combining patterns