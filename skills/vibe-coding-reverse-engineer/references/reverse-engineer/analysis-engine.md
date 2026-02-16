# Analysis Engine - Core Codebase Analysis Algorithms

This file contains the framework-agnostic analysis algorithms for reverse-engineering existing codebases. The analysis engine systematically examines codebases across 8 critical areas to generate comprehensive technical documentation.

## Table of Contents

1. [Overview](#overview)
2. [Analysis Areas](#analysis-areas)
3. [Confidence Scoring System](#confidence-scoring-system)
4. [Analysis Workflow](#analysis-workflow)
5. [Area-Specific Algorithms](#area-specific-algorithms)
6. [Output Format Specifications](#output-format-specifications)

---

## Overview

### Purpose

The analysis engine provides systematic codebase examination to extract technical information that can be converted into documentation. It operates in two phases:

**Phase 1: Quick Scan (2-3 minutes)**
- Detect framework and language
- Identify primary dependencies
- Count files and estimate scope
- Locate critical config files

**Phase 2: Deep Analysis (5-20 minutes)**
- Extract detailed information across 8 areas
- Build feature inventory
- Map data structures and relationships
- Document architecture and patterns

### Framework-Agnostic Approach

All algorithms use:
- **Glob patterns** for file discovery
- **Regex patterns** for content extraction
- **Config file parsing** for settings detection
- **Confidence scoring** for uncertain detections

Framework-specific details are delegated to `code-detectors.md`.

---

## Analysis Areas

### 1. Features & Functionality
**What:** User-facing capabilities, workflows, CRUD operations
**Output:** Feature list with routes, files, operations

### 2. Technical Architecture
**What:** Tech stack, frameworks, libraries, component structure
**Output:** Stack inventory with versions and relationships

### 3. Business Logic
**What:** Validation rules, permissions, state transitions, business rules
**Output:** Rules matrix, permission system, validation schemas

### 4. UX & Design Patterns
**What:** Brand colors, typography, spacing, component patterns, interactions
**Output:** Design system tokens and component catalog

### 5. Database
**What:** Schema, tables, fields, relationships, migrations, health
**Output:** ERD, schema documentation, recommendations

### 6. Auth Functionality
**What:** Authentication methods, session management, security measures
**Output:** Auth methods list, security checklist, recommendations

### 7. External APIs
**What:** Third-party services, integrations, API clients
**Output:** Service inventory with purpose and configuration

### 8. Middleware
**What:** Middleware stack (auth, logging, errors, rate limiting, CORS)
**Output:** Middleware list with execution order and purpose

---

## Confidence Scoring System

Every detection is tagged with a confidence level to ensure accuracy.

### Confidence Levels

**HIGH (95-100%)** - Definitive evidence
- Package.json lists exact version
- Config file explicitly declares framework
- Multiple corroborating indicators

**MEDIUM (70-94%)** - Strong evidence but some ambiguity
- Detected from file patterns but version unclear
- Library present but configuration not found
- Indirect indicators only

**LOW (<70%)** - Weak evidence, likely guessing
- Build artifacts suggest framework but no config
- Commented out code or dead imports
- Conflicting indicators

### Calculation Method

```
confidence = (detected_indicators / total_possible_indicators) * 100

Examples:
- package.json has "next": "14.0.0" → 1 indicator
- next.config.js exists → +1 indicator
- app/ directory exists → +1 indicator
- Total possible: 3 indicators
- Confidence: 3/3 * 100 = 100% (HIGH)
```

### User Verification Protocol

After analysis, show summary with confidence tags:

```
DETECTED CONFIGURATION:
✓ Framework: Next.js 14.0.0 (HIGH - 100%)
✓ Database: PostgreSQL via Prisma (HIGH - 95%)
⚠ Auth: NextAuth (MEDIUM - 75% - version unclear)
⚠ Frontend State: Zustand (LOW - 60% - found imports but no usage)

Please verify these detections before I generate docs.
```

User can accept or correct before proceeding.

---

## Analysis Workflow

### Entry Point: `analyzeCodebase()`

```
function analyzeCodebase(projectPath) {
  const analysis = {
    quickScan: {},
    deepAnalysis: {},
    confidence: {},
    recommendations: []
  };

  // Phase 1: Quick Scan
  analysis.quickScan = performQuickScan(projectPath);
  showProgress("Quick scan complete");

  // Phase 2: Deep Analysis (8 areas)
  analysis.deepAnalysis.features = analyzeFeaturesAndFunctionality(projectPath);
  showProgress("Features analyzed");

  analysis.deepAnalysis.techStack = analyzeTechnicalArchitecture(projectPath);
  showProgress("Tech stack analyzed");

  analysis.deepAnalysis.businessLogic = analyzeBusinessLogic(projectPath);
  showProgress("Business logic analyzed");

  analysis.deepAnalysis.design = analyzeUXAndDesign(projectPath);
  showProgress("Design system analyzed");

  analysis.deepAnalysis.database = analyzeDatabase(projectPath);
  showProgress("Database analyzed");

  analysis.deepAnalysis.auth = analyzeAuth(projectPath);
  showProgress("Auth analyzed");

  analysis.deepAnalysis.externalAPIs = analyzeExternalAPIs(projectPath);
  showProgress("External APIs analyzed");

  analysis.deepAnalysis.middleware = analyzeMiddleware(projectPath);
  showProgress("Middleware analyzed");

  // Calculate confidence scores
  analysis.confidence = calculateConfidenceScores(analysis);

  // Generate recommendations
  analysis.recommendations = generateRecommendations(analysis);

  return analysis;
}
```

### Progress Tracking

For large codebases (100+ files), show real-time progress:

```
Analyzing codebase... (487 files detected)

[=====>              ] 30% | ETA: 12 minutes

Current: Feature detection (analyzing routes)
✓ Quick scan (2m 15s)
⊙ Feature detection (5m 30s) - 142/487 files
  Pending: Database, Auth, Middleware, External APIs
```

---

## Area-Specific Algorithms

### 1. Features & Functionality Analysis

**Goal:** Identify all user-facing features and operations

#### Algorithm: `analyzeFeaturesAndFunctionality()`

```javascript
function analyzeFeaturesAndFunctionality(projectPath) {
  const features = {};

  // Step 1: Find all route files
  const routePatterns = [
    'pages/**/*.{js,jsx,ts,tsx}',       // Next.js pages router
    'app/**/page.{js,jsx,ts,tsx}',      // Next.js app router
    'app/**/route.{js,ts}',             // Next.js API routes
    'src/routes/**/*.{js,jsx,ts,tsx}',  // React Router
    'src/pages/**/*.{vue}',             // Vue Router
    'views/**/*.py',                     // Django views
    'app/controllers/**/*.rb',           // Rails controllers
    'routes/**/*.{js,ts}',               // Express routes
  ];

  const routeFiles = glob(routePatterns, { cwd: projectPath });

  // Step 2: Analyze each route file
  for (const file of routeFiles) {
    const content = read(file);
    const path = extractRoutePath(file);
    const resource = extractResource(path);

    // Detect CRUD operations
    const operations = detectOperations(content);

    // Detect form submissions
    const forms = detectForms(content);

    // Detect API calls
    const apiCalls = detectAPICall(content);

    if (!features[resource]) {
      features[resource] = {
        name: resource,
        routes: [],
        operations: new Set(),
        files: [],
        forms: [],
        apiEndpoints: [],
        confidence: 0
      };
    }

    features[resource].routes.push(path);
    features[resource].files.push(file);
    features[resource].operations = operations;
    features[resource].forms.push(...forms);
    features[resource].apiEndpoints.push(...apiCalls);
  }

  // Step 3: Find API endpoints
  const apiPatterns = [
    'pages/api/**/*.{js,ts}',           // Next.js
    'app/api/**/*.{js,ts}',             // Next.js app router
    'api/**/*.{js,ts}',                  // Express
    '**/views.py',                       // Django
    'app/controllers/**/*.rb'            // Rails
  ];

  const apiFiles = glob(apiPatterns, { cwd: projectPath });

  for (const file of apiFiles) {
    const content = read(file);
    const endpoints = extractAPIEndpoints(content, file);

    for (const endpoint of endpoints) {
      const resource = endpoint.resource;

      if (!features[resource]) {
        features[resource] = {
          name: resource,
          routes: [],
          operations: new Set(),
          files: [],
          apiEndpoints: []
        };
      }

      features[resource].apiEndpoints.push(endpoint);
      features[resource].operations.add(endpoint.method);
    }
  }

  // Step 4: Calculate confidence for each feature
  for (const feature of Object.values(features)) {
    feature.confidence = calculateFeatureConfidence(feature);
    feature.operations = Array.from(feature.operations);
  }

  return features;
}

function detectOperations(content) {
  const operations = new Set();

  // Create operation
  if (/\b(useState|form|onSubmit|handleSubmit|POST)\b/i.test(content)) {
    operations.add('CREATE');
  }

  // Read operation
  if (/\b(useQuery|fetch|getServerSideProps|GET|useEffect)\b/i.test(content)) {
    operations.add('READ');
  }

  // Update operation
  if (/\b(mutation|PATCH|PUT|update|edit)\b/i.test(content)) {
    operations.add('UPDATE');
  }

  // Delete operation
  if (/\b(DELETE|remove|destroy|delete)\b/i.test(content)) {
    operations.add('DELETE');
  }

  return operations;
}

function extractRoutePath(filePath) {
  // Next.js pages router: pages/tasks/[id].tsx → /tasks/:id
  // Next.js app router: app/tasks/[id]/page.tsx → /tasks/:id
  // Express: routes/tasks.js → /tasks
  // Django: urls.py patterns

  let path = filePath
    .replace(/^(pages|app|routes|views)\//, '/')
    .replace(/\/(page|route|index)\.(js|jsx|ts|tsx)$/, '')
    .replace(/\[([^\]]+)\]/g, ':$1')  // [id] → :id
    .replace(/\/+$/, '') || '/';

  return path;
}

function extractResource(path) {
  // /tasks/:id → tasks
  // /api/users/profile → users
  const parts = path.split('/').filter(p => p && !p.startsWith(':'));
  return parts[parts.length - 1] || 'root';
}

function calculateFeatureConfidence(feature) {
  let score = 0;
  let maxScore = 5;

  // Has routes
  if (feature.routes.length > 0) score += 1;

  // Has API endpoints
  if (feature.apiEndpoints.length > 0) score += 1;

  // Has CRUD operations
  if (feature.operations.length >= 2) score += 1;

  // Has forms
  if (feature.forms.length > 0) score += 1;

  // Multiple files (indicates significant feature)
  if (feature.files.length >= 2) score += 1;

  return (score / maxScore) * 100;
}
```

**Output Example:**

```javascript
{
  "tasks": {
    "name": "tasks",
    "routes": ["/tasks", "/tasks/:id", "/tasks/new"],
    "operations": ["CREATE", "READ", "UPDATE", "DELETE"],
    "files": [
      "pages/tasks/index.tsx",
      "pages/tasks/[id].tsx",
      "pages/tasks/new.tsx"
    ],
    "forms": [
      { type: "create", fields: ["title", "description", "dueDate"] },
      { type: "edit", fields: ["title", "description", "status", "dueDate"] }
    ],
    "apiEndpoints": [
      { method: "GET", path: "/api/tasks", file: "pages/api/tasks/index.ts" },
      { method: "POST", path: "/api/tasks", file: "pages/api/tasks/index.ts" },
      { method: "PATCH", path: "/api/tasks/:id", file: "pages/api/tasks/[id].ts" }
    ],
    "confidence": 100
  }
}
```

---

### 2. Technical Architecture Analysis

**Goal:** Identify tech stack, frameworks, libraries, and component structure

#### Algorithm: `analyzeTechnicalArchitecture()`

```javascript
function analyzeTechnicalArchitecture(projectPath) {
  const architecture = {
    framework: null,
    language: null,
    runtime: null,
    packageManager: null,
    dependencies: {},
    devDependencies: {},
    components: {
      pages: [],
      layouts: [],
      features: [],
      ui: [],
      utilities: []
    },
    buildTools: [],
    testing: [],
    linting: [],
    confidence: {}
  };

  // Step 1: Read package.json
  const packageJson = readPackageJson(projectPath);

  if (packageJson) {
    architecture.dependencies = packageJson.dependencies || {};
    architecture.devDependencies = packageJson.devDependencies || {};

    // Detect framework
    const frameworkDetection = detectFramework(packageJson);
    architecture.framework = frameworkDetection.name;
    architecture.confidence.framework = frameworkDetection.confidence;

    // Detect language
    architecture.language = detectLanguage(packageJson, projectPath);

    // Detect package manager
    architecture.packageManager = detectPackageManager(projectPath);

    // Detect build tools
    architecture.buildTools = detectBuildTools(packageJson);

    // Detect testing framework
    architecture.testing = detectTestingFramework(packageJson);

    // Detect linting tools
    architecture.linting = detectLintingTools(packageJson);
  }

  // Step 2: Detect runtime
  architecture.runtime = detectRuntime(projectPath);

  // Step 3: Catalog components
  architecture.components = catalogComponents(projectPath, architecture.framework);

  return architecture;
}

function detectFramework(packageJson) {
  const deps = { ...packageJson.dependencies, ...packageJson.devDependencies };

  // Priority order for framework detection
  const frameworks = [
    { name: 'Next.js', keys: ['next'], confidence: 100 },
    { name: 'Nuxt', keys: ['nuxt'], confidence: 100 },
    { name: 'Remix', keys: ['@remix-run/react'], confidence: 100 },
    { name: 'React', keys: ['react'], confidence: 90 },
    { name: 'Vue', keys: ['vue'], confidence: 90 },
    { name: 'Svelte', keys: ['svelte'], confidence: 90 },
    { name: 'Express', keys: ['express'], confidence: 90 },
    { name: 'NestJS', keys: ['@nestjs/core'], confidence: 100 },
    { name: 'Fastify', keys: ['fastify'], confidence: 90 }
  ];

  for (const framework of frameworks) {
    const found = framework.keys.find(key => deps[key]);
    if (found) {
      const version = deps[found];
      return {
        name: framework.name,
        version: version,
        package: found,
        confidence: framework.confidence
      };
    }
  }

  return { name: 'Unknown', confidence: 0 };
}

function detectLanguage(packageJson, projectPath) {
  const deps = { ...packageJson.dependencies, ...packageJson.devDependencies };

  // Check for TypeScript
  if (deps['typescript'] || exists(join(projectPath, 'tsconfig.json'))) {
    return 'TypeScript';
  }

  // Check for JavaScript
  if (exists(join(projectPath, 'package.json'))) {
    return 'JavaScript';
  }

  return 'Unknown';
}

function catalogComponents(projectPath, framework) {
  const components = {
    pages: [],
    layouts: [],
    features: [],
    ui: [],
    utilities: []
  };

  // Find component files
  const componentPatterns = [
    'components/**/*.{js,jsx,ts,tsx,vue,svelte}',
    'src/components/**/*.{js,jsx,ts,tsx,vue,svelte}',
    'app/components/**/*.{js,jsx,ts,tsx}'
  ];

  const componentFiles = glob(componentPatterns, { cwd: projectPath });

  for (const file of componentFiles) {
    const content = read(file);
    const name = extractComponentName(file);
    const type = classifyComponent(file, content);

    const component = {
      name,
      file,
      type,
      props: extractProps(content),
      exports: extractExports(content)
    };

    components[type].push(component);
  }

  return components;
}

function classifyComponent(file, content) {
  const fileLower = file.toLowerCase();

  // Layouts
  if (fileLower.includes('layout') || fileLower.includes('template')) {
    return 'layouts';
  }

  // Pages (if in components dir, typically page-level components)
  if (fileLower.includes('page') || fileLower.includes('screen')) {
    return 'pages';
  }

  // UI components (buttons, inputs, cards, etc.)
  const uiPatterns = /button|input|select|card|modal|dialog|alert|badge|avatar/i;
  if (uiPatterns.test(file)) {
    return 'ui';
  }

  // Utilities (hooks, helpers, etc.)
  if (fileLower.includes('hook') || fileLower.includes('util') || fileLower.includes('helper')) {
    return 'utilities';
  }

  // Feature components (domain-specific)
  return 'features';
}
```

**Output Example:**

```javascript
{
  "framework": {
    "name": "Next.js",
    "version": "14.0.0",
    "package": "next",
    "confidence": 100
  },
  "language": "TypeScript",
  "runtime": "Node.js 18.17.0",
  "packageManager": "npm",
  "dependencies": {
    "next": "14.0.0",
    "react": "18.2.0",
    "prisma": "5.0.0",
    "@prisma/client": "5.0.0"
  },
  "components": {
    "pages": [
      { "name": "Dashboard", "file": "components/Dashboard.tsx" }
    ],
    "layouts": [
      { "name": "MainLayout", "file": "components/layouts/MainLayout.tsx" }
    ],
    "features": [
      { "name": "TaskList", "file": "components/tasks/TaskList.tsx" },
      { "name": "TaskCard", "file": "components/tasks/TaskCard.tsx" }
    ],
    "ui": [
      { "name": "Button", "file": "components/ui/Button.tsx" },
      { "name": "Input", "file": "components/ui/Input.tsx" }
    ],
    "utilities": [
      { "name": "useAuth", "file": "components/hooks/useAuth.ts" }
    ]
  },
  "buildTools": ["webpack", "babel"],
  "testing": ["jest", "react-testing-library"],
  "linting": ["eslint", "prettier"]
}
```

---

### 3. Business Logic Analysis

**Goal:** Extract validation rules, permissions, state machines, business rules

#### Algorithm: `analyzeBusinessLogic()`

```javascript
function analyzeBusinessLogic(projectPath) {
  const logic = {
    validation: {
      schemas: [],
      rules: []
    },
    permissions: {
      roles: [],
      rules: []
    },
    stateMachines: [],
    businessRules: [],
    confidence: {}
  };

  // Step 1: Find validation schemas
  logic.validation = findValidationSchemas(projectPath);

  // Step 2: Find permission/auth logic
  logic.permissions = findPermissionLogic(projectPath);

  // Step 3: Find state machines
  logic.stateMachines = findStateMachines(projectPath);

  // Step 4: Extract business rules
  logic.businessRules = extractBusinessRules(projectPath);

  return logic;
}

function findValidationSchemas(projectPath) {
  const validation = {
    schemas: [],
    library: null,
    confidence: 0
  };

  // Check for validation libraries
  const packageJson = readPackageJson(projectPath);
  const deps = { ...packageJson.dependencies, ...packageJson.devDependencies };

  if (deps['zod']) {
    validation.library = 'Zod';
    validation.schemas = findZodSchemas(projectPath);
    validation.confidence = 95;
  } else if (deps['yup']) {
    validation.library = 'Yup';
    validation.schemas = findYupSchemas(projectPath);
    validation.confidence = 95;
  } else if (deps['joi']) {
    validation.library = 'Joi';
    validation.schemas = findJoiSchemas(projectPath);
    validation.confidence = 95;
  } else {
    // Look for manual validation
    validation.schemas = findManualValidation(projectPath);
    validation.confidence = 60;
  }

  return validation;
}

function findZodSchemas(projectPath) {
  const schemas = [];

  // Find files with Zod imports
  const files = grep(/import.*zod/, projectPath);

  for (const file of files) {
    const content = read(file);

    // Extract Zod schemas: z.object({...})
    const schemaMatches = content.matchAll(/(\w+)\s*=\s*z\.object\({([^}]+)}/g);

    for (const match of schemaMatches) {
      const schemaName = match[1];
      const fields = match[2];

      schemas.push({
        name: schemaName,
        file,
        fields: parseZodFields(fields),
        library: 'Zod'
      });
    }
  }

  return schemas;
}

function findPermissionLogic(projectPath) {
  const permissions = {
    roles: new Set(),
    rules: [],
    middleware: [],
    confidence: 0
  };

  // Find role definitions
  const rolePatterns = [
    /role:\s*['"](\w+)['"]/gi,
    /roles?\s*=\s*\[([^\]]+)\]/gi,
    /enum.*Role.*{([^}]+)}/gi
  ];

  const files = glob('**/*.{js,ts,jsx,tsx,py,rb}', { cwd: projectPath });

  for (const file of files) {
    const content = read(file);

    for (const pattern of rolePatterns) {
      const matches = content.matchAll(pattern);
      for (const match of matches) {
        const roles = match[1].split(',').map(r => r.trim().replace(/['"]/g, ''));
        roles.forEach(role => permissions.roles.add(role));
      }
    }

    // Find permission checks
    const permissionChecks = findPermissionChecks(content);
    permissions.rules.push(...permissionChecks.map(check => ({ ...check, file })));
  }

  permissions.roles = Array.from(permissions.roles);
  permissions.confidence = permissions.roles.length > 0 ? 85 : 30;

  return permissions;
}
```

**Output Example:**

```javascript
{
  "validation": {
    "library": "Zod",
    "schemas": [
      {
        "name": "createTaskSchema",
        "file": "lib/validations/task.ts",
        "fields": {
          "title": { "type": "string", "required": true, "min": 1, "max": 200 },
          "description": { "type": "string", "required": false },
          "dueDate": { "type": "date", "required": false },
          "priority": { "type": "enum", "values": ["LOW", "MEDIUM", "HIGH"] }
        }
      }
    ],
    "confidence": 95
  },
  "permissions": {
    "roles": ["USER", "ADMIN", "OWNER"],
    "rules": [
      {
        "resource": "tasks",
        "action": "delete",
        "condition": "isOwner || isAdmin",
        "file": "lib/permissions.ts"
      }
    ],
    "confidence": 85
  }
}
```

---

### 4. UX & Design Analysis

**Goal:** Extract brand colors, typography, spacing, component patterns

#### Algorithm: `analyzeUXAndDesign()`

```javascript
function analyzeUXAndDesign(projectPath) {
  const design = {
    colors: {},
    typography: {},
    spacing: {},
    borderRadius: {},
    shadows: {},
    breakpoints: {},
    animations: {},
    componentPatterns: [],
    confidence: {}
  };

  // Step 1: Extract from Tailwind config
  const tailwindDesign = extractTailwindDesign(projectPath);
  if (tailwindDesign) {
    Object.assign(design, tailwindDesign);
    design.confidence.tailwind = 100;
  }

  // Step 2: Extract from CSS variables
  const cssDesign = extractCSSVariables(projectPath);
  if (cssDesign) {
    mergeDesignTokens(design, cssDesign);
    design.confidence.css = 90;
  }

  // Step 3: Extract from theme files
  const themeDesign = extractThemeFiles(projectPath);
  if (themeDesign) {
    mergeDesignTokens(design, themeDesign);
    design.confidence.theme = 85;
  }

  // Step 4: Analyze component patterns
  design.componentPatterns = analyzeComponentPatterns(projectPath);

  return design;
}

function extractTailwindDesign(projectPath) {
  const configPaths = [
    'tailwind.config.js',
    'tailwind.config.ts',
    'tailwind.config.cjs'
  ];

  for (const configPath of configPaths) {
    const fullPath = join(projectPath, configPath);
    if (exists(fullPath)) {
      const content = read(fullPath);
      return parseTailwindConfig(content);
    }
  }

  return null;
}

function parseTailwindConfig(content) {
  const design = {
    colors: {},
    spacing: {},
    borderRadius: {},
    shadows: {},
    breakpoints: {}
  };

  // Extract colors from theme.extend.colors or theme.colors
  const colorsMatch = content.match(/colors:\s*{([^}]+)}/);
  if (colorsMatch) {
    design.colors = parseObjectLiteral(colorsMatch[1]);
  }

  // Extract spacing
  const spacingMatch = content.match(/spacing:\s*{([^}]+)}/);
  if (spacingMatch) {
    design.spacing = parseObjectLiteral(spacingMatch[1]);
  }

  // Extract border radius
  const borderRadiusMatch = content.match(/borderRadius:\s*{([^}]+)}/);
  if (borderRadiusMatch) {
    design.borderRadius = parseObjectLiteral(borderRadiusMatch[1]);
  }

  return design;
}

function extractCSSVariables(projectPath) {
  const cssPaths = [
    'app/globals.css',
    'styles/globals.css',
    'src/styles/globals.css',
    'public/styles/main.css'
  ];

  const design = {
    colors: {},
    typography: {},
    spacing: {}
  };

  for (const cssPath of cssPaths) {
    const fullPath = join(projectPath, cssPath);
    if (exists(fullPath)) {
      const content = read(fullPath);

      // Extract :root variables
      const rootMatch = content.match(/:root\s*{([^}]+)}/);
      if (rootMatch) {
        const variables = rootMatch[1];

        // Extract color variables
        const colorVars = variables.matchAll(/--([a-z-]+):\s*([^;]+);/g);
        for (const match of colorVars) {
          const varName = match[1];
          const value = match[2].trim();

          if (varName.includes('color') || varName.includes('bg') || /^#|rgb|hsl/.test(value)) {
            design.colors[varName] = value;
          }
        }
      }
    }
  }

  return design;
}
```

**Output Example:**

```javascript
{
  "colors": {
    "primary": "#3B82F6",
    "secondary": "#10B981",
    "accent": "#F59E0B",
    "background": {
      "light": "#FFFFFF",
      "dark": "#1F2937"
    },
    "text": {
      "light": "#111827",
      "dark": "#F9FAFB"
    }
  },
  "typography": {
    "fontFamily": "Inter, sans-serif",
    "sizes": {
      "xs": "0.75rem",
      "sm": "0.875rem",
      "base": "1rem",
      "lg": "1.125rem"
    },
    "weights": {
      "normal": 400,
      "medium": 500,
      "semibold": 600,
      "bold": 700
    }
  },
  "spacing": {
    "xs": "4px",
    "sm": "8px",
    "md": "16px",
    "lg": "24px"
  },
  "confidence": {
    "tailwind": 100,
    "css": 90
  }
}
```

---

### 5. Database Analysis

**Goal:** Extract schema, tables, fields, relationships, migrations

#### Algorithm: `analyzeDatabase()`

```javascript
function analyzeDatabase(projectPath) {
  const database = {
    type: null,
    orm: null,
    schema: {
      tables: [],
      relationships: [],
      indexes: []
    },
    migrations: [],
    recommendations: [],
    confidence: {}
  };

  // Step 1: Detect database type and ORM
  const dbDetection = detectDatabase(projectPath);
  database.type = dbDetection.type;
  database.orm = dbDetection.orm;
  database.confidence.detection = dbDetection.confidence;

  // Step 2: Extract schema
  if (dbDetection.orm === 'Prisma') {
    database.schema = extractPrismaSchema(projectPath);
  } else if (dbDetection.orm === 'TypeORM') {
    database.schema = extractTypeORMSchema(projectPath);
  } else if (dbDetection.orm === 'Mongoose') {
    database.schema = extractMongooseSchema(projectPath);
  } else if (dbDetection.orm === 'Django ORM') {
    database.schema = extractDjangoSchema(projectPath);
  } else if (dbDetection.orm === 'ActiveRecord') {
    database.schema = extractActiveRecordSchema(projectPath);
  }

  // Step 3: Find migrations
  database.migrations = findMigrations(projectPath, dbDetection.orm);

  // Step 4: Generate recommendations
  database.recommendations = generateDatabaseRecommendations(database.schema);

  return database;
}

function detectDatabase(projectPath) {
  const packageJson = readPackageJson(projectPath);
  const deps = { ...packageJson.dependencies, ...packageJson.devDependencies };

  // Prisma
  if (deps['prisma'] || deps['@prisma/client']) {
    const schemaPath = join(projectPath, 'prisma/schema.prisma');
    if (exists(schemaPath)) {
      const schema = read(schemaPath);
      const dbType = extractPrismaDbType(schema);
      return { type: dbType, orm: 'Prisma', confidence: 100 };
    }
  }

  // TypeORM
  if (deps['typeorm']) {
    return { type: 'SQL', orm: 'TypeORM', confidence: 90 };
  }

  // Mongoose
  if (deps['mongoose']) {
    return { type: 'MongoDB', orm: 'Mongoose', confidence: 100 };
  }

  // Sequelize
  if (deps['sequelize']) {
    return { type: 'SQL', orm: 'Sequelize', confidence: 90 };
  }

  return { type: 'Unknown', orm: 'Unknown', confidence: 0 };
}

function extractPrismaSchema(projectPath) {
  const schemaPath = join(projectPath, 'prisma/schema.prisma');
  if (!exists(schemaPath)) {
    return { tables: [], relationships: [] };
  }

  const content = read(schemaPath);
  const schema = {
    tables: [],
    relationships: [],
    indexes: []
  };

  // Extract models (tables)
  const modelRegex = /model\s+(\w+)\s*{([^}]+)}/g;
  let match;

  while ((match = modelRegex.exec(content)) !== null) {
    const tableName = match[1];
    const fieldsBlock = match[2];

    const table = {
      name: tableName,
      fields: [],
      relations: []
    };

    // Extract fields
    const fieldLines = fieldsBlock.split('\n').filter(line => line.trim());
    for (const line of fieldLines) {
      const field = parsePrismaField(line);
      if (field) {
        table.fields.push(field);

        // Check for relationships
        if (field.isRelation) {
          schema.relationships.push({
            from: tableName,
            to: field.type,
            type: field.relationType,
            field: field.name
          });
        }
      }

      // Check for indexes
      if (line.includes('@@index')) {
        const indexMatch = line.match(/@@index\(\[([^\]]+)\]\)/);
        if (indexMatch) {
          schema.indexes.push({
            table: tableName,
            fields: indexMatch[1].split(',').map(f => f.trim())
          });
        }
      }
    }

    schema.tables.push(table);
  }

  return schema;
}

function parsePrismaField(line) {
  // Example: id String @id @default(uuid())
  // Example: email String @unique
  // Example: tasks Task[]

  const trimmed = line.trim();
  if (!trimmed || trimmed.startsWith('//') || trimmed.startsWith('@@')) {
    return null;
  }

  const parts = trimmed.split(/\s+/);
  if (parts.length < 2) return null;

  const field = {
    name: parts[0],
    type: parts[1].replace('?', '').replace('[]', ''),
    required: !parts[1].includes('?'),
    isArray: parts[1].includes('[]'),
    isRelation: false,
    attributes: []
  };

  // Check if it's a relation (type starts with uppercase and not a Prisma type)
  const prismaTypes = ['String', 'Int', 'Float', 'Boolean', 'DateTime', 'Json'];
  if (/^[A-Z]/.test(field.type) && !prismaTypes.includes(field.type)) {
    field.isRelation = true;
    field.relationType = field.isArray ? 'one-to-many' : 'one-to-one';
  }

  // Extract attributes
  const attributeMatches = trimmed.matchAll(/@(\w+)(?:\(([^)]*)\))?/g);
  for (const match of attributeMatches) {
    field.attributes.push({
      name: match[1],
      args: match[2]
    });
  }

  return field;
}

function generateDatabaseRecommendations(schema) {
  const recommendations = [];

  // Check for missing indexes on foreign keys
  for (const table of schema.tables) {
    for (const field of table.fields) {
      if (field.isRelation && !schema.indexes.find(idx =>
        idx.table === table.name && idx.fields.includes(field.name)
      )) {
        recommendations.push({
          type: 'INDEX',
          severity: 'MEDIUM',
          message: `Consider adding index on ${table.name}.${field.name} for better query performance`
        });
      }
    }
  }

  // Check for soft deletes
  const hasSoftDeletes = schema.tables.some(table =>
    table.fields.some(field => field.name === 'deletedAt')
  );

  if (!hasSoftDeletes) {
    recommendations.push({
      type: 'SOFT_DELETE',
      severity: 'LOW',
      message: 'Consider adding soft delete (deletedAt field) to preserve data history'
    });
  }

  return recommendations;
}
```

**Output Example:**

```javascript
{
  "type": "PostgreSQL",
  "orm": "Prisma",
  "schema": {
    "tables": [
      {
        "name": "User",
        "fields": [
          { "name": "id", "type": "String", "required": true, "attributes": [{"name": "id"}, {"name": "default", "args": "uuid()"}] },
          { "name": "email", "type": "String", "required": true, "attributes": [{"name": "unique"}] },
          { "name": "tasks", "type": "Task", "required": false, "isArray": true, "isRelation": true }
        ]
      },
      {
        "name": "Task",
        "fields": [
          { "name": "id", "type": "String", "required": true },
          { "name": "title", "type": "String", "required": true },
          { "name": "userId", "type": "String", "required": true },
          { "name": "user", "type": "User", "required": true, "isRelation": true }
        ]
      }
    ],
    "relationships": [
      { "from": "User", "to": "Task", "type": "one-to-many", "field": "tasks" },
      { "from": "Task", "to": "User", "type": "one-to-one", "field": "user" }
    ],
    "indexes": [
      { "table": "Task", "fields": ["userId"] }
    ]
  },
  "recommendations": [
    {
      "type": "SOFT_DELETE",
      "severity": "LOW",
      "message": "Consider adding soft delete (deletedAt field) to preserve data history"
    }
  ],
  "confidence": { "detection": 100 }
}
```

---

### 6. Auth Analysis

(Due to length constraints, continuing with abbreviated versions)

**Algorithm:** Detect auth library → Extract config → Identify methods → Check security measures

**Output:** Auth methods, session type, security checklist

---

### 7. External APIs Analysis

**Algorithm:** Parse .env files → Find API client initialization → Check service imports

**Output:** List of services (SendGrid, Stripe, AWS, etc.)

---

### 8. Middleware Analysis

**Algorithm:** Glob middleware files → Parse execution order → Categorize by type

**Output:** Middleware stack with purpose and coverage

---

## Output Format Specifications

All analysis results follow standardized output format for easy doc generation:

```javascript
{
  "metadata": {
    "analyzedAt": "2026-02-15T10:30:00Z",
    "duration": "9m 46s",
    "filesAnalyzed": 487,
    "overallConfidence": 92
  },
  "quickScan": {
    "framework": { /* ... */ },
    "language": "TypeScript",
    "fileCount": 487
  },
  "deepAnalysis": {
    "features": { /* ... */ },
    "techStack": { /* ... */ },
    "businessLogic": { /* ... */ },
    "design": { /* ... */ },
    "database": { /* ... */ },
    "auth": { /* ... */ },
    "externalAPIs": { /* ... */ },
    "middleware": { /* ... */ }
  },
  "confidence": {
    "features": 95,
    "techStack": 100,
    "businessLogic": 80,
    "design": 90,
    "database": 100,
    "auth": 85,
    "externalAPIs": 90,
    "middleware": 75
  },
  "recommendations": [/* ... */]
}
```

---

## Error Handling

### Incomplete Detection

If confidence < 70% on critical areas, flag for user verification:

```
⚠ LOW CONFIDENCE DETECTION

I detected the following with low confidence:
- Auth: Passport.js (60% confidence - found imports but no config)
- Frontend State: Redux (55% confidence - found artifacts but unclear usage)

Please verify or correct these before I generate docs.
```

### Missing Critical Files

If package.json missing or unreadable:

```
❌ CANNOT ANALYZE

Required file missing: package.json

This directory may not be a valid project. Options:
1. Navigate to correct directory
2. Provide PRD manually instead
3. Start new IDEATE session
```

---

## Performance Optimization

For large codebases (1000+ files):

1. **Parallel file reading** where possible
2. **Smart sampling** for component cataloging (analyze 20% of files, extrapolate)
3. **Progress streaming** to show real-time updates
4. **Caching** of package.json and config files

---

## Extending the Engine

To add new analysis areas:

1. Add function: `analyzeNewArea(projectPath)`
2. Define detection patterns
3. Create confidence scoring logic
4. Add to `analyzeCodebase()` workflow
5. Define output format
6. Add to progress tracking

Example:

```javascript
analysis.deepAnalysis.newArea = analyzeNewArea(projectPath);
showProgress("New area analyzed");
```
