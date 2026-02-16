# Integrations Interrogation

<goal>
Map every external dependency, third-party service, and API connection. If it's outside your codebase, it can fail outside your control.
</goal>

---

## Question Bank

### Third-Party Services

- List every external service the app depends on.
- For each: Is it critical (app breaks without it) or optional?
- What happens if each service goes down?
- What are the costs for each? (Pay-per-use, flat rate, free tier limits)
- What's the SLA/uptime guarantee?

### Payment Processing

- Do you need payments?
- Provider: Stripe, PayPal, Square, Braintree, other?
- One-time payments, subscriptions, or both?
- What currencies?
- What payment methods? (Card, bank, Apple Pay, etc.)
- How do you handle failed payments?
- How do you handle refunds?
- How do you handle disputes/chargebacks?

### Email

- Do you send emails?
- Provider: SendGrid, Mailgun, SES, Postmark, Resend?
- Transactional, marketing, or both?
- Templates: Who designs them? How updated?
- What if email sending fails?
- Do you need email open/click tracking?

### Authentication Providers

- OAuth providers: Google, GitHub, Facebook, Apple, Microsoft?
- Do you need enterprise SSO? (SAML, OIDC)
- What happens if an OAuth provider is down?
- What if a provider deprecates their API?

### Storage & CDN

- File storage: S3, GCS, Cloudinary, other?
- CDN: Cloudflare, CloudFront, Fastly?
- Image processing: On-upload? On-demand?
- Video transcoding needed?

### Analytics & Tracking

- Analytics: Google Analytics, Mixpanel, Amplitude, Plausible?
- What events do you track?
- Is tracking privacy-compliant? (Cookie consent, etc.)
- A/B testing: Built-in or service? (LaunchDarkly, Split, etc.)

### APIs You Consume

- What external APIs does the app call?
- For each: What's the rate limit?
- For each: What's the cost?
- For each: What's the auth method? (API key, OAuth, etc.)
- What if the API changes or breaks?
- Do you cache API responses?

### APIs You Provide

- Do others integrate with you? (Webhook, API, embed)
- Is there a public API? What endpoints?
- API authentication: API keys, OAuth, JWT?
- API rate limiting?
- API versioning strategy?
- API documentation: How generated/maintained?

### Webhooks

- Do you receive webhooks? From what services?
- Do you send webhooks? For what events?
- How do you handle failed webhook deliveries?
- Retry strategy?
- Webhook signature verification?

---

## Push-Back Phrases

- "'We use Stripe' — for what exactly? Subscriptions? One-time?"
- "What if [service] goes down for 2 hours?"
- "What's the rate limit on that API? What if you hit it?"
- "What happens when [provider] changes their pricing?"
- "Is this integration required for v1 or can it wait?"

---

## Exit Criteria

Category is complete when you can answer:
- [ ] All third-party services listed
- [ ] Critical vs optional dependencies marked
- [ ] Failure modes and fallbacks defined
- [ ] Costs understood
- [ ] API integrations documented (both directions)
