# BACKEND_STRUCTURE Generator

<purpose>
Database schema with every table, column, type, and relationship. Auth logic. API endpoint contracts with request/response shapes. Storage rules. Edge cases. Migrations.
</purpose>

## Table of Contents

- [Template Structure](#template-structure) - Full backend format
  - [Database Schema](#database-schema)
  - [API Endpoints](#api-endpoints)
  - [Authentication Logic](#authentication-logic)
  - [Authorization Rules](#authorization-rules)
  - [Error Codes](#error-codes)
  - [File Storage Rules](#file-storage-rules)
- [Generation Rules](#generation-rules) - How to generate
- [Validation Checklist](#validation-checklist) - Before marking complete

---

## Template Structure

```markdown
# [APP NAME] — Backend Structure

## Overview

**Database:** [From TECH_STACK.md]
**ORM:** [From TECH_STACK.md]
**API Style:** REST | GraphQL | tRPC
**Auth:** [From TECH_STACK.md]

---

## Database Schema

### Entity Relationship Diagram
```
[User] 1──────M [Post]
   │              │
   │              │
   └──M [Comment] M┘
```

### Tables

#### users
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK, default: gen_random_uuid() | Unique identifier |
| email | varchar(255) | UNIQUE, NOT NULL | User email |
| password_hash | varchar(255) | NOT NULL | Bcrypt hash |
| name | varchar(100) | NOT NULL | Display name |
| avatar_url | varchar(500) | NULL | Profile image URL |
| role | enum('user','admin') | DEFAULT 'user' | User role |
| email_verified | boolean | DEFAULT false | Verification status |
| created_at | timestamptz | DEFAULT now() | Creation time |
| updated_at | timestamptz | DEFAULT now() | Last update |

**Indexes:**
- `idx_users_email` on (email)

---

#### posts
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK | Unique identifier |
| user_id | uuid | FK → users.id, NOT NULL | Author |
| title | varchar(200) | NOT NULL | Post title |
| content | text | NOT NULL | Post body |
| status | enum('draft','published') | DEFAULT 'draft' | Publication status |
| published_at | timestamptz | NULL | When published |
| created_at | timestamptz | DEFAULT now() | Creation time |
| updated_at | timestamptz | DEFAULT now() | Last update |

**Indexes:**
- `idx_posts_user_id` on (user_id)
- `idx_posts_status` on (status)

**Foreign Keys:**
- `user_id` → `users.id` ON DELETE CASCADE

---

[Continue for all tables]

---

## Enums

### user_role
| Value | Description |
|-------|-------------|
| user | Standard user |
| admin | Administrator |

### post_status
| Value | Description |
|-------|-------------|
| draft | Not published |
| published | Publicly visible |

---

## API Endpoints

### Authentication

#### POST /api/auth/register
**Description:** Create new user account
**Auth Required:** No

**Request Body:**
```json
{
  "email": "string (email format, required)",
  "password": "string (min 8 chars, required)",
  "name": "string (max 100 chars, required)"
}
```

**Response 201:**
```json
{
  "user": {
    "id": "uuid",
    "email": "string",
    "name": "string"
  },
  "token": "string (JWT)"
}
```

**Response 400:**
```json
{
  "error": "VALIDATION_ERROR",
  "message": "string",
  "details": [{ "field": "string", "message": "string" }]
}
```

**Response 409:**
```json
{
  "error": "EMAIL_EXISTS",
  "message": "Email already registered"
}
```

---

#### POST /api/auth/login
**Description:** Authenticate user
**Auth Required:** No

**Request Body:**
```json
{
  "email": "string (required)",
  "password": "string (required)"
}
```

**Response 200:**
```json
{
  "user": {
    "id": "uuid",
    "email": "string",
    "name": "string",
    "role": "string"
  },
  "token": "string (JWT)",
  "expiresAt": "ISO8601 timestamp"
}
```

**Response 401:**
```json
{
  "error": "INVALID_CREDENTIALS",
  "message": "Invalid email or password"
}
```

---

### Resources

#### GET /api/posts
**Description:** List posts
**Auth Required:** Optional (affects visible posts)

**Query Parameters:**
| Param | Type | Default | Description |
|-------|------|---------|-------------|
| page | integer | 1 | Page number |
| limit | integer | 20 | Items per page (max 100) |
| status | string | - | Filter by status |
| userId | uuid | - | Filter by author |

**Response 200:**
```json
{
  "data": [
    {
      "id": "uuid",
      "title": "string",
      "content": "string",
      "status": "string",
      "author": {
        "id": "uuid",
        "name": "string"
      },
      "createdAt": "ISO8601"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "totalPages": 5
  }
}
```

---

#### POST /api/posts
**Description:** Create post
**Auth Required:** Yes

**Request Body:**
```json
{
  "title": "string (max 200, required)",
  "content": "string (required)",
  "status": "draft | published (default: draft)"
}
```

**Response 201:**
```json
{
  "id": "uuid",
  "title": "string",
  "content": "string",
  "status": "string",
  "createdAt": "ISO8601"
}
```

---

[Continue for all endpoints]

---

## Authentication Logic

### JWT Structure
```json
{
  "sub": "user_id (uuid)",
  "email": "string",
  "role": "string",
  "iat": "issued at (unix timestamp)",
  "exp": "expires at (unix timestamp)"
}
```

### Token Lifecycle
| Token Type | Expiration | Storage |
|------------|------------|---------|
| Access Token | 15 minutes | Memory / httpOnly cookie |
| Refresh Token | 7 days | httpOnly cookie |

### Password Requirements
- Minimum 8 characters
- Hashed with bcrypt (cost factor: 12)
- Never stored in plain text
- Never logged

---

## Authorization Rules

| Resource | Action | user | admin |
|----------|--------|------|-------|
| posts | create | own only | all |
| posts | read | public + own drafts | all |
| posts | update | own only | all |
| posts | delete | own only | all |
| users | read | own only | all |
| users | update | own only | all |
| users | delete | own only | all |

---

## Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| VALIDATION_ERROR | 400 | Request validation failed |
| UNAUTHORIZED | 401 | Not authenticated |
| FORBIDDEN | 403 | Not authorized |
| NOT_FOUND | 404 | Resource not found |
| CONFLICT | 409 | Resource conflict |
| INTERNAL_ERROR | 500 | Server error |

---

## File Storage Rules

### Upload Constraints
| Type | Max Size | Allowed Formats |
|------|----------|-----------------|
| Avatar | 5MB | jpg, png, webp |
| Attachment | 25MB | pdf, doc, docx |

### Storage Path Convention
```
/uploads/{entity}/{entity_id}/{timestamp}_{filename}
```

---

## Document References

- PRD.md — Features requiring these endpoints
- APP_FLOW.md — Screens consuming these endpoints
- TECH_STACK.md — Technologies implementing this
```

---

## Generation Rules

1. **Every column has type AND constraints** — Not just "string"
2. **Every endpoint has full contract** — Request AND all responses
3. **Every relationship is explicit** — FK, ON DELETE behavior
4. **Every enum is documented** — All possible values
5. **Auth rules are tables** — Who can do what
6. **Error codes are standardized** — Consistent across API

---

## Validation Checklist

- [ ] All tables from data interrogation
- [ ] All columns with types and constraints
- [ ] All relationships with FK behavior
- [ ] All API endpoints with contracts
- [ ] All error responses documented
- [ ] Auth logic complete
- [ ] Authorization rules clear
