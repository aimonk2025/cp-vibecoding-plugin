# Document Generation from Code Analysis

This file defines how to convert code analysis results and gap-filling Q&A into the 8 canonical documentation files.

## Table of Contents

1. [Overview](#overview)
2. [Data Sources](#data-sources)
3. [Document Generation Templates](#document-generation-templates)
4. [Generation Order](#generation-order)

---

## Overview

### Input Sources

Documents are generated from two sources:

1. **Code Analysis** (from `analysis-engine.md`)
   - Technical facts: frameworks, dependencies, schema, routes
   - Automatically extracted, no user input needed
   - High confidence, verifiable

2. **Gap-Filling Q&A** (from `reverse-engineer-questions.md`)
   - Business context: problem, users, goals, roadmap
   - User-provided through conversation
   - Subjective, requires interpretation

### Output Documents

| Document | Primary Source | Secondary Source |
|----------|---------------|------------------|
| TECH_STACK.md | Code Analysis | - |
| BACKEND_STRUCTURE.md | Code Analysis | - |
| FRONTEND_GUIDELINES.md | Code Analysis | - |
| DESIGN_SYSTEM.md | Code Analysis | Gap-Filling (rationale) |
| APP_FLOW.md | Code Analysis | Gap-Filling (user context) |
| PRD.md | Gap-Filling | Code Analysis |
| IMPLEMENTATION_PLAN.md | Gap-Filling (roadmap) | Code Analysis |
| CLAUDE.md | Code Analysis | Gap-Filling |

---

## Data Sources

### From Code Analysis

```javascript
const codeAnalysis = {
  // Quick Scan
  quickScan: {
    framework: { name: 'Next.js', version: '14.0.0', router: 'app' },
    language: 'TypeScript',
    fileCount: 487
  },

  // Deep Analysis
  features: {
    tasks: {
      routes: ['/tasks', '/tasks/:id', '/tasks/new'],
      apiEndpoints: [
        { method: 'GET', path: '/api/tasks' },
        { method: 'POST', path: '/api/tasks' }
      ],
      files: ['pages/tasks/index.tsx', 'components/TaskList.tsx']
    }
  },

  techStack: {
    framework: { name: 'Next.js', version: '14.0.0' },
    dependencies: { react: '18.2.0', prisma: '5.0.0' },
    components: {
      pages: 5,
      features: 12,
      ui: 6,
      utilities: 3
    }
  },

  database: {
    type: 'PostgreSQL',
    orm: 'Prisma',
    schema: {
      tables: [
        { name: 'User', fields: [...], relations: [...] },
        { name: 'Task', fields: [...], relations: [...] }
      ],
      relationships: [
        { from: 'User', to: 'Task', type: 'one-to-many' }
      ]
    }
  },

  design: {
    colors: { primary: '#3B82F6', secondary: '#10B981' },
    typography: { fontFamily: 'Inter' },
    spacing: { base: '4px' }
  },

  auth: {
    method: 'NextAuth',
    providers: ['email', 'google'],
    sessionType: 'JWT'
  },

  externalAPIs: [
    { service: 'SendGrid', purpose: 'Email' },
    { service: 'Stripe', purpose: 'Payments' }
  ],

  middleware: [
    { name: 'auth', purpose: 'Authentication' },
    { name: 'logger', purpose: 'Request logging' }
  ]
};
```

### From Gap-Filling Q&A

```javascript
const gapFillingAnswers = {
  problem: {
    statement: 'Busy parents forget household tasks because paper and digital systems dont sync',
    whoHasProblem: 'Working parents 25-45 with multiple children',
    currentSolutions: 'Paper lists + phone reminders',
    painPoints: ['Things fall through cracks', 'Spouse doesnt see tasks', 'Missed activities']
  },

  users: {
    primary: {
      name: 'Sarah',
      role: 'Working parent',
      techLevel: 'Tech-comfortable',
      device: 'Mobile primarily',
      usageFrequency: 'Daily, multiple times'
    },
    secondary: [
      { name: 'Mike', role: 'Spouse', usageFrequency: 'Daily' }
    ]
  },

  businessGoals: {
    objective: 'User growth and retention',
    successMetrics: [
      { metric: 'Active families', target: 10000, timeframe: '6 months' },
      { metric: 'Tasks completed per family', target: 5, timeframe: 'weekly' }
    ],
    revenueModel: 'Freemium with family plan'
  },

  featurePriorities: [
    { feature: 'Task Management', priority: 1, rationale: 'Core value proposition' },
    { feature: 'Team Sharing', priority: 2, rationale: 'Family collaboration' },
    { feature: 'Dashboard', priority: 3, rationale: 'Motivation and tracking' }
  ],

  database: {
    limitations: 'None currently',
    plannedChanges: 'Add calendar_events table',
    compliance: 'GDPR'
  },

  design: {
    philosophy: 'Calm, stress-reducing, family-friendly',
    inspirations: ['Apple Reminders', 'Notion', 'Todoist'],
    accessibility: 'WCAG AA'
  },

  roadmap: {
    planned: ['Calendar sync', 'Shopping lists', 'Kid assignments'],
    outOfScope: ['Social features', 'Gamification', 'Enterprise features']
  }
};
```

---

## Document Generation Templates

### 1. TECH_STACK.md

**Primary Source:** Code Analysis (100%)

```markdown
# Tech Stack

## Overview

This document defines the technology choices for [Project Name].

## Core Framework

| Technology | Version | Purpose |
|-----------|---------|---------|
| {{framework.name}} | {{framework.version}} | {{framework.purpose}} |
| {{language}} | {{languageVersion}} | Primary language |

## Frontend

### Framework
- **{{framework.name}}** ({{framework.version}})
  - Router: {{framework.router}}
  - Rendering: {{framework.rendering}}

### Styling
- **{{styling.name}}** ({{styling.version}})
  - Config: {{styling.configFile}}

### State Management
- **{{stateManagement.name}}** ({{stateManagement.version}}) - {{stateManagement.purpose}}

### UI Components
{{#each uiLibraries}}
- **{{name}}** ({{version}}) - {{purpose}}
{{/each}}

## Backend

### Database
- **{{database.type}}** via **{{database.orm}}** ({{database.ormVersion}})
- Connection: {{database.connectionMethod}}
- Migrations: {{database.migrationsPath}}

### Authentication
- **{{auth.library}}** ({{auth.version}})
- Providers: {{auth.providers}}
- Session: {{auth.sessionType}}

### API
- Style: {{api.style}}
- Routes: {{api.routesPath}}

## External Services

| Service | Purpose | SDK/Package |
|---------|---------|-------------|
{{#each externalAPIs}}
| {{service}} | {{purpose}} | {{package}} |
{{/each}}

## Development Tools

### Build
{{#each buildTools}}
- **{{name}}** - {{purpose}}
{{/each}}

### Testing
{{#each testingTools}}
- **{{name}}** ({{version}}) - {{purpose}}
{{/each}}

### Linting/Formatting
{{#each lintingTools}}
- **{{name}}** - {{purpose}}
{{/each}}

## Package Versions

<details>
<summary>All Dependencies</summary>

| Package | Version | Purpose |
|---------|---------|---------|
{{#each dependencies}}
| {{name}} | {{version}} | {{purpose}} |
{{/each}}

</details>

## Rationale

### Why {{framework.name}}?
{{framework.rationale}}

### Why {{database.type}}?
{{database.rationale}}

### Why {{auth.library}}?
{{auth.rationale}}
```

**Generation Function:**

```javascript
function generateTechStackDoc(analysis) {
  const doc = {
    framework: {
      name: analysis.techStack.framework.name,
      version: analysis.techStack.framework.version,
      router: analysis.techStack.framework.router || 'default',
      rendering: detectRenderingMode(analysis),
      purpose: 'Full-stack React framework',
      rationale: 'Chosen for SSR, API routes, and App Router'
    },
    language: analysis.techStack.language,
    languageVersion: analysis.techStack.languageVersion || 'latest',
    database: {
      type: analysis.database.type,
      orm: analysis.database.orm,
      ormVersion: analysis.database.version,
      rationale: 'Type-safe ORM with excellent DX'
    },
    auth: {
      library: analysis.auth.library,
      version: analysis.auth.version,
      providers: analysis.auth.providers.join(', '),
      sessionType: analysis.auth.sessionType
    },
    dependencies: formatDependencies(analysis.techStack.dependencies),
    externalAPIs: analysis.externalAPIs,
    buildTools: analysis.techStack.buildTools,
    testingTools: analysis.techStack.testing,
    lintingTools: analysis.techStack.linting
  };

  return renderTemplate('TECH_STACK', doc);
}
```

---

### 2. BACKEND_STRUCTURE.md

**Primary Source:** Code Analysis (100%)

```markdown
# Backend Structure

## Overview

Backend architecture for [Project Name].

## Database Schema

### Entity Relationship Diagram

```
{{erd}}
```

### Tables

{{#each tables}}
#### {{name}}

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
{{#each fields}}
| {{name}} | {{type}} | {{constraints}} | {{description}} |
{{/each}}

**Relationships:**
{{#each relations}}
- {{this}}
{{/each}}

**Indexes:**
{{#each indexes}}
- {{this}}
{{/each}}

{{/each}}

## API Endpoints

### REST API

{{#each resources}}
#### {{name}}

| Method | Path | Description | Auth |
|--------|------|-------------|------|
{{#each endpoints}}
| {{method}} | {{path}} | {{description}} | {{auth}} |
{{/each}}

{{/each}}

## Authentication

### Methods
{{#each authMethods}}
- **{{name}}**: {{description}}
{{/each}}

### Session Management
- Type: {{sessionType}}
- Duration: {{sessionDuration}}
- Storage: {{sessionStorage}}

### Permission Levels

| Role | Permissions |
|------|-------------|
{{#each roles}}
| {{name}} | {{permissions}} |
{{/each}}

## Middleware Stack

| Order | Middleware | Purpose | Applies To |
|-------|-----------|---------|------------|
{{#each middleware}}
| {{order}} | {{name}} | {{purpose}} | {{appliesTo}} |
{{/each}}

## External Integrations

{{#each integrations}}
### {{name}}
- **Purpose:** {{purpose}}
- **SDK:** {{sdk}}
- **Config:** {{configLocation}}
- **Environment Variables:**
  {{#each envVars}}
  - `{{this}}`
  {{/each}}
{{/each}}

## Error Handling

### Error Codes
{{#each errorCodes}}
- `{{code}}`: {{description}}
{{/each}}

### Error Response Format
```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "details": {}
  }
}
```
```

**Generation Function:**

```javascript
function generateBackendStructureDoc(analysis) {
  const doc = {
    erd: generateERDiagram(analysis.database.schema),
    tables: analysis.database.schema.tables.map(table => ({
      name: table.name,
      fields: table.fields.map(field => ({
        name: field.name,
        type: field.type,
        constraints: formatConstraints(field.attributes),
        description: inferFieldDescription(field)
      })),
      relations: formatRelations(table, analysis.database.schema.relationships),
      indexes: formatIndexes(table, analysis.database.schema.indexes)
    })),
    resources: groupEndpointsByResource(analysis.features),
    authMethods: analysis.auth.providers.map(p => ({
      name: p,
      description: getAuthDescription(p)
    })),
    sessionType: analysis.auth.sessionType,
    roles: analysis.businessLogic.permissions.roles,
    middleware: analysis.middleware.map((m, i) => ({
      order: i + 1,
      name: m.name,
      purpose: m.purpose,
      appliesTo: m.appliesTo || 'All routes'
    })),
    integrations: analysis.externalAPIs.map(api => ({
      name: api.service,
      purpose: api.purpose,
      sdk: api.package,
      configLocation: api.configFile,
      envVars: api.envVars
    }))
  };

  return renderTemplate('BACKEND_STRUCTURE', doc);
}
```

---

### 3. FRONTEND_GUIDELINES.md

**Primary Source:** Code Analysis (100%)

```markdown
# Frontend Guidelines

## Overview

Frontend architecture and conventions for [Project Name].

## Project Structure

```
{{projectStructure}}
```

## Component Architecture

### Component Categories

| Category | Count | Purpose |
|----------|-------|---------|
| Pages | {{pages.count}} | Route-level components |
| Layouts | {{layouts.count}} | Page wrappers |
| Features | {{features.count}} | Domain-specific components |
| UI | {{ui.count}} | Reusable UI primitives |
| Utilities | {{utilities.count}} | Hooks and helpers |

### Component Naming

- **Pages:** PascalCase, matches route (e.g., `TasksPage`)
- **Features:** PascalCase, describes feature (e.g., `TaskList`, `TaskCard`)
- **UI:** PascalCase, generic name (e.g., `Button`, `Input`, `Modal`)

### File Structure

```
component-name/
  index.ts           # Exports
  ComponentName.tsx  # Main component
  ComponentName.types.ts  # TypeScript types
  ComponentName.test.tsx  # Tests (if applicable)
```

## State Management

### Global State
- **Library:** {{stateManagement.library}}
- **Pattern:** {{stateManagement.pattern}}

### Local State
- Use `useState` for component-local state
- Use `useReducer` for complex local state

### Server State
- **Library:** {{serverState.library}}
- **Pattern:** {{serverState.pattern}}

## Routing

### Route Structure

| Route | Page | Description |
|-------|------|-------------|
{{#each routes}}
| `{{path}}` | {{component}} | {{description}} |
{{/each}}

### Dynamic Routes
{{#each dynamicRoutes}}
- `{{path}}` - {{description}}
{{/each}}

## Data Fetching

### Pattern
{{dataFetchingPattern}}

### Example
```typescript
{{dataFetchingExample}}
```

## Forms

### Validation
- **Library:** {{forms.validation}}
- **Pattern:** {{forms.pattern}}

### Example
```typescript
{{formsExample}}
```

## Styling

### Approach
- **Framework:** {{styling.framework}}
- **Methodology:** {{styling.methodology}}

### Conventions
{{#each stylingConventions}}
- {{this}}
{{/each}}

## Component Catalog

### Pages ({{pages.count}})
{{#each pages.items}}
- `{{name}}` - {{file}}
{{/each}}

### Features ({{features.count}})
{{#each features.items}}
- `{{name}}` - {{file}}
{{/each}}

### UI Components ({{ui.count}})
{{#each ui.items}}
- `{{name}}` - {{file}}
{{/each}}

## Imports/Exports

### Path Aliases
```json
{{pathAliases}}
```

### Import Order
1. External packages
2. Internal aliases (@/)
3. Relative imports
4. Types
```

**Generation Function:**

```javascript
function generateFrontendGuidelinesDoc(analysis) {
  const doc = {
    projectStructure: generateProjectTree(analysis),
    pages: {
      count: analysis.techStack.components.pages.length,
      items: analysis.techStack.components.pages
    },
    layouts: {
      count: analysis.techStack.components.layouts?.length || 0,
      items: analysis.techStack.components.layouts || []
    },
    features: {
      count: analysis.techStack.components.features.length,
      items: analysis.techStack.components.features
    },
    ui: {
      count: analysis.techStack.components.ui.length,
      items: analysis.techStack.components.ui
    },
    utilities: {
      count: analysis.techStack.components.utilities.length,
      items: analysis.techStack.components.utilities
    },
    routes: formatRoutes(analysis.features),
    dynamicRoutes: analysis.features.routes?.filter(r => r.path.includes(':')),
    stateManagement: detectStateManagement(analysis),
    serverState: detectServerState(analysis),
    styling: {
      framework: analysis.techStack.styling?.name || 'CSS',
      methodology: analysis.techStack.styling?.methodology || 'Component-scoped'
    },
    forms: detectFormsLibrary(analysis),
    pathAliases: analysis.techStack.pathAliases || { '@/*': ['./src/*'] }
  };

  return renderTemplate('FRONTEND_GUIDELINES', doc);
}
```

---

### 4. DESIGN_SYSTEM.md

**Primary Source:** Code Analysis + Gap-Filling (enhanced)

```markdown
# Design System

## Overview

Design tokens and component patterns for [Project Name].

## Design Philosophy

{{designPhilosophy}}

### Inspirations
{{#each inspirations}}
- **{{name}}:** {{what}}
{{/each}}

## Colors

### Brand Palette

| Name | Value | Usage |
|------|-------|-------|
{{#each colors.brand}}
| {{name}} | `{{value}}` | {{usage}} |
{{/each}}

### Semantic Colors

| Name | Light | Dark | Usage |
|------|-------|------|-------|
{{#each colors.semantic}}
| {{name}} | `{{light}}` | `{{dark}}` | {{usage}} |
{{/each}}

### CSS Variables

```css
:root {
{{#each cssVariables}}
  {{this}}
{{/each}}
}
```

## Typography

### Font Family
- **Primary:** {{typography.primary}}
- **Monospace:** {{typography.monospace}}

### Font Sizes

| Name | Size | Line Height | Usage |
|------|------|-------------|-------|
{{#each typography.sizes}}
| {{name}} | {{size}} | {{lineHeight}} | {{usage}} |
{{/each}}

### Font Weights

| Name | Weight |
|------|--------|
{{#each typography.weights}}
| {{name}} | {{value}} |
{{/each}}

## Spacing

### Scale

| Name | Value | Usage |
|------|-------|-------|
{{#each spacing}}
| {{name}} | {{value}} | {{usage}} |
{{/each}}

### Base Unit
`{{spacingBase}}`

## Border Radius

| Name | Value | Usage |
|------|-------|-------|
{{#each borderRadius}}
| {{name}} | {{value}} | {{usage}} |
{{/each}}

## Shadows

| Name | Value | Usage |
|------|-------|-------|
{{#each shadows}}
| {{name}} | `{{value}}` | {{usage}} |
{{/each}}

## Breakpoints

| Name | Min Width | Max Width |
|------|-----------|-----------|
{{#each breakpoints}}
| {{name}} | {{min}} | {{max}} |
{{/each}}

## Component Patterns

### Buttons

```css
{{buttonPattern}}
```

### Inputs

```css
{{inputPattern}}
```

### Cards

```css
{{cardPattern}}
```

## Accessibility

### Requirements
{{#each accessibility}}
- {{this}}
{{/each}}

### Color Contrast
All text must meet WCAG {{wcagLevel}} contrast requirements.

## Implementation

### Tailwind Config
```javascript
{{tailwindConfig}}
```

### CSS Variables
```css
{{cssVariablesBlock}}
```
```

**Generation Function (with gap-filling enhancement):**

```javascript
function generateDesignSystemDoc(analysis, gapFilling = null) {
  const doc = {
    // From code analysis
    colors: {
      brand: formatBrandColors(analysis.design.colors),
      semantic: inferSemanticColors(analysis.design.colors)
    },
    cssVariables: generateCSSVariables(analysis.design),
    typography: analysis.design.typography,
    spacing: analysis.design.spacing,
    borderRadius: analysis.design.borderRadius,
    shadows: analysis.design.shadows,
    breakpoints: analysis.design.breakpoints || defaultBreakpoints(),
    tailwindConfig: analysis.design.tailwindConfig,

    // From gap-filling (if available)
    designPhilosophy: gapFilling?.design?.philosophy ||
      'Clean, modern interface with focus on usability',
    inspirations: gapFilling?.design?.inspirations?.map(i => ({
      name: i,
      what: 'Design language and patterns'
    })) || [],
    accessibility: gapFilling?.design?.accessibility ?
      [`WCAG ${gapFilling.design.accessibility}`, 'Keyboard navigation', 'Screen reader support'] :
      ['Basic accessibility'],
    wcagLevel: gapFilling?.design?.accessibility || 'AA'
  };

  return renderTemplate('DESIGN_SYSTEM', doc);
}

// Enhanced version after gap-filling
function enhanceDesignSystemDoc(originalDoc, gapFilling) {
  // Add design philosophy section
  const philosophySection = `
## Design Philosophy

${gapFilling.design.philosophy}

### Inspirations
${gapFilling.design.inspirations.map(i => `- **${i}**`).join('\n')}
`;

  // Insert after Overview
  return insertSection(originalDoc, philosophySection, 'after', '## Overview');
}
```

---

### 5. APP_FLOW.md

**Primary Source:** Code Analysis + Gap-Filling (enhanced)

```markdown
# App Flow

## Overview

User journeys and navigation flows for [Project Name].

## User Personas

{{#each personas}}
### {{name}}
- **Role:** {{role}}
- **Tech Level:** {{techLevel}}
- **Primary Device:** {{device}}
- **Usage:** {{usageFrequency}}
{{/each}}

## Core User Journeys

{{#each journeys}}
### {{name}}

**Persona:** {{persona}}
**Goal:** {{goal}}

```
{{flow}}
```

**Steps:**
{{#each steps}}
{{stepNumber}}. {{description}}
   - Route: `{{route}}`
   - Actions: {{actions}}
{{/each}}

{{/each}}

## Navigation Structure

### Main Navigation
{{#each mainNav}}
- **{{label}}** (`{{route}}`) - {{description}}
{{/each}}

### Site Map

```
{{siteMap}}
```

## Screen Inventory

| Screen | Route | Purpose | Components |
|--------|-------|---------|------------|
{{#each screens}}
| {{name}} | `{{route}}` | {{purpose}} | {{components}} |
{{/each}}

## State Transitions

### Authentication States
```
{{authStateFlow}}
```

### Feature States
{{#each featureStates}}
#### {{feature}}
```
{{stateFlow}}
```
{{/each}}

## Entry Points

{{#each entryPoints}}
- **{{name}}:** {{description}} -> `{{route}}`
{{/each}}

## Error States

| Screen | Error Condition | Display | Recovery |
|--------|-----------------|---------|----------|
{{#each errorStates}}
| {{screen}} | {{condition}} | {{display}} | {{recovery}} |
{{/each}}
```

**Generation Function (with gap-filling enhancement):**

```javascript
function generateAppFlowDoc(analysis, gapFilling = null) {
  const doc = {
    // From code analysis
    screens: analysis.features.routes.map(route => ({
      name: inferScreenName(route.path),
      route: route.path,
      purpose: inferPurpose(route),
      components: route.components?.join(', ') || 'TBD'
    })),
    mainNav: extractMainNavigation(analysis.features),
    siteMap: generateSiteMap(analysis.features.routes),
    authStateFlow: generateAuthFlow(analysis.auth),
    featureStates: generateFeatureStates(analysis.features),
    entryPoints: identifyEntryPoints(analysis.features.routes),

    // From gap-filling (if available)
    personas: gapFilling ? [
      {
        name: gapFilling.users.primary.name,
        role: gapFilling.users.primary.role,
        techLevel: gapFilling.users.primary.techLevel,
        device: gapFilling.users.primary.device,
        usageFrequency: gapFilling.users.primary.usageFrequency
      },
      ...(gapFilling.users.secondary || [])
    ] : [{ name: 'Primary User', role: 'User' }],

    journeys: gapFilling ?
      generateJourneys(analysis.features, gapFilling.users) :
      inferJourneys(analysis.features)
  };

  return renderTemplate('APP_FLOW', doc);
}

function enhanceAppFlowDoc(originalDoc, gapFilling) {
  // Add persona details
  // Add journey goals and context
  // Add user-specific flows
  return enhancedDoc;
}
```

---

### 6. PRD.md (Requires Gap-Filling)

**Primary Source:** Gap-Filling + Code Analysis

```markdown
# Product Requirements Document

## Overview

### Product Name
{{productName}}

### One-Liner
{{oneLiner}}

### Problem Statement
{{problemStatement}}

## Target Users

### Primary Persona: {{primaryPersona.name}}
- **Role:** {{primaryPersona.role}}
- **Pain Points:**
{{#each primaryPersona.painPoints}}
  - {{this}}
{{/each}}
- **Goals:**
{{#each primaryPersona.goals}}
  - {{this}}
{{/each}}

### Secondary Personas
{{#each secondaryPersonas}}
- **{{name}}:** {{description}}
{{/each}}

## Features

### Core Features (Must Have)

{{#each coreFeatures}}
#### F{{id}}: {{name}}

**Priority:** {{priority}}
**Status:** {{status}}

**Description:**
{{description}}

**Acceptance Criteria:**
{{#each acceptanceCriteria}}
- [ ] {{this}}
{{/each}}

**Technical Notes:**
{{technicalNotes}}

{{/each}}

### Nice-to-Have Features

{{#each niceToHaveFeatures}}
#### F{{id}}: {{name}}
{{description}}
{{/each}}

## Success Metrics

| Metric | Target | Timeframe |
|--------|--------|-----------|
{{#each successMetrics}}
| {{metric}} | {{target}} | {{timeframe}} |
{{/each}}

## Technical Requirements

### Platform
{{platform}}

### Tech Stack
{{techStackSummary}}

### Performance Requirements
{{#each performanceRequirements}}
- {{this}}
{{/each}}

### Security Requirements
{{#each securityRequirements}}
- {{this}}
{{/each}}

## Out of Scope

{{#each outOfScope}}
- {{this}}
{{/each}}

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
{{#each risks}}
| {{risk}} | {{likelihood}} | {{impact}} | {{mitigation}} |
{{/each}}

## Timeline

### Phase 1: MVP
{{mvpTimeline}}

### Phase 2: Enhancement
{{phase2Timeline}}

## Appendix

### Glossary
{{#each glossary}}
- **{{term}}:** {{definition}}
{{/each}}

### References
{{#each references}}
- {{this}}
{{/each}}
```

**Generation Function:**

```javascript
function generatePRDDoc(analysis, gapFilling) {
  const doc = {
    // From gap-filling
    productName: inferProductName(analysis) || 'Product Name',
    oneLiner: gapFilling.problem.statement,
    problemStatement: formatProblemStatement(gapFilling.problem),

    primaryPersona: {
      name: gapFilling.users.primary.name,
      role: gapFilling.users.primary.role,
      painPoints: gapFilling.problem.painPoints,
      goals: inferUserGoals(gapFilling)
    },
    secondaryPersonas: gapFilling.users.secondary || [],

    // Combine code analysis + gap-filling
    coreFeatures: gapFilling.featurePriorities
      .filter(f => f.priority <= 2)
      .map((f, i) => ({
        id: i + 1,
        name: f.feature,
        priority: f.priority === 1 ? 'P0' : 'P1',
        status: 'Implemented',
        description: getFeatureDescription(f.feature, analysis.features),
        acceptanceCriteria: inferAcceptanceCriteria(f.feature, analysis.features),
        technicalNotes: getFeatureTechNotes(f.feature, analysis)
      })),

    niceToHaveFeatures: gapFilling.featurePriorities
      .filter(f => f.priority > 2)
      .map((f, i) => ({
        id: 100 + i + 1,
        name: f.feature,
        description: f.rationale
      })),

    successMetrics: gapFilling.businessGoals.successMetrics,

    // From code analysis
    platform: inferPlatform(analysis.techStack),
    techStackSummary: summarizeTechStack(analysis.techStack),
    performanceRequirements: inferPerformanceReqs(analysis),
    securityRequirements: inferSecurityReqs(analysis),

    // From gap-filling
    outOfScope: gapFilling.roadmap.outOfScope,
    risks: inferRisks(gapFilling, analysis),
    mvpTimeline: 'Current implementation',
    phase2Timeline: gapFilling.roadmap.planned.join(', ')
  };

  return renderTemplate('PRD', doc);
}
```

---

### 7. IMPLEMENTATION_PLAN.md

**Primary Source:** Gap-Filling (roadmap) + Code Analysis

```markdown
# Implementation Plan

## Overview

Phased implementation plan for [Project Name].

## Current State

### Implemented Features
{{#each implementedFeatures}}
- [x] **{{name}}** - {{status}}
{{/each}}

### Technical Foundation
- Framework: {{framework}}
- Database: {{database}}
- Auth: {{auth}}

## Roadmap

### Phase 1: {{phase1.name}} (Current)
**Status:** {{phase1.status}}

{{#each phase1.features}}
- [{{status}}] {{name}}
{{/each}}

### Phase 2: {{phase2.name}}
**Target:** {{phase2.target}}

{{#each phase2.features}}
#### {{name}}

**Priority:** {{priority}}
**Complexity:** {{complexity}}

**Requirements:**
{{#each requirements}}
- {{this}}
{{/each}}

**Technical Approach:**
{{technicalApproach}}

**Dependencies:**
{{#each dependencies}}
- {{this}}
{{/each}}

{{/each}}

### Phase 3: {{phase3.name}}
**Target:** {{phase3.target}}

{{#each phase3.features}}
- {{name}}: {{description}}
{{/each}}

## Technical Debt

### Current Debt
{{#each technicalDebt}}
- **{{area}}:** {{description}} (Priority: {{priority}})
{{/each}}

### Planned Improvements
{{#each improvements}}
- {{this}}
{{/each}}

## Dependencies

### External
{{#each externalDependencies}}
- {{name}}: {{reason}}
{{/each}}

### Internal
{{#each internalDependencies}}
- {{from}} requires {{to}}
{{/each}}

## Risk Assessment

| Phase | Risk | Mitigation |
|-------|------|------------|
{{#each risks}}
| {{phase}} | {{risk}} | {{mitigation}} |
{{/each}}
```

**Generation Function:**

```javascript
function generateImplementationPlanDoc(analysis, gapFilling) {
  const doc = {
    implementedFeatures: Object.entries(analysis.features).map(([name, data]) => ({
      name: formatFeatureName(name),
      status: 'Complete'
    })),

    framework: analysis.techStack.framework.name,
    database: `${analysis.database.type} via ${analysis.database.orm}`,
    auth: analysis.auth.library,

    phase1: {
      name: 'Current Implementation',
      status: 'Complete',
      features: Object.keys(analysis.features).map(f => ({
        name: formatFeatureName(f),
        status: 'x'
      }))
    },

    phase2: {
      name: 'Next Release',
      target: gapFilling.businessGoals.successMetrics[0]?.timeframe || 'TBD',
      features: gapFilling.roadmap.planned.slice(0, 3).map(feature => ({
        name: feature,
        priority: 'P1',
        complexity: 'Medium',
        requirements: inferRequirements(feature),
        technicalApproach: inferApproach(feature, analysis),
        dependencies: inferDependencies(feature, analysis)
      }))
    },

    phase3: {
      name: 'Future',
      target: 'TBD',
      features: gapFilling.roadmap.planned.slice(3).map(f => ({
        name: f,
        description: 'Planned for future release'
      }))
    },

    technicalDebt: inferTechnicalDebt(analysis),
    improvements: gapFilling.database.plannedChanges ?
      [gapFilling.database.plannedChanges] : [],
    externalDependencies: analysis.externalAPIs.map(api => ({
      name: api.service,
      reason: api.purpose
    }))
  };

  return renderTemplate('IMPLEMENTATION_PLAN', doc);
}
```

---

### 8. CLAUDE.md

**Primary Source:** Code Analysis + Gap-Filling

```markdown
# Project-Specific Rules for Claude

## Project Context

{{projectContext}}

## Tech Stack Rules

### Framework: {{framework}}
{{#each frameworkRules}}
- {{this}}
{{/each}}

### Database: {{database}}
{{#each databaseRules}}
- {{this}}
{{/each}}

### Styling: {{styling}}
{{#each stylingRules}}
- {{this}}
{{/each}}

## Coding Conventions

### File Naming
{{#each fileNaming}}
- {{this}}
{{/each}}

### Component Structure
{{componentStructure}}

### Import Order
{{importOrder}}

## Feature Implementation

### When adding a new feature:
{{#each featureSteps}}
{{@index}}. {{this}}
{{/each}}

### When modifying existing features:
{{#each modifySteps}}
{{@index}}. {{this}}
{{/each}}

## Database Changes

### When modifying schema:
{{#each schemaSteps}}
{{@index}}. {{this}}
{{/each}}

## Testing Requirements

{{#each testingRules}}
- {{this}}
{{/each}}

## Do NOT

{{#each doNot}}
- {{this}}
{{/each}}

## Business Context

### Problem Being Solved
{{problemStatement}}

### Primary Users
{{primaryUsers}}

### Success Metrics
{{successMetrics}}
```

**Generation Function:**

```javascript
function generateClaudeMdDoc(analysis, gapFilling) {
  const doc = {
    projectContext: `${gapFilling.problem.statement} Built with ${analysis.techStack.framework.name}.`,

    framework: analysis.techStack.framework.name,
    frameworkRules: getFrameworkRules(analysis.techStack.framework.name),

    database: `${analysis.database.type} via ${analysis.database.orm}`,
    databaseRules: getDatabaseRules(analysis.database.orm),

    styling: analysis.techStack.styling?.name || 'CSS',
    stylingRules: getStylingRules(analysis.techStack.styling?.name),

    fileNaming: inferFileNamingConventions(analysis),
    componentStructure: inferComponentStructure(analysis),
    importOrder: '1. External packages\n2. Internal aliases (@/)\n3. Relative imports\n4. Types',

    featureSteps: [
      'Create feature branch',
      `Add route in ${analysis.techStack.framework.router === 'app' ? 'app/' : 'pages/'}`,
      'Create component files',
      'Add API endpoint if needed',
      'Update types',
      'Write tests',
      'Update documentation'
    ],

    modifySteps: [
      'Read existing implementation first',
      'Check for related components',
      'Maintain existing patterns',
      'Update tests'
    ],

    schemaSteps: [
      'Create migration file',
      'Update Prisma schema',
      'Run prisma generate',
      'Update types',
      'Test migration'
    ],

    testingRules: getTestingRules(analysis.techStack.testing),

    doNot: [
      'Skip type definitions',
      'Commit without running tests',
      'Change auth without security review',
      'Add dependencies without justification'
    ],

    problemStatement: gapFilling.problem.statement,
    primaryUsers: gapFilling.users.primary.role,
    successMetrics: gapFilling.businessGoals.successMetrics
      .map(m => `${m.metric}: ${m.target}`)
      .join(', ')
  };

  return renderTemplate('CLAUDE', doc);
}
```

---

## Generation Order

### Phase 1: Technical Docs (From Code Only)

Generate these immediately after code analysis, before gap-filling:

1. **TECH_STACK.md** - Pure code analysis
2. **BACKEND_STRUCTURE.md** - Pure code analysis
3. **FRONTEND_GUIDELINES.md** - Pure code analysis
4. **DESIGN_SYSTEM.md** (partial) - Code analysis, enhanced later
5. **APP_FLOW.md** (partial) - Code analysis, enhanced later

### Phase 2: Complete Docs (After Gap-Filling)

Generate these after gap-filling interrogation:

6. **PRD.md** - Gap-filling + code analysis
7. **DESIGN_SYSTEM.md** (enhanced) - Add rationale
8. **APP_FLOW.md** (enhanced) - Add personas and journeys
9. **IMPLEMENTATION_PLAN.md** - Gap-filling roadmap + code analysis
10. **CLAUDE.md** - Code analysis + gap-filling context

### Approval Flow

Each document follows:
1. Generate document
2. Show to user
3. Wait for approval or feedback
4. Save if approved, or regenerate with feedback
5. Move to next document
