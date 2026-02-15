# Edge Cases Interrogation

<goal>
Find every weird state, failure mode, and "what if" scenario. The happy path is easy. Edge cases are where apps break.
</goal>

---

## Question Bank

### Empty States

- What does the app look like with zero data?
- First user ever — what do they see?
- User with no [items/friends/posts/etc.] — what shows?
- Search with no results — what happens?
- Report with no data — show empty or hide?

### Boundary Conditions

- What's the maximum number of [items] a user can have?
- What happens when they hit the limit?
- What's the minimum? Can it be zero?
- What's the longest allowed [title/name/description]?
- What's the smallest valid input?

### Timing Issues

- What if two users edit the same thing simultaneously?
- What if a long operation is interrupted?
- What if a request times out? Retry? Fail? Show what?
- What if the user closes the tab mid-action?
- What if they're on a slow/unstable connection?

### State Conflicts

- Can a user be in two states at once? (Admin AND banned?)
- What if something is deleted while being viewed?
- What if a dependency is removed? (User deleted, but their posts exist)
- What if the database and cache disagree?
- What if payment succeeds but webhook fails?

### User Misbehavior

- What if users spam/abuse the system?
- What if they upload malicious files?
- What if they enter script tags / SQL injection?
- What if they try to access others' data?
- What if they create offensive content?
- What if they use fake emails?

### System Failures

- What if the database goes down?
- What if a third-party API fails?
- What if file storage is unreachable?
- What if email sending fails?
- What if the payment provider is down?

### Recovery

- Can users undo mistakes?
- Is there a recycle bin / soft delete?
- How do you recover from data corruption?
- What's the disaster recovery plan?
- How do you handle rollbacks?

### Weird But Valid

- What if a user changes their email mid-session?
- What if they have multiple tabs open?
- What if they use the back button at the wrong time?
- What if they're in a different timezone?
- What if they use the app at exactly midnight?

---

## Push-Back Phrases

- "What if that fails? What does the user see?"
- "What if there's no data yet?"
- "What if two users do this at the same time?"
- "What if someone tries to break this intentionally?"
- "You said it 'shouldn't happen' — but what if it does?"

---

## Exit Criteria

Category is complete when you can answer:
- [ ] Empty states designed
- [ ] Limits and boundaries defined
- [ ] Concurrent/timing conflicts handled
- [ ] Abuse and bad actors considered
- [ ] System failures have fallbacks
- [ ] Recovery paths exist
