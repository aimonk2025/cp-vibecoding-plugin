# Flexible Entry Point Detection

Users can start from ANY phase. System validates quality and fills gaps.

---

## Auto-Detection on Plugin Activation

When the vibe-coding plugin activates, FIRST check if there's existing code in the current directory.

### Auto-Detection Logic

```javascript
function onPluginActivate(projectPath) {
  // Step 1: Check for existing codebase
  const codebaseDetection = detectExistingCodebase(projectPath);

  if (codebaseDetection.hasCode) {
    // Show auto-detected codebase and offer options
    showCodebaseDetectionPrompt(codebaseDetection);
    return; // Wait for user choice
  }

  // Step 2: No code detected - proceed with normal entry point detection
  proceedWithNormalFlow();
}

function detectExistingCodebase(projectPath) {
  const detection = {
    hasCode: false,
    framework: null,
    language: null,
    fileCount: 0,
    hasDatabase: false,
    summary: ''
  };

  // Check for package managers / dependency files
  const hasPackageJson = exists(join(projectPath, 'package.json'));
  const hasRequirementsTxt = exists(join(projectPath, 'requirements.txt'));
  const hasGemfile = exists(join(projectPath, 'Gemfile'));
  const hasComposerJson = exists(join(projectPath, 'composer.json'));
  const hasCargoToml = exists(join(projectPath, 'Cargo.toml'));
  const hasGoMod = exists(join(projectPath, 'go.mod'));

  // Must have at least one dependency file
  if (!hasPackageJson && !hasRequirementsTxt && !hasGemfile &&
      !hasComposerJson && !hasCargoToml && !hasGoMod) {
    return detection;
  }

  // Count code files
  const codePatterns = [
    '**/*.{js,jsx,ts,tsx}',
    '**/*.{py}',
    '**/*.{rb}',
    '**/*.{php}',
    '**/*.{go}',
    '**/*.{rs}'
  ];

  const codeFiles = glob(codePatterns, {
    cwd: projectPath,
    ignore: ['node_modules/**', 'venv/**', 'env/**', '.venv/**', 'vendor/**', 'dist/**', 'build/**']
  });

  detection.fileCount = codeFiles.length;

  // Need at least 10 code files to consider it a codebase
  if (detection.fileCount < 10) {
    return detection;
  }

  // Codebase detected!
  detection.hasCode = true;

  // Quick framework detection
  if (hasPackageJson) {
    const pkg = readPackageJson(projectPath);
    if (pkg.dependencies?.next) {
      detection.framework = 'Next.js';
      detection.language = 'TypeScript/JavaScript';
    } else if (pkg.dependencies?.react) {
      detection.framework = 'React';
      detection.language = 'TypeScript/JavaScript';
    } else if (pkg.dependencies?.vue) {
      detection.framework = 'Vue';
      detection.language = 'TypeScript/JavaScript';
    } else if (pkg.dependencies?.express) {
      detection.framework = 'Express';
      detection.language = 'JavaScript';
    }
  } else if (hasRequirementsTxt) {
    const reqs = read(join(projectPath, 'requirements.txt'));
    if (/django/i.test(reqs)) {
      detection.framework = 'Django';
      detection.language = 'Python';
    } else if (/fastapi/i.test(reqs)) {
      detection.framework = 'FastAPI';
      detection.language = 'Python';
    }
  } else if (hasGemfile) {
    detection.framework = 'Rails';
    detection.language = 'Ruby';
  } else if (hasComposerJson) {
    detection.framework = 'Laravel';
    detection.language = 'PHP';
  }

  // Check for database
  detection.hasDatabase = exists(join(projectPath, 'prisma/schema.prisma')) ||
                          exists(join(projectPath, 'db/schema.rb')) ||
                          glob('**/models.py', { cwd: projectPath }).length > 0 ||
                          glob('**/*.entity.ts', { cwd: projectPath }).length > 0;

  // Generate summary
  detection.summary = `${detection.framework || 'Unknown'} project with ${detection.fileCount} code files`;
  if (detection.hasDatabase) {
    detection.summary += ' and database';
  }

  return detection;
}
```

### Auto-Detection Prompt

When code is detected, show this prompt:

```
I detected an existing codebase in this directory:

DETECTED:
- Framework: {{framework}} {{#if version}}({{version}}){{/if}}
- Language: {{language}}
- Code Files: {{fileCount}}
{{#if hasDatabase}}- Database: Detected{{/if}}

OPTIONS:
1. Generate docs from existing code (reverse-engineer)
   → I'll analyze your code and create PRD + technical docs

2. Build a new project here
   → Start fresh with IDEATE phase (careful: may conflict with existing code)

3. Continue with something else
   → Tell me what you need

Type 1, 2, or 3:
```

### User Selection Handling

```javascript
function handleAutoDetectionChoice(choice, codebaseDetection) {
  switch (choice) {
    case '1':
    case 'reverse':
    case 'generate docs':
    case 'analyze':
      // Start reverse-engineering workflow
      updateProgressFile('ENTRY_POINT', 'reverse_engineer_auto_detected');
      loadReference('codebase-analysis.md');
      loadReference('analysis-engine.md');
      loadReference('code-detectors.md');
      startReverseEngineeringWorkflow(codebaseDetection.projectPath);
      break;

    case '2':
    case 'new':
    case 'build new':
      // Warn about existing code, then start IDEATE
      showWarning(`
WARNING: You have existing code in this directory.
Starting a new project may cause conflicts.

Continue anyway? (yes/no)
      `);
      // If confirmed, start normal IDEATE
      break;

    case '3':
    case 'other':
    case 'something else':
      // Ask what they need
      showToUser('What would you like to do?');
      // Fall through to normal trigger detection
      break;

    default:
      // Try to interpret as trigger phrase
      detectTriggerPhrase(choice);
  }
}
```

### Skip Auto-Detection

Auto-detection is skipped when:
- User explicitly triggers a specific phase ("I want to build a new app")
- User provides a PRD ("Here's my PRD")
- User resumes session ("continue", "where were we?")
- Directory has < 10 code files

### Progress Tracking for Auto-Detection

```
VIBE CODING PROGRESS
====================
Entry Point: Auto-detected Codebase
Created: [timestamp]

AUTO-DETECTION RESULTS:
framework: Next.js
language: TypeScript
file_count: 487
has_database: true
user_choice: reverse_engineer

NEXT ACTION: Start reverse-engineering analysis
```

---

## Entry Point Scenarios

### 1. Complete Greenfield (New Project)
**User says:** "I want to build a task app"
**Action:** Start IDEATE phase (full interrogation)

### 2. Has Existing PRD
**User says:** "I have a PRD, use this"
**Action:**
1. Read PRD
2. **Validate PRD quality** (critical!)
3. If complete → Generate remaining docs
4. If incomplete → Enhance PRD through targeted questions

### 3. Has Existing Codebase
**User says:** "Generate docs for this code"
**Action:**
1. Analyze codebase
2. Generate technical docs from code
3. Ask questions for PRD gaps
4. Rebuild complete doc suite

### 4. Fast-Track (User Knows What They Want)
**User says:** "Skip the long questions, I know what I want"
**Action:** Condensed interrogation (10 key questions)

### 5. Reverse-Engineer Existing Codebase (NEW)
**User says:** "Generate docs from my code" / "Document this codebase" / "Create PRD from code"
**OR:** Auto-detected when plugin finds existing code

**Action:**
1. Run deep codebase analysis (8 areas)
2. Show confidence levels, get user verification
3. Generate technical docs (TECH_STACK, BACKEND_STRUCTURE, FRONTEND_GUIDELINES, partial DESIGN_SYSTEM, partial APP_FLOW)
4. Run gap-filling interrogation for business context
5. Complete doc suite (PRD, enhanced DESIGN_SYSTEM, enhanced APP_FLOW, IMPLEMENTATION_PLAN, CLAUDE.md)
6. Present next options: IDEATE (add features) / BUILD (enhance code) / Done

**See:** `codebase-analysis.md` for detailed workflow

## PRD Quality Validation (Critical!)

When user provides PRD, run validation:

```
VALIDATING PRD QUALITY:

✓ Problem statement: Clear and specific
✓ Target users: Defined with personas
✓ Core features: Listed with priorities
✗ Success metrics: Missing
✗ Technical constraints: Vague
✗ Out of scope: Not defined

QUALITY SCORE: 60% (INCOMPLETE)

This PRD needs enhancement before generating other docs.
```

### PRD Completeness Checklist

**Must Have (Blockers):**
- [ ] Problem statement (what problem does this solve?)
- [ ] Target users (who is this for?)
- [ ] Core features (what must it do?)
- [ ] Success criteria (how do we measure success?)

**Should Have (Important):**
- [ ] User personas (specific user descriptions)
- [ ] Feature priorities (must/should/could/won't)
- [ ] Technical constraints (budget, timeline, tech limits)
- [ ] Out of scope (what we won't build)
- [ ] Competitive context (alternatives, differentiation)

**Nice to Have:**
- [ ] User journeys (step-by-step flows)
- [ ] Business model (how does this make money?)
- [ ] Risks (what could go wrong?)

### Quality Levels

**Level 1: Stub (0-30%)**
- Just a title and vague description
- Example: "A task management app for users"
- **Action:** Run full IDEATE interrogation

**Level 2: Basic (31-60%)**
- Has problem and features, missing context
- Example: Problem + feature list, but no users/metrics
- **Action:** Targeted interrogation to fill gaps

**Level 3: Solid (61-85%)**
- Most elements present, needs polish
- **Action:** Quick questions on missing items

**Level 4: Complete (86-100%)**
- All critical elements well-defined
- **Action:** Skip to generating other docs

## Entry Point Logic with Validation

```
User provides PRD:

1. Parse PRD content
2. Run quality validation
3. Calculate completeness score

IF score >= 86%:
  → "PRD looks complete! Generating remaining docs..."
  → Proceed to DOCUMENT phase
  
ELSE IF score 61-85%:
  → "PRD is solid but missing: [list gaps]"
  → "I'll ask 5-10 questions to complete it"
  → Run targeted interrogation
  → Enhance PRD
  → Then generate other docs
  
ELSE IF score 31-60%:
  → "This PRD is basic. I found: [what's there]"
  → "Missing: [critical gaps]"
  → "I need to ask ~20 questions to make this complete"
  → Run focused interrogation
  → Rebuild PRD
  → Then generate other docs
  
ELSE (score < 30%):
  → "This PRD is too vague to use"
  → "Let's start from scratch with proper interrogation"
  → Run full IDEATE phase
  → Generate all docs fresh
```

## Examples

### Example 1: Complete PRD

**User provides:**
```markdown
# Task App PRD

## Problem
Busy parents (ages 30-45) forget household tasks because they track
them on paper and lose notes. This causes stress and conflicts.

## Users
Primary: Sarah, 35, working mom, 2 kids, uses phone for everything
Secondary: Mike, 40, stay-at-home dad, 3 kids, tech-savvy

## Features (Must Have)
1. Quick task entry (< 5 seconds)
2. Shared family task list
3. Simple check-off interface

## Success Metrics
- 80% of daily tasks completed
- < 5 min/day spent on app

## Out of Scope
- Advanced project management
- Time tracking
- Integrations
```

**Validation:**
```
QUALITY SCORE: 92% (COMPLETE)

✓ Problem: Specific and measurable
✓ Users: Detailed personas
✓ Features: Prioritized with rationale
✓ Success metrics: Quantifiable
✓ Scope: Clearly defined

Proceeding to generate remaining docs...
```

### Example 2: Basic PRD (Needs Enhancement)

**User provides:**
```markdown
# CRM App

Build a CRM for small businesses. Features:
- Contact management
- Deal tracking
- Email integration
```

**Validation:**
```
QUALITY SCORE: 35% (BASIC)

✓ Features: Listed (but not prioritized)
✗ Problem: Not defined
✗ Users: Not specified
✗ Success metrics: Missing
✗ Technical constraints: Missing

I need to enhance this PRD. Let me ask targeted questions:

Q: What specific problem do small businesses have with existing CRMs?
```

**User answers questions:**
```
[After 15 minutes of focused Q&A]

PRD ENHANCED:
- Problem: Existing CRMs too expensive ($50+/user) for 5-person teams
- Users: Small B2B service businesses (consultants, agencies)
- Success: Manage 100+ contacts, close 20% more deals
- Constraints: Budget $500/month, 2-month timeline

QUALITY SCORE: 88% (COMPLETE)

Proceeding to generate remaining docs...
```

### Example 3: Vague PRD (Start Over)

**User provides:**
```markdown
# Social App

An app for social networking
```

**Validation:**
```
QUALITY SCORE: 5% (STUB)

✗ Everything missing

This is too vague to enhance. Let's start with proper interrogation:

Q: What's the one-sentence description of what you want to build?
```

## Codebase Entry Point

When analyzing existing code:

```
User: "Generate docs for my codebase"

1. Scan codebase:
   ✓ Framework: Next.js + React
   ✓ Database: PostgreSQL (3 tables)
   ✓ Features: Auth, Blog posts, Comments
   
2. Generate technical docs from code:
   ✓ TECH_STACK.md (from package.json)
   ✓ BACKEND_STRUCTURE.md (from schema)
   ✓ FRONTEND_GUIDELINES.md (from components)
   
3. Ask questions to build PRD:
   Q: What problem does this blog solve?
   Q: Who are your target users?
   Q: Why did you build comments vs just posts?
   [Continue until PRD complete]
   
4. Generate remaining docs:
   ✓ PRD.md (from Q&A)
   ✓ APP_FLOW.md (from routes + Q&A)
   ✓ DESIGN_SYSTEM.md (from CSS/Tailwind)
   ✓ IMPLEMENTATION_PLAN.md (for future features)
```

## Progress Tracking

```
ENTRY POINT: User-provided PRD
prd_source: user-provided
prd_quality_initial: 35% (Basic)
prd_quality_final: 88% (Complete)
enhancement_questions: 12
duration: 15 minutes

---
PHASE: IDEATE
---
STATUS: partial (PRD enhancement only)
mode: targeted_interrogation

QUESTIONS ASKED:
Q: What problem do small businesses have with existing CRMs?
A: Too expensive ($50+/user) for small teams

Q: Who specifically would use this?
A: Small B2B service businesses with 5-10 employees

[...12 questions total...]

---
PHASE: DOCUMENT
---
STATUS: in_progress

DOCS COMPLETED:
✓ PRD.md (enhanced from user's basic version)
⊙ APP_FLOW.md (generating...)
```
