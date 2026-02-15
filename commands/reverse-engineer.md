---
description: Generate docs from existing codebase/app/project (reverse-engineer your code into PRD + tech docs). Use when you have code and need documentation.
---

# Reverse-Engineer Command

Analyze existing codebase and generate complete documentation suite.

## Instructions

Trigger reverse-engineering workflow to generate PRD and technical docs from existing code.

### Step 1: Check Current State

Read progress.txt (if exists).

If already in REVERSE-ENGINEER phase:
```
ALREADY IN REVERSE-ENGINEER PHASE

Current progress:
[Show analysis status]

Options:
1. "continue" - Resume current analysis
2. "restart" - Start fresh analysis

What would you like?
```

If in a different phase:
```
PHASE TRANSITION WARNING

You're currently in [CURRENT PHASE].

Starting REVERSE-ENGINEER will analyze your codebase fresh.
Existing docs may be overwritten.

Are you sure? (yes/no)
```

### Step 2: Quick Scan

Run quick codebase detection:
```
SCANNING CODEBASE...

Looking for:
- Framework indicators (package.json, requirements.txt, etc.)
- Code file patterns
- Database schemas
- Configuration files

[spinner]
```

### Step 3: Show Detection Results

```
CODEBASE DETECTED

Framework: {{framework}} {{#if version}}({{version}}){{/if}}
Language: {{language}}
Code Files: {{fileCount}}
{{#if hasDatabase}}Database: Detected ({{dbType}}){{/if}}
{{#if hasAuth}}Auth: Detected ({{authType}}){{/if}}

Confidence: {{overallConfidence}}%

This analysis will:
1. Deep scan 8 areas (features, architecture, database, auth, APIs, etc.)
2. Generate 5 technical docs from code
3. Ask questions about business context
4. Generate complete 8-doc suite

Estimated time: 15-20 minutes

Proceed? (yes/no)
```

**[WAIT FOR CONFIRMATION]**

### Step 4: Load Reverse-Engineering Workflow

**Load:**
- `references/doc-architect/codebase-analysis.md`
- `references/doc-architect/reverse-engineer/analysis-engine.md`
- `references/doc-architect/reverse-engineer/code-detectors.md`

### Step 5: Initialize Progress File

Create/update progress.txt:
```
VIBE CODING PROGRESS
====================
Entry Point: Manual /reverse-engineer command
Created: [timestamp]

CURRENT STATE:
phase: REVERSE-ENGINEER
step: deep_analysis_starting
started: [timestamp]
last_updated: [timestamp]

QUICK SCAN RESULTS:
framework: [detected]
language: [detected]
file_count: [count]
has_database: [yes/no]
has_auth: [yes/no]

NEXT ACTION: Start deep 8-area analysis
```

### Step 6: Start Deep Analysis

```
STARTING DEEP ANALYSIS
======================

Analyzing 8 areas:

[1/8] Features & Functionality
    Scanning routes, components, handlers...

[2/8] Technical Architecture
    Analyzing project structure, patterns...

[3/8] Business Logic
    Mapping domain models, workflows...

[4/8] UX & Design
    Extracting styles, components...

[5/8] Database & Data Models
    Reading schemas, migrations...

[6/8] Authentication & Security
    Detecting auth patterns, security...

[7/8] External APIs & Integrations
    Finding API calls, third-party services...

[8/8] Middleware & Utilities
    Identifying middleware, helpers...

[Progress bar]
```

Then continue with codebase-analysis.md workflow:
- Show confidence levels
- Get user verification
- Generate tech docs
- Run gap-filling Q&A
- Complete doc suite
- Present next options

## Alternative: Quick Mode

If user wants faster analysis:
```
User: /vibe-coding:reverse-engineer quick

Claude:
QUICK MODE

Skipping interactive verification.
Using default confidence thresholds.

Generating docs now...

[Generates all docs without confirmation steps]

Done! Review generated docs in docs/
```

## Alternative: Specific Area

If user wants to analyze specific area:
```
User: /vibe-coding:reverse-engineer database

Claude:
DATABASE ANALYSIS ONLY

Scanning for:
- Schema files (Prisma, TypeORM, etc.)
- Migration history
- Model definitions
- Relationships

[Shows detailed database analysis]
```

## After Completion

When all docs generated:
```
REVERSE-ENGINEERING COMPLETE!

8 documents generated:
✓ PRD.md
✓ APP_FLOW.md
✓ TECH_STACK.md
✓ DESIGN_SYSTEM.md
✓ BACKEND_STRUCTURE.md
✓ FRONTEND_GUIDELINES.md
✓ IMPLEMENTATION_PLAN.md
✓ CLAUDE.md

All docs saved to: docs/

What's next?

Options:
1. "add features" - Start IDEATE to plan new features
2. "improve code" - Start BUILD to enhance existing code
3. "done" - Keep docs and exit

What would you like to do?
```

**[WAIT FOR USER CHOICE]**

Then transition to appropriate phase per workflow-state-machine.md.
