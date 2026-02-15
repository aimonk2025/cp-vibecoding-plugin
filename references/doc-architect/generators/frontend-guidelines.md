# FRONTEND_GUIDELINES Generator

<purpose>
The engineering rules. Component architecture and hierarchy. Naming conventions. File structure. State management approach. How components compose and nest. This is how the app gets built.
</purpose>

## Table of Contents

- [Template Structure](#template-structure) - Full guidelines format
  - [Project Structure](#project-structure)
  - [Naming Conventions](#naming-conventions)
  - [Component Architecture](#component-architecture)
  - [State Management](#state-management)
  - [Data Fetching](#data-fetching)
  - [Form Handling](#form-handling)
  - [Responsive Design](#responsive-design)
  - [Accessibility](#accessibility)
  - [Testing](#testing)
  - [Performance Rules](#performance-rules)
- [Generation Rules](#generation-rules) - How to generate
- [Validation Checklist](#validation-checklist) - Before marking complete

---

## Template Structure

```markdown
# [APP NAME] — Frontend Guidelines

## Overview

**Framework:** [From TECH_STACK.md]
**Styling:** [From TECH_STACK.md]
**State:** [From TECH_STACK.md]

---

## Project Structure

```
src/
├── app/                    # Next.js app router (or pages/)
│   ├── (auth)/            # Auth-required routes
│   ├── (public)/          # Public routes
│   ├── layout.tsx         # Root layout
│   └── page.tsx           # Home page
├── components/
│   ├── ui/                # Base UI components (buttons, inputs)
│   ├── features/          # Feature-specific components
│   ├── layouts/           # Page layouts
│   └── providers/         # Context providers
├── lib/
│   ├── api/               # API client functions
│   ├── hooks/             # Custom hooks
│   ├── utils/             # Utility functions
│   └── validations/       # Zod schemas / validators
├── stores/                # State management (if applicable)
├── types/                 # TypeScript types
└── styles/
    └── globals.css        # Global styles + tokens
```

---

## Naming Conventions

### Files
| Type | Convention | Example |
|------|------------|---------|
| Components | PascalCase | `UserCard.tsx` |
| Hooks | camelCase with use prefix | `useAuth.ts` |
| Utils | camelCase | `formatDate.ts` |
| Types | PascalCase | `User.ts` |
| Constants | SCREAMING_SNAKE | `API_ENDPOINTS.ts` |

### Components
| Type | Convention | Example |
|------|------------|---------|
| Component name | PascalCase | `UserProfile` |
| Props type | ComponentNameProps | `UserProfileProps` |
| Event handlers | handleAction | `handleSubmit` |
| Boolean props | is/has prefix | `isLoading`, `hasError` |

### CSS Classes (Tailwind)
| Type | Convention |
|------|------------|
| Composition | Logical order: layout → spacing → sizing → typography → colors → effects |

---

## Component Architecture

### Component Hierarchy
```
Page (app/page.tsx)
└── Layout (components/layouts/)
    └── Feature Component (components/features/)
        └── UI Component (components/ui/)
```

### Component Template
```tsx
// components/features/UserCard.tsx

import { type FC } from 'react'
import { cn } from '@/lib/utils'

interface UserCardProps {
  user: User
  className?: string
  onSelect?: (user: User) => void
}

export const UserCard: FC<UserCardProps> = ({
  user,
  className,
  onSelect
}) => {
  return (
    <div className={cn('rounded-lg p-4', className)}>
      {/* Component content */}
    </div>
  )
}
```

### Component Rules
1. **One component per file** — No multiple exports
2. **Props interface above component** — Named `ComponentNameProps`
3. **Destructure props** — In function signature
4. **className prop for customization** — Use cn() for merging
5. **No inline styles** — Use Tailwind classes only
6. **No hardcoded values** — Use design tokens

---

## State Management

### Local State (useState)
Use for: UI state that doesn't need to be shared
- Modal open/closed
- Form input values
- Loading states within component

### Global State ([Zustand/Context/etc.])
Use for: State needed across multiple components
- User authentication
- Theme preferences
- Shopping cart

### Server State ([TanStack Query/SWR])
Use for: Data from API
- User data
- Lists, items
- Any fetched content

### State Rules
1. **Start local, lift when needed** — Don't prematurely globalize
2. **Server state is not client state** — Use proper data fetching
3. **Derive when possible** — Don't store computed values

---

## Data Fetching

### Pattern
```tsx
// Using TanStack Query
import { useQuery } from '@tanstack/react-query'
import { getUsers } from '@/lib/api/users'

export function useUsers() {
  return useQuery({
    queryKey: ['users'],
    queryFn: getUsers,
  })
}
```

### API Client
```tsx
// lib/api/users.ts
import { api } from './client'

export async function getUsers(): Promise<User[]> {
  const response = await api.get('/users')
  return response.data
}
```

### Rules
1. **Hooks for data fetching** — Never fetch in components directly
2. **Type API responses** — No `any` types
3. **Handle all states** — Loading, error, empty, success

---

## Form Handling

### Pattern
```tsx
// Using react-hook-form + zod
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { userSchema, type UserFormData } from '@/lib/validations/user'

export function UserForm() {
  const form = useForm<UserFormData>({
    resolver: zodResolver(userSchema),
  })

  const onSubmit = (data: UserFormData) => {
    // Handle submit
  }

  return <form onSubmit={form.handleSubmit(onSubmit)}>...</form>
}
```

---

## Responsive Design

### Mobile-First
```tsx
// ✅ Correct: Mobile first
<div className="p-4 md:p-6 lg:p-8">

// ❌ Wrong: Desktop first
<div className="p-8 sm:p-4">
```

### Breakpoint Usage
| Breakpoint | Usage |
|------------|-------|
| Default | Mobile (< 640px) |
| sm: | Large phones (640px+) |
| md: | Tablets (768px+) |
| lg: | Laptops (1024px+) |
| xl: | Desktops (1280px+) |

### Rules
1. **Design mobile first** — Base styles are mobile
2. **Add complexity at larger sizes** — Not the reverse
3. **Test at all breakpoints** — Not just desktop
4. **Touch targets: 44px minimum** — On mobile

---

## Accessibility

### Requirements
- [ ] All images have alt text
- [ ] All interactive elements are keyboard accessible
- [ ] Focus states are visible
- [ ] Color contrast meets WCAG AA
- [ ] Form inputs have labels
- [ ] Error messages are announced

### Pattern
```tsx
// Accessible button
<button
  onClick={handleClick}
  disabled={isLoading}
  aria-busy={isLoading}
  aria-label="Submit form"
>
  {isLoading ? 'Loading...' : 'Submit'}
</button>
```

---

## Testing

### What to Test
- [ ] Component renders without crashing
- [ ] User interactions work correctly
- [ ] Error states display properly
- [ ] Accessibility requirements met

### File Naming
- `ComponentName.test.tsx` — Unit tests
- `ComponentName.stories.tsx` — Storybook (if used)

---

## Performance Rules

1. **Lazy load routes** — Use dynamic imports
2. **Optimize images** — Use Next/Image or equivalent
3. **Memoize expensive computations** — useMemo for heavy calcs
4. **Avoid unnecessary re-renders** — useCallback for handlers passed as props

---

## Document References

- TECH_STACK.md — Technologies used
- DESIGN_SYSTEM.md — Visual tokens to use
- APP_FLOW.md — Screens to build
```

---

## Generation Rules

1. **File structure matches tech stack** — Next.js vs Vite vs etc.
2. **Patterns match chosen libraries** — TanStack Query vs SWR
3. **Examples are specific** — Not generic React patterns
4. **Mobile-first is explicit** — Clear examples
5. **Accessibility is required** — Not optional

---

## Validation Checklist

- [ ] File structure documented
- [ ] Naming conventions complete
- [ ] Component patterns shown
- [ ] State management approach defined
- [ ] Data fetching patterns shown
- [ ] Mobile-first examples
- [ ] Accessibility requirements
