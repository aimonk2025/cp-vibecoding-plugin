# Distribution and Sharing Guide for Skills

Skills make your MCP integration more complete. As users compare connectors, those with skills offer a faster path to value, giving you an edge over MCP-only alternatives.

## Current Distribution Model (January 2026)

### How Individual Users Get Skills

Users install skills manually through:

1. **Download** the skill folder (from GitHub, direct link, etc.)
2. **Zip** the folder (if not already zipped as .skill file)
3. **Upload** to Claude.ai via Settings > Capabilities > Skills
4. **Or place** in Claude Code skills directory

### Organization-Level Skills

**For enterprise customers:**
- Admins can deploy skills workspace-wide (shipped December 18, 2025)
- Automatic updates when skill is updated
- Centralized management across organization
- Users automatically get skills without manual installation

**Benefits:**
- Consistent experience across team
- IT controls which skills are available
- Easier rollout of updates
- No individual user setup required

## An Open Standard

Anthropic has published Agent Skills as an open standard. Like MCP, skills should be portable across tools and platforms - the same skill should work whether you're using Claude or other AI platforms.

**Platform compatibility:**
- Claude.ai: Full support
- Claude Code: Full support
- API: Programmatic access (requires Code Execution Tool beta)
- Other platforms: Check individual platform documentation

**Note:** Some skills are designed to take full advantage of a specific platform's capabilities. Authors can note this in the skill's `compatibility` field.

## Using Skills via API

For programmatic use cases - building applications, agents, or automated workflows:

### Key Capabilities

- `/v1/skills` endpoint for listing and managing skills
- Add skills to Messages API requests via `container.skills` parameter
- Version control and management through Claude Console
- Works with Claude Agent SDK for building custom agents

### When to Use API vs. Claude.ai

| Use Case | Best Surface |
|----------|-------------|
| End users interacting with skills directly | Claude.ai / Claude Code |
| Manual testing and iteration during development | Claude.ai / Claude Code |
| Individual, ad-hoc workflows | Claude.ai / Claude Code |
| Applications using skills programmatically | API |
| Production deployments at scale | API |
| Automated pipelines and agent systems | API |

**Note:** Skills in the API require the Code Execution Tool beta, which provides the secure environment skills need to run.

**For implementation details:**
- Skills API Quickstart
- Create Custom Skills
- Skills in the Agent SDK

## Recommended Distribution Approach

### 1. Host on GitHub

**Public repository for open-source skills:**

```
your-skill-name/
├── README.md               # For human visitors (not in skill folder)
├── LICENSE                 # Skill license
├── .gitignore             # Git ignore patterns
├── skill-name/            # Actual skill folder
│   ├── SKILL.md           # Skill definition
│   ├── scripts/           # Scripts
│   ├── references/        # References
│   └── assets/            # Assets
└── examples/              # Optional: Usage examples
    └── screenshots/
```

**Key points:**
- README.md is at repo level (for GitHub visitors)
- Actual skill folder is subdirectory
- No README.md inside skill folder itself
- Clear installation instructions in repo README
- Screenshots and examples help users understand value

### 2. Create Installation Guide

**In your repo README.md:**

````markdown
# My Awesome Skill

## Description

[Brief description of what your skill does and why users would want it]

## Installation

### Option 1: Download .skill File (Recommended)

1. Go to [Releases](https://github.com/yourorg/your-skill/releases)
2. Download the latest `your-skill.skill` file
3. In Claude.ai:
   - Go to Settings > Capabilities > Skills
   - Click "Upload skill"
   - Select the downloaded .skill file
4. Enable the skill and start using it!

### Option 2: From Source

1. Clone this repository:
   ```bash
   git clone https://github.com/yourorg/your-skill.git
   cd your-skill
   ```

2. Package the skill (requires Python):
   ```bash
   python scripts/package_skill.py skill-name ./
   ```

3. Upload `your-skill.skill` to Claude.ai (Settings > Skills > Upload)

## Usage

**Trigger the skill** by asking Claude:
- "Create a new project using [your service]"
- "Help me set up [workflow]"
- [List 3-5 example phrases that trigger your skill]

**Example workflow:**

[Show concrete example of using the skill with screenshots if possible]

## Requirements

- [List any prerequisites: MCP connections, API keys, etc.]
- [Specify if requires Claude.ai, Claude Code, or API]
- [Note any system dependencies]

## Examples

[Include screenshots or examples of skill in action]

## Support

- Issues: [GitHub Issues](https://github.com/yourorg/your-skill/issues)
- Documentation: [Link to docs if applicable]
- Contact: your-email@example.com

## License

[License information]
````

### 3. Document in Your MCP Repo

**If you have an MCP server, link to the skill:**

````markdown
# MyService MCP Server

## Installation

[MCP installation instructions]

## Recommended: Install Companion Skill

For the best experience, install the MyService skill alongside this MCP server.

**Why use both together:**
- **MCP provides:** Data access to your MyService account
- **Skill provides:** Automated workflows and best practices
- **Together:** 10x better experience with guided automation

### Quick Comparison

**With MCP only:**
```
User: "Create a project in MyService"
Claude: "What should I name it?"
User: "Q4 Planning"
Claude: "What type of project?"
User: "Marketing project"
Claude: "Should I add any team members?"
User: "Add the marketing team"
[15+ messages back and forth]
```

**With MCP + Skill:**
```
User: "Create a marketing project for Q4 Planning"
Claude: [Automatically creates project with standard template,
         adds marketing team, sets up task boards, applies
         company conventions] "Done! Here's your project: [link]"
[1-2 messages total]
```

### Install the Skill

**Download:** [Link to skill GitHub repo]

**Quick install:**
1. Download the .skill file from releases
2. Upload to Claude.ai (Settings > Skills)
3. Ensure MyService MCP is connected
4. Try: "Set up a new project in MyService"

## Documentation

[Rest of MCP documentation]
````

## Positioning Your Skill

How you describe your skill determines whether users understand its value and try it.

### Focus on Outcomes, Not Features

**❌ Bad (feature-focused):**
```
The ProjectHub skill is a folder containing YAML frontmatter
and Markdown instructions that calls our MCP server tools.
```

**✅ Good (outcome-focused):**
```
The ProjectHub skill enables teams to set up complete project
workspaces in seconds - including pages, databases, and templates -
instead of spending 30 minutes on manual setup.
```

### Highlight the MCP + Skills Story

**For MCP builders, emphasize the combination:**

```markdown
## Why MyService MCP + Skill?

**MyService MCP** gives Claude access to your data and tools.

**MyService Skill** teaches Claude your team's best practices and workflows.

**Together** they enable AI-powered automation that feels magical:
- One command replaces 20-step manual processes
- Consistent quality every time
- Embedded expertise from your power users
- Lower onboarding time for new team members
```

### Show Before/After

**Concrete examples resonate:**

```markdown
## Real Example: Customer Onboarding

**Before (manual):**
1. Create customer account (2 min)
2. Set up payment method (3 min)
3. Create subscription (2 min)
4. Configure permissions (3 min)
5. Send welcome email (2 min)
**Total: 12 minutes, error-prone**

**After (with skill):**
User: "Onboard new customer: Acme Corp, billing@acme.com"
Claude: [Completes all steps automatically in 30 seconds]
**Total: 30 seconds, consistent quality**
```

### Quantify the Value

**Users want to know: "What do I get?"**

- "Reduces project setup from 30 minutes to 30 seconds"
- "Ensures 100% compliance with company templates"
- "Eliminates 90% of back-and-forth messages"
- "Automates workflows used 50+ times per week"

## GitHub Repository Best Practices

### README Structure

```markdown
# Skill Name

[One-line description]

## Quick Start

[Minimal steps to get started - aim for <60 seconds]

## What This Skill Does

[2-3 paragraphs explaining capabilities]

## Installation

[Detailed installation steps]

## Usage Examples

[3-5 concrete examples with screenshots]

## Requirements

[Prerequisites and dependencies]

## Troubleshooting

[Common issues and solutions]

## Contributing

[How others can contribute]

## License

[License information]
```

### Use Releases

**Create GitHub releases for versions:**

1. Tag your versions (v1.0.0, v1.1.0, etc.)
2. Attach the packaged .skill file to release
3. Write release notes explaining changes
4. Users can download specific versions

**Example release notes:**

```markdown
## v1.2.0 - January 2026

### New Features
- Added support for multi-project workflows
- Integrated with new ProjectHub API endpoints

### Improvements
- Faster project creation (2x speed improvement)
- Better error messages for connection issues

### Bug Fixes
- Fixed issue with special characters in project names
- Resolved template application failures

### Download
- [my-skill.skill](link) - Ready to upload to Claude
```

### Include Screenshots

**Visual examples help:**
- Screenshot of skill in Claude.ai
- Screenshot of result (created project, generated report, etc.)
- GIF of workflow in action (using tool like LICEcap)

**Where to include:**
- README.md (primary location)
- GitHub releases
- Documentation site if you have one

### Provide Examples Directory

```
examples/
├── basic-usage.md          # Simple examples
├── advanced-workflows.md   # Complex examples
├── screenshots/            # Visual examples
│   ├── skill-in-action.png
│   └── result.png
└── sample-inputs/          # Test data
    └── sample-project.json
```

## Promoting Your Skill

### For MCP Builders

**Include skill in your MCP announcement:**

```markdown
Announcing MyService MCP + Skills!

We're excited to release our official MCP server with companion skills
that make Claude your MyService copilot.

What you can do:
- "Set up a project for Q4 planning" - Creates project with full structure
- "Generate status report for Project X" - Analyzes and reports progress
- "Onboard new team member Sarah" - Adds user with appropriate permissions

Get started:
- Install MCP: [link]
- Install Skill: [link]
- Documentation: [link]
```

### Documentation Site

**If you have a docs site, add a skills section:**

- Overview of skills
- Installation guide
- Usage examples
- Comparison: with vs. without skill
- Troubleshooting
- API for programmatic use

### Community Channels

**Share in relevant communities:**
- Claude Developers Discord
- Your product's community forum
- Social media (Twitter, LinkedIn)
- Internal company channels

**Announcement template:**

```
We built a skill that automates [workflow] in [tool]!

Instead of [old painful process], now you can just ask Claude
to [one-line command] and it handles everything.

Check it out: [link]

[Screenshot or GIF]
```

## Measuring Success

### Installation Metrics

Track:
- GitHub stars/forks
- Download count from releases
- Installation rate (if you have telemetry)
- GitHub issues/questions

### Usage Metrics

If using API with telemetry:
- Skill trigger rate
- Successful workflow completions
- Error rates
- User retention (do users keep using it?)

### User Feedback

Collect:
- GitHub issues for bugs
- Feature requests
- User testimonials
- Before/after stories

**Create feedback issue template:**

```markdown
### What were you trying to do?

[Description]

### What happened?

[Actual behavior]

### What did you expect?

[Expected behavior]

### Screenshots

[If applicable]

### Skill version

[Version number]
```

## Versioning Strategy

### Semantic Versioning

Follow semver: MAJOR.MINOR.PATCH

**When to increment:**
- **MAJOR** (1.0.0 → 2.0.0): Breaking changes (old workflows don't work)
- **MINOR** (1.0.0 → 1.1.0): New features (backward compatible)
- **PATCH** (1.0.0 → 1.0.1): Bug fixes (no new features)

**Update version in:**
- metadata.version in SKILL.md frontmatter
- GitHub release tag
- CHANGELOG.md

### Changelog

Maintain CHANGELOG.md:

```markdown
# Changelog

## [1.2.0] - 2026-01-15

### Added
- Multi-project workflow support
- Integration with new API endpoints

### Changed
- Improved project creation speed (2x faster)
- Updated error messages for clarity

### Fixed
- Special characters in project names now handled
- Template application failures resolved

## [1.1.0] - 2025-12-10

[Previous version notes]
```

## Supporting Your Users

### Documentation

Provide:
- Installation guide (step-by-step)
- Usage examples (concrete scenarios)
- Troubleshooting (common issues)
- API reference (if programmatic use supported)
- FAQ (frequently asked questions)

### Issue Management

**Be responsive:**
- Triage issues quickly (within 24-48 hours)
- Label appropriately (bug, feature, question)
- Close resolved issues promptly
- Link to documentation when applicable

**Issue templates help:**
- Bug report template
- Feature request template
- Question template

### Support Channels

**Provide multiple options:**
- GitHub Issues (public, searchable)
- Email (for private concerns)
- Discord/Slack (for community)
- Documentation site (for self-service)

## For MCP Builders: Complete Checklist

When distributing skills with your MCP:

- [ ] Skill hosted on GitHub with clear README
- [ ] .skill file attached to GitHub releases
- [ ] Installation instructions in MCP documentation
- [ ] "Why MCP + Skill" section explaining value
- [ ] Before/after examples showing improvement
- [ ] Screenshots or GIFs demonstrating usage
- [ ] Troubleshooting section for common issues
- [ ] Link to skill repo from MCP repo
- [ ] Version numbers match (skill v1.0 with MCP v1.0)
- [ ] Support channels clearly listed
- [ ] License information provided
- [ ] Changelog maintained
- [ ] Examples directory with sample usage

## Summary

**Distribute skills effectively by:**
1. Hosting on GitHub with clear documentation
2. Providing .skill file downloads via releases
3. Creating concrete before/after examples
4. Linking skill with MCP (if applicable)
5. Focusing on outcomes, not technical details
6. Making installation dead simple
7. Providing excellent support

**For MCP builders:** Skills complete your integration. Users who install both your MCP and skill get 10x better experience than MCP alone.

**For all builders:** Good distribution means users can find, install, and succeed with your skill in <5 minutes.
