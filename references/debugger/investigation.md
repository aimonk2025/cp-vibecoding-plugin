# Investigation Phase

Reproduce first. Research second. No fixes until both complete.

## Step 1: Reproduce the Bug

**Rule: No fix attempt begins until reproduction is confirmed.**

### Reproduction Protocol

1. Run the exact steps user describes
2. Use the same environment if possible
3. Note any variations in behavior
4. Capture evidence (logs, errors, screenshots)

### Reproduction Report

```
REPRODUCTION ATTEMPT:

Steps taken:
1. [step]
2. [step]
3. [step]

Result: [REPRODUCED / COULD NOT REPRODUCE / PARTIAL]

If REPRODUCED:
- Observed behavior: [what happened]
- Expected behavior: [what should happen]
- Evidence captured: [logs, errors, screenshots]

If COULD NOT REPRODUCE:
- What I tried: [steps]
- What I saw instead: [behavior]
- Possible reasons: [environment diff, timing, data state]
- Need from user: [specific info to proceed]
```

### Cannot Reproduce?

Ask for:
```
REPRODUCTION BLOCKED - NEED MORE INFO:

1. Environment details:
   - Browser/version: ?
   - OS: ?
   - Device: ?
   - Network conditions: ?

2. Account/data state:
   - User role/permissions: ?
   - Specific data that triggers it: ?
   - Account age/state: ?

3. Exact steps:
   - Starting point: ?
   - Each click/action: ?
   - Timing between steps: ?

4. Additional evidence:
   - Full console output: ?
   - Network tab: ?
   - Video of the bug: ?
```

## Step 2: Research Blast Radius

**Rule: Understand every connected system before proposing any fix.**

### Blast Radius Mapping

Use subagents to investigate:

```
INVOKING: blast-radius-mapper
TARGET: [file/function where bug manifests]
GOAL: Map all connected code paths
```

### What to Map

1. **Direct dependencies**
   - What does this file import?
   - What imports this file?

2. **Data flow**
   - Where does the data come from?
   - Where does it go?
   - What transforms it along the way?

3. **State connections**
   - What state does this touch?
   - What else reads/writes that state?

4. **API contracts**
   - What endpoints are involved?
   - What's the expected request/response?

5. **Side effects**
   - Does this trigger other actions?
   - Are there event listeners or hooks?

### Blast Radius Report

```
BLAST RADIUS MAPPED:

Files involved:
- [file]: [role in the bug]
- [file]: [role in the bug]
- [file]: [role in the bug]

Connected systems:
- [system]: [how it connects]
- [system]: [how it connects]

Data flow:
[source] → [transform] → [destination]

Evidence gathered:
- Logs: [relevant entries]
- Errors: [stack traces]
- Network: [request/response issues]

NOT involved (verified):
- [file/system]: [why it's not related]
```

### Investigation Subagents

| Subagent | Use For |
|----------|---------|
| `log-analyzer` | Parse logs, find error patterns |
| `blast-radius-mapper` | Trace code connections |
| `data-flow-tracer` | Follow data through system |
| `pattern-matcher` | Find similar code/bugs in codebase |

See [debug-subagents.md](debug-subagents.md) for full definitions.

## Investigation Checklist

Before proceeding to analysis:

```
INVESTIGATION COMPLETE:
[ ] Bug reproduced and documented
[ ] Blast radius mapped
[ ] All connected files identified
[ ] Evidence gathered (logs, errors, traces)
[ ] Data flow understood
[ ] NOT-involved systems verified

→ Ready to analyze findings and determine root cause.
```

## Red Flags During Investigation

If you encounter these, pause and report:

| Red Flag | Action |
|----------|--------|
| Bug affects more than expected | Report expanded scope |
| Multiple unrelated issues found | Trigger multi-bug protocol |
| Undocumented behavior discovered | Ask for clarification |
| Security implications found | Escalate immediately |
| Data corruption possible | Stop, report, get approval |
