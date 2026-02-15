# Features Interrogation

<goal>
Define exactly what the app does. Every feature must be justified. "Users can do stuff" is not a feature spec.
</goal>

---

## Question Bank

### Feature Inventory

- List every feature you imagine the app having.
- For each feature: Is it MVP or future?
- For each MVP feature: Why can't v1 ship without it?
- What features do competitors have that you WON'T build?
- What's the one feature that makes this app unique?

### For EACH Feature

- What user type uses this feature?
- What's the trigger? (User clicks? Time-based? Event-based?)
- What's the input?
- What's the output / result?
- What happens if it fails?
- Is it sync (instant) or async (background)?
- How do you know if it worked?

### CRUD Analysis

For each data type (users, posts, orders, etc.):
- Can users Create it? How?
- Can users Read it? Who can see what?
- Can users Update it? What fields? Who?
- Can users Delete it? Soft delete? Hard delete? Who?

### Feature Dependencies

- Which features depend on other features?
- What's the order of implementation?
- Are there features that unlock other features?
- What if a dependency fails?

### Feature Boundaries

- What does this feature NOT do?
- Where does this feature end and another begin?
- What's the maximum scale? (Max items, max users, max size)
- What's the minimum viable version of this feature?

### Notifications & Triggers

- Does this feature trigger notifications? To whom?
- Email? Push? In-app? SMS?
- Can users turn notifications off?
- Are there automated actions based on events?

---

## Push-Back Phrases

- "'Users can manage their profile' — what specifically can they edit?"
- "You said 'share' — share how? Link? Email? Social?"
- "'Real-time' — how real-time? Seconds? Minutes?"
- "What if they try to [edge case]?"
- "Is this a v1 must-have or a nice-to-have?"

---

## Exit Criteria

Category is complete when you can answer:
- [ ] Complete feature list with MVP/future tags
- [ ] Each feature's trigger, input, output defined
- [ ] CRUD operations for each data type
- [ ] Dependencies and order mapped
- [ ] Boundaries and limits set
