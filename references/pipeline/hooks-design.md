# Hooks Design for Vibe Coding

## Hook Types Needed

### 1. Progress Tracking Hooks

**Auto-save after every conversation turn:**
```json
{
  "PostModelResponse": [
    {
      "name": "Save conversation to progress.txt",
      "description": "After Claude asks a question or receives an answer, update progress.txt",
      "action": "append_to_progress_file"
    }
  ]
}
```

**What it does:**
- Captures every Q&A exchange
- Timestamps each interaction
- Updates TOPICS COVERED checklist
- Sets NEXT ACTION based on conversation state

### 2. Phase Transition Hooks

**Validate phase completion before transition:**
```json
{
  "PrePhaseTransition": [
    {
      "name": "Validate IDEATE completion",
      "condition": "current_phase == IDEATE && next_phase == DOCUMENT",
      "checks": [
        "All 10 topics covered",
        "Summary generated",
        "User approved summary"
      ],
      "on_fail": "Block transition, show missing topics"
    }
  ]
}
```

### 3. Document Generation Hooks

**Track docs as they're created:**
```json
{
  "PostToolUse": [
    {
      "matcher": "Write",
      "condition": "file_path matches '(PRD|APP_FLOW|TECH_STACK).md'",
      "hooks": [
        {
          "type": "update_progress",
          "action": "mark_document_generated"
        }
      ]
    }
  ]
}
```

### 4. Build Verification Hooks

**Verify after implementation:**
```json
{
  "PostFeatureImplementation": [
    {
      "name": "Run tests after feature",
      "hooks": [
        {
          "type": "command",
          "command": "npm test"
        },
        {
          "type": "update_progress",
          "action": "mark_feature_complete_if_tests_pass"
        }
      ]
    }
  ]
}
```

### 5. Context Preservation Hooks

**Load context on session start:**
```json
{
  "SessionStart": [
    {
      "name": "Load progress file",
      "hooks": [
        {
          "type": "read_file",
          "file": "progress.txt"
        },
        {
          "type": "set_context",
          "from": "progress_file"
        }
      ]
    }
  ]
}
```

## Hook Implementation Strategy

Since hooks have limitations in Claude Code plugins, we'll use **instructions-based hooks**:

### Pattern: Instruction Hooks

Instead of actual hooks, we embed instructions in SKILL.md:

```markdown
## Auto-Save Protocol (Execute After Every Response)

After EVERY response where you:
- Ask a question
- Receive an answer
- Generate a document
- Implement a feature
- Fix a bug

IMMEDIATELY:
1. Read current progress.txt
2. Update relevant section
3. Write back to progress.txt
4. Continue with next action
```

### Pattern: Phase Checkpoint Instructions

```markdown
## Phase Transition Checklist

Before transitioning from IDEATE → DOCUMENT:
1. Verify all 10 topics covered
2. Generate summary
3. Get user approval
4. Update progress.txt with:
   - IDEATE status: complete
   - DOCUMENT status: in_progress
   - Timestamp transition
5. Load doc-architect/main.md
6. Start DOCUMENT phase
```

## Practical Hooks We Can Implement

### Hook 1: Progress Auto-Save

**File:** `hooks/hooks.json`
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "name": "Update progress after file operations",
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'File updated - remember to update progress.txt'"
          }
        ]
      }
    ]
  }
}
```

### Hook 2: Test Runner After Implementation

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "name": "Run tests after code changes",
        "matcher": "Write|Edit",
        "condition": "file ends with .ts, .js, .tsx, .jsx",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | grep -E '\.(ts|js|tsx|jsx)$' && npm test || true"
          }
        ]
      }
    ]
  }
}
```

### Hook 3: Lint After Code Write

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "name": "Auto-lint code files",
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | xargs npm run lint:fix 2>/dev/null || true"
          }
        ]
      }
    ]
  }
}
```

## Alternative: Embedded Instructions

Since plugin hooks are limited, we use **instruction-based checkpoints**:

### In SKILL.md:
```markdown
## Progress Tracking (CRITICAL - DO THIS AFTER EVERY INTERACTION)

After EVERY user interaction:
1. Read progress.txt
2. Append latest Q&A to INTERROGATION TRANSCRIPT
3. Update TOPICS COVERED checklist
4. Set NEXT ACTION
5. Update last_updated timestamp
6. Write back to progress.txt

This is NOT optional. Progress MUST be saved continuously.
```

### In Each Phase main.md:
```markdown
## Checkpoint Protocol

After completing each step:
□ Update progress.txt with completion status
□ Document what was done
□ Set next action
□ Verify no regressions

Never skip checkpoints.
```

## Progress File Update Frequency

| Phase | Update Trigger | What to Save |
|-------|----------------|--------------|
| IDEATE | After each Q&A | Question, answer, topics covered, next question |
| DOCUMENT | After each doc | Doc name, status, approval state |
| BUILD | After each feature | Feature name, files changed, tests passed |
| DEBUG | After each fix | Bug description, fix applied, verification |
| SHIP | After each step | Deployment step, status, logs |

## Recovery & Resume

If session ends unexpectedly:
1. Read progress.txt
2. Parse last_updated timestamp
3. Find NEXT ACTION
4. Resume from that point
5. Show user: "Resuming from: [NEXT ACTION]"

This makes the workflow **session-independent**.
