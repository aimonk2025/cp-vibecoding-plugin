# Codebase Analysis & Documentation Generation

This file orchestrates the reverse-engineering workflow: analyzing existing codebases and generating comprehensive documentation from code + user input.

## Table of Contents

1. [When to Use](#when-to-use)
2. [High-Level Workflow](#high-level-workflow)
3. [Analysis Orchestration](#analysis-orchestration)
4. [Confidence Verification Protocol](#confidence-verification-protocol)
5. [Progress Tracking](#progress-tracking)
6. [Error Handling](#error-handling)

---

## When to Use

### User Trigger Phrases

Activate reverse-engineering when user says:
- "Generate docs for this codebase"
- "Document my existing project"
- "Analyze my code and create documentation"
- "I have code, need PRD/docs"
- "Create PRD from my code"
- "Reverse engineer this project"

### Auto-Detection Trigger

Also activate when:
1. Plugin starts in directory with existing code
2. Auto-detection finds:
   - package.json with dependencies
   - OR requirements.txt with packages
   - OR Gemfile with gems
   - OR composer.json with packages
   - AND 10+ code files

See `entry-point-detection.md` for auto-detection logic.

---

## High-Level Workflow

```
┌─────────────────────────────────┐
│ 1. QUICK SCAN (2-3 min)         │
│ Detect framework, count files   │
└────────────┬────────────────────┘
             │
             ▼
┌─────────────────────────────────┐
│ 2. DEEP ANALYSIS (5-20 min)     │
│ All 8 areas analyzed             │
└────────────┬────────────────────┘
             │
             ▼
┌─────────────────────────────────┐
│ 3. CONFIDENCE VERIFICATION       │
│ Show results, user confirms      │
└────────────┬────────────────────┘
             │
             ▼
┌─────────────────────────────────┐
│ 4. GENERATE TECH DOCS (10-15m)  │
│ 5 docs from code analysis        │
└────────────┬────────────────────┘
             │
             ▼
┌─────────────────────────────────┐
│ 5. GAP-FILLING Q&A (15-20 min)  │
│ Ask about business context       │
└────────────┬────────────────────┘
             │
             ▼
┌─────────────────────────────────┐
│ 6. COMPLETE DOC SUITE (10-15m)  │
│ Remaining 3 docs                 │
└────────────┬────────────────────┘
             │
             ▼
┌─────────────────────────────────┐
│ 7. PRESENT NEXT OPTIONS          │
│ IDEATE / BUILD / Done            │
└─────────────────────────────────┘
```

**Total Time:** 45-75 minutes for complete documentation

---

## Analysis Orchestration

### Entry Point: `analyzeAndDocumentCodebase()`

This is the master orchestration function that coordinates the entire workflow.

```javascript
async function analyzeAndDocumentCodebase(projectPath) {
  // Load analysis engine
  loadReference('analysis-engine.md');
  loadReference('code-detectors.md');

  updateProgress('Starting codebase analysis...');

  // ===========================
  // PHASE 1: QUICK SCAN
  // ===========================

  updateProgress('Phase 1: Quick Scan');

  const quickScan = performQuickScan(projectPath);
  /*
    Returns:
    {
      framework: { name, version, confidence },
      language: 'TypeScript',
      fileCount: 487,
      hasDatabase: true,
      hasTests: true,
      estimatedTime: '15-20 minutes'
    }
  */

  showToUser(`
Detected codebase:
- Framework: ${quickScan.framework.name} ${quickScan.framework.version}
- Language: ${quickScan.language}
- Files: ${quickScan.fileCount}

Starting deep analysis... (estimated time: ${quickScan.estimatedTime})
  `);

  // ===========================
  // PHASE 2: DEEP ANALYSIS
  // ===========================

  updateProgress('Phase 2: Deep Analysis (8 areas)');

  const analysis = {};

  // Area 1: Features & Functionality
  updateProgress('Analyzing features and functionality...');
  analysis.features = analyzeFeaturesAndFunctionality(projectPath);
  showProgress('✓ Features analyzed', { filesAnalyzed: analysis.features.filesAnalyzed });

  // Area 2: Technical Architecture
  updateProgress('Analyzing technical architecture...');
  analysis.techStack = analyzeTechnicalArchitecture(projectPath);
  showProgress('✓ Tech stack analyzed');

  // Area 3: Business Logic
  updateProgress('Analyzing business logic...');
  analysis.businessLogic = analyzeBusinessLogic(projectPath);
  showProgress('✓ Business logic analyzed');

  // Area 4: UX & Design
  updateProgress('Extracting design system...');
  analysis.design = analyzeUXAndDesign(projectPath);
  showProgress('✓ Design system extracted');

  // Area 5: Database
  updateProgress('Analyzing database schema...');
  analysis.database = analyzeDatabase(projectPath);
  showProgress('✓ Database analyzed');

  // Area 6: Auth
  updateProgress('Analyzing auth mechanisms...');
  analysis.auth = analyzeAuth(projectPath);
  showProgress('✓ Auth analyzed');

  // Area 7: External APIs
  updateProgress('Detecting external services...');
  analysis.externalAPIs = analyzeExternalAPIs(projectPath);
  showProgress('✓ External APIs detected');

  // Area 8: Middleware
  updateProgress('Analyzing middleware stack...');
  analysis.middleware = analyzeMiddleware(projectPath);
  showProgress('✓ Middleware analyzed');

  // Calculate overall confidence
  analysis.confidence = calculateOverallConfidence(analysis);
  analysis.metadata = {
    analyzedAt: new Date().toISOString(),
    duration: calculateDuration(),
    filesAnalyzed: quickScan.fileCount,
    overallConfidence: analysis.confidence.overall
  };

  updateProgressFile('ANALYSIS_COMPLETE', analysis);

  // ===========================
  // PHASE 3: CONFIDENCE VERIFICATION
  // ===========================

  const verified = await verifyDetectionsWithUser(analysis);

  if (!verified.confirmed) {
    // User corrected some detections
    applyUserCorrections(analysis, verified.corrections);
    updateProgressFile('DETECTIONS_CORRECTED', verified.corrections);
  }

  // ===========================
  // PHASE 4: GENERATE TECH DOCS
  // ===========================

  updateProgress('Phase 4: Generating technical documentation');

  // Load doc generation templates
  loadReference('doc-generation-from-code.md');

  // Doc 1: TECH_STACK.md
  updateProgress('Generating TECH_STACK.md...');
  const techStackDoc = generateTechStackDoc(analysis.techStack, analysis.database);
  showDocumentToUser('TECH_STACK.md', techStackDoc);
  const approved1 = await askUserApproval('TECH_STACK.md');
  if (approved1) {
    saveDocument('docs/TECH_STACK.md', techStackDoc);
    updateProgressFile('DOC_GENERATED', 'TECH_STACK.md');
  }

  // Doc 2: BACKEND_STRUCTURE.md
  updateProgress('Generating BACKEND_STRUCTURE.md...');
  const backendDoc = generateBackendStructureDoc(
    analysis.database,
    analysis.features.apiEndpoints,
    analysis.auth,
    analysis.middleware
  );
  showDocumentToUser('BACKEND_STRUCTURE.md', backendDoc);
  const approved2 = await askUserApproval('BACKEND_STRUCTURE.md');
  if (approved2) {
    saveDocument('docs/BACKEND_STRUCTURE.md', backendDoc);
    updateProgressFile('DOC_GENERATED', 'BACKEND_STRUCTURE.md');
  }

  // Doc 3: FRONTEND_GUIDELINES.md
  updateProgress('Generating FRONTEND_GUIDELINES.md...');
  const frontendDoc = generateFrontendGuidelinesDoc(
    analysis.techStack.components,
    analysis.features.routes,
    analysis.techStack.framework
  );
  showDocumentToUser('FRONTEND_GUIDELINES.md', frontendDoc);
  const approved3 = await askUserApproval('FRONTEND_GUIDELINES.md');
  if (approved3) {
    saveDocument('docs/FRONTEND_GUIDELINES.md', frontendDoc);
    updateProgressFile('DOC_GENERATED', 'FRONTEND_GUIDELINES.md');
  }

  // Doc 4: DESIGN_SYSTEM.md (partial - will enhance after Q&A)
  updateProgress('Generating DESIGN_SYSTEM.md (partial)...');
  const designDoc = generateDesignSystemDoc(analysis.design);
  showDocumentToUser('DESIGN_SYSTEM.md', designDoc);
  const approved4 = await askUserApproval('DESIGN_SYSTEM.md');
  if (approved4) {
    saveDocument('docs/DESIGN_SYSTEM.md', designDoc);
    updateProgressFile('DOC_GENERATED', 'DESIGN_SYSTEM.md (partial)');
  }

  // Doc 5: APP_FLOW.md (partial - will enhance after Q&A)
  updateProgress('Generating APP_FLOW.md (partial)...');
  const appFlowDoc = generateAppFlowDoc(analysis.features.routes, analysis.features.flows);
  showDocumentToUser('APP_FLOW.md', appFlowDoc);
  const approved5 = await askUserApproval('APP_FLOW.md');
  if (approved5) {
    saveDocument('docs/APP_FLOW.md', appFlowDoc);
    updateProgressFile('DOC_GENERATED', 'APP_FLOW.md (partial)');
  }

  showToUser(`
✓ Technical documentation complete!

Generated:
- TECH_STACK.md
- BACKEND_STRUCTURE.md
- FRONTEND_GUIDELINES.md
- DESIGN_SYSTEM.md (partial)
- APP_FLOW.md (partial)

Next: I need to understand the WHY behind this code.
  `);

  // ===========================
  // PHASE 5: GAP-FILLING Q&A
  // ===========================

  updateProgress('Phase 5: Interactive gap-filling');

  // Load question bank
  loadReference('reverse-engineer-questions.md');
  loadReference('conversation-engine.md');

  const gapFillingAnswers = await conductGapFillingInterrogation(analysis);
  /*
    Asks about:
    - Problem statement
    - Target users
    - Business goals
    - Success metrics
    - Feature priorities
    - Database change needs
    - Design rationale
    - Roadmap
  */

  updateProgressFile('GAP_FILLING_COMPLETE', gapFillingAnswers);

  // ===========================
  // PHASE 6: COMPLETE DOC SUITE
  // ===========================

  updateProgress('Phase 6: Completing documentation suite');

  // Doc 6: PRD.md (code analysis + gap-filling Q&A)
  updateProgress('Generating PRD.md...');
  const prdDoc = generatePRDDoc(analysis, gapFillingAnswers);
  showDocumentToUser('PRD.md', prdDoc);
  const approved6 = await askUserApproval('PRD.md');
  if (approved6) {
    saveDocument('docs/PRD.md', prdDoc);
    updateProgressFile('DOC_GENERATED', 'PRD.md');
  }

  // Doc 7: Enhanced APP_FLOW.md
  updateProgress('Enhancing APP_FLOW.md with user context...');
  const enhancedAppFlowDoc = enhanceAppFlowDoc(appFlowDoc, gapFillingAnswers);
  showDocumentToUser('APP_FLOW.md (enhanced)', enhancedAppFlowDoc);
  const approved7 = await askUserApproval('APP_FLOW.md (enhanced)');
  if (approved7) {
    saveDocument('docs/APP_FLOW.md', enhancedAppFlowDoc);
    updateProgressFile('DOC_ENHANCED', 'APP_FLOW.md');
  }

  // Doc 8: Enhanced DESIGN_SYSTEM.md
  updateProgress('Enhancing DESIGN_SYSTEM.md with rationale...');
  const enhancedDesignDoc = enhanceDesignSystemDoc(designDoc, gapFillingAnswers);
  showDocumentToUser('DESIGN_SYSTEM.md (enhanced)', enhancedDesignDoc);
  const approved8 = await askUserApproval('DESIGN_SYSTEM.md (enhanced)');
  if (approved8) {
    saveDocument('docs/DESIGN_SYSTEM.md', enhancedDesignDoc);
    updateProgressFile('DOC_ENHANCED', 'DESIGN_SYSTEM.md');
  }

  // Doc 9: IMPLEMENTATION_PLAN.md (for future features)
  updateProgress('Generating IMPLEMENTATION_PLAN.md...');
  const implPlanDoc = generateImplementationPlanDoc(gapFillingAnswers.roadmap);
  showDocumentToUser('IMPLEMENTATION_PLAN.md', implPlanDoc);
  const approved9 = await askUserApproval('IMPLEMENTATION_PLAN.md');
  if (approved9) {
    saveDocument('docs/IMPLEMENTATION_PLAN.md', implPlanDoc);
    updateProgressFile('DOC_GENERATED', 'IMPLEMENTATION_PLAN.md');
  }

  // Doc 10: CLAUDE.md (project-specific rules)
  updateProgress('Generating CLAUDE.md...');
  const claudeDoc = generateClaudeMdDoc(analysis, gapFillingAnswers);
  showDocumentToUser('CLAUDE.md', claudeDoc);
  const approved10 = await askUserApproval('CLAUDE.md');
  if (approved10) {
    saveDocument('docs/CLAUDE.md', claudeDoc);
    updateProgressFile('DOC_GENERATED', 'CLAUDE.md');
  }

  updateProgressFile('ALL_DOCS_COMPLETE');

  // ===========================
  // PHASE 7: PRESENT NEXT OPTIONS
  // ===========================

  const nextAction = await presentNextOptions();
  /*
    Options:
    1. Add features (→ IDEATE phase)
    2. Improve code (→ BUILD phase)
    3. Just keep docs (→ Exit)
  */

  return {
    analysis,
    gapFillingAnswers,
    nextAction
  };
}
```

---

## Confidence Verification Protocol

After deep analysis, ALWAYS show summary with confidence levels and ask user to verify.

### Verification Display Format

```
Analysis Complete! (15m 42s)

DETECTED CONFIGURATION:
✓ Framework: Next.js 14.0.0 with App Router (HIGH confidence - 100%)
  Indicators: package.json, next.config.js, app/ directory

✓ Database: PostgreSQL via Prisma 5.0.0 (HIGH confidence - 100%)
  Indicators: prisma/schema.prisma, @prisma/client dependency

⚠ Auth: NextAuth.js 4.x (MEDIUM confidence - 75%)
  Indicators: @auth/core found, but version unclear from config

⚠ State Management: Zustand (LOW confidence - 60%)
  Indicators: found imports but no clear usage patterns

✗ Frontend Testing: Unknown (confidence - 0%)
  Indicators: no test files found

Does this look correct?
- Type 'yes' to continue with doc generation
- Type 'fix: [field]' to correct (e.g., "fix: auth is Passport not NextAuth")
- Type 'cancel' to exit
```

### User Correction Handling

If user corrects detections:

```javascript
function applyUserCorrections(analysis, corrections) {
  for (const correction of corrections) {
    const { field, correctedValue } = correction;

    if (field === 'framework') {
      analysis.techStack.framework = correctedValue;
      analysis.confidence.framework = 100; // User-provided = 100% confidence
    }
    else if (field === 'database') {
      analysis.database.type = correctedValue;
      analysis.confidence.database = 100;
    }
    // ... handle other fields
  }

  showToUser(`✓ Corrections applied. Proceeding with doc generation...`);
}
```

---

## Progress Tracking

All analysis progress is tracked in `progress.txt`.

### Initial State (Quick Scan Complete)

```
VIBE CODING PROGRESS
====================
Project: TaskMaster Pro
Entry Point: Reverse-Engineering (Auto-detected)
Created: 2026-02-15T10:30:00Z
Last Updated: 2026-02-15T10:33:00Z

CURRENT STATE:
phase: REVERSE-ENGINEER
step: deep_analysis_in_progress
next_action: Continue deep analysis

---
PHASE: REVERSE-ENGINEER
---

STATUS: in_progress
started: 2026-02-15T10:30:00Z

QUICK SCAN RESULTS:
framework: Next.js 14.0.0
router: app
language: TypeScript
file_count: 487
has_database: true
has_tests: true
estimated_time: 15-20 minutes
completed_at: 2026-02-15T10:33:00Z

DEEP ANALYSIS PROGRESS:
✓ Features & Functionality (5m 30s)
✓ Technical Architecture (2m 15s)
✓ Business Logic (3m 45s)
✓ UX & Design (1m 50s)
⊙ Database Analysis (in progress...)
  Pending: Auth, External APIs, Middleware

NEXT ACTION: Complete deep analysis (database, auth, external APIs, middleware)
```

### After Analysis Complete

```
DEEP ANALYSIS COMPLETE:
overall_confidence: 92%
duration: 15m 42s
files_analyzed: 487
completed_at: 2026-02-15T10:45:42Z

ANALYSIS RESULTS:

Features Detected: 5
- User Authentication (routes: /login, /signup, API: 3 endpoints)
- Task Management (routes: /tasks, /tasks/:id, API: 5 endpoints)
- Team Collaboration (routes: /teams, API: 4 endpoints)
- User Profile (routes: /profile, API: 2 endpoints)
- Dashboard (route: /, API: 1 endpoint)

Tech Stack:
- Framework: Next.js 14.0.0 (100% confidence)
- Language: TypeScript
- Database: PostgreSQL via Prisma 5.0.0 (100% confidence)
- Auth: NextAuth 4.x (75% confidence)
- Styling: Tailwind CSS 3.3.0
- Components: 23 total (5 pages, 12 features, 6 UI)

Database Schema:
- Tables: 3 (users, tasks, teams)
- Relationships: 2 (users→tasks, teams→tasks)
- Indexes: 3

CONFIDENCE VERIFICATION:
status: pending
awaiting_user_confirmation: true

NEXT ACTION: Show analysis summary to user for verification
```

### After Docs Generated

```
DOCS GENERATED FROM CODE:

✓ TECH_STACK.md
  generated: 2026-02-15T10:50:00Z
  approved: 2026-02-15T10:51:00Z
  location: docs/TECH_STACK.md
  lines: 180

✓ BACKEND_STRUCTURE.md
  generated: 2026-02-15T10:52:00Z
  approved: 2026-02-15T10:53:00Z
  location: docs/BACKEND_STRUCTURE.md
  lines: 245

✓ FRONTEND_GUIDELINES.md
  generated: 2026-02-15T10:54:00Z
  approved: 2026-02-15T10:55:00Z
  location: docs/FRONTEND_GUIDELINES.md
  lines: 198

✓ DESIGN_SYSTEM.md (partial)
  generated: 2026-02-15T10:56:00Z
  approved: 2026-02-15T10:57:00Z
  location: docs/DESIGN_SYSTEM.md
  lines: 156

✓ APP_FLOW.md (partial)
  generated: 2026-02-15T10:58:00Z
  approved: 2026-02-15T10:59:00Z
  location: docs/APP_FLOW.md
  lines: 167

NEXT ACTION: Start gap-filling interrogation
```

### During Gap-Filling

```
GAP-FILLING INTERROGATION:

status: in_progress
started: 2026-02-15T11:00:00Z
questions_asked: 8
estimated_remaining: 5-8 questions

TRANSCRIPT:

Q: I can see your app does task management with team collaboration. What specific problem does this solve?
A: Busy parents forget household tasks because they track on paper and lose notes. This causes stress and family conflicts.

Q: Who specifically are these busy parents? Describe one real person.
A: Sarah, 35, working mom, 2 kids ages 5 and 8, uses phone for everything but struggles with paper lists

Q: How is Sarah solving this today without your app?
A: Paper lists on fridge + phone reminders, but things fall through cracks between the two systems

[... 5 more Q&As ...]

TOPICS COVERED:
✓ Problem statement - Complete
✓ Target users - Complete
✓ Success metrics - Complete
⊙ Feature priorities - Partial
  Pending: Roadmap, Design rationale

NEXT ACTION: Continue gap-filling - ask about feature priorities
```

### After Complete

```
PHASE: REVERSE-ENGINEER
STATUS: completed
completed_at: 2026-02-15T11:45:00Z
duration: 1h 15m

ALL DOCS GENERATED:
✓ TECH_STACK.md
✓ BACKEND_STRUCTURE.md
✓ FRONTEND_GUIDELINES.md
✓ DESIGN_SYSTEM.md (enhanced)
✓ APP_FLOW.md (enhanced)
✓ PRD.md
✓ IMPLEMENTATION_PLAN.md
✓ CLAUDE.md

NEXT OPTIONS PRESENTED:
1. Add features (IDEATE)
2. Improve code (BUILD)
3. Just keep docs (Exit)

NEXT ACTION: Awaiting user choice
```

---

## Error Handling

### Error: No Code Detected

```
❌ NO CODEBASE DETECTED

I couldn't find code files in this directory.

Expected:
- package.json (Node.js)
- OR requirements.txt (Python)
- OR Gemfile (Ruby)
- OR composer.json (PHP)
- AND 10+ code files

Options:
1. Navigate to correct directory
2. Provide PRD manually instead
3. Start new project with IDEATE
```

### Error: Unsupported Framework

```
⚠ PARTIALLY SUPPORTED FRAMEWORK

I detected: SolidJS (confidence: 70%)

This framework has limited support. I can analyze:
✓ File structure
✓ Dependencies
✓ Component files
✗ Framework-specific patterns
✗ Routing (manual input needed)

Continue anyway? (yes/no)
```

### Error: Analysis Timeout

```
⚠ ANALYSIS TAKING LONGER THAN EXPECTED

Analyzed: 542/1247 files (43%)
Time elapsed: 25 minutes
Estimated remaining: 30 minutes

Options:
1. Continue analysis (may take 30+ more minutes)
2. Stop here and use partial analysis
3. Cancel and provide docs manually
```

### Error: Low Confidence Across Board

```
⚠ LOW CONFIDENCE DETECTION

Overall confidence: 45%

Detected with LOW confidence:
- Framework: Remix? (50%)
- Database: Supabase? (40%)
- Auth: Unknown (0%)

This codebase may be too complex or non-standard for automatic analysis.

Options:
1. Continue with manual corrections
2. Skip to IDEATE phase instead
3. Provide PRD manually
```

---

## Integration with Other Phases

### Transition to IDEATE

If user chooses "Add features" after reverse-engineering:

```javascript
function transitionToIdeate(analysisResults, gapFillingAnswers) {
  updateProgressFile('TRANSITION_TO_IDEATE');

  loadReference('interrogator/main.md');
  loadReference('conversation-engine.md');

  const context = {
    existingApp: true,
    currentFeatures: analysisResults.features,
    techStack: analysisResults.techStack,
    prdExists: true
  };

  showToUser(`
You have an existing app with:
- ${Object.keys(analysisResults.features).length} main features
- ${analysisResults.database.schema.tables.length} database tables
- ${analysisResults.techStack.components.total} components

What new features would you like to add?
  `);

  // Start targeted interrogation for NEW features only
  startInterrogation(context, 'add_features_mode');
}
```

### Transition to BUILD

If user chooses "Improve code":

```javascript
function transitionToBuild(analysisResults, gapFillingAnswers) {
  updateProgressFile('TRANSITION_TO_BUILD');

  loadReference('engineer/main.md');

  showToUser(`
I've documented your codebase. What would you like to improve?

1. Refactor existing code
2. Add tests (I see limited test coverage)
3. Improve performance
4. Fix known bugs
5. Implement planned features from IMPLEMENTATION_PLAN.md

Type 1-5:
  `);

  const choice = await getUserInput();

  // Proceed to BUILD phase with context
  startBuildPhase(analysisResults, choice);
}
```

---

## References

This file coordinates the following reference files:

**Core Analysis:**
- `analysis-engine.md` - Core analysis algorithms (8 areas)
- `code-detectors.md` - Framework-specific detection patterns

**Documentation Generation:**
- `doc-generation-from-code.md` - How to convert code analysis to docs
- `doc-architect/generators/*` - Individual doc generator templates

**Gap-Filling:**
- `reverse-engineer-questions.md` - Business context question bank
- `conversation-engine.md` - Adaptive questioning technique

**Workflow:**
- `entry-point-detection.md` - Auto-detection and entry point logic
- `workflow-state-machine.md` - Phase transitions
- `progress-templates.md` - Progress tracking templates

---

## Summary

**Codebase analysis** is a comprehensive workflow that:

1. **Scans** code quickly to detect framework and scope
2. **Analyzes** deeply across 8 critical areas
3. **Verifies** detections with user before proceeding
4. **Generates** 5 technical docs from code alone
5. **Asks** targeted questions about business context
6. **Completes** full 8-doc suite with combined code + user input
7. **Transitions** seamlessly to IDEATE or BUILD phases

**Total time:** 45-75 minutes for complete documentation

**Confidence-driven:** Always show confidence levels and get user verification before generating docs

**Flexible:** Supports all major frameworks and gracefully handles edge cases
