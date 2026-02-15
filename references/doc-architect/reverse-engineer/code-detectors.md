# Code Detectors - Framework-Specific Detection Patterns

This file contains detection patterns and extraction logic for all supported frameworks. Each detector identifies framework-specific files, patterns, and configurations to enable accurate codebase analysis.

## Table of Contents

1. [Frontend Frameworks](#frontend-frameworks)
2. [Backend Frameworks](#backend-frameworks)
3. [Database ORMs](#database-orms)
4. [Detection Priority & Waterfall](#detection-priority--waterfall)

---

## Frontend Frameworks

### Next.js Detector

**Supported Versions:** 12.x, 13.x, 14.x (both `pages/` and `app/` router)

#### Detection Criteria

```javascript
function detectNextJs(projectPath) {
  const detection = {
    framework: 'Next.js',
    version: null,
    router: null,  // 'pages' | 'app' | 'both'
    confidence: 0,
    indicators: []
  };

  // Indicator 1: package.json has "next"
  const packageJson = readPackageJson(projectPath);
  if (packageJson?.dependencies?.next || packageJson?.devDependencies?.next) {
    detection.version = packageJson.dependencies.next || packageJson.devDependencies.next;
    detection.confidence += 40;
    detection.indicators.push('package.json has next dependency');
  }

  // Indicator 2: next.config.js exists
  const configFiles = ['next.config.js', 'next.config.mjs', 'next.config.ts'];
  for (const configFile of configFiles) {
    if (exists(join(projectPath, configFile))) {
      detection.confidence += 30;
      detection.indicators.push(`Found ${configFile}`);
      break;
    }
  }

  // Indicator 3: pages/ directory exists (pages router)
  if (exists(join(projectPath, 'pages'))) {
    detection.router = 'pages';
    detection.confidence += 15;
    detection.indicators.push('Found pages/ directory');
  }

  // Indicator 4: app/ directory exists (app router)
  if (exists(join(projectPath, 'app'))) {
    detection.router = detection.router === 'pages' ? 'both' : 'app';
    detection.confidence += 15;
    detection.indicators.push('Found app/ directory');
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Route Extraction

```javascript
function extractNextJsRoutes(projectPath, router) {
  const routes = [];

  if (router === 'pages' || router === 'both') {
    // Pages router: pages/**/*.{js,jsx,ts,tsx}
    const pageFiles = glob('pages/**/*.{js,jsx,ts,tsx}', { cwd: projectPath });

    for (const file of pageFiles) {
      routes.push({
        path: convertPagesPathToRoute(file),
        file,
        type: 'page',
        router: 'pages'
      });
    }

    // API routes: pages/api/**/*.{js,ts}
    const apiFiles = glob('pages/api/**/*.{js,ts}', { cwd: projectPath });

    for (const file of apiFiles) {
      routes.push({
        path: convertPagesPathToRoute(file),
        file,
        type: 'api',
        router: 'pages',
        methods: extractAPIMethodsFromFile(file)
      });
    }
  }

  if (router === 'app' || router === 'both') {
    // App router: app/**/page.{js,jsx,ts,tsx}
    const pageFiles = glob('app/**/page.{js,jsx,ts,tsx}', { cwd: projectPath });

    for (const file of pageFiles) {
      routes.push({
        path: convertAppPathToRoute(file),
        file,
        type: 'page',
        router: 'app'
      });
    }

    // App router API: app/**/route.{js,ts}
    const routeFiles = glob('app/**/route.{js,ts}', { cwd: projectPath });

    for (const file of routeFiles) {
      routes.push({
        path: convertAppPathToRoute(file),
        file,
        type: 'api',
        router: 'app',
        methods: extractAppRouteExports(file)
      });
    }
  }

  return routes;
}

function convertPagesPathToRoute(filePath) {
  // pages/tasks/[id].tsx → /tasks/:id
  // pages/api/users/index.ts → /api/users
  return filePath
    .replace(/^pages\//, '/')
    .replace(/\/index\.(js|jsx|ts|tsx)$/, '')
    .replace(/\.(js|jsx|ts|tsx)$/, '')
    .replace(/\[([^\]]+)\]/g, ':$1')
    .replace(/\/+$/, '') || '/';
}

function convertAppPathToRoute(filePath) {
  // app/tasks/[id]/page.tsx → /tasks/:id
  // app/api/users/route.ts → /api/users
  return filePath
    .replace(/^app\//, '/')
    .replace(/\/(page|route)\.(js|jsx|ts|tsx)$/, '')
    .replace(/\[([^\]]+)\]/g, ':$1')
    .replace(/\/+$/, '') || '/';
}

function extractAppRouteExports(filePath) {
  // App router API routes export: GET, POST, PATCH, DELETE
  const content = read(filePath);
  const methods = [];

  if (/export\s+(async\s+)?function\s+GET/m.test(content)) methods.push('GET');
  if (/export\s+(async\s+)?function\s+POST/m.test(content)) methods.push('POST');
  if (/export\s+(async\s+)?function\s+PATCH/m.test(content)) methods.push('PATCH');
  if (/export\s+(async\s+)?function\s+PUT/m.test(content)) methods.push('PUT');
  if (/export\s+(async\s+)?function\s+DELETE/m.test(content)) methods.push('DELETE');

  return methods;
}
```

#### Component Detection

```javascript
function detectNextJsComponents(projectPath) {
  const componentPatterns = [
    'components/**/*.{js,jsx,ts,tsx}',
    'src/components/**/*.{js,jsx,ts,tsx}',
    'app/components/**/*.{js,jsx,ts,tsx}'
  ];

  const components = glob(componentPatterns, { cwd: projectPath });

  return components.map(file => ({
    name: extractComponentName(file),
    file,
    isServerComponent: checkIfServerComponent(file),
    isClientComponent: checkIfClientComponent(file)
  }));
}

function checkIfClientComponent(filePath) {
  const content = read(filePath);
  return content.includes("'use client'") || content.includes('"use client"');
}

function checkIfServerComponent(filePath) {
  const content = read(filePath);
  // Server components don't have 'use client' directive in Next.js 13+
  return !checkIfClientComponent(filePath) && /app\//.test(filePath);
}
```

---

### React Detector (CRA, Vite)

**Supported:** Create React App, Vite, custom React setups

#### Detection Criteria

```javascript
function detectReact(projectPath) {
  const detection = {
    framework: 'React',
    version: null,
    bundler: null,  // 'vite' | 'webpack' | 'esbuild' | 'unknown'
    confidence: 0,
    indicators: []
  };

  const packageJson = readPackageJson(projectPath);

  // Indicator 1: Has react dependency
  if (packageJson?.dependencies?.react) {
    detection.version = packageJson.dependencies.react;
    detection.confidence += 40;
    detection.indicators.push('package.json has react dependency');
  }

  // Indicator 2: Has react-dom
  if (packageJson?.dependencies?.['react-dom']) {
    detection.confidence += 20;
    detection.indicators.push('package.json has react-dom');
  }

  // Detect bundler
  if (exists(join(projectPath, 'vite.config.js')) || exists(join(projectPath, 'vite.config.ts'))) {
    detection.bundler = 'vite';
    detection.confidence += 20;
    detection.indicators.push('Found vite.config');
  } else if (packageJson?.dependencies?.['react-scripts']) {
    detection.bundler = 'create-react-app';
    detection.confidence += 20;
    detection.indicators.push('Found react-scripts (CRA)');
  } else if (exists(join(projectPath, 'webpack.config.js'))) {
    detection.bundler = 'webpack';
    detection.confidence += 15;
    detection.indicators.push('Found webpack.config');
  }

  // Indicator 3: src/index.js or src/main.jsx exists
  if (exists(join(projectPath, 'src/index.js')) ||
      exists(join(projectPath, 'src/index.tsx')) ||
      exists(join(projectPath, 'src/main.jsx')) ||
      exists(join(projectPath, 'src/main.tsx'))) {
    detection.confidence += 20;
    detection.indicators.push('Found entry point');
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Route Detection (React Router)

```javascript
function extractReactRoutes(projectPath) {
  const routes = [];

  // Find files with react-router imports
  const routerFiles = grep(/from ['"]react-router/, projectPath, {
    output_mode: 'files_with_matches'
  });

  for (const file of routerFiles) {
    const content = read(file);

    // Extract <Route> declarations
    const routeMatches = content.matchAll(/<Route\s+path=['"]([^'"]+)['"].*?>/g);

    for (const match of routeMatches) {
      routes.push({
        path: match[1],
        file,
        type: 'page'
      });
    }
  }

  return routes;
}
```

---

### Vue 3 Detector

**Supported:** Vue 3, Nuxt 3

#### Detection Criteria

```javascript
function detectVue(projectPath) {
  const detection = {
    framework: 'Vue',
    version: null,
    confidence: 0,
    indicators: []
  };

  const packageJson = readPackageJson(projectPath);

  // Indicator 1: Has vue dependency
  if (packageJson?.dependencies?.vue) {
    detection.version = packageJson.dependencies.vue;
    detection.confidence += 40;
    detection.indicators.push('package.json has vue dependency');

    // Check if Vue 3
    if (detection.version.startsWith('3') || detection.version.startsWith('^3')) {
      detection.confidence += 10;
      detection.indicators.push('Vue 3 detected');
    }
  }

  // Indicator 2: vite.config or vue.config exists
  if (exists(join(projectPath, 'vite.config.js')) || exists(join(projectPath, 'vue.config.js'))) {
    detection.confidence += 25;
    detection.indicators.push('Found Vue config file');
  }

  // Indicator 3: src/main.js with createApp
  const mainFiles = ['src/main.js', 'src/main.ts'];
  for (const mainFile of mainFiles) {
    if (exists(join(projectPath, mainFile))) {
      const content = read(join(projectPath, mainFile));
      if (content.includes('createApp')) {
        detection.confidence += 25;
        detection.indicators.push('Found createApp in main file');
      }
    }
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Component Detection

```javascript
function detectVueComponents(projectPath) {
  const components = glob('**/*.vue', { cwd: projectPath, ignore: ['node_modules/**'] });

  return components.map(file => {
    const content = read(file);
    const hasScriptSetup = /<script\s+setup/i.test(content);
    const usesCompositionAPI = /import\s+{[^}]*ref[^}]*}\s+from\s+['"]vue['"]/i.test(content);

    return {
      name: extractComponentName(file),
      file,
      scriptSetup: hasScriptSetup,
      compositionAPI: usesCompositionAPI
    };
  });
}
```

---

### Nuxt 3 Detector

#### Detection Criteria

```javascript
function detectNuxt(projectPath) {
  const detection = {
    framework: 'Nuxt',
    version: null,
    confidence: 0,
    indicators: []
  };

  const packageJson = readPackageJson(projectPath);

  // Indicator 1: Has nuxt dependency
  if (packageJson?.dependencies?.nuxt || packageJson?.devDependencies?.nuxt) {
    detection.version = packageJson.dependencies.nuxt || packageJson.devDependencies.nuxt;
    detection.confidence += 50;
    detection.indicators.push('package.json has nuxt dependency');
  }

  // Indicator 2: nuxt.config exists
  const configFiles = ['nuxt.config.js', 'nuxt.config.ts'];
  for (const configFile of configFiles) {
    if (exists(join(projectPath, configFile))) {
      detection.confidence += 30;
      detection.indicators.push(`Found ${configFile}`);
      break;
    }
  }

  // Indicator 3: pages/ directory
  if (exists(join(projectPath, 'pages'))) {
    detection.confidence += 20;
    detection.indicators.push('Found pages/ directory');
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Route Extraction

```javascript
function extractNuxtRoutes(projectPath) {
  // Nuxt uses file-based routing: pages/**/*.vue
  const pageFiles = glob('pages/**/*.vue', { cwd: projectPath });

  return pageFiles.map(file => ({
    path: convertNuxtPathToRoute(file),
    file,
    type: 'page'
  }));
}

function convertNuxtPathToRoute(filePath) {
  // pages/tasks/[id].vue → /tasks/:id
  return filePath
    .replace(/^pages\//, '/')
    .replace(/\.vue$/, '')
    .replace(/\/index$/, '')
    .replace(/\[([^\]]+)\]/g, ':$1')
    .replace(/\/+$/, '') || '/';
}
```

---

### Svelte/SvelteKit Detector

#### Detection Criteria

```javascript
function detectSvelte(projectPath) {
  const detection = {
    framework: 'Svelte',
    kit: false,
    version: null,
    confidence: 0,
    indicators: []
  };

  const packageJson = readPackageJson(projectPath);

  // Indicator 1: Has svelte dependency
  if (packageJson?.dependencies?.svelte || packageJson?.devDependencies?.svelte) {
    detection.version = packageJson.dependencies.svelte || packageJson.devDependencies.svelte;
    detection.confidence += 40;
    detection.indicators.push('package.json has svelte dependency');
  }

  // Indicator 2: Has @sveltejs/kit (SvelteKit)
  if (packageJson?.devDependencies?.['@sveltejs/kit']) {
    detection.kit = true;
    detection.confidence += 30;
    detection.indicators.push('SvelteKit detected');
  }

  // Indicator 3: svelte.config.js exists
  if (exists(join(projectPath, 'svelte.config.js'))) {
    detection.confidence += 30;
    detection.indicators.push('Found svelte.config.js');
  }

  return detection.confidence >= 70 ? detection : null;
}
```

---

## Backend Frameworks

### Express.js Detector

**Supported:** Express 4.x, 5.x

#### Detection Criteria

```javascript
function detectExpress(projectPath) {
  const detection = {
    framework: 'Express',
    version: null,
    confidence: 0,
    indicators: []
  };

  const packageJson = readPackageJson(projectPath);

  // Indicator 1: Has express dependency
  if (packageJson?.dependencies?.express) {
    detection.version = packageJson.dependencies.express;
    detection.confidence += 50;
    detection.indicators.push('package.json has express dependency');
  }

  // Indicator 2: Find app = express() pattern
  const entryFiles = [
    'index.js', 'server.js', 'app.js',
    'src/index.js', 'src/server.js', 'src/app.js',
    'index.ts', 'server.ts', 'app.ts',
    'src/index.ts', 'src/server.ts', 'src/app.ts'
  ];

  for (const entryFile of entryFiles) {
    if (exists(join(projectPath, entryFile))) {
      const content = read(join(projectPath, entryFile));
      if (/express\(\)/.test(content)) {
        detection.confidence += 30;
        detection.indicators.push(`Found express() in ${entryFile}`);
        break;
      }
    }
  }

  // Indicator 3: routes/ directory
  if (exists(join(projectPath, 'routes'))) {
    detection.confidence += 20;
    detection.indicators.push('Found routes/ directory');
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Route Extraction

```javascript
function extractExpressRoutes(projectPath) {
  const routes = [];

  // Find route files
  const routeFiles = glob('routes/**/*.{js,ts}', { cwd: projectPath });

  for (const file of routeFiles) {
    const content = read(file);

    // Extract router.get/post/patch/delete patterns
    const routePatterns = [
      /router\.(get|post|patch|put|delete)\(['"]([^'"]+)['"]/g,
      /app\.(get|post|patch|put|delete)\(['"]([^'"]+)['"]/g
    ];

    for (const pattern of routePatterns) {
      let match;
      while ((match = pattern.exec(content)) !== null) {
        routes.push({
          method: match[1].toUpperCase(),
          path: match[2],
          file,
          type: 'api'
        });
      }
    }
  }

  // Also check main server file
  const serverFiles = ['index.js', 'server.js', 'app.js', 'src/index.js', 'src/server.js'];
  for (const serverFile of serverFiles) {
    if (exists(join(projectPath, serverFile))) {
      const content = read(join(projectPath, serverFile));

      // app.use('/api/users', usersRouter)
      const useMatches = content.matchAll(/app\.use\(['"]([^'"]+)['"],\s*(\w+)\)/g);
      for (const match of useMatches) {
        routes.push({
          basePath: match[1],
          router: match[2],
          file: serverFile,
          type: 'mount'
        });
      }
    }
  }

  return routes;
}
```

---

### NestJS Detector

**Supported:** NestJS 8.x, 9.x, 10.x

#### Detection Criteria

```javascript
function detectNestJS(projectPath) {
  const detection = {
    framework: 'NestJS',
    version: null,
    confidence: 0,
    indicators: []
  };

  const packageJson = readPackageJson(projectPath);

  // Indicator 1: Has @nestjs/core
  if (packageJson?.dependencies?.['@nestjs/core']) {
    detection.version = packageJson.dependencies['@nestjs/core'];
    detection.confidence += 50;
    detection.indicators.push('package.json has @nestjs/core');
  }

  // Indicator 2: nest-cli.json exists
  if (exists(join(projectPath, 'nest-cli.json'))) {
    detection.confidence += 30;
    detection.indicators.push('Found nest-cli.json');
  }

  // Indicator 3: src/main.ts with NestFactory
  if (exists(join(projectPath, 'src/main.ts'))) {
    const content = read(join(projectPath, 'src/main.ts'));
    if (/NestFactory\.create/.test(content)) {
      detection.confidence += 20;
      detection.indicators.push('Found NestFactory.create');
    }
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Route Extraction

```javascript
function extractNestJSRoutes(projectPath) {
  const routes = [];

  // Find controller files
  const controllerFiles = glob('**/*.controller.{ts,js}', {
    cwd: projectPath,
    ignore: ['node_modules/**', 'dist/**']
  });

  for (const file of controllerFiles) {
    const content = read(file);

    // Extract @Controller decorator
    const controllerMatch = content.match(/@Controller\(['"]([^'"]*)['"]\)/);
    const basePath = controllerMatch ? controllerMatch[1] : '';

    // Extract route decorators
    const routePatterns = [
      /@Get\(['"]?([^'"]*?)['"]?\)/g,
      /@Post\(['"]?([^'"]*?)['"]?\)/g,
      /@Patch\(['"]?([^'"]*?)['"]?\)/g,
      /@Put\(['"]?([^'"]*?)['"]?\)/g,
      /@Delete\(['"]?([^'"]*?)['"]?\)/g
    ];

    for (const pattern of routePatterns) {
      let match;
      const methodName = pattern.source.match(/@(\w+)/)[1].toUpperCase();

      while ((match = pattern.exec(content)) !== null) {
        const routePath = match[1] || '';
        const fullPath = `/${basePath}/${routePath}`.replace(/\/+/g, '/').replace(/\/$/, '') || '/';

        routes.push({
          method: methodName,
          path: fullPath,
          file,
          type: 'api'
        });
      }
    }
  }

  return routes;
}
```

---

### Django Detector

**Supported:** Django 3.x, 4.x, 5.x

#### Detection Criteria

```javascript
function detectDjango(projectPath) {
  const detection = {
    framework: 'Django',
    version: null,
    confidence: 0,
    indicators: []
  };

  // Indicator 1: requirements.txt has Django
  if (exists(join(projectPath, 'requirements.txt'))) {
    const content = read(join(projectPath, 'requirements.txt'));
    const djangoMatch = content.match(/Django[>=<]*([0-9.]+)/i);

    if (djangoMatch) {
      detection.version = djangoMatch[1];
      detection.confidence += 50;
      detection.indicators.push('requirements.txt has Django');
    }
  }

  // Indicator 2: manage.py exists
  if (exists(join(projectPath, 'manage.py'))) {
    detection.confidence += 30;
    detection.indicators.push('Found manage.py');
  }

  // Indicator 3: settings.py with INSTALLED_APPS
  const settingsFiles = glob('**/settings.py', { cwd: projectPath, ignore: ['venv/**', 'env/**'] });
  if (settingsFiles.length > 0) {
    const content = read(settingsFiles[0]);
    if (/INSTALLED_APPS/.test(content)) {
      detection.confidence += 20;
      detection.indicators.push('Found INSTALLED_APPS in settings.py');
    }
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Route Extraction

```javascript
function extractDjangoRoutes(projectPath) {
  const routes = [];

  // Find urls.py files
  const urlFiles = glob('**/urls.py', {
    cwd: projectPath,
    ignore: ['venv/**', 'env/**', '.venv/**']
  });

  for (const file of urlFiles) {
    const content = read(file);

    // Extract path() patterns
    const pathMatches = content.matchAll(/path\(['"]([^'"]+)['"],\s*([^,\)]+)/g);

    for (const match of pathMatches) {
      routes.push({
        path: `/${match[1]}`.replace(/\/+/g, '/'),
        view: match[2].trim(),
        file,
        type: 'page'
      });
    }
  }

  return routes;
}
```

---

### FastAPI Detector

**Supported:** FastAPI 0.9x+

#### Detection Criteria

```javascript
function detectFastAPI(projectPath) {
  const detection = {
    framework: 'FastAPI',
    version: null,
    confidence: 0,
    indicators: []
  };

  // Indicator 1: requirements.txt has fastapi
  if (exists(join(projectPath, 'requirements.txt'))) {
    const content = read(join(projectPath, 'requirements.txt'));
    const fastapiMatch = content.match(/fastapi[>=<]*([0-9.]+)/i);

    if (fastapiMatch) {
      detection.version = fastapiMatch[1];
      detection.confidence += 50;
      detection.indicators.push('requirements.txt has fastapi');
    }
  }

  // Indicator 2: main.py with FastAPI()
  const entryFiles = ['main.py', 'app.py', 'app/main.py', 'src/main.py'];
  for (const entryFile of entryFiles) {
    if (exists(join(projectPath, entryFile))) {
      const content = read(join(projectPath, entryFile));
      if (/FastAPI\(\)/.test(content)) {
        detection.confidence += 30;
        detection.indicators.push(`Found FastAPI() in ${entryFile}`);
        break;
      }
    }
  }

  // Indicator 3: Has uvicorn
  if (exists(join(projectPath, 'requirements.txt'))) {
    const content = read(join(projectPath, 'requirements.txt'));
    if (/uvicorn/i.test(content)) {
      detection.confidence += 20;
      detection.indicators.push('Found uvicorn');
    }
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Route Extraction

```javascript
function extractFastAPIRoutes(projectPath) {
  const routes = [];

  // Find Python files with FastAPI route decorators
  const pyFiles = glob('**/*.py', {
    cwd: projectPath,
    ignore: ['venv/**', 'env/**', '.venv/**', '__pycache__/**']
  });

  for (const file of pyFiles) {
    const content = read(file);

    // Extract @app.get/post/etc patterns
    const routePatterns = [
      /@app\.(get|post|patch|put|delete)\(['"]([^'"]+)['"]/g,
      /@router\.(get|post|patch|put|delete)\(['"]([^'"]+)['"]/g
    ];

    for (const pattern of routePatterns) {
      let match;
      while ((match = pattern.exec(content)) !== null) {
        routes.push({
          method: match[1].toUpperCase(),
          path: match[2],
          file,
          type: 'api'
        });
      }
    }
  }

  return routes;
}
```

---

### Ruby on Rails Detector

**Supported:** Rails 6.x, 7.x

#### Detection Criteria

```javascript
function detectRails(projectPath) {
  const detection = {
    framework: 'Ruby on Rails',
    version: null,
    confidence: 0,
    indicators: []
  };

  // Indicator 1: Gemfile has rails
  if (exists(join(projectPath, 'Gemfile'))) {
    const content = read(join(projectPath, 'Gemfile'));
    const railsMatch = content.match(/gem\s+['"]rails['"],\s*['"]~>\s*([0-9.]+)['"]/);

    if (railsMatch) {
      detection.version = railsMatch[1];
      detection.confidence += 50;
      detection.indicators.push('Gemfile has rails gem');
    }
  }

  // Indicator 2: config/application.rb exists
  if (exists(join(projectPath, 'config/application.rb'))) {
    detection.confidence += 30;
    detection.indicators.push('Found config/application.rb');
  }

  // Indicator 3: app/controllers exists
  if (exists(join(projectPath, 'app/controllers'))) {
    detection.confidence += 20;
    detection.indicators.push('Found app/controllers directory');
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Route Extraction

```javascript
function extractRailsRoutes(projectPath) {
  const routes = [];

  // Parse config/routes.rb
  if (exists(join(projectPath, 'config/routes.rb'))) {
    const content = read(join(projectPath, 'config/routes.rb'));

    // Extract resources :tasks
    const resourceMatches = content.matchAll(/resources?\s+:(\w+)/g);
    for (const match of resourceMatches) {
      const resource = match[1];
      routes.push({
        resource,
        type: 'resource',
        file: 'config/routes.rb'
      });
    }

    // Extract get/post/patch/delete routes
    const routePatterns = [
      /(get|post|patch|put|delete)\s+['"]([^'"]+)['"],\s*to:\s*['"]([^'"]+)['"]/g
    ];

    for (const pattern of routePatterns) {
      let match;
      while ((match = pattern.exec(content)) !== null) {
        routes.push({
          method: match[1].toUpperCase(),
          path: match[2],
          controller: match[3],
          file: 'config/routes.rb',
          type: 'route'
        });
      }
    }
  }

  return routes;
}
```

---

### Laravel Detector

**Supported:** Laravel 8.x, 9.x, 10.x, 11.x

#### Detection Criteria

```javascript
function detectLaravel(projectPath) {
  const detection = {
    framework: 'Laravel',
    version: null,
    confidence: 0,
    indicators: []
  };

  // Indicator 1: composer.json has laravel/framework
  if (exists(join(projectPath, 'composer.json'))) {
    const content = read(join(projectPath, 'composer.json'));
    const parsed = JSON.parse(content);

    if (parsed.require?.['laravel/framework']) {
      detection.version = parsed.require['laravel/framework'];
      detection.confidence += 50;
      detection.indicators.push('composer.json has laravel/framework');
    }
  }

  // Indicator 2: artisan file exists
  if (exists(join(projectPath, 'artisan'))) {
    detection.confidence += 30;
    detection.indicators.push('Found artisan file');
  }

  // Indicator 3: app/Http/Controllers exists
  if (exists(join(projectPath, 'app/Http/Controllers'))) {
    detection.confidence += 20;
    detection.indicators.push('Found app/Http/Controllers directory');
  }

  return detection.confidence >= 70 ? detection : null;
}
```

#### Route Extraction

```javascript
function extractLaravelRoutes(projectPath) {
  const routes = [];

  // Parse routes/web.php and routes/api.php
  const routeFiles = ['routes/web.php', 'routes/api.php'];

  for (const routeFile of routeFiles) {
    if (exists(join(projectPath, routeFile))) {
      const content = read(join(projectPath, routeFile));

      // Extract Route::get/post/patch/delete
      const routePatterns = [
        /Route::(get|post|patch|put|delete)\(['"]([^'"]+)['"],\s*\[([^\]]+)\]/g,
        /Route::(get|post|patch|put|delete)\(['"]([^'"]+)['"],\s*'([^']+)'/g
      ];

      for (const pattern of routePatterns) {
        let match;
        while ((match = pattern.exec(content)) !== null) {
          routes.push({
            method: match[1].toUpperCase(),
            path: match[2],
            handler: match[3],
            file: routeFile,
            type: 'route'
          });
        }
      }

      // Extract Route::resource
      const resourceMatches = content.matchAll(/Route::resource\(['"]([^'"]+)['"],\s*([^)]+)\)/g);
      for (const match of resourceMatches) {
        routes.push({
          resource: match[1],
          controller: match[2],
          file: routeFile,
          type: 'resource'
        });
      }
    }
  }

  return routes;
}
```

---

## Database ORMs

### Prisma Detector

```javascript
function detectPrisma(projectPath) {
  const detection = {
    orm: 'Prisma',
    database: null,
    version: null,
    confidence: 0
  };

  const packageJson = readPackageJson(projectPath);

  if (packageJson?.dependencies?.['@prisma/client'] || packageJson?.devDependencies?.prisma) {
    detection.version = packageJson.dependencies?.['@prisma/client'] || packageJson.devDependencies?.prisma;
    detection.confidence += 50;

    // Read schema to detect database type
    if (exists(join(projectPath, 'prisma/schema.prisma'))) {
      const schema = read(join(projectPath, 'prisma/schema.prisma'));

      // Extract datasource db { provider = "..." }
      const providerMatch = schema.match(/provider\s*=\s*['"](\w+)['"]/);
      if (providerMatch) {
        detection.database = providerMatch[1]; // postgresql, mysql, sqlite, etc.
        detection.confidence += 50;
      }
    }
  }

  return detection.confidence >= 70 ? detection : null;
}
```

### TypeORM Detector

```javascript
function detectTypeORM(projectPath) {
  const detection = {
    orm: 'TypeORM',
    database: null,
    version: null,
    confidence: 0
  };

  const packageJson = readPackageJson(projectPath);

  if (packageJson?.dependencies?.typeorm) {
    detection.version = packageJson.dependencies.typeorm;
    detection.confidence += 50;

    // Check for database driver
    if (packageJson.dependencies.pg || packageJson.dependencies.postgres) {
      detection.database = 'PostgreSQL';
      detection.confidence += 25;
    } else if (packageJson.dependencies.mysql || packageJson.dependencies.mysql2) {
      detection.database = 'MySQL';
      detection.confidence += 25;
    } else if (packageJson.dependencies.sqlite3) {
      detection.database = 'SQLite';
      detection.confidence += 25;
    }

    // Check for entity files
    const entityFiles = glob('**/*.entity.{ts,js}', {
      cwd: projectPath,
      ignore: ['node_modules/**', 'dist/**']
    });

    if (entityFiles.length > 0) {
      detection.confidence += 25;
    }
  }

  return detection.confidence >= 70 ? detection : null;
}
```

### Mongoose Detector

```javascript
function detectMongoose(projectPath) {
  const detection = {
    orm: 'Mongoose',
    database: 'MongoDB',
    version: null,
    confidence: 0
  };

  const packageJson = readPackageJson(projectPath);

  if (packageJson?.dependencies?.mongoose) {
    detection.version = packageJson.dependencies.mongoose;
    detection.confidence = 100;
  }

  return detection.confidence >= 70 ? detection : null;
}
```

### Sequelize Detector

```javascript
function detectSequelize(projectPath) {
  const detection = {
    orm: 'Sequelize',
    database: null,
    version: null,
    confidence: 0
  };

  const packageJson = readPackageJson(projectPath);

  if (packageJson?.dependencies?.sequelize) {
    detection.version = packageJson.dependencies.sequelize;
    detection.confidence += 50;

    // Detect database from drivers
    if (packageJson.dependencies.pg) {
      detection.database = 'PostgreSQL';
      detection.confidence += 25;
    } else if (packageJson.dependencies.mysql2) {
      detection.database = 'MySQL';
      detection.confidence += 25;
    } else if (packageJson.dependencies.sqlite3) {
      detection.database = 'SQLite';
      detection.confidence += 25;
    }

    // Check for models directory
    if (exists(join(projectPath, 'models')) || exists(join(projectPath, 'src/models'))) {
      detection.confidence += 25;
    }
  }

  return detection.confidence >= 70 ? detection : null;
}
```

### Django ORM Detector

Detected automatically with Django framework detection.

### ActiveRecord Detector

Detected automatically with Rails framework detection.

---

## Detection Priority & Waterfall

The framework detection uses a waterfall approach with priority ordering:

```javascript
function detectAllFrameworks(projectPath) {
  const detections = {
    frontend: null,
    backend: null,
    database: null,
    confidence: {}
  };

  // Frontend detection (priority order)
  const frontendDetectors = [
    detectNextJs,
    detectNuxt,
    detectRemix,
    detectReact,
    detectVue,
    detectSvelte
  ];

  for (const detector of frontendDetectors) {
    const result = detector(projectPath);
    if (result && result.confidence >= 70) {
      detections.frontend = result;
      detections.confidence.frontend = result.confidence;
      break;
    }
  }

  // Backend detection (priority order)
  const backendDetectors = [
    detectNestJS,
    detectExpress,
    detectFastAPI,
    detectDjango,
    detectRails,
    detectLaravel
  ];

  for (const detector of backendDetectors) {
    const result = detector(projectPath);
    if (result && result.confidence >= 70) {
      detections.backend = result;
      detections.confidence.backend = result.confidence;
      break;
    }
  }

  // Database/ORM detection
  const databaseDetectors = [
    detectPrisma,
    detectTypeORM,
    detectMongoose,
    detectSequelize
  ];

  for (const detector of databaseDetectors) {
    const result = detector(projectPath);
    if (result && result.confidence >= 70) {
      detections.database = result;
      detections.confidence.database = result.confidence;
      break;
    }
  }

  return detections;
}
```

### Confidence Verification

After detection, show summary to user:

```
DETECTED CONFIGURATION:
✓ Frontend: Next.js 14.0.0 with App Router (HIGH - 100%)
✓ Backend: Next.js API Routes (MEDIUM - 85%)
✓ Database: PostgreSQL via Prisma 5.0.0 (HIGH - 100%)

Please verify these detections before I generate docs.
Type 'yes' to continue or 'fix: [field]' to correct.
```

---

## Utility Functions

```javascript
function extractComponentName(filePath) {
  // Extract component name from file path
  // components/tasks/TaskCard.tsx → TaskCard
  const parts = filePath.split('/');
  const fileName = parts[parts.length - 1];
  return fileName.replace(/\.(js|jsx|ts|tsx|vue|svelte)$/, '');
}

function readPackageJson(projectPath) {
  const packageJsonPath = join(projectPath, 'package.json');
  if (exists(packageJsonPath)) {
    const content = read(packageJsonPath);
    return JSON.parse(content);
  }
  return null;
}

function exists(filePath) {
  // Check if file exists (use appropriate file system API)
  try {
    read(filePath);
    return true;
  } catch {
    return false;
  }
}
```
