# Shipper Phase

Verify. Deploy. Maintain. Ship with confidence.

## Table of Contents

- [Role](#role) - Your behavior
- [Ship Workflow](#ship-workflow) - 5-step process
  - [Step 1: Scope Check](#step-1-scope-check)
  - [Step 2: Pre-Ship Verification](#step-2-pre-ship-verification)
  - [Step 3: Deploy](#step-3-deploy)
  - [Step 4: Post-Ship Verification](#step-4-post-ship-verification)
  - [Step 5: Post-Ship Setup](#step-5-post-ship-setup)
- [Ship Completion](#ship-completion) - Success state
- [Iteration Loop](#iteration-loop) - After shipping
- [Reference Files](#reference-files) - Detailed guides

---

## Role

You ensure the project is ready for production, deploy it successfully, and set up for ongoing maintenance.

## Ship Workflow

### Step 1: Scope Check
Before anything, verify MVP is complete:
```
SCOPE CHECK:

Core feature works? [ ] YES / [ ] NO
Feature creep? [ ] YES / [ ] NO
Would you use this? [ ] YES / [ ] NO

If any NO: Address before continuing
```

Load `scope-check.md` for detailed questions.

### Step 2: Pre-Ship Verification
Run complete checklist:
```
PRE-SHIP CHECKLIST:

Mobile:
[ ] Tested on actual device
[ ] No horizontal scroll
[ ] Buttons tappable

Error States:
[ ] API failures handled
[ ] Form errors clear
[ ] 404 page exists

Empty States:
[ ] No items message
[ ] First-time user experience

Security:
[ ] No secrets in code
[ ] Protected routes work
[ ] Input validated

Performance:
[ ] Loads quickly
[ ] Images optimized
[ ] No console errors

Core Flow:
[ ] End-to-end works
```

Load `pre-ship-checklist.md` for full checklist.

### Step 3: Deploy
Execute deployment:
```
DEPLOYMENT:

[ ] Code pushed to GitHub
[ ] Vercel connected
[ ] Env vars set (PRODUCTION values)
[ ] Build succeeds
[ ] Preview tested
[ ] Production deployed

Production URL: _______________
```

Load `deployment.md` for detailed process.

### Step 4: Post-Ship Verification
Immediately after deploy:
```
POST-DEPLOY CHECK:

[ ] Site loads (not blank)
[ ] Auth works
[ ] Core feature works
[ ] Mobile correct
[ ] No console errors

All pass? → Ship complete!
Any fail? → Debug and redeploy
```

### Step 5: Post-Ship Setup
Set up for maintenance:
```
POST-SHIP:

[ ] Monitoring in place
[ ] Feedback channel ready
[ ] Documentation updated
[ ] progress.txt updated

Ready for iteration based on user feedback.
```

Load `post-ship.md` for maintenance guide.

## Ship Completion

```
🚀 SHIPPED!

Production URL: [url]

Status:
✓ All pre-ship checks passed
✓ Successfully deployed
✓ Post-deploy verified
✓ Monitoring active

What's Next:
- Monitor for issues
- Collect user feedback
- Iterate based on real usage

The vibe coding pipeline is complete!

Future work:
- Bug reports → DEBUG phase
- Feature requests → BUILD phase
- Major changes → IDEATE phase
```

## Iteration Loop

After shipping, the cycle continues:

```
ITERATION TRIGGERS:

Bug reported → Load references/debugger/main.md
Feature needed → Load references/engineer/main.md
Major pivot → Load references/interrogator/main.md

Ship early. Ship often. Learn from users.
```

## Reference Files

For detailed guidance:
- `pre-ship-checklist.md` - Full verification
- `scope-check.md` - MVP & feature creep
- `deployment.md` - Deploy process
- `post-ship.md` - Maintenance & iteration
