# TECH_STACK Generator

<purpose>
Exact frameworks, exact versions, exact hosting. Every dependency named and version-locked. Every integration documented. Every cost estimated. No ambiguity.
</purpose>

---

## Template Structure

```markdown
# [APP NAME] — Tech Stack

## Overview

**Architecture:** [Monolith / Microservices / Serverless / Hybrid]
**Primary Language:** [Language + version]
**Deployment Target:** [Cloud provider + service]

---

## Frontend

### Framework
| Technology | Version | Purpose |
|------------|---------|---------|
| [e.g., React] | 18.2.0 | UI framework |
| [e.g., Next.js] | 14.1.0 | SSR/SSG framework |
| [e.g., TypeScript] | 5.3.0 | Type safety |

### State Management
| Technology | Version | Purpose |
|------------|---------|---------|
| [e.g., Zustand] | 4.5.0 | Global state |

### Styling
| Technology | Version | Purpose |
|------------|---------|---------|
| [e.g., Tailwind CSS] | 3.4.0 | Utility-first CSS |
| [e.g., shadcn/ui] | latest | Component library |

### Build Tools
| Technology | Version | Purpose |
|------------|---------|---------|
| [e.g., Vite] | 5.0.0 | Build tool |
| [e.g., ESLint] | 8.56.0 | Linting |
| [e.g., Prettier] | 3.2.0 | Formatting |

---

## Backend

### Runtime
| Technology | Version | Purpose |
|------------|---------|---------|
| [e.g., Node.js] | 20.11.0 LTS | Runtime |

### Framework
| Technology | Version | Purpose |
|------------|---------|---------|
| [e.g., Fastify] | 4.25.0 | API framework |

### API Style
| Type | Spec |
|------|------|
| [REST / GraphQL / tRPC] | [OpenAPI 3.1 / SDL / etc.] |

---

## Database

### Primary Database
| Technology | Version | Hosting | Purpose |
|------------|---------|---------|---------|
| [e.g., PostgreSQL] | 16.1 | [Supabase/RDS/etc.] | Primary data |

### ORM / Query Builder
| Technology | Version | Purpose |
|------------|---------|---------|
| [e.g., Prisma] | 5.8.0 | Database ORM |

### Caching (if applicable)
| Technology | Version | Hosting | Purpose |
|------------|---------|---------|---------|
| [e.g., Redis] | 7.2 | [Upstash/ElastiCache] | Session/cache |

---

## Authentication

| Technology | Version | Purpose |
|------------|---------|---------|
| [e.g., NextAuth.js] | 4.24.0 | Auth framework |
| [e.g., bcrypt] | 5.1.0 | Password hashing |

### Providers
- [x] Email/Password
- [ ] Google OAuth
- [ ] GitHub OAuth
- [ ] Magic Link

---

## File Storage

| Technology | Purpose | Limits |
|------------|---------|--------|
| [e.g., AWS S3] | File uploads | [Max size, types] |
| [e.g., Cloudinary] | Image processing | [Transformations needed] |

---

## Third-Party Services

| Service | Purpose | Tier | Monthly Cost |
|---------|---------|------|--------------|
| [e.g., Stripe] | Payments | [Free/Starter] | $0-XX |
| [e.g., SendGrid] | Email | [Free tier] | $0-XX |
| [e.g., Sentry] | Error tracking | [Free tier] | $0-XX |

---

## Infrastructure

### Hosting
| Component | Service | Region | Tier |
|-----------|---------|--------|------|
| Frontend | [Vercel/Netlify] | [Region] | [Plan] |
| Backend | [Railway/Render/AWS] | [Region] | [Plan] |
| Database | [Provider] | [Region] | [Plan] |

### DNS & CDN
| Service | Purpose |
|---------|---------|
| [e.g., Cloudflare] | DNS + CDN + DDoS |

### CI/CD
| Service | Purpose |
|---------|---------|
| [e.g., GitHub Actions] | CI/CD pipeline |

---

## Environment Variables

| Variable | Description | Where Used |
|----------|-------------|------------|
| DATABASE_URL | DB connection string | Backend |
| NEXTAUTH_SECRET | Auth encryption key | Backend |
| STRIPE_SECRET_KEY | Payment processing | Backend |
| NEXT_PUBLIC_API_URL | API base URL | Frontend |

---

## Cost Estimate

### Monthly (at launch scale)
| Service | Cost |
|---------|------|
| Hosting (Frontend) | $XX |
| Hosting (Backend) | $XX |
| Database | $XX |
| File Storage | $XX |
| Third-party services | $XX |
| **Total** | **$XX** |

### Monthly (at 6-month scale)
| Service | Cost |
|---------|------|
| [Adjusted estimates] | |
| **Total** | **$XX** |

---

## Version Constraints

### Mandated
- [Technology]: [Version] — [Reason: client requirement, etc.]

### Forbidden
- [Technology] — [Reason: security, licensing, etc.]

---

## Document References

- FRONTEND_GUIDELINES.md — How these technologies are used
- BACKEND_STRUCTURE.md — Database and API implementation
- IMPLEMENTATION_PLAN.md — Setup order for tech stack
```

---

## Generation Rules

1. **Version-lock everything** — "React 18.2.0" not "React"
2. **Justify choices** — Why this tech over alternatives
3. **Cost estimates required** — Even if $0 (free tier)
4. **Environment variables listed** — Every secret/config
5. **Hosting is specific** — Provider + region + tier
6. **Third-party SLAs noted** — What happens if they go down

---

## Validation Checklist

- [ ] Every technology has exact version
- [ ] Every service has hosting location
- [ ] Every third-party has cost estimate
- [ ] Environment variables documented
- [ ] No placeholder versions ("latest")
- [ ] Constraints from interrogation included
