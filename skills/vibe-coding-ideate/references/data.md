# Data & Storage Interrogation

<goal>
Know every piece of data: what it is, where it lives, who owns it, how long it stays, and what happens when it's gone.
</goal>

---

## Question Bank

### Data Inventory

- List every type of data the app will store.
- For each type: Who creates it? Who owns it?
- What's the expected volume? (10 users? 10M users?)
- How fast does data grow? (10 records/day? 10K/second?)
- Is any data time-sensitive? (Expires? Becomes stale?)

### For EACH Data Type

- What fields/attributes does it have?
- Which fields are required vs optional?
- What are the data types? (String, number, date, file, etc.)
- What are the constraints? (Max length, allowed values, format)
- Is there a unique identifier? What is it?
- Are there relationships to other data? (User has many Posts)

### Storage Decisions

- Database type: Relational (SQL) or NoSQL? Why?
- Specific database: Postgres, MySQL, MongoDB, Firebase, etc.?
- Where is the database hosted? Cloud provider?
- Do you need full-text search? How complex?
- Do you need real-time sync? (Firebase, Supabase, etc.)

### Files & Media

- Does the app handle file uploads?
- What types? (Images, PDFs, videos, any file?)
- Max file size?
- Where are files stored? (S3, Cloudinary, local?)
- Are files public or private?
- Do files need processing? (Thumbnails, compression, virus scan?)

### Data Lifecycle

- How long is data kept?
- Is there archival? What triggers it?
- Can users delete their data? Soft delete or hard delete?
- What happens to related data when something is deleted?
- Is there a recycle bin / undo?
- What about data export? (GDPR, user request)

### Data Sensitivity

- Is any data PII (personally identifiable)?
- Is any data subject to regulations? (HIPAA, GDPR, CCPA, PCI)
- What data must be encrypted at rest?
- What data must be encrypted in transit?
- Who can access raw database data?

### Backups & Recovery

- How often are backups taken?
- How long are backups retained?
- What's the recovery time objective (RTO)?
- What's the recovery point objective (RPO)?
- Have you tested restoring from backup?

---

## Push-Back Phrases

- "'User data' — what specific fields?"
- "You said 'store files' — what kind, how big, how many?"
- "'Keep it forever' — really? Storage costs? Legal?"
- "What happens to comments when the post is deleted?"
- "Is 'email' the unique identifier or can it change?"

---

## Exit Criteria

Category is complete when you can answer:
- [ ] All data types listed with fields
- [ ] Storage technology chosen with rationale
- [ ] File handling defined if applicable
- [ ] Retention and deletion rules set
- [ ] Sensitivity and compliance addressed
