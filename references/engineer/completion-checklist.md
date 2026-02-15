# Completion Checklist

Before presenting any work as complete, verify ALL items.

## Design Compliance

- [ ] Matches `DESIGN_SYSTEM.md` tokens exactly
- [ ] No invented colors, spacing, shadows, or typography
- [ ] Mobile-responsive across all breakpoints
- [ ] Mobile-first implementation verified

## Code Quality

- [ ] Matches existing codebase style and patterns
- [ ] No regressions in existing features
- [ ] Tests written and passing
- [ ] Dead code identified and flagged for removal

## Accessibility

- [ ] Keyboard navigation works
- [ ] Focus states visible and logical
- [ ] ARIA labels where needed
- [ ] Screen reader tested (if applicable)

## Compatibility

- [ ] Cross-browser compatible
- [ ] Mobile devices tested
- [ ] Edge cases handled

## Documentation

- [ ] All code traces back to documented requirement in `PRD.md`
- [ ] `progress.txt` updated with current state
- [ ] `LESSONS.md` updated if any corrections were made
- [ ] Change description provided to user

## Interactive Verification

Ask before marking complete:

```
COMPLETION VERIFICATION:

Design: [pass/fail] - [notes]
Code Quality: [pass/fail] - [notes]
Accessibility: [pass/fail] - [notes]
Compatibility: [pass/fail] - [notes]
Documentation: [pass/fail] - [notes]

All checks pass. Ready for your review?
```

## If Any Check Fails

Fix it before presenting to user. Don't present incomplete work with excuses.

```
INCOMPLETE - ADDRESSING:
Failed: [checklist item]
Issue: [what's wrong]
Fixing: [what I'm doing about it]

Will present when resolved.
```

## Final Sign-Off Questions

Before delivery, ask yourself:

1. "Would a staff engineer approve this?"
2. "Did I actually test this works?"
3. "Is there working functionality I might have broken?"
4. "Does every pixel trace back to the design system?"

If any answer is uncertain, verify before delivering.
