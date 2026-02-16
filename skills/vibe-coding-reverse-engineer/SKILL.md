---
name: vibe-coding-reverse-engineer
description: |
  Analyze existing codebase and generate complete 8-document suite through deep code analysis + business context Q&A.
  Scans code structure, detects framework/stack, analyzes 8 areas (features, architecture, database, auth, APIs, middleware, UX, logic), generates technical docs from code, fills business gaps through targeted questions.
  Use when: (1) Docs from code - user says "generate docs from my code/app/codebase", "document this project/app", "create documentation for this code", "reverse engineer and document",
  (2) Code analysis - user says "analyze my app/code", "reverse engineer this", "understand this codebase", "what does this code do?",
  (3) Auto-detection - orchestrator detects existing codebase (10+ code files + dependency file) and prompts user,
  (4) Explicit trigger - user says "reverse engineer", "docs from code", "analyze codebase", "scan my project".
  Supports Next.js, React, Vue, Django, FastAPI, Rails, Laravel, and more. Auto-detects framework and database.
  Generates 5 tech docs directly from code (TECH_STACK, BACKEND_STRUCTURE, FRONTEND_GUIDELINES, partial DESIGN_SYSTEM, partial APP_FLOW).
  Then asks ~10 business questions to create remaining 3 docs (PRD, enhanced DESIGN_SYSTEM/APP_FLOW, IMPLEMENTATION_PLAN).
  Outputs all 8 canonical docs, then offers: add features (→IDEATE), improve code (→BUILD), or done (→EXIT).
---

# Vibe Coding REVERSE-ENGINEER Phase

Generate documentation from existing codebase.

## Workflow

### 1. Quick Scan
- Detect framework and language
- Count files and components
- Identify database/storage
- Estimate complexity

### 2. Deep Analysis (8 Areas)

**Load:** `../vibe-coding-document/references/codebase-analysis.md`

Analyze:
1. **Framework & Stack** - What technologies?
2. **Database** - Schema, models, relationships
3. **API Endpoints** - Routes, methods, parameters
4. **Authentication** - Auth flow, roles, permissions
5. **Frontend Components** - Component tree, state management
6. **Business Logic** - Core algorithms, workflows
7. **Integrations** - External APIs, services
8. **Deployment** - Current deployment setup

### 3. Confidence Verification
- Show analysis summary
- Mark confidence levels (High/Medium/Low)
- Ask user to verify/correct
- Adjust analysis based on feedback

### 4. Generate Technical Docs (5 docs)
- TECH_STACK.md
- BACKEND_STRUCTURE.md
- FRONTEND_GUIDELINES.md
- DESIGN_SYSTEM.md (partial - from CSS/styling)
- APP_FLOW.md (partial - from routes)

### 5. Gap-Filling Q&A

**Load:** `../vibe-coding-ideate/references/reverse-engineer-questions.md`

Ask business context questions:
- What problem does this solve?
- Who are the users?
- What's the business model?
- What are success metrics?
- What's planned for future?

### 6. Complete Documentation (3 remaining docs)
- PRD.md (from Q&A)
- Enhanced DESIGN_SYSTEM.md
- Enhanced APP_FLOW.md
- IMPLEMENTATION_PLAN.md (for future features)
- CLAUDE.md

### 7. Present Options

```
REVERSE-ENGINEERING COMPLETE!
==============================

Generated 8 complete documentation files.

Next steps - What would you like to do?

1. Add new features
   → Go to IDEATE phase to plan new features

2. Improve existing code
   → Go to BUILD phase to refactor/enhance

3. Just keep the docs
   → Exit (docs saved in ./docs/)

Type 1, 2, or 3:
```

## Progress Tracking

```
PHASE: REVERSE-ENGINEER
STATUS: [quick_scan|deep_analysis|tech_docs|gap_filling|complete]

ANALYSIS PROGRESS:
✓ Quick scan - Complete
✓ Deep analysis - 8/8 areas analyzed
✓ Confidence verification - Confirmed
⊙ Tech docs - 3/5 generated
✗ Gap-filling Q&A - Not started
✗ Complete docs - Not started

NEXT ACTION: [current step]
```

## Reference Files

- `../vibe-coding-document/references/codebase-analysis.md` - Analysis engine
- `references/reverse-engineer/analysis-engine.md` - Deep analysis
- `references/reverse-engineer/code-detectors.md` - Framework detection
- `references/reverse-engineer/doc-generation-from-code.md` - Doc generation
- `../vibe-coding-ideate/references/reverse-engineer-questions.md` - Gap-filling questions

## Hand-off Options

**Option 1: To IDEATE (Add Features)**
```
PHASE: REVERSE-ENGINEER
STATUS: complete
user_choice: add_features

---
PHASE: IDEATE
---
mode: add_features
existing_docs: 8
```

**Option 2: To BUILD (Improve Code)**
```
PHASE: REVERSE-ENGINEER
STATUS: complete
user_choice: improve_code

---
PHASE: BUILD
---
mode: enhancement
existing_codebase: true
```

**Option 3: Exit**
```
PHASE: REVERSE-ENGINEER
STATUS: complete
user_choice: docs_only
outcome: Documentation generated successfully
```
