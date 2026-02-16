---
name: vibe-coding-ship
description: |
  Deployment workflow with comprehensive pre-flight checks, environment setup, deployment execution, and post-launch monitoring.
  Validates environment, runs tests, checks configurations, deploys to target platform, and verifies deployment success.
  Use when: (1) Deployment request - user says "deploy", "ship it", "launch", "go live", "release", "push to production",
  (2) BUILD complete - orchestrator delegates SHIP phase after all implementation phases finished and tests passing,
  (3) Deployment questions - user says "how do I deploy?", "deployment steps", "what's the deployment process?",
  (4) Staging deployment - user says "deploy to staging", "test deployment", "deploy to dev", "trial run",
  (5) Production deployment - user says "deploy to production", "push live", "go to prod".
  Requires all tests passing and no blocking bugs. Runs pre-flight checklist (env vars, configs, security, performance).
  Sets up deployment environment, executes deployment, runs smoke tests, and monitors for errors.
  Tracks all deployment steps in progress.txt. Marks project complete when successfully deployed.
---

# Vibe Coding SHIP Phase

Deployment with pre-flight checks and post-launch monitoring.

## Prerequisites

**Required:**
- BUILD phase complete
- All tests passing
- No blocking bugs
- User explicitly requests deployment

## Deployment Workflow

1. **Pre-Flight Checklist**
   - Run comprehensive checks
   - Verify all tests pass
   - Check environment variables
   - Validate configurations

2. **Environment Setup**
   - Configure deployment target
   - Set up environment variables
   - Prepare deployment scripts

3. **Deploy**
   - Execute deployment
   - Monitor deployment progress
   - Handle deployment errors

4. **Verify Deployment**
   - Run smoke tests
   - Check critical endpoints
   - Verify functionality

5. **Monitor**
   - Set up monitoring
   - Watch for errors
   - Log deployment success

## Pre-Flight Checklist

**Load:** `references/pre-ship-checklist.md`

```
PRE-FLIGHT CHECKS
=================

Environment:
✓ NODE_ENV set correctly
✓ API keys configured
✓ Database connections valid

Code Quality:
✓ All tests passing
✓ No console.log statements
✓ No TODO comments in critical code

Security:
✓ No hardcoded secrets
✓ CORS configured properly
✓ Rate limiting enabled

Performance:
✓ Build size acceptable
✓ Images optimized
✓ Caching configured

Ready to deploy: YES/NO
```

## Progress Tracking

```
PHASE: SHIP
STATUS: in_progress
deployment_target: [platform]
started: [timestamp]

CHECKLIST:
✓ Pre-flight checks - Complete
✓ Environment setup - Complete
⊙ Deploying - In Progress
✗ Smoke tests - Not Started
✗ Monitoring - Not Started

NEXT ACTION: [current deployment step]
```

## Reference Files

- `references/main.md` - Deployment orchestration
- `references/pre-ship-checklist.md` - Pre-flight checks
- `references/deployment.md` - Deployment procedures
- `references/post-ship.md` - Post-deployment monitoring

## Completion

When deployed successfully:

```
PHASE: SHIP
STATUS: complete
completed: [timestamp]
deployment_url: [URL]
deployment_successful: true

PROJECT COMPLETE!
```
