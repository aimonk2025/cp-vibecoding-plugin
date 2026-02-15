# Design & UX Interrogation

Define the look, feel, and flow of the app. Every screen, every interaction, every state.

## Table of Contents

- [Workflow](#workflow) - Sub-flow for brand colors
- [Brand & Style](#brand--style-start-here) - Style direction questions
- [Typography](#typography) - Fonts, sizes, weights
- [Layout & Navigation](#layout--navigation) - Nav model, grid system
- [Responsiveness](#responsiveness) - Mobile-first, breakpoints
- [Screens & Pages](#screens--pages) - All screens mapped
- [Components](#components) - Reusable UI patterns
- [Interactions & States](#interactions--states) - Hover, loading, empty, error
- [Feedback & Notifications](#feedback--notifications) - Toasts, alerts
- [Accessibility](#accessibility) - WCAG, screen readers
- [Exit Criteria](#exit-criteria) - When this category is complete

---

## Workflow

This category has a sub-flow for brand colors:

```
Design & UX Flow:
1. Brand & Style (this file)
2. → TRIGGER: brand-colors.md (interactive color selection)
3. Typography
4. Layout & Navigation
5. Responsiveness
6. Screens & Components
7. Interactions & States
8. Accessibility
```

---

## Question Bank

### Brand & Style (Start Here)

- Is there existing branding to follow? (Logo, colors, fonts)
- Style direction: Minimal, playful, corporate, brutalist, other?
- Do you have reference apps/sites you want to feel like?
- What should users FEEL when using the app?
- Is there a style guide or design system already?
- If not: Who decides design direction?

**After style questions answered:**
```
STYLE CAPTURED

Now let's define your color palette.

Loading: brand-colors.md
→ Interactive color selection flow
```

---

### Typography

*Asked AFTER brand-colors.md completes*

- Specific fonts required? (Brand fonts, Google Fonts, system fonts)
- System fonts acceptable for performance?
- Font pairing: Same family or complementary fonts for headings vs body?
- What sizes for:
  - Hero/display headings?
  - Page headings (h1)?
  - Section headings (h2, h3)?
  - Body text?
  - Captions/labels?
  - Small text (footnotes)?
- Any text that needs special treatment? (Prices, labels, code)
- Line height preferences: Tight, normal, relaxed?

### Layout & Navigation

- What's the navigation model?
  - Sidebar (collapsible? persistent?)
  - Top nav (sticky? transparent?)
  - Bottom tabs (mobile)
  - Hamburger menu
  - Combination?
- Is navigation consistent across all screens?
- Fixed header? Fixed footer? Sticky elements?
- What's the max content width? (Full width, 1200px, 1400px, etc.)
- Grid system: 12-column, flexible, specific breakpoints?
- Sidebar width if applicable?
- Content area padding?

### Responsiveness

- Desktop-first or mobile-first design approach?
- What breakpoints? (sm, md, lg, xl, 2xl - or custom?)
- Are there features only on certain screen sizes?
- What's the minimum supported screen width?
- Touch targets sized appropriately for mobile? (44px minimum)
- How does navigation change on mobile?
- Do tables become cards on mobile? Or horizontal scroll?

### Screens & Pages

- List every screen/page in the app.
- For each screen:
  - What's the purpose?
  - What's the primary action?
  - What's the navigation to/from?
  - What data is displayed?
- Are there modals? For what actions?
- Are there multi-step flows? (Wizards, onboarding, checkout)
- Drawer panels? Slide-overs?
- Full-page vs inline editing?

### Components

- What reusable components exist?
  - Buttons (variants: primary, secondary, ghost, destructive?)
  - Cards (clickable? with actions?)
  - Forms (inline or modal?)
  - Tables (sortable? filterable? selectable rows?)
  - Lists (simple, with actions, with avatars?)
- How are lists displayed? (Table, cards, list items)
- Pagination, infinite scroll, or load more?
- How are dates/times displayed? Timezone handling?
- Avatar style: Circle, rounded square, initials?
- Badge/tag styles?
- Tooltip styles?

### Interactions & States

- What needs hover states?
- What needs focus states (keyboard navigation)?
- What needs loading states?
  - Skeleton loaders?
  - Spinners?
  - Progress bars?
- What needs empty states? (No data, no results, first-time user)
- What needs error states?
- Are there drag-and-drop interactions?
- Are there gestures? (Swipe, pinch, long-press)
- Keyboard shortcuts?
- Confirmation dialogs for destructive actions?

### Feedback & Notifications

- How are success actions confirmed?
  - Toast notification?
  - Inline message?
  - Page redirect with message?
- How are errors displayed?
  - Toast?
  - Inline under field?
  - Alert banner?
- Where do notifications appear? (Top-right, bottom-center, etc.)
- Auto-dismiss or manual close?
- Are there sounds or haptics?

### Accessibility

- WCAG level target: A, AA, or AAA?
- Screen reader support required?
- Keyboard-only navigation required?
- Color contrast requirements? (4.5:1 for AA, 7:1 for AAA)
- Reduced motion support? (prefers-reduced-motion)
- Focus indicators visible?
- Skip navigation links?
- ARIA labels on interactive elements?

---

## Push-Back Phrases

- "'Modern' - modern like Apple or modern like Figma or modern like Linear?"
- "'A dashboard' - what exactly is on it? What's the primary metric?"
- "You said 'notifications' - where? How? What triggers them? How dismissed?"
- "'Clean design' - that means different things. Minimal? Whitespace heavy? Flat?"
- "What does this screen look like with no data? With 1000 items? With an error?"
- "'Nice looking' - show me a reference that matches what you mean."

---

## Exit Criteria

Category is complete when you can answer:

- [ ] Style direction defined with references
- [ ] **Brand colors captured via brand-colors.md**
- [ ] Typography fully specified (fonts, sizes, weights)
- [ ] Navigation model clear
- [ ] Every screen listed with purpose
- [ ] Component patterns identified
- [ ] All states designed (empty, loading, error, hover, focus)
- [ ] Responsiveness strategy defined
- [ ] Accessibility requirements set

---

## Handoff

After all design questions complete:

```
DESIGN & UX COMPLETE ✓

Captured:
- Style direction & references
- Complete color palette (brand, neutral, semantic, dark mode)
- Typography system
- Layout & navigation
- All screens mapped
- Component patterns
- State designs
- Accessibility requirements

This category is done. Select next category or "summarize" if ready.
```
