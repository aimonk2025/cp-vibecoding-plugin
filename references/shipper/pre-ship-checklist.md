# Pre-Ship Checklist

Verify everything before deploying. Your users will find every bug you missed.

## Interactive Verification Flow

Go through each section. Don't skip.

### 1. Mobile Testing (Critical)

```
MOBILE CHECK:

Device tested: [ ] Actual phone (not just browser responsive mode)

Layout:
[ ] No horizontal scroll
[ ] Text readable without zooming
[ ] Buttons large enough to tap (min 44x44px)
[ ] Forms usable (keyboard doesn't cover inputs)

Navigation:
[ ] Menu works (hamburger opens/closes)
[ ] Links are tappable
[ ] Back button behavior correct

Performance:
[ ] Loads in reasonable time on 4G
[ ] Images not massive/slow
[ ] No janky scrolling

RESULT: [PASS / FAIL - list issues]
```

### 2. Error States

```
ERROR STATE CHECK:

Test each scenario:
[ ] API fails - does user see helpful message or blank screen?
[ ] Network offline - any indication?
[ ] Invalid form input - clear error messages?
[ ] 404 page - does it exist and help user?
[ ] Auth expired - graceful redirect to login?

RESULT: [PASS / FAIL - list issues]
```

### 3. Empty States

First-time users see empty data. Handle it.

```
EMPTY STATE CHECK:

[ ] No items in list - helpful message + CTA?
[ ] No search results - "no results" message?
[ ] New user dashboard - onboarding or guidance?
[ ] No notifications - not just blank space?

RESULT: [PASS / FAIL - list issues]
```

### 4. Loading States

Users need feedback during async operations.

```
LOADING STATE CHECK:

[ ] Page load - spinner or skeleton?
[ ] Form submit - button disabled + loading indicator?
[ ] Data fetch - loading state before content?
[ ] File upload - progress indicator?

RESULT: [PASS / FAIL - list issues]
```

### 5. Security Audit

```
SECURITY CHECK:

Secrets:
[ ] No API keys in frontend code
[ ] No secrets in git history (check old commits!)
[ ] .env in .gitignore
[ ] Different keys for dev vs prod

Auth:
[ ] Protected routes actually protected
[ ] Can't access other users' data
[ ] Logout actually clears session

Input:
[ ] Forms validate on backend (not just frontend)
[ ] No SQL injection vectors
[ ] No XSS vectors (user input escaped)

RESULT: [PASS / FAIL - list issues]
```

### 6. Cross-Browser

```
BROWSER CHECK:

Test in:
[ ] Chrome
[ ] Safari (especially on iOS)
[ ] Firefox
[ ] Edge (if enterprise users)

Common issues:
- Safari date input different
- Firefox flexbox quirks
- iOS viewport issues

RESULT: [PASS / FAIL - list issues]
```

### 7. Performance Quick Check

```
PERFORMANCE CHECK:

[ ] Largest Contentful Paint < 2.5s
[ ] No massive images (compress them)
[ ] No unnecessary API calls on load
[ ] No console errors flooding

Tools:
- Chrome DevTools → Lighthouse
- PageSpeed Insights

RESULT: [PASS / FAIL - list issues]
```

### 8. Core Flow Test

The main thing your app does - test it end to end.

```
CORE FLOW TEST:

Your core user action: [describe it]

Steps:
1. [step] → [expected result] → [actual: PASS/FAIL]
2. [step] → [expected result] → [actual: PASS/FAIL]
3. [step] → [expected result] → [actual: PASS/FAIL]
...

RESULT: [PASS / FAIL - list issues]
```

## Pre-Ship Summary

```
PRE-SHIP VERIFICATION COMPLETE:

| Check | Status |
|-------|--------|
| Mobile | [PASS/FAIL] |
| Error States | [PASS/FAIL] |
| Empty States | [PASS/FAIL] |
| Loading States | [PASS/FAIL] |
| Security | [PASS/FAIL] |
| Cross-Browser | [PASS/FAIL] |
| Performance | [PASS/FAIL] |
| Core Flow | [PASS/FAIL] |

Overall: [READY TO SHIP / BLOCKERS EXIST]

Blockers to fix:
1. [issue]
2. [issue]
```

## Quick Fix Patterns

| Issue | Fix |
|-------|-----|
| No error boundary | Add React ErrorBoundary component |
| No loading state | Add isLoading state + spinner |
| No empty state | Add conditional render when data.length === 0 |
| Image too large | Compress with tinypng.com, use next/image |
| Secret in code | Move to .env, restart dev server |
