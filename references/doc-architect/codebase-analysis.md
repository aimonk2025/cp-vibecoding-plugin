# Codebase Analysis & Documentation Generation

Generate docs from existing code (reverse engineering).

## Detection

User says:
- "Generate docs for this codebase"
- "Document my existing project"
- "Analyze my code and create documentation"
- "I have code, need PRD/docs"

## Analysis Workflow

### Step 1: Scan Codebase Structure

Scan directory and identify:
- Framework (Next.js, React, Vue, etc.)
- Language (TypeScript, JavaScript, Python)
- Database (PostgreSQL, MongoDB, etc.)
- Key directories (components/, api/, pages/)
- Configuration files

### Step 2: Detect Features

Identify features by analyzing:
- Page/route structure
- Component files
- API endpoints
- Database tables/collections

### Step 3: Database Schema Analysis

Extract schema from:
- Prisma schema files
- Migration files
- SQL files
- Mongoose models

### Step 4: API Endpoint Mapping

Map all API endpoints:
- REST routes
- GraphQL schemas
- RPC endpoints

### Step 5: UI Component Analysis

Catalog components:
- Layout components
- Feature components
- Utility components
- Shared components

### Step 6: Design System Extraction

Extract from code:
- Colors (CSS variables, Tailwind)
- Typography
- Spacing
- Component patterns

## Documentation Generation

### Generate Technical Docs First

1. **TECH_STACK.md** - From package.json + imports
2. **BACKEND_STRUCTURE.md** - From schema + API files
3. **FRONTEND_GUIDELINES.md** - From components

### Then Ask Questions for PRD

Cannot detect from code:
- Why features exist
- Target users
- Business goals
- Success metrics

Ask targeted questions to fill these gaps.

### Generate Remaining Docs

4. **PRD.md** - From code analysis + Q&A
5. **APP_FLOW.md** - From routes + Q&A
6. **DESIGN_SYSTEM.md** - From CSS/config
7. **IMPLEMENTATION_PLAN.md** - For future features
8. **CLAUDE.md** - Project-specific rules

## What Can Be Detected

✓ Tech stack
✓ Database schema
✓ API endpoints
✓ Components
✓ Styling
✓ File structure
✓ Dependencies

## What Needs User Input

✗ Why features exist
✗ Target users
✗ Business goals
✗ Success metrics
✗ Roadmap
✗ Design rationale

## Progress Tracking

Track in progress.txt:
- Analysis results
- Features detected
- Docs generated from code
- Questions asked
- Final doc suite status
