# APP_FLOW Generator

<purpose>
Every screen, every route, every user journey. What loads first. What data each screen needs. What happens on error. What happens with no data. Navigation logic between every screen.
</purpose>

## Table of Contents

- [Template Structure](#template-structure) - Full app flow format
  - [Screen Inventory](#screen-inventory)
  - [Navigation Structure](#navigation-structure)
  - [Screen Definitions](#screen-definitions)
  - [User Journeys](#user-journeys)
  - [Modals & Overlays](#modals--overlays)
  - [Deep Links](#deep-links)
  - [Error Handling](#error-handling)
- [Generation Rules](#generation-rules) - How to generate
- [Validation Checklist](#validation-checklist) - Before marking complete

---

## Template Structure

```markdown
# [APP NAME] — Application Flow

## Overview

**Total Screens:** [Number]
**Entry Point:** [First screen users see]
**Auth Required:** [Yes/No — which screens]

---

## Screen Inventory

| ID | Screen Name | Route | Auth | Description |
|----|-------------|-------|------|-------------|
| SCREEN-001 | | | | |
| SCREEN-002 | | | | |

---

## Navigation Structure

### Primary Navigation
[Describe nav model: sidebar, top nav, bottom tabs, etc.]

```
[Visual hierarchy of navigation]
├── Home (SCREEN-001)
├── Dashboard (SCREEN-002)
│   ├── Sub-page (SCREEN-003)
│   └── Sub-page (SCREEN-004)
└── Settings (SCREEN-005)
```

---

## Screen Definitions

### SCREEN-001: [Screen Name]

**Route:** `/path`
**Auth Required:** Yes | No
**Features:** FEAT-001, FEAT-002 (from PRD)

**Purpose:**
[What user accomplishes on this screen]

**Data Requirements:**
| Data | Source | Loading State |
|------|--------|---------------|
| [What data] | [API endpoint / local] | [Skeleton/spinner/none] |

**Primary Action:** [The one main thing user does here]

**Secondary Actions:**
- [Action]: [Where it leads]
- [Action]: [Where it leads]

**States:**

| State | Condition | Display |
|-------|-----------|---------|
| Loading | Data fetching | [Skeleton/spinner] |
| Empty | No data exists | [Empty state message + CTA] |
| Error | Fetch failed | [Error message + retry] |
| Success | Data loaded | [Normal view] |

**Navigation:**
- Accessed from: [SCREEN-XXX]
- Leads to: [SCREEN-XXX], [SCREEN-XXX]
- Back behavior: [Where back goes]

**Mobile Considerations:**
- [Any mobile-specific behavior]

---

### SCREEN-002: [Screen Name]
[Repeat structure for each screen]

---

## User Journeys

### Journey 1: [Journey Name] (e.g., "New User Onboarding")

**User Type:** [From PRD]
**Goal:** [What they're trying to accomplish]

```
[Step-by-step flow]
1. User lands on SCREEN-001
2. User clicks [action]
3. System shows SCREEN-002
4. User completes [task]
5. System redirects to SCREEN-003
```

**Happy Path:** [Ideal flow]
**Error Path:** [What happens if something fails]
**Exit Points:** [Where user can abandon]

---

### Journey 2: [Journey Name]
[Repeat for each major user journey]

---

## Modals & Overlays

| ID | Modal Name | Trigger | Purpose |
|----|------------|---------|---------|
| MODAL-001 | | | |

### MODAL-001: [Modal Name]

**Triggered by:** [Button/action on SCREEN-XXX]
**Purpose:** [What it accomplishes]
**Actions:**
- Confirm: [What happens]
- Cancel: [What happens]
- Outside click: [Closes / stays open]

---

## Deep Links

| Route | Parameters | Destination |
|-------|------------|-------------|
| `/item/:id` | id: string | SCREEN-XXX with item loaded |

---

## Error Handling

| Error Type | User Message | Recovery Action |
|------------|--------------|-----------------|
| Network failure | | Retry button |
| 404 Not Found | | Redirect to [screen] |
| 401 Unauthorized | | Redirect to login |
| 500 Server Error | | Error page + support contact |

---

## Document References

- PRD.md — Feature IDs referenced in screens
- DESIGN_SYSTEM.md — Visual tokens for all states
- BACKEND_STRUCTURE.md — API endpoints for data requirements
```

---

## Generation Rules

1. **Every screen gets unique ID** — SCREEN-001, SCREEN-002
2. **Routes are explicit** — Exact URL paths
3. **Data requirements listed** — What API calls, what loads
4. **All states covered** — Loading, empty, error, success
5. **Navigation is bidirectional** — Where it comes from AND goes to
6. **Modals are screens too** — Document separately
7. **User journeys trace paths** — Step by step through screens

---

## Validation Checklist

- [ ] Every screen from interrogation documented
- [ ] Every screen has unique ID
- [ ] Every screen has route
- [ ] Every screen has all 4 states defined
- [ ] Navigation flows are complete
- [ ] User journeys cover all user types
- [ ] Error handling defined
- [ ] PRD feature IDs referenced
