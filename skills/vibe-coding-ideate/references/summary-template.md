# Summary Template

<instruction>
Generate this summary ONLY after all categories are exhausted. Fill in every section with specifics gathered during interrogation. No placeholders. No assumptions.
</instruction>

## Table of Contents

- [Core Concept](#1-core-concept) - Problem & solution
- [Users](#2-users) - User types & goals
- [Features](#3-features-mvp) - MVP feature list
- [Data Model](#4-data-model) - Entities & storage
- [Auth & Authorization](#5-authentication--authorization) - Roles & permissions
- [Tech Stack](#6-tech-stack) - Technologies
- [Business Constraints](#7-business-constraints) - Timeline, budget, team
- [Edge Cases](#8-key-edge-cases) - Failure scenarios
- [Integrations](#9-integrations) - External services
- [Design](#10-design) - Colors, typography, screens

---

# [APP NAME] - Requirements Summary

## 1. Core Concept

**Problem:** [Specific problem being solved]

**Solution:** [One-sentence description of what the app does]

**Why this solution:** [Why software, why now, why this approach]

**Scope v1:** [What's in]

**Out of scope v1:** [What's explicitly out]

---

## 2. Users

| User Type | Description | Primary Goal | Device | Frequency |
|-----------|-------------|--------------|--------|-----------|
| | | | | |

**Primary user for v1:** [Which type]

**User relationships:** [Hierarchy, teams, interactions]

---

## 3. Features (MVP)

| Feature | User Type | Trigger | Input | Output | Priority |
|---------|-----------|---------|-------|--------|----------|
| | | | | | |

**Unique feature:** [The one thing that differentiates]

**Deferred to v2:** [List]

---

## 4. Data Model

| Entity | Key Fields | Created By | Retention |
|--------|------------|------------|-----------|
| | | | |

**Storage:** [Database choice + reasoning]

**Files:** [If applicable: types, storage, limits]

**Sensitivity:** [PII, compliance requirements]

---

## 5. Authentication & Authorization

**Auth methods:** [Email/password, OAuth, etc.]

**Password rules:** [Requirements, 2FA]

**Session:** [Duration, strategy]

**Roles:**
| Role | Permissions |
|------|-------------|
| | |

**Data access:** [Who sees what]

---

## 6. Tech Stack

| Layer | Technology | Reasoning |
|-------|------------|-----------|
| Frontend | | |
| Backend | | |
| Database | | |
| Hosting | | |
| CI/CD | | |

**Constraints:** [Mandated or forbidden technologies]

---

## 7. Business Constraints

**Revenue model:** [How it makes money]

**Timeline:** [Launch date, what's driving it]

**Budget:** [Development, ongoing]

**Scale expectation:** [Users at launch, 6mo, 1yr]

**Team:** [Who's building, skills, gaps]

**Compliance:** [GDPR, HIPAA, etc.]

**Success metric:** [The #1 number]

---

## 8. Key Edge Cases

| Scenario | Handling |
|----------|----------|
| Empty state | |
| Concurrent edit | |
| System failure | |
| User abuse | |
| [Specific to app] | |

---

## 9. Integrations

| Service | Purpose | Critical? | Fallback |
|---------|---------|-----------|----------|
| | | | |

**APIs consumed:** [List with rate limits]

**APIs provided:** [If any]

---

## 10. Design

**Style:** [Direction, references]

**Brand Colors:**
| Token | Hex | Usage |
|-------|-----|-------|
| Primary | #XXXXXX | Main actions, links |
| Primary Hover | #XXXXXX | Hover state |
| Secondary | #XXXXXX | Secondary actions |
| Accent | #XXXXXX | Highlights |

**Neutral Colors:**
| Token | Hex |
|-------|-----|
| Background | #XXXXXX |
| Surface | #XXXXXX |
| Border | #XXXXXX |
| Text | #XXXXXX |
| Text Muted | #XXXXXX |

**Semantic Colors:**
| Token | Hex |
|-------|-----|
| Success | #XXXXXX |
| Error | #XXXXXX |
| Warning | #XXXXXX |
| Info | #XXXXXX |

**Dark Mode:** [Yes/No, default theme]

**Typography:** [Fonts, sizes]

**Navigation:** [Model, structure]

**Key screens:** [List with purposes]

**Accessibility:** [WCAG level, requirements]

---

## Remaining Questions

[List anything that wasn't fully resolved]

---

## Confirmation Request

> "This is everything I've learned. Read it carefully. Is anything missing, wrong, or assumed? This document will be the source of truth for all future development."
