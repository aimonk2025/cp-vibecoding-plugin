# Tech Stack Interrogation

<goal>
Define every technology choice with reasoning. "Something modern" is not a tech stack. "React with Next.js because SSR improves SEO for our landing pages" is.
</goal>

---

## Question Bank

### Platform

- Is this a web app, mobile app, desktop app, or all?
- If mobile: iOS, Android, or both?
- If both: Native, React Native, Flutter, or web wrapper?
- If web: SPA, MPA, SSR, SSG, or hybrid?
- If desktop: Electron, Tauri, native, or web?

### Frontend

- Framework: React, Vue, Svelte, Angular, vanilla, or other?
- If React: Next.js, Remix, Vite, CRA, or custom?
- State management: Redux, Zustand, Jotai, Context, MobX, none?
- Styling: CSS, Tailwind, Styled-components, CSS Modules, Sass?
- Component library: Build custom, shadcn, MUI, Chakra, Ant?
- What's the browser support requirement? IE11? Modern only?

### Backend

- Language: Node.js, Python, Go, Rust, Java, Ruby, PHP, other?
- Framework: Express, Fastify, Django, FastAPI, Rails, Laravel?
- Architecture: Monolith, microservices, serverless, or hybrid?
- API style: REST, GraphQL, tRPC, gRPC?
- If GraphQL: Apollo, Relay, urql?
- Do you need WebSockets? For what?

### Database

- Type: SQL, NoSQL, or both?
- Specific: PostgreSQL, MySQL, MongoDB, Firebase, Supabase?
- ORM: Prisma, TypeORM, Drizzle, SQLAlchemy, none?
- Migrations: How handled?
- Need caching? Redis, Memcached?

### Infrastructure

- Cloud provider: AWS, GCP, Azure, Vercel, Railway, Fly.io?
- Deployment: Containers, serverless, VMs, PaaS?
- If containers: Docker? Kubernetes? ECS?
- CDN: Cloudflare, Vercel Edge, CloudFront?
- DNS: Where registered and managed?

### DevOps

- Version control: GitHub, GitLab, Bitbucket?
- CI/CD: GitHub Actions, CircleCI, Jenkins, GitLab CI?
- Environments: Local, dev, staging, production?
- How do you handle secrets/env vars?
- Monitoring: Datadog, New Relic, self-hosted?
- Error tracking: Sentry, Bugsnag, LogRocket?
- Logging: Where do logs go? How long kept?

### Constraints

- Are any technologies mandated? (Client requirement, team skills)
- Are any technologies forbidden? (Security, licensing)
- What's the team's experience level with chosen stack?
- Is there an existing codebase to integrate with?

---

## Push-Back Phrases

- "'Modern stack' — which specific technologies?"
- "Why React over Vue? What's the reasoning?"
- "'Cloud' — which cloud? Which services specifically?"
- "You said 'serverless' — for everything or just some functions?"
- "What's your team's experience with [technology]?"

---

## Exit Criteria

Category is complete when you can answer:
- [ ] Every layer has a specific technology
- [ ] Each choice has a reason
- [ ] Constraints and mandates documented
- [ ] DevOps and infrastructure defined
- [ ] Team capability aligned with choices
