# IMPLEMENTATION_PLAN Generator

<purpose>
The master blueprint. Numbered phases and steps covering the entire build from start to finish. Each step lists exact files to create, features to implement (referencing PRD feature IDs), and tests to write. This file is the map. It gets written once and does not get modified during execution.
</purpose>

## Table of Contents

- [Template Structure](#template-structure) - Full plan format
  - [Phase 1: Project Setup](#phase-1-project-setup)
  - [Phase 2: Backend Core](#phase-2-backend-core)
  - [Phase 3: Authentication](#phase-3-authentication)
  - [Phase 4: Frontend Foundation](#phase-4-frontend-foundation)
  - [Phase 5: Features](#phase-5-features)
  - [Phase 6: Polish](#phase-6-polish)
  - [Phase 7: Deployment](#phase-7-deployment)
- [Generation Rules](#generation-rules) - How to generate
- [Validation Checklist](#validation-checklist) - Before marking complete

---

## Template Structure

```markdown
# [APP NAME] — Implementation Plan

## Overview

**Total Phases:** [Number]
**Estimated Sessions:** [Number]
**Prerequisites:** All canonical docs complete

---

## Phase Dependencies

```
Phase 1 (Setup)
    ↓
Phase 2 (Core Backend)
    ↓
Phase 3 (Auth)
    ↓
Phase 4 (Core Frontend)
    ↓
Phase 5 (Features)
    ↓
Phase 6 (Polish)
    ↓
Phase 7 (Deploy)
```

---

## Phase 1: Project Setup

**Goal:** Initialize project with all tooling configured
**Depends on:** None
**Blocks:** All subsequent phases

### Step 1.1: Initialize Project
**Files to create:**
- [ ] `package.json` — Dependencies from TECH_STACK.md
- [ ] `tsconfig.json` — TypeScript config
- [ ] `.eslintrc.js` — Linting rules
- [ ] `.prettierrc` — Formatting rules
- [ ] `.gitignore` — Standard ignores
- [ ] `.env.example` — Environment template

**Verification:**
- [ ] `npm install` completes without errors
- [ ] `npm run lint` passes
- [ ] `npm run typecheck` passes

### Step 1.2: Configure Project Structure
**Files to create:**
- [ ] `src/` directory structure per FRONTEND_GUIDELINES.md
- [ ] `src/styles/globals.css` — Design tokens from DESIGN_SYSTEM.md
- [ ] `src/lib/utils.ts` — Utility functions (cn, etc.)

**Verification:**
- [ ] Project starts without errors
- [ ] Design tokens accessible

### Step 1.3: Database Setup
**Files to create:**
- [ ] `prisma/schema.prisma` — Full schema from BACKEND_STRUCTURE.md
- [ ] Initial migration

**Verification:**
- [ ] `npx prisma migrate dev` succeeds
- [ ] Database tables created
- [ ] Seed data (if any) loads

---

## Phase 2: Backend Core

**Goal:** API foundation with database access
**Depends on:** Phase 1
**Blocks:** Phase 3, 4

### Step 2.1: API Client Setup
**Files to create:**
- [ ] `src/lib/api/client.ts` — API client configuration
- [ ] `src/lib/api/types.ts` — API response types

**Verification:**
- [ ] API client instantiates
- [ ] Types match BACKEND_STRUCTURE.md

### Step 2.2: Database Access Layer
**Files to create:**
- [ ] `src/lib/db/client.ts` — Database client
- [ ] `src/lib/db/[entity].ts` — Per-entity queries

**Verification:**
- [ ] Can connect to database
- [ ] CRUD operations work

---

## Phase 3: Authentication

**Goal:** Complete auth system
**Depends on:** Phase 2
**Blocks:** Phase 5 (features requiring auth)
**Features:** FEAT-XXX (auth features from PRD)

### Step 3.1: Auth Configuration
**Files to create:**
- [ ] `src/lib/auth/config.ts` — Auth provider config
- [ ] `src/lib/auth/session.ts` — Session handling

### Step 3.2: Auth API Routes
**Files to create:**
- [ ] `src/app/api/auth/register/route.ts`
- [ ] `src/app/api/auth/login/route.ts`
- [ ] `src/app/api/auth/logout/route.ts`
- [ ] `src/app/api/auth/me/route.ts`

**Verification:**
- [ ] Can register new user
- [ ] Can login with credentials
- [ ] Can logout
- [ ] Session persists correctly

### Step 3.3: Auth UI
**Files to create:**
- [ ] `src/app/(auth)/login/page.tsx` — SCREEN-XXX from APP_FLOW.md
- [ ] `src/app/(auth)/register/page.tsx` — SCREEN-XXX from APP_FLOW.md
- [ ] `src/components/features/auth/LoginForm.tsx`
- [ ] `src/components/features/auth/RegisterForm.tsx`

**Verification:**
- [ ] Forms validate per BACKEND_STRUCTURE.md
- [ ] Error states display per APP_FLOW.md
- [ ] Styling matches DESIGN_SYSTEM.md

---

## Phase 4: Frontend Foundation

**Goal:** Layout, navigation, base components
**Depends on:** Phase 1
**Blocks:** Phase 5

### Step 4.1: Layouts
**Files to create:**
- [ ] `src/app/layout.tsx` — Root layout
- [ ] `src/components/layouts/MainLayout.tsx`
- [ ] `src/components/layouts/AuthLayout.tsx`

**Verification:**
- [ ] Layouts render correctly
- [ ] Responsive at all breakpoints per DESIGN_SYSTEM.md

### Step 4.2: Navigation
**Files to create:**
- [ ] `src/components/ui/Navigation.tsx`
- [ ] `src/components/ui/MobileNav.tsx`

**Verification:**
- [ ] Navigation matches APP_FLOW.md
- [ ] Mobile navigation works

### Step 4.3: Base UI Components
**Files to create:**
- [ ] `src/components/ui/Button.tsx`
- [ ] `src/components/ui/Input.tsx`
- [ ] `src/components/ui/Card.tsx`
- [ ] `src/components/ui/Modal.tsx`
- [ ] [All base components needed]

**Verification:**
- [ ] All variants render correctly
- [ ] All states (hover, focus, disabled) work
- [ ] Accessible (keyboard, screen reader)

---

## Phase 5: Features

**Goal:** Implement all MVP features
**Depends on:** Phase 3, 4
**Features:** [All P0 features from PRD.md]

### Step 5.1: [Feature Name] (FEAT-001)
**PRD Reference:** FEAT-001
**Screens:** SCREEN-XXX, SCREEN-XXX

**Files to create:**
- [ ] `src/app/[route]/page.tsx`
- [ ] `src/components/features/[feature]/[Component].tsx`
- [ ] `src/lib/api/[feature].ts`
- [ ] `src/lib/hooks/use[Feature].ts`

**Verification:**
- [ ] All acceptance criteria from PRD met
- [ ] All states from APP_FLOW.md work
- [ ] Edge cases handled

### Step 5.2: [Feature Name] (FEAT-002)
[Repeat for each feature]

---

## Phase 6: Polish

**Goal:** Loading states, error handling, empty states, animations
**Depends on:** Phase 5

### Step 6.1: Loading States
**Files to modify:**
- [ ] Add skeleton components
- [ ] Add loading spinners

### Step 6.2: Error Handling
**Files to create:**
- [ ] `src/app/error.tsx` — Global error boundary
- [ ] `src/app/not-found.tsx` — 404 page

### Step 6.3: Empty States
**Files to modify:**
- [ ] Add empty state components to all list screens

### Step 6.4: Animations
**Files to modify:**
- [ ] Add transitions per DESIGN_SYSTEM.md

---

## Phase 7: Deployment

**Goal:** Production-ready deployment
**Depends on:** Phase 6

### Step 7.1: Environment Configuration
- [ ] Production environment variables set
- [ ] Database production instance ready
- [ ] File storage configured

### Step 7.2: Build & Deploy
- [ ] `npm run build` succeeds
- [ ] Deploy to [hosting from TECH_STACK.md]
- [ ] Production URL accessible

### Step 7.3: Verification
- [ ] All features work in production
- [ ] Performance acceptable
- [ ] No console errors

---

## Phase Reference Quick View

| Phase | Focus | Key Deliverables |
|-------|-------|------------------|
| 1 | Setup | Project scaffolding, tooling |
| 2 | Backend | Database, API foundation |
| 3 | Auth | Registration, login, sessions |
| 4 | Frontend | Layouts, navigation, base UI |
| 5 | Features | All MVP features (FEAT-XXX) |
| 6 | Polish | States, errors, animations |
| 7 | Deploy | Production launch |

---

## Document References

- PRD.md — Feature IDs (FEAT-XXX)
- APP_FLOW.md — Screen IDs (SCREEN-XXX)
- TECH_STACK.md — Technologies used
- DESIGN_SYSTEM.md — Visual tokens
- FRONTEND_GUIDELINES.md — Code patterns
- BACKEND_STRUCTURE.md — API contracts
```

---

## Generation Rules

1. **Phases are numbered** — Phase 1, 2, 3...
2. **Steps are numbered within phases** — Step 1.1, 1.2, 2.1...
3. **Dependencies are explicit** — What blocks what
4. **Files are exact paths** — Not "create a component"
5. **Verification is testable** — Can be checked pass/fail
6. **PRD features are referenced** — FEAT-XXX IDs
7. **APP_FLOW screens are referenced** — SCREEN-XXX IDs

---

## Validation Checklist

- [ ] All PRD features have implementation steps
- [ ] All APP_FLOW screens have implementation steps
- [ ] Dependencies are logical
- [ ] Every step has verification criteria
- [ ] File paths match project structure
- [ ] No circular dependencies
