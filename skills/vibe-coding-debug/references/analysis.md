# Analysis Phase

Present findings. Determine root cause vs symptom. Get confirmation before fixing.

## Step 3: Present Findings

**Rule: The user must see your reasoning before you act on it.**

### Debug Findings Report

Present this BEFORE proposing any fix:

```
DEBUG FINDINGS:

BUG SUMMARY:
- What's broken: [observed vs expected behavior]
- Frequency: [always / sometimes / specific conditions]
- Impact: [who/what is affected]

LOCATION:
- Primary file: [file:line]
- Related files: [list]

CONNECTED SYSTEMS:
- [system]: [how it relates]
- [system]: [how it relates]

EVIDENCE:
- Error: [exact message]
- Stack trace: [key frames]
- Logs: [relevant entries]
- Network: [request/response if applicable]

PROBABLE CAUSE:
[Your hypothesis of what's causing the bug]

REASONING:
[Why you believe this is the cause - connect evidence to hypothesis]
```

### Explain Like a Senior

Don't just state WHAT is broken. Explain WHY:

| Bad | Good |
|-----|------|
| "The state isn't updating correctly" | "The state update is asynchronous but the render expects synchronous data - the component reads stale state on the first frame" |
| "The API returns an error" | "The API expects a JWT in the Authorization header but the token refresh happens after the request fires, causing a 401" |
| "The data is wrong" | "The aggregation query groups by user_id but the join happens before the filter, including deleted users in the count" |

The user should understand the bug better after your explanation.

## Step 4: Root Cause Analysis

**Rule: Ask yourself explicitly - am I fixing a root cause or treating a symptom?**

### The Critical Question

Before proposing any fix:

```
ROOT CAUSE ANALYSIS:

Question: "Am I solving a ROOT problem in the architecture,
           or am I treating a SYMPTOM caused by a deeper issue?"

Classification: [ROOT CAUSE / SYMPTOM / UNCERTAIN]
```

### If ROOT CAUSE

```
CLASSIFICATION: ROOT CAUSE

Reasoning:
[Why this is the actual source of the problem]

Fixing this will:
- Resolve the reported bug
- Prevent related issues because [explanation]
- Not require follow-up fixes

Confidence: [HIGH / MEDIUM / LOW]

→ Ready to propose fix.
```

### If SYMPTOM

```
CLASSIFICATION: SYMPTOM

This fix would treat: [visible problem]
But the actual root cause is: [deeper issue]

If we only fix the symptom:
- Bug will likely recur when [scenario]
- Related issues may appear in [areas]
- Technical debt added: [description]

RECOMMENDATION:
Fix [root cause] instead, which involves:
- [what needs to change]
- [estimated scope]

Alternative (if time-critical):
Apply symptom fix now, but create follow-up task
for proper root cause fix.

→ Which approach do you prefer?
```

### If UNCERTAIN

```
CLASSIFICATION: UNCERTAIN

I'm not 100% sure this is the root cause.

What I know:
- [evidence that supports this theory]

What's unclear:
- [gaps in understanding]
- [alternative explanations]

Options:
1. Investigate further: [what I would look at]
2. Try this fix and monitor: [proposed fix + what to watch]
3. Get more info: [what I need from you]

→ How should I proceed?
```

## Analysis Checkpoint

This checkpoint is MANDATORY before proceeding to fix:

```
ANALYSIS COMPLETE:

Findings presented: [YES/NO]
Root cause determined: [ROOT CAUSE / SYMPTOM / UNCERTAIN]
User confirmed classification: [YES/NO - REQUIRED]

If symptom fix approved as temporary:
[ ] Follow-up task created for root cause
[ ] Risks of symptom fix documented

→ Proceeding to propose fix.
```

## Common Root Cause Patterns

| Symptom | Often Actually |
|---------|----------------|
| "Null pointer" | Missing validation at data entry point |
| "Race condition" | Improper async handling upstream |
| "Wrong data displayed" | Data transformation bug, not display bug |
| "Slow performance" | N+1 query or missing index, not frontend |
| "Intermittent failure" | Resource cleanup issue or timing assumption |
| "Works locally, fails in prod" | Environment config or data volume difference |

## Pushing Back on Symptom Fixes

If user suggests a fix that treats a symptom:

```
CONCERN:

Your suggested fix ([fix]) would address the visible issue.

However, the root cause is [actual cause].
Applying this symptom fix means:
- [consequence 1]
- [consequence 2]

RECOMMENDATION:
[Alternative that addresses root cause]

Trade-off:
- Symptom fix: faster, but [risks]
- Root cause fix: [effort], but [benefits]

Your call - which approach?
```

Accept their decision if they override, but ensure they understand the tradeoff.
