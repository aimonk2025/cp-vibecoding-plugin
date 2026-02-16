# DESIGN_SYSTEM.md Generator

Complete visual language with ready-to-use CSS variables and Tailwind config.

## Table of Contents

- [Template Structure](#template-structure) - The output format
  - [Colors](#colors) - Brand, neutral, semantic, dark mode
  - [Typography](#typography) - Fonts, sizes, weights
  - [Spacing](#spacing) - Base unit, scale
  - [Border Radius](#border-radius) - Rounding scale
  - [Shadows](#shadows) - Elevation levels
  - [Breakpoints](#breakpoints) - Responsive targets
  - [Animation](#animation) - Durations, easing
  - [Z-Index](#z-index-scale) - Stacking order
  - [Component Tokens](#component-tokens) - Buttons, inputs, cards
- [CSS Variables](#css-variables) - Ready-to-paste CSS
- [Tailwind Configuration](#tailwind-configuration) - Config snippet
- [Usage Examples](#usage-examples) - Implementation patterns
- [Generation Rules](#generation-rules) - How to fill template
- [Validation Checklist](#validation-checklist) - Before completion

---

## Template Structure

```markdown
# [APP NAME] - Design System

## Overview

**Design Philosophy:** [1 sentence: minimal, playful, corporate, etc.]
**Reference Apps:** [Apps that inspire the look/feel]
**Default Theme:** Light | Dark | System

---

## Colors

### Brand Colors

| Token | Hex | Usage |
|-------|-----|-------|
| primary | #XXXXXX | Primary actions, links, focus states |
| primary-hover | #XXXXXX | Primary hover state |
| primary-active | #XXXXXX | Primary pressed state |
| secondary | #XXXXXX | Secondary actions, less emphasis |
| secondary-hover | #XXXXXX | Secondary hover state |
| accent | #XXXXXX | Highlights, badges, special elements |

### Neutral Colors

| Token | Hex | Usage |
|-------|-----|-------|
| background | #XXXXXX | Page background |
| surface | #XXXXXX | Card/component backgrounds |
| surface-elevated | #XXXXXX | Modals, dropdowns |
| border | #XXXXXX | Borders, dividers |
| border-strong | #XXXXXX | Emphasized borders |
| text | #XXXXXX | Primary text |
| text-muted | #XXXXXX | Secondary/helper text |
| text-disabled | #XXXXXX | Disabled text |

### Semantic Colors

| Token | Hex | Background | Usage |
|-------|-----|------------|-------|
| success | #XXXXXX | #XXXXXX | Success states, confirmations |
| error | #XXXXXX | #XXXXXX | Error states, destructive actions |
| warning | #XXXXXX | #XXXXXX | Warning states, caution |
| info | #XXXXXX | #XXXXXX | Informational states |

### Dark Mode Colors

| Token | Light | Dark |
|-------|-------|------|
| background | #FAFAFA | #0A0A0A |
| surface | #FFFFFF | #171717 |
| surface-elevated | #FFFFFF | #262626 |
| border | #E5E5E5 | #404040 |
| text | #171717 | #FAFAFA |
| text-muted | #737373 | #A3A3A3 |
| [Continue for all tokens...] | | |

---

## Typography

### Font Stack

| Token | Value | Usage |
|-------|-------|-------|
| font-sans | '[Primary Font]', system-ui, -apple-system, sans-serif | Body text |
| font-heading | '[Heading Font]', system-ui, sans-serif | Headings (if different) |
| font-mono | 'JetBrains Mono', 'Fira Code', monospace | Code, technical |

### Type Scale

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| text-xs | 12px / 0.75rem | 16px / 1rem | 400 | Captions, labels |
| text-sm | 14px / 0.875rem | 20px / 1.25rem | 400 | Secondary text, metadata |
| text-base | 16px / 1rem | 24px / 1.5rem | 400 | Body text |
| text-lg | 18px / 1.125rem | 28px / 1.75rem | 400 | Large body, intro text |
| text-xl | 20px / 1.25rem | 28px / 1.75rem | 600 | Small headings (h4) |
| text-2xl | 24px / 1.5rem | 32px / 2rem | 600 | Section headings (h3) |
| text-3xl | 30px / 1.875rem | 36px / 2.25rem | 700 | Page headings (h2) |
| text-4xl | 36px / 2.25rem | 40px / 2.5rem | 700 | Hero headings (h1) |
| text-5xl | 48px / 3rem | 48px / 3rem | 700 | Display text |

### Font Weights

| Token | Value | Usage |
|-------|-------|-------|
| font-normal | 400 | Body text |
| font-medium | 500 | Emphasis, labels |
| font-semibold | 600 | Subheadings |
| font-bold | 700 | Headings, strong emphasis |

---

## Spacing

### Base Unit
**Base:** 4px (all spacing is multiples of 4)

### Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| space-0 | 0 | No spacing |
| space-1 | 4px / 0.25rem | Tight: icon gaps |
| space-2 | 8px / 0.5rem | Related elements |
| space-3 | 12px / 0.75rem | Default gap |
| space-4 | 16px / 1rem | Component padding |
| space-5 | 20px / 1.25rem | Medium gap |
| space-6 | 24px / 1.5rem | Card padding |
| space-8 | 32px / 2rem | Section gaps |
| space-10 | 40px / 2.5rem | Large gaps |
| space-12 | 48px / 3rem | Page sections |
| space-16 | 64px / 4rem | Major sections |
| space-20 | 80px / 5rem | Hero spacing |

---

## Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| radius-none | 0 | Sharp corners |
| radius-sm | 4px / 0.25rem | Subtle rounding |
| radius-md | 8px / 0.5rem | Default (buttons, inputs) |
| radius-lg | 12px / 0.75rem | Cards |
| radius-xl | 16px / 1rem | Modals, large cards |
| radius-2xl | 24px / 1.5rem | Feature cards |
| radius-full | 9999px | Pills, avatars, circles |

---

## Shadows

| Token | Value | Usage |
|-------|-------|-------|
| shadow-sm | 0 1px 2px 0 rgb(0 0 0 / 0.05) | Subtle elevation |
| shadow-md | 0 4px 6px -1px rgb(0 0 0 / 0.1) | Cards, buttons |
| shadow-lg | 0 10px 15px -3px rgb(0 0 0 / 0.1) | Dropdowns |
| shadow-xl | 0 20px 25px -5px rgb(0 0 0 / 0.1) | Modals |
| shadow-inner | inset 0 2px 4px 0 rgb(0 0 0 / 0.05) | Pressed states |

---

## Breakpoints

| Token | Value | Target |
|-------|-------|--------|
| sm | 640px | Large phones (landscape) |
| md | 768px | Tablets |
| lg | 1024px | Small laptops |
| xl | 1280px | Desktops |
| 2xl | 1536px | Large screens |

**Approach:** Mobile-first (use min-width media queries)

---

## Animation

### Durations

| Token | Value | Usage |
|-------|-------|-------|
| duration-fast | 100ms | Micro-interactions (hover) |
| duration-normal | 200ms | Standard transitions |
| duration-slow | 300ms | Page/modal transitions |
| duration-slower | 500ms | Complex animations |

### Easing

| Token | Value | Usage |
|-------|-------|-------|
| ease-linear | linear | Progress bars |
| ease-in | cubic-bezier(0.4, 0, 1, 1) | Exit animations |
| ease-out | cubic-bezier(0, 0, 0.2, 1) | Enter animations |
| ease-in-out | cubic-bezier(0.4, 0, 0.2, 1) | Transitions |

---

## Z-Index Scale

| Token | Value | Usage |
|-------|-------|-------|
| z-base | 0 | Default stacking |
| z-dropdown | 100 | Dropdowns, popovers |
| z-sticky | 200 | Sticky headers |
| z-overlay | 250 | Overlays, backdrops |
| z-modal | 300 | Modals, dialogs |
| z-toast | 400 | Toast notifications |
| z-tooltip | 500 | Tooltips |

---

## Component Tokens

### Buttons

| Variant | Background | Text | Border | Hover BG |
|---------|------------|------|--------|----------|
| Primary | primary | white | none | primary-hover |
| Secondary | transparent | primary | primary | primary/10 |
| Ghost | transparent | text | none | surface |
| Destructive | error | white | none | error-hover |
| Disabled | border | text-disabled | none | - |

**Sizes:**
| Size | Height | Padding X | Font Size | Radius |
|------|--------|-----------|-----------|--------|
| sm | 32px | 12px | text-sm | radius-md |
| md | 40px | 16px | text-base | radius-md |
| lg | 48px | 24px | text-lg | radius-md |

### Inputs

| State | Border | Background | Ring |
|-------|--------|------------|------|
| Default | border | surface | none |
| Hover | border-strong | surface | none |
| Focus | primary | surface | primary/20 |
| Error | error | error-bg | error/20 |
| Disabled | border | background | none |

**Sizes:**
| Size | Height | Padding X | Font Size |
|------|--------|-----------|-----------|
| sm | 32px | 12px | text-sm |
| md | 40px | 16px | text-base |
| lg | 48px | 16px | text-lg |

### Cards

| Variant | Background | Border | Shadow | Radius |
|---------|------------|--------|--------|--------|
| Default | surface | border | shadow-sm | radius-lg |
| Elevated | surface-elevated | none | shadow-md | radius-lg |
| Interactive | surface | border | shadow-sm | radius-lg |

---

## CSS Variables

Copy this into your global CSS:

\`\`\`css
:root {
  /* Brand Colors */
  --color-primary: #XXXXXX;
  --color-primary-hover: #XXXXXX;
  --color-primary-active: #XXXXXX;
  --color-secondary: #XXXXXX;
  --color-secondary-hover: #XXXXXX;
  --color-accent: #XXXXXX;

  /* Neutral Colors */
  --color-background: #XXXXXX;
  --color-surface: #XXXXXX;
  --color-surface-elevated: #XXXXXX;
  --color-border: #XXXXXX;
  --color-border-strong: #XXXXXX;
  --color-text: #XXXXXX;
  --color-text-muted: #XXXXXX;
  --color-text-disabled: #XXXXXX;

  /* Semantic Colors */
  --color-success: #XXXXXX;
  --color-success-bg: #XXXXXX;
  --color-error: #XXXXXX;
  --color-error-bg: #XXXXXX;
  --color-warning: #XXXXXX;
  --color-warning-bg: #XXXXXX;
  --color-info: #XXXXXX;
  --color-info-bg: #XXXXXX;

  /* Typography */
  --font-sans: '[Primary Font]', system-ui, -apple-system, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;

  /* Spacing (base: 4px) */
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-3: 0.75rem;
  --space-4: 1rem;
  --space-6: 1.5rem;
  --space-8: 2rem;
  --space-12: 3rem;
  --space-16: 4rem;

  /* Border Radius */
  --radius-sm: 0.25rem;
  --radius-md: 0.5rem;
  --radius-lg: 0.75rem;
  --radius-xl: 1rem;
  --radius-full: 9999px;

  /* Shadows */
  --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
  --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
  --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
  --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1);

  /* Animation */
  --duration-fast: 100ms;
  --duration-normal: 200ms;
  --duration-slow: 300ms;
  --ease-out: cubic-bezier(0, 0, 0.2, 1);
  --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);

  /* Z-Index */
  --z-dropdown: 100;
  --z-sticky: 200;
  --z-modal: 300;
  --z-toast: 400;
  --z-tooltip: 500;
}

/* Dark Mode */
@media (prefers-color-scheme: dark) {
  :root {
    --color-background: #0A0A0A;
    --color-surface: #171717;
    --color-surface-elevated: #262626;
    --color-border: #404040;
    --color-border-strong: #525252;
    --color-text: #FAFAFA;
    --color-text-muted: #A3A3A3;
    --color-text-disabled: #525252;
    /* Adjust other colors as needed */
  }
}

/* Or use class-based dark mode */
.dark {
  --color-background: #0A0A0A;
  --color-surface: #171717;
  /* ... */
}
\`\`\`

---

## Tailwind Configuration

If using Tailwind CSS, extend your config:

\`\`\`js
// tailwind.config.js
module.exports = {
  darkMode: 'class', // or 'media'
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#XXXXXX',
          hover: '#XXXXXX',
          active: '#XXXXXX',
        },
        secondary: {
          DEFAULT: '#XXXXXX',
          hover: '#XXXXXX',
        },
        accent: '#XXXXXX',
        background: '#XXXXXX',
        surface: {
          DEFAULT: '#XXXXXX',
          elevated: '#XXXXXX',
        },
        border: {
          DEFAULT: '#XXXXXX',
          strong: '#XXXXXX',
        },
        success: {
          DEFAULT: '#XXXXXX',
          bg: '#XXXXXX',
        },
        error: {
          DEFAULT: '#XXXXXX',
          bg: '#XXXXXX',
        },
        warning: {
          DEFAULT: '#XXXXXX',
          bg: '#XXXXXX',
        },
        info: {
          DEFAULT: '#XXXXXX',
          bg: '#XXXXXX',
        },
      },
      fontFamily: {
        sans: ['[Primary Font]', 'system-ui', '-apple-system', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      },
      fontSize: {
        xs: ['0.75rem', { lineHeight: '1rem' }],
        sm: ['0.875rem', { lineHeight: '1.25rem' }],
        base: ['1rem', { lineHeight: '1.5rem' }],
        lg: ['1.125rem', { lineHeight: '1.75rem' }],
        xl: ['1.25rem', { lineHeight: '1.75rem' }],
        '2xl': ['1.5rem', { lineHeight: '2rem' }],
        '3xl': ['1.875rem', { lineHeight: '2.25rem' }],
        '4xl': ['2.25rem', { lineHeight: '2.5rem' }],
        '5xl': ['3rem', { lineHeight: '1' }],
      },
      borderRadius: {
        sm: '0.25rem',
        md: '0.5rem',
        lg: '0.75rem',
        xl: '1rem',
        '2xl': '1.5rem',
      },
      boxShadow: {
        sm: '0 1px 2px 0 rgb(0 0 0 / 0.05)',
        md: '0 4px 6px -1px rgb(0 0 0 / 0.1)',
        lg: '0 10px 15px -3px rgb(0 0 0 / 0.1)',
        xl: '0 20px 25px -5px rgb(0 0 0 / 0.1)',
      },
      transitionDuration: {
        fast: '100ms',
        normal: '200ms',
        slow: '300ms',
      },
      zIndex: {
        dropdown: '100',
        sticky: '200',
        modal: '300',
        toast: '400',
        tooltip: '500',
      },
    },
  },
  plugins: [],
}
\`\`\`

---

## Usage Examples

### Using CSS Variables

\`\`\`css
.button-primary {
  background-color: var(--color-primary);
  color: white;
  padding: var(--space-2) var(--space-4);
  border-radius: var(--radius-md);
  transition: background-color var(--duration-fast) var(--ease-out);
}

.button-primary:hover {
  background-color: var(--color-primary-hover);
}

.card {
  background-color: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: var(--space-6);
  box-shadow: var(--shadow-sm);
}
\`\`\`

### Using Tailwind Classes

\`\`\`jsx
<button className="bg-primary hover:bg-primary-hover text-white px-4 py-2 rounded-md transition-colors duration-fast">
  Primary Button
</button>

<div className="bg-surface border border-border rounded-lg p-6 shadow-sm">
  Card content
</div>
\`\`\`

---

## Document References

- **FRONTEND_GUIDELINES.md** - Component implementation patterns
- **APP_FLOW.md** - Where tokens are applied per screen
- **TECH_STACK.md** - CSS framework choice (Tailwind, CSS Modules, etc.)
```

---

## Generation Rules

1. **Every value is exact** - Hex codes, pixel values, no "kinda blue"
2. **Every token is named** - Consistent naming (kebab-case for CSS, camelCase for JS)
3. **Every token has usage** - When and where to use it
4. **Dark mode is complete** - Every color token has both values
5. **CSS variables ready** - Copy-paste into project
6. **Tailwind config ready** - If using Tailwind (check TECH_STACK.md)
7. **Consistent scale** - Spacing is multiples of base unit

---

## Validation Checklist

Before doc is complete:

- [ ] All brand colors have hex values from interrogation
- [ ] Dark mode values defined (if applicable)
- [ ] Typography has exact sizes, weights, line heights
- [ ] Spacing scale complete with base unit
- [ ] Border radius scale defined
- [ ] Shadow scale defined
- [ ] Breakpoints match responsive strategy
- [ ] CSS variables block is valid CSS
- [ ] Tailwind config is valid JS (if applicable)
- [ ] Component tokens match component library choice
- [ ] No placeholder values remain (#XXXXXX replaced)
