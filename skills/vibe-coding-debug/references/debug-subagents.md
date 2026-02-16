# Debug Subagents

Specialized subagents for debugging tasks. Use to keep main context clean.

## Core Debug Subagents

### log-analyzer

**Purpose**: Parse logs to find error patterns and anomalies

**Triggers**:
- "analyze logs", "check logs"
- Error investigation
- Intermittent bug diagnosis

**Context Loaded**:
- Log files or log output
- Known error patterns
- Timestamp of bug occurrence

**Output**:
- Relevant log entries
- Error patterns found
- Timeline of events
- Anomalies detected

**Usage**:
```
INVOKING: log-analyzer
TARGET: [log file or output]
TIMEFRAME: [when bug occurred]
LOOKING FOR: [specific errors or patterns]
```

**Example**:
```
INVOKING: log-analyzer
TARGET: server.log (last 1 hour)
TIMEFRAME: 2024-01-15 14:30-14:45
LOOKING FOR: 500 errors, timeout warnings, auth failures
```

---

### blast-radius-mapper

**Purpose**: Trace all code paths connected to a bug location

**Triggers**:
- Starting investigation
- Before proposing fix
- Understanding impact of change

**Context Loaded**:
- Target file/function
- Import/export relationships
- Function call graph

**Output**:
- Files that import target
- Files that target imports
- Shared state/data
- Event connections

**Usage**:
```
INVOKING: blast-radius-mapper
TARGET: [file:function or file]
DIRECTION: [inbound / outbound / both]
DEPTH: [how many levels to trace]
```

**Example**:
```
INVOKING: blast-radius-mapper
TARGET: src/hooks/useAuth.ts:refreshToken
DIRECTION: both
DEPTH: 2
```

---

### data-flow-tracer

**Purpose**: Follow data through the system from source to display

**Triggers**:
- Data appears wrong/stale
- Transformation bugs
- State management issues

**Context Loaded**:
- Data entry point
- Known transformations
- Display components

**Output**:
- Data path visualization
- Each transformation step
- Where data changes
- Potential mutation points

**Usage**:
```
INVOKING: data-flow-tracer
DATA: [what data to trace]
SOURCE: [where it originates]
DESTINATION: [where it should end up]
```

**Example**:
```
INVOKING: data-flow-tracer
DATA: user.profile.name
SOURCE: API response (GET /user)
DESTINATION: ProfileHeader component
```

---

### regression-checker

**Purpose**: Verify fix didn't break other things

**Triggers**:
- After implementing fix
- Before closing debug session
- When fix touches shared code

**Context Loaded**:
- Changed files
- Connected systems (from blast radius)
- Test suites

**Output**:
- Systems checked
- Pass/fail for each
- Any new issues found

**Usage**:
```
INVOKING: regression-checker
CHANGED: [list of files changed]
CHECK: [systems to verify]
RUN: [tests to execute]
```

**Example**:
```
INVOKING: regression-checker
CHANGED: src/hooks/useAuth.ts, src/api/client.ts
CHECK: login flow, token refresh, protected routes
RUN: auth.test.ts, integration/auth.test.ts
```

---

### stack-trace-decoder

**Purpose**: Parse and explain stack traces

**Triggers**:
- Error with stack trace
- Crash investigation
- "What does this error mean"

**Context Loaded**:
- Stack trace
- Source maps (if available)
- Framework error patterns

**Output**:
- Decoded trace with file:line
- Most likely error origin
- Call sequence explanation
- Common causes for this error type

**Usage**:
```
INVOKING: stack-trace-decoder
TRACE: [paste stack trace]
FRAMEWORK: [React, Node, etc.]
```

---

### env-diff-checker

**Purpose**: Find differences between environments

**Triggers**:
- "Works locally, fails in prod"
- Environment-specific bugs
- Deployment issues

**Context Loaded**:
- Environment configs
- Package versions
- Build artifacts

**Output**:
- Config differences
- Version mismatches
- Missing env vars
- Build differences

**Usage**:
```
INVOKING: env-diff-checker
WORKING: [environment where it works]
BROKEN: [environment where it fails]
CHECK: [configs, versions, env vars]
```

---

## Inherited Subagents

From vibe-engineer, these are also useful for debugging:

| Subagent | Debug Use Case |
|----------|----------------|
| `pattern-matcher` | Find similar bugs in codebase history |
| `security-checker` | If bug has security implications |
| `test-writer` | Write tests for the fixed behavior |

## Subagent Chaining

For complex bugs, chain subagents:

```
DEBUG CHAIN:

1. log-analyzer → Find error timing and pattern
   OUTPUT: Error occurs at 14:32, 401 auth error

2. stack-trace-decoder → Understand the error
   OUTPUT: Fails in refreshToken(), line 45

3. blast-radius-mapper → Map connected code
   OUTPUT: 5 files depend on refreshToken()

4. data-flow-tracer → Follow the auth token
   OUTPUT: Token not updated before API call

5. regression-checker → After fix, verify all auth flows
   OUTPUT: All 5 dependent systems verified
```

## Creating Bug-Specific Subagents

For recurring bug patterns, define custom subagents:

```
CUSTOM DEBUG SUBAGENT: [name]

PURPOSE: [what it investigates]
TRIGGERS: [when to use]
CONTEXT: [what to load]
OUTPUT: [what to return]

Example pattern this catches:
[describe the recurring bug type]
```

Add to `tasks/lessons.md` for reuse across sessions.
