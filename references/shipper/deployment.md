# Deployment

Your code works locally. Now make it work on the internet.

## Table of Contents

- [Platform: Vercel](#platform-vercel-recommended) - Recommended hosting
  - [First-Time Setup](#first-time-setup)
  - [Environment Variables](#environment-variables)
  - [Build Errors](#build-errors)
  - [Preview Deployments](#preview-deployments)
- [Troubleshooting](#troubleshooting) - Common issues
- [Deployment Checklist](#deployment-checklist) - Final verification
- [Post-Deploy Verification](#post-deploy-verification) - After going live
- [Alternative Platforms](#alternative-platforms) - Other options

---

## Platform: Vercel (Recommended)

Free tier is generous. Automatic deploys. Built for Next.js.

### First-Time Setup

```
VERCEL SETUP:

1. Push code to GitHub (if not already)
   git add .
   git commit -m "Ready for deployment"
   git push

2. Go to vercel.com → Sign in with GitHub

3. Import your repository
   - Select your repo
   - Vercel auto-detects Next.js/React settings

4. Configure environment variables
   - Add each var from your .env
   - Use PRODUCTION values, not dev

5. Deploy
   - Click Deploy
   - Wait for build
   - Get your URL: your-app.vercel.app

Done? [ ] YES / [ ] NO - troubleshoot below
```

### Environment Variables

```
ENV VAR CHECKLIST:

From your .env.local, add to Vercel:

[ ] DATABASE_URL (production database, not local)
[ ] API_KEY (production key)
[ ] AUTH_SECRET (strong random string)
[ ] [other vars...]

Common mistakes:
❌ Using localhost URLs in production
❌ Using dev API keys in production
❌ Forgetting to add a variable (blank screen on deploy)

Verify:
- Each local .env var has a Vercel equivalent
- Values are production-appropriate
```

### Build Errors

Most deploy failures happen at build time.

```
BUILD ERROR TRIAGE:

1. Read the error message (actually read it)

2. Common errors:

   "Module not found"
   → Missing dependency
   → Fix: Check imports, run npm install

   "Type error"
   → TypeScript compilation failed
   → Fix: Fix the type error locally first

   "Build exceeded memory"
   → Project too large or infinite loop
   → Fix: Check for circular imports

   "Environment variable undefined"
   → Var not set in Vercel
   → Fix: Add the missing var in Vercel dashboard

3. Build locally first:
   npm run build

   If it fails locally, it will fail on Vercel.
   Fix local build first.
```

### Preview Deployments

Vercel creates preview deploys for every PR/branch.

```
PREVIEW DEPLOY WORKFLOW:

1. Push to a branch (not main)
2. Vercel auto-creates preview URL
3. Test your changes on preview
4. If good, merge to main
5. Main auto-deploys to production

Use this for:
- Testing before going live
- Sharing with others for review
- Catching deployment issues early
```

## Troubleshooting

### "Works Locally, Breaks on Vercel"

```
LOCAL VS VERCEL DEBUG:

90% of the time it's environment variables.

Check:
[ ] All env vars added to Vercel?
[ ] Values correct (not localhost)?
[ ] Spelling matches exactly?
[ ] Redeployed after adding vars?

Still broken? Check:
[ ] Build logs in Vercel dashboard
[ ] Runtime logs (Functions tab)
[ ] Browser console on deployed site

Give AI:
"Works on localhost but breaks on Vercel.
Here's the Vercel build log: [paste]
Here's the browser error: [paste]"
```

### Rollback

```
ROLLBACK PROCEDURE:

If new deploy breaks production:

1. Go to Vercel dashboard
2. Deployments tab
3. Find last working deployment
4. Click "..." → "Promote to Production"

Production is restored immediately.
Fix your code, then redeploy.
```

### Custom Domain

```
CUSTOM DOMAIN SETUP:

1. Vercel dashboard → Settings → Domains
2. Add your domain (e.g., yourapp.com)
3. Update DNS at your registrar:
   - Add CNAME record: www → cname.vercel-dns.com
   - Add A record: @ → 76.76.19.19
4. Wait for DNS propagation (up to 48h, usually minutes)
5. Vercel auto-provisions SSL

Verify:
[ ] Domain shows your app
[ ] HTTPS works (lock icon)
[ ] www and non-www both work
```

## Deployment Checklist

```
DEPLOYMENT COMPLETE:

[ ] Code pushed to GitHub
[ ] Vercel connected to repo
[ ] Environment variables set (production values)
[ ] Build succeeds
[ ] Preview deployment tested
[ ] Production URL works
[ ] Core flow works on production
[ ] Mobile works on production

Production URL: _______________

RESULT: [DEPLOYED / ISSUES - list them]
```

## Post-Deploy Verification

```
IMMEDIATE POST-DEPLOY CHECK:

[ ] Site loads (not blank screen)
[ ] Can log in (if auth exists)
[ ] Core feature works
[ ] No console errors
[ ] Mobile layout correct

If any fail:
→ Check Vercel logs
→ Compare with local behavior
→ Rollback if critical
```

## Alternative Platforms

If not using Vercel:

| Platform | Best For |
|----------|----------|
| Vercel | Next.js, React, frontend |
| Netlify | Similar to Vercel, good free tier |
| Railway | Full-stack with databases |
| Render | Backend services, databases |
| Fly.io | Docker, global edge |

Same principles apply:
1. Connect repo
2. Set env vars
3. Deploy
4. Verify
