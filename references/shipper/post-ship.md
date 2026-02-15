# Post-Ship

You shipped. Now maintain, iterate, and improve.

## Table of Contents

- [Immediate Post-Ship](#immediate-post-ship-first-24-48-hours) - First 24-48 hours
- [Iteration Cycle](#iteration-cycle) - Feedback, prioritization, updates
- [Documentation Updates](#documentation-updates) - Keep docs current
- [Maintenance Mode](#maintenance-mode) - Health checks, downtime
- [Knowing When to Stop](#knowing-when-to-stop) - Project lifecycle
- [Post-Ship Summary](#post-ship-summary) - Status template
- [Pipeline Loop](#pipeline-loop) - Continue the cycle

---

## Immediate Post-Ship (First 24-48 Hours)

### Monitor for Issues

```
POST-SHIP MONITORING:

Watch for:
[ ] Error spikes in Vercel/hosting logs
[ ] User complaints (if you have feedback channel)
[ ] Performance degradation
[ ] Auth/payment failures

Tools:
- Vercel Analytics (free, built-in)
- Browser console on production
- User reports

If critical issue found:
→ Rollback immediately
→ Fix locally
→ Redeploy
```

### Announce and Gather Feedback

```
FEEDBACK COLLECTION:

Where to announce:
- Your audience (Twitter, Discord, etc.)
- Relevant communities
- Friends/colleagues for early testing

What to ask:
- "What's confusing?"
- "What's broken?"
- "What's missing that you expected?"

Track feedback in:
[ ] Simple doc/spreadsheet
[ ] GitHub issues
[ ] Notion database

Don't immediately build everything requested.
Look for patterns. Multiple people asking = priority.
```

## Iteration Cycle

### Processing Feedback

```
FEEDBACK TRIAGE:

For each piece of feedback, classify:

[ ] BUG - Something is broken
    → Goes to vibe-debugger
    → Fix ASAP if critical

[ ] UX ISSUE - Works but confusing
    → Note the pattern
    → Batch similar issues

[ ] FEATURE REQUEST - New functionality
    → Add to backlog
    → Prioritize by frequency

[ ] EDGE CASE - Unusual scenario
    → Note it
    → Fix if affects multiple users

[ ] SCOPE CREEP - Nice idea, not core
    → Politely acknowledge
    → Don't promise timeline
```

### Iteration Prioritization

```
WHAT TO BUILD NEXT:

Priority order:
1. Critical bugs (app broken for users)
2. Security issues (always urgent)
3. High-frequency UX issues (many users confused)
4. Features multiple users requested
5. Your own improvement ideas

NOT priority:
- Features one person asked for
- "Cool" ideas with no user demand
- Refactoring (unless blocking features)
- Over-optimization
```

### Shipping Updates

```
UPDATE DEPLOYMENT FLOW:

1. Create branch for changes
2. Implement fix/feature
3. Test locally
4. Push → Preview deploy
5. Test preview URL
6. Merge to main → Production

For critical fixes:
- Skip preview if truly urgent
- Have rollback ready
- Monitor after deploy
```

## Documentation Updates

### Keep Docs Current

```
DOCS UPDATE CHECKLIST:

After shipping/updating, review:

[ ] README - Still accurate?
[ ] progress.txt - Updated with current state?
[ ] PRD.md - New features documented?
[ ] CLAUDE.md - Rules still apply?
[ ] lessons.md - New learnings captured?

If returning after break:
"Read progress.txt and summarize current state
against IMPLEMENTATION_PLAN.md"
```

### Capture Learnings

```
POST-SHIP LESSONS:

After each release, note:

What worked well:
- [thing that went smoothly]

What was painful:
- [thing that caused problems]

What to do differently:
- [improvement for next time]

Add to lessons.md for future sessions.
```

## Maintenance Mode

### Regular Health Checks

```
MONTHLY MAINTENANCE:

[ ] Dependencies updated (npm update)
[ ] Security vulnerabilities checked (npm audit)
[ ] Costs reviewed (staying in free tier?)
[ ] Performance still acceptable
[ ] Backups working (if applicable)

Quarterly:
[ ] Review analytics - anyone using this?
[ ] Prune unused features
[ ] Update outdated packages
```

### Handling Downtime

```
IF SITE GOES DOWN:

1. Check Vercel status page
2. Check your logs
3. Check if you deployed recently (rollback?)
4. Check third-party services (Supabase, etc.)

Communicate if you have users:
"We're aware of issues and working on it"

Fix → Deploy → Verify → Communicate resolution
```

## Knowing When to Stop

### Project Lifecycle

```
PROJECT STATUS CHECK:

Is this project:

[ ] ACTIVE - Regular updates, growing users
    → Continue iteration cycle

[ ] STABLE - Works, minimal changes needed
    → Maintenance mode only

[ ] DEPRECATED - No longer relevant
    → Archive, don't delete
    → Keep it running if people use it

[ ] FAILED - No users, no interest
    → Learn from it
    → Move on to next project
```

### Moving On

```
WHEN TO MOVE ON:

Signs it's time:
- No user growth despite effort
- You've lost interest
- Better idea demanding attention
- Maintenance burden > value

Before moving on:
[ ] Document current state in progress.txt
[ ] Note learnings in lessons.md
[ ] Leave it running if it works
[ ] Don't delete - you might return
```

## Post-Ship Summary

```
POST-SHIP STATUS:

Current state: [MONITORING / ITERATING / STABLE / MAINTENANCE]

Recent changes:
- [change 1]
- [change 2]

Feedback received:
- [pattern 1] - [action taken]
- [pattern 2] - [action taken]

Next priorities:
1. [priority 1]
2. [priority 2]

Health:
- Uptime: [good/issues]
- Performance: [good/issues]
- User feedback: [positive/negative/mixed]

Documentation updated: [YES/NO]
```

## Pipeline Loop

After post-ship, the cycle continues:

```
Bug reports → vibe-debugger → vibe-shipper (update)
Feature requests → vibe-engineer → vibe-shipper (update)
Major changes → vibe-interrogator → full pipeline

Ship early. Ship often. Learn from users.
```
