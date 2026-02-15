# Testing and Validation Guide for Skills

Skills should be tested at varying levels of rigor depending on your needs. This guide covers three testing approaches and provides frameworks for measuring success.

## Testing Approaches

### 1. Manual Testing in Claude.ai

**Best for:** Fast iteration, initial validation, exploratory testing

**Process:**
1. Upload your skill to Claude.ai (Settings > Capabilities > Skills)
2. Run test queries directly and observe behavior
3. Note what works and what doesn't
4. Iterate quickly based on observations

**Advantages:**
- No setup required
- Fast feedback loop
- Easy to test different phrasings

**Limitations:**
- Not repeatable
- Hard to track changes over time
- Manual effort for each test

### 2. Scripted Testing in Claude Code

**Best for:** Repeatable validation, regression testing, consistent quality checks

**Process:**
1. Create a test script with standard queries
2. Run the script after each skill modification
3. Compare results systematically
4. Track improvements across versions

**Advantages:**
- Repeatable across changes
- Systematic coverage
- Can track metrics over time

**Limitations:**
- Requires initial setup
- Still manual review of outputs

### 3. Programmatic Testing via Skills API

**Best for:** Production deployments, enterprise use cases, systematic evaluation

**Process:**
1. Build evaluation suites using the Skills API
2. Run tests against defined test sets
3. Generate quantitative metrics
4. Automate quality gates

**Advantages:**
- Fully automated
- Quantitative metrics
- Scalable for large test suites

**Limitations:**
- Requires API integration
- Most complex to set up

## Choosing Your Approach

- **Internal skill for small team:** Manual testing is sufficient
- **Skill for team/department:** Add scripted testing
- **Public skill or enterprise deployment:** Use programmatic testing

## Pro Tip: Iterate on a Single Task First

The most effective approach: iterate on ONE challenging task until Claude succeeds, then extract the winning approach into your skill.

**Why this works:**
- Leverages Claude's in-context learning
- Provides faster signal than broad testing
- Helps you discover what actually works

**Process:**
1. Pick a representative challenging task
2. Work with Claude (without the skill) until it succeeds
3. Note what instructions/context made it work
4. Extract those patterns into your skill
5. Test the skill on that same task
6. Once working, expand to multiple test cases

## Three Testing Areas

### Area 1: Triggering Tests

**Goal:** Ensure your skill loads at the right times.

**Test cases:**
- ✅ Triggers on obvious tasks
- ✅ Triggers on paraphrased requests
- ❌ Doesn't trigger on unrelated topics

**Example test suite for a ProjectHub skill:**

```
Should trigger:
- "Help me set up a new ProjectHub workspace"
- "I need to create a project in ProjectHub"
- "Initialize a ProjectHub project for Q4 planning"

Should NOT trigger:
- "What's the weather in San Francisco?"
- "Help me write Python code"
- "Create a spreadsheet" (unless ProjectHub handles sheets)
```

**How to measure:**
Run 10-20 test queries that should trigger your skill. Track how many times it loads automatically vs. requires explicit invocation.

**Target:** 90% trigger rate on relevant queries

### Area 2: Functional Tests

**Goal:** Verify the skill produces correct outputs.

**Test cases:**
- Valid outputs generated
- API calls succeed (for MCP skills)
- Error handling works
- Edge cases covered

**Example test for project creation skill:**

```
Test: Create project with 5 tasks
Given: Project name "Q4 Planning", 5 task descriptions
When: Skill executes workflow
Then:
  - Project created in ProjectHub
  - 5 tasks created with correct properties
  - All tasks linked to project
  - No API errors
```

**How to measure:**
Run the same request 3-5 times. Compare outputs for structural consistency and quality.

**Target:** Consistent, correct results across all test runs

### Area 3: Performance Comparison

**Goal:** Prove the skill improves results vs. baseline.

**Baseline comparison example:**

```
Without skill:
- User provides instructions each time
- 15 back-and-forth messages
- 3 failed API calls requiring retry
- 12,000 tokens consumed

With skill:
- Automatic workflow execution
- 2 clarifying questions only
- 0 failed API calls
- 6,000 tokens consumed
```

**How to measure:**
Compare the same task with and without the skill enabled. Track:
- Number of messages/turns
- Failed API calls
- Total tokens consumed
- Time to completion
- User corrections needed

## Success Criteria Framework

Define success criteria before building. These are aspirational targets, not precise thresholds.

### Quantitative Metrics

**Trigger rate: 90% on relevant queries**
- How to measure: Run 10-20 test queries that should trigger your skill
- Track: How many times it loads automatically vs. requires explicit invocation
- Target: 9 out of 10 relevant queries should trigger the skill

**Workflow efficiency: Completes in X tool calls**
- How to measure: Count tool calls and tokens consumed
- Compare: Same task with and without skill enabled
- Target: Skill reduces tool calls by 30-50%

**Reliability: 0 failed API calls per workflow**
- How to measure: Monitor MCP server logs during test runs
- Track: Retry rates and error codes
- Target: All API calls succeed on first attempt

### Qualitative Metrics

**Users don't need to prompt about next steps**
- How to assess: During testing, note how often you need to redirect or clarify
- Ask beta users: "Did you need to tell Claude what to do next?"
- Target: Claude proactively executes the full workflow

**Workflows complete without user correction**
- How to assess: Run the same request 3-5 times
- Compare: Structural consistency and quality of outputs
- Target: No corrections needed across test runs

**Consistent results across sessions**
- How to assess: Can a new user accomplish the task on first try?
- Test: Give the skill to someone unfamiliar, observe their experience
- Target: First-time users succeed without guidance

## Using skill-creator for Iteration

The skill-creator skill can help you build and improve skills based on test results.

**Creating skills:**
- Generate skills from natural language descriptions
- Produce properly formatted SKILL.md with frontmatter
- Suggest trigger phrases and structure

**Reviewing skills:**
- Flag common issues (vague descriptions, missing triggers)
- Identify potential over/under-triggering risks
- Suggest test cases based on stated purpose

**Iterative improvement:**
After testing, bring your findings back to skill-creator:

```
"Use the issues & solution identified in this chat to improve how the
skill handles [specific edge case]"
```

**Note:** skill-creator helps design and refine skills but does not execute automated test suites or produce quantitative evaluation results.

## Iteration Based on Feedback

Plan to iterate based on these signals:

### Undertriggering Signals

**Symptoms:**
- Skill doesn't load when it should
- Users manually enabling it
- Support questions about when to use it

**Solution:**
Add more detail and nuance to the description field. Include:
- Additional trigger phrases
- Technical terms users might say
- File types the skill handles
- Specific task variations

**Example fix:**
```yaml
# Before (undertriggers)
description: Helps with project management

# After (improved)
description: Manages Linear project workflows including sprint planning,
task creation, and status tracking. Use when user mentions "sprint",
"Linear tasks", "project planning", or asks to "create tickets".
```

### Overtriggering Signals

**Symptoms:**
- Skill loads for irrelevant queries
- Users disabling it
- Confusion about purpose

**Solutions:**

1. **Add negative triggers:**
```yaml
description: Advanced data analysis for CSV files. Use for statistical
modeling, regression, clustering. Do NOT use for simple data exploration
(use data-viz skill instead).
```

2. **Be more specific:**
```yaml
# Too broad
description: Processes documents

# More specific
description: Processes PDF legal documents for contract review
```

3. **Clarify scope:**
```yaml
description: PayFlow payment processing for e-commerce. Use specifically
for online payment workflows, not for general financial queries.
```

### Execution Issues

**Symptoms:**
- Inconsistent results
- API call failures
- User corrections needed

**Solutions:**
- Improve instructions (be more specific)
- Add error handling
- Include validation steps
- Add examples for edge cases
- Test scripts for fragile operations

## Test Case Template

Use this template to document your test cases:

```markdown
## Test Suite for [Skill Name]

### Triggering Tests

**Should trigger:**
1. [exact phrase user would say]
2. [paraphrased version]
3. [variation with different wording]

**Should NOT trigger:**
1. [related but out of scope]
2. [similar domain but wrong tool]
3. [completely unrelated]

### Functional Tests

**Test 1: [Test name]**
- Given: [initial conditions]
- When: [user request]
- Then: [expected outcome]

**Test 2: [Test name]**
- Given: [initial conditions]
- When: [user request]
- Then: [expected outcome]

### Performance Comparison

**Without skill:**
- [metric 1]: [value]
- [metric 2]: [value]
- [metric 3]: [value]

**With skill:**
- [metric 1]: [value]
- [metric 2]: [value]
- [metric 3]: [value]

**Improvement:**
- [metric 1]: [% improvement]
- [metric 2]: [% improvement]
- [metric 3]: [% improvement]
```

## Best Practices

1. **Start simple:** Begin with manual testing, add rigor as needed
2. **Test early:** Don't wait until skill is "done" to start testing
3. **Test the description first:** Triggering tests should be your first priority
4. **Document failures:** Track what doesn't work to guide improvements
5. **Involve real users:** Your own testing has blind spots
6. **Compare versions:** Keep test results to measure improvements
7. **Automate gradually:** Start manual, script repetitive tests, automate when stable
