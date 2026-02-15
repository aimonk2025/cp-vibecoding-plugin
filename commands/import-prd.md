---
description: Import an existing PRD or requirements document (e.g., /vibe-coding:import-prd ./my-prd.md)
---

# Import PRD Command

Import an existing Product Requirements Document and generate remaining documentation.

## Instructions

The user provides a file path in `$ARGUMENTS`.

### Step 1: Parse File Path

Extract file path from `$ARGUMENTS`:
```
/vibe-coding:import-prd ./docs/requirements.md
/vibe-coding:import-prd /path/to/prd.md
/vibe-coding:import-prd requirements.txt
```

If `$ARGUMENTS` is empty:
```
IMPORT PRD COMMAND

Usage: /vibe-coding:import-prd [file path]

Examples:
- /vibe-coding:import-prd ./my-prd.md
- /vibe-coding:import-prd ./docs/requirements.txt
- /vibe-coding:import-prd ../project-spec.md

Or paste your PRD content:
Type "paste prd" and I'll accept pasted content in the next message.
```

### Step 2: Read PRD File

Try to read the file at the provided path.

If file NOT found:
```
FILE NOT FOUND: [path]

I couldn't find a file at that location.

Options:
1. Check the path and try again
2. Paste your PRD content (type "paste" and I'll accept it)
3. Start fresh with interrogation (type "/vibe-coding:ideate")

What would you like to do?
```

If file found, read contents.

### Step 3: Validate PRD Quality

**Load:** `references/doc-architect/prd-import.md`

Run quality validation (0-100% scoring):

#### Quality Rubric
- Problem Statement: 0-20 points
- Target Users: 0-20 points
- Core Features: 0-20 points
- Success Metrics: 0-15 points
- Technical Constraints: 0-10 points
- Scope Definition: 0-15 points

Calculate total score.

### Step 4: Show Validation Results

```
PRD IMPORT VALIDATION
=====================

File: [file path]
Size: [file size]
Format: [markdown/text/other]

QUALITY ASSESSMENT:

Score: [X]% ([Level])

Sections Found:
✓ Problem Statement - [quality level]
✓ Core Features - [quality level]
✗ Target Users - Missing
✗ Success Metrics - Missing
⊙ Technical Constraints - Vague

[Level] = Stub (0-30%) | Basic (31-60%) | Solid (61-85%) | Complete (86-100%)
```

### Step 5: Handle Based on Quality

#### If Score >= 86% (Complete):
```
PRD QUALITY: EXCELLENT (91%)

This PRD is comprehensive and ready to use!

Found:
✓ Clear problem with validation
✓ Detailed user personas
✓ Prioritized features
✓ Quantified success metrics
✓ Technical constraints defined
✓ Scope clearly defined

Next Steps:
I'll generate the remaining 7 documents based on this PRD:
- APP_FLOW.md
- TECH_STACK.md
- DESIGN_SYSTEM.md
- BACKEND_STRUCTURE.md
- FRONTEND_GUIDELINES.md
- IMPLEMENTATION_PLAN.md
- CLAUDE.md

This will take about 20-25 minutes total.

Proceed? (Type "continue")
```

#### If Score 61-85% (Solid):
```
PRD QUALITY: SOLID (72%)

This PRD is mostly complete but has some gaps.

Missing/Vague:
✗ Success metrics not quantified
⊙ Technical constraints vague

I'll ask 5-10 quick questions to fill these gaps,
then generate all 8 documents.

Estimated time: 10 minutes Q&A + 20 minutes doc generation

Proceed? (Type "continue")
```

#### If Score 31-60% (Basic):
```
PRD QUALITY: BASIC (45%)

This PRD has some good content but needs enhancement.

Found:
✓ Features list
✗ Problem not defined
✗ Users not specified
✗ No success metrics

I'll ask ~15 targeted questions to complete this PRD,
then generate the remaining 7 documents.

Estimated time: 15 minutes Q&A + 20 minutes doc generation

Proceed? (Type "continue")
```

#### If Score 0-30% (Stub):
```
PRD QUALITY: STUB (18%)

This PRD is too incomplete to use as a foundation.

I recommend starting with proper interrogation instead.

Options:
1. Full interrogation (~30 min) - Thorough requirements gathering
2. Fast-track interrogation (~10 min) - 10 essential questions
3. Try a different PRD file

What would you like to do?
```

### Step 6: Enhancement Flow (if needed)

**Load:** `references/doc-architect/prd-import.md` (enhancement questions section)

Ask targeted questions based on gaps:
```
Let's enhance your PRD. I'll ask [X] targeted questions.

Question 1 of [X]:
[Question about missing section]
```

After all questions answered:
```
PRD ENHANCED!

Updated quality: 88% (Complete)

Sections added/improved:
✓ Problem Statement - Added specific metrics
✓ Target Users - Created 2 detailed personas
✓ Success Metrics - Added quantifiable KPIs

Saving enhanced PRD to: docs/PRD.md

Proceed to generate remaining 7 documents? (Type "continue")
```

### Step 7: Initialize Progress Tracking

Create progress.txt with entry point noted:
```
ENTRY POINT: User-provided PRD
prd_source: [file path]
prd_initial_quality: [score]%
prd_final_quality: [score after enhancement]%
enhancement_questions: [count]

PHASE: DOCUMENT
STATUS: in_progress
current_doc: none (PRD imported)

DOCS COMPLETED:
✓ PRD.md (imported and enhanced)

DOCS PENDING:
- APP_FLOW.md
- TECH_STACK.md
[...remaining 6...]

NEXT ACTION: Generate APP_FLOW.md
```

## Handle Paste Mode

If user types "paste" or "paste prd":
```
PASTE MODE ACTIVATED

Please paste your PRD content in your next message.

I'll accept any format:
- Plain text
- Markdown
- Structured document

Paste now:
```

Then on next message, capture pasted content and run validation.

## Examples

**Example 1: Good PRD**
```
User: /vibe-coding:import-prd ./my-requirements.md

Claude:
Reading: ./my-requirements.md...

PRD IMPORT VALIDATION
Score: 92% (Complete)

Excellent PRD! Ready to generate 7 remaining documents.
Type "continue" to proceed.
```

**Example 2: Basic PRD Needs Enhancement**
```
User: /vibe-coding:import-prd ./basic-spec.txt

Claude:
Reading: ./basic-spec.txt...

PRD QUALITY: BASIC (48%)

I found features but missing problem and users.
Let me ask 12 questions to complete this.

Proceed? (Type "continue")
```

**Example 3: File Not Found**
```
User: /vibe-coding:import-prd ./wrong-path.md

Claude:
FILE NOT FOUND: ./wrong-path.md

Options:
1. Check path and retry
2. Paste content instead
3. Start fresh interrogation
```
