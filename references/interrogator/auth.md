# Auth & Security Interrogation

<goal>
Define exactly how users prove who they are, what they can do, and how the app stays secure. "Users can log in" is not an auth model.
</goal>

---

## Question Bank

### Authentication (Who are you?)

- Do users need accounts at all? Or is it anonymous?
- Sign-up methods: Email/password? OAuth (Google, GitHub, etc.)? Magic link? Phone/SMS?
- If multiple methods, can they be linked?
- Is email verification required?
- Is phone verification required?
- Can users sign up themselves or are they invited?
- Is there SSO (Single Sign-On) for enterprise?

### Password Rules

- If email/password: What's the minimum password strength?
- Is there a password reset flow?
- How long is the reset link valid?
- What happens after X failed login attempts?
- Do you support 2FA/MFA? Required or optional?
- What 2FA methods? (Authenticator app, SMS, email, hardware keys)

### Sessions & Tokens

- How long do sessions last?
- Does "Remember me" extend this? By how much?
- Are sessions single-device or multi-device?
- Can users see/revoke other sessions?
- JWT or session cookies?
- If JWT, where stored? (localStorage, httpOnly cookie)
- What's the refresh token strategy?

### Authorization (What can you do?)

- Are there roles? What are they? (Admin, User, Guest, etc.)
- What can each role do that others can't?
- Are permissions role-based (RBAC) or attribute-based (ABAC)?
- Can permissions be customized per user?
- Is there organization/team-level access?
- Can a user belong to multiple orgs with different roles?

### Data Access Rules

- Can users see each other's data?
- Who can see what? (Own data, team data, all data)
- Can users share their data? How?
- What's the default privacy state?
- Are there public vs private resources?

### Security Measures

- HTTPS everywhere?
- Rate limiting on sensitive endpoints? What limits?
- CORS policy?
- CSRF protection?
- Input validation and sanitization?
- SQL injection prevention?
- XSS prevention?

### Account Management

- Can users change their email?
- Can users change their username?
- Can users delete their account?
- What happens to their data?
- Is there an admin impersonation feature?
- How are admin accounts protected?

---

## Push-Back Phrases

- "'Users log in' — with what? Email? Google? Both?"
- "You said 'admin' — what specifically can they do that users can't?"
- "'Secure' — secure how? Against what threats?"
- "What if someone guesses the reset link?"
- "Can User A see User B's data? Under any circumstance?"

---

## Exit Criteria

Category is complete when you can answer:
- [ ] All auth methods defined
- [ ] Password/2FA rules set
- [ ] Session/token strategy chosen
- [ ] Roles and permissions mapped
- [ ] Data access rules explicit
- [ ] Security measures listed
