# Named Subagents

Use these specialized subagents for recurring patterns. Each subagent loads only relevant context.

## Core Subagents

### test-writer

**Purpose**: Generate test scaffolds and test cases

**Triggers**:
- "write tests for [X]"
- New feature implementation
- Refactoring existing code
- Coverage gaps identified

**Context Loaded**:
- Testing framework docs (jest, pytest, etc.)
- Existing test patterns in codebase
- Acceptance criteria from plan

**Output**:
- Test file with assertions matching acceptance criteria
- Edge case coverage
- Mock/stub setup if needed

**Usage**:
```
SUBAGENT: test-writer
TARGET: [function/module to test]
ACCEPTANCE CRITERIA: [from plan]
EXISTING PATTERNS: [path to similar tests]
```

---

### ci-fixer

**Purpose**: Autonomously debug and fix CI/CD failures

**Triggers**:
- CI pipeline failure
- "fix pipeline", "fix CI"
- Failed GitHub Actions / GitLab CI

**Context Loaded**:
- CI logs (full output)
- Workflow/pipeline files
- Recent commits that might have caused failure

**Output**:
- Root cause analysis
- Minimal fix patch
- Verification that fix resolves issue

**Usage**:
```
SUBAGENT: ci-fixer
CI OUTPUT: [paste logs or link]
WORKFLOW FILE: [path]
```

---

### refactor-reviewer

**Purpose**: Review refactoring changes for regressions

**Triggers**:
- After refactoring code
- Before merging large changes
- "review this refactor"

**Context Loaded**:
- Original code (before)
- New code (after)
- Related tests
- Callers/dependents of changed code

**Output**:
- Behavior diff analysis
- Potential regression points
- Suggested additional tests

**Usage**:
```
SUBAGENT: refactor-reviewer
BEFORE: [original code or commit]
AFTER: [new code]
SCOPE: [what should remain unchanged]
```

---

### security-checker

**Purpose**: Scan for security vulnerabilities

**Triggers**:
- New API endpoints
- User input handling
- Authentication/authorization changes
- "check security", "security review"

**Context Loaded**:
- OWASP top 10 checklist
- Project's security patterns
- Input validation code

**Output**:
- Vulnerability report
- Severity ratings
- Remediation suggestions

**Usage**:
```
SUBAGENT: security-checker
TARGET: [file/function/endpoint]
THREAT MODEL: [what we're protecting against]
```

---

### docs-syncer

**Purpose**: Keep documentation in sync with code

**Triggers**:
- After implementing features
- API changes
- "update docs"

**Context Loaded**:
- Relevant documentation files
- Code changes made
- PRD requirements

**Output**:
- Documentation updates needed
- Before/after for doc changes
- Gaps between code and docs

**Usage**:
```
SUBAGENT: docs-syncer
CODE CHANGES: [summary of what changed]
DOCS TO CHECK: [paths]
```

---

### pattern-matcher

**Purpose**: Find and apply existing codebase patterns

**Triggers**:
- Starting new feature
- Uncertain about conventions
- "how does this codebase handle [X]"

**Context Loaded**:
- Similar implementations in codebase
- Style guides
- Existing patterns for the task type

**Output**:
- Relevant patterns found
- Recommended approach
- Files to reference

**Usage**:
```
SUBAGENT: pattern-matcher
TASK: [what you're trying to implement]
LOOKING FOR: [type of pattern needed]
```

---

## Using Skills as Subagents

Claude Skills can be invoked as specialized subagents. See [skills-integration.md](skills-integration.md) for:

- Available skills for this project
- When to invoke skills vs. manual implementation
- Skill chaining patterns

## Subagent Best Practices

1. **One task per subagent** - Keep focused
2. **Progressive disclosure** - Load metadata first, details on demand
3. **Clear handoff** - Define exactly what subagent should return
4. **Verify output** - Don't blindly trust subagent results

## Creating Project-Specific Subagents

For recurring project patterns, define custom subagents in `tasks/lessons.md`:

```
CUSTOM SUBAGENT: [name]
PURPOSE: [what it does]
TRIGGERS: [when to use]
CONTEXT: [what to load]
OUTPUT: [what to return]
```
