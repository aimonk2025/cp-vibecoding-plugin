# PRD Generator

<purpose>
Product Requirements Document. Every feature with acceptance criteria, user stories, and priority. If it's not in the PRD, it doesn't exist.
</purpose>

## Table of Contents

- [Template Structure](#template-structure) - PRD format
- [Generation Rules](#generation-rules) - How to generate
- [BLOCKED Template](#blocked-template) - Missing info
- [Validation Checklist](#validation-checklist) - Before marking complete

---

## Template Structure

```markdown
# [APP NAME] — Product Requirements Document

## Overview

**Product Name:** [Name]
**Version:** 1.0
**Last Updated:** [Date]
**Owner:** [Name/Team]

## Problem Statement

[2-3 sentences from interrogation: what problem, who has it, why it matters]

## Solution Summary

[1 sentence: what the app does]

## Target Users

| User Type | Description | Primary Goal |
|-----------|-------------|--------------|
| [From interrogation] | | |

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| [From interrogation] | | |

---

## Features

### FEAT-001: [Feature Name]

**Priority:** P0 (MVP) | P1 (v1.1) | P2 (Future)

**User Story:**
As a [user type], I want to [action] so that [benefit].

**Description:**
[What this feature does in detail]

**Acceptance Criteria:**
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]

**Edge Cases:**
- [Edge case]: [Expected behavior]
- [Edge case]: [Expected behavior]

**Dependencies:**
- Requires: [FEAT-XXX] (if any)
- Blocks: [FEAT-XXX] (if any)

**Technical Notes:**
- [Any implementation constraints from interrogation]

---

### FEAT-002: [Feature Name]
[Repeat structure for each feature]

---

## Feature Priority Matrix

| ID | Feature | Priority | User Type | Complexity |
|----|---------|----------|-----------|------------|
| FEAT-001 | | P0 | | |
| FEAT-002 | | P0 | | |

---

## Out of Scope (v1)

- [Feature explicitly excluded]
- [Feature explicitly excluded]

## Future Considerations (v2+)

- [Feature deferred]
- [Feature deferred]

---

## Glossary

| Term | Definition |
|------|------------|
| [Domain term] | [What it means in this app] |

---

## Document References

- APP_FLOW.md — Screen implementations of these features
- BACKEND_STRUCTURE.md — Data models supporting these features
- IMPLEMENTATION_PLAN.md — Build order for these features
```

---

## Generation Rules

1. **Every feature gets a unique ID** — FEAT-001, FEAT-002, etc.
2. **Priority is explicit** — P0 (must ship), P1 (v1.1), P2 (future)
3. **Acceptance criteria are testable** — Can be checked pass/fail
4. **User stories follow format** — As a [who], I want [what], so that [why]
5. **No vague descriptions** — "Users can manage things" is not acceptable
6. **Edge cases from interrogation** — Include every weird state discussed
7. **Dependencies explicit** — What blocks what

---

## BLOCKED Template

If information is missing:

```markdown
### FEAT-XXX: [Feature Name]

**Status:** BLOCKED

**Missing Information:**
- [ ] [Specific question that needs answering]
- [ ] [Specific question that needs answering]

**Action Required:** Return to interrogation to resolve before generating.
```

---

## Validation Checklist

Before marking PRD complete:

- [ ] Every MVP feature from interrogation is documented
- [ ] Every feature has unique ID
- [ ] Every feature has acceptance criteria
- [ ] Every feature has priority assigned
- [ ] Edge cases included
- [ ] Out of scope explicitly listed
- [ ] No placeholder text remains
- [ ] No "TBD" sections
