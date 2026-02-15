# Quick Reference Checklist

Use this checklist to validate your skill before and after upload. Print this out or keep it handy during development.

## Before You Start

- [ ] Identified 2-3 concrete use cases for the skill
- [ ] Determined skill category (Document Creation | Workflow Automation | MCP Enhancement)
- [ ] Listed tools needed (built-in Claude tools OR MCP servers)
- [ ] Reviewed example skills for similar use cases
- [ ] Reviewed this guide and relevant reference docs
- [ ] Planned folder structure (which resources needed: scripts/, references/, assets/)

## During Development

### File Structure

- [ ] Folder named in kebab-case (lowercase, hyphens only, no spaces/underscores)
- [ ] SKILL.md file exists (exact spelling, case-sensitive)
- [ ] SKILL.md is in root of skill folder (not in subfolder)
- [ ] No README.md inside skill folder (README only at repo level if distributing)

### YAML Frontmatter

- [ ] Frontmatter starts with `---` on its own line
- [ ] Frontmatter ends with `---` on its own line
- [ ] `name` field present
- [ ] `name` is kebab-case (lowercase, hyphens only)
- [ ] `name` matches folder name exactly
- [ ] `name` doesn't contain "claude" or "anthropic" (reserved)
- [ ] `description` field present
- [ ] `description` includes WHAT the skill does
- [ ] `description` includes WHEN to use it
- [ ] `description` has 3-5 specific trigger phrases
- [ ] `description` mentions file types if relevant (.pdf, .docx, .csv, etc.)
- [ ] `description` is under 1024 characters (aim for 200-400)
- [ ] No XML angle brackets (< or >) anywhere in frontmatter
- [ ] No unescaped quotes or YAML syntax errors
- [ ] All quotes properly closed
- [ ] Optional fields (license, metadata) formatted correctly if used

### Description Quality

- [ ] Uses formula: [What] + [When] + [Capabilities]
- [ ] Includes action verbs ("create", "analyze", "generate")
- [ ] Includes user-facing language (not technical jargon)
- [ ] Trigger phrases are what users would actually say
- [ ] File types mentioned if skill handles specific formats
- [ ] Specific enough to avoid overtriggering
- [ ] Broad enough to catch all relevant queries
- [ ] Negative triggers included if needed (to prevent overtriggering)

### SKILL.md Body

- [ ] Instructions are clear and actionable
- [ ] Examples provided for common use cases
- [ ] Error handling documented
- [ ] References to bundled resources (scripts/, references/, assets/) are clear
- [ ] Step-by-step workflows use numbered lists
- [ ] Critical steps marked clearly (CRITICAL:, IMPORTANT:, etc.)
- [ ] Script paths correct (e.g., `scripts/validate.py` not just `validate.py`)
- [ ] MCP tool names match server documentation exactly (if applicable)
- [ ] Progressive disclosure used (detailed info in references/, not all in SKILL.md)
- [ ] SKILL.md under 5,000 words (rough target for performance)

### Bundled Resources

**Scripts (scripts/)**

- [ ] All scripts tested independently (run them to verify they work)
- [ ] Script permissions set correctly (chmod +x for executable scripts)
- [ ] Script dependencies documented (Python version, packages, etc.)
- [ ] Scripts referenced correctly from SKILL.md
- [ ] Error messages from scripts are helpful
- [ ] Example scripts deleted if not needed

**References (references/)**

- [ ] Reference files clearly linked from SKILL.md
- [ ] When to read each reference documented in SKILL.md
- [ ] Reference files use clear headers and structure
- [ ] Files over 100 lines have table of contents
- [ ] No duplication between SKILL.md and references
- [ ] Example reference files deleted if not needed

**Assets (assets/)**

- [ ] Asset files clearly referenced from SKILL.md
- [ ] Assets are files used IN output (not documentation)
- [ ] Templates tested (if applicable)
- [ ] Assets organized in clear structure
- [ ] Example asset files deleted if not needed

## Before Upload

### Validation

- [ ] Run validation script: `python scripts/quick_validate.py skill-folder/`
- [ ] All validation errors fixed
- [ ] No warnings about common issues

### Triggering Tests

Test that skill triggers correctly:

- [ ] Tested with 5-10 phrases that SHOULD trigger
- [ ] At least 80% of relevant phrases trigger the skill
- [ ] Tested with 3-5 phrases that should NOT trigger
- [ ] Skill doesn't trigger on unrelated topics
- [ ] Paraphrased requests also trigger (not just exact phrases)

### Functional Tests

- [ ] Skill produces expected outputs
- [ ] All scripts execute successfully
- [ ] All MCP tool calls work (if applicable)
- [ ] Error handling works as expected
- [ ] Edge cases handled appropriately

### MCP-Specific Tests (if applicable)

- [ ] MCP server connected before testing skill
- [ ] Tested MCP independently (without skill) first
- [ ] All MCP tool names match server exactly
- [ ] All parameters correct (names and types)
- [ ] Authentication works
- [ ] Error handling for failed MCP calls included

### Packaging

- [ ] Skill packaged using: `python scripts/package_skill.py skill-folder/`
- [ ] .skill file created successfully
- [ ] .skill file size reasonable (< 10 MB typically)
- [ ] Test upload .skill file to Claude.ai

## After Upload

### Initial Testing

- [ ] Upload successful to Claude.ai (Settings > Capabilities > Skills)
- [ ] Skill appears in skills list
- [ ] Skill can be toggled on/off
- [ ] Test in real conversations (not just test queries)

### Triggering Validation

- [ ] Test with obvious trigger phrases - does it load?
- [ ] Test with paraphrased requests - still loads?
- [ ] Test with unrelated topics - doesn't load?
- [ ] Check triggering rate: aim for 90% of relevant queries

### Quality Checks

- [ ] Outputs match expectations
- [ ] Workflows complete without errors
- [ ] No failed API/MCP calls
- [ ] Results consistent across multiple runs
- [ ] Users don't need to prompt about next steps

### Performance

- [ ] Skill responds in reasonable time
- [ ] No noticeable slowdown from skill being enabled
- [ ] Context window usage seems appropriate
- [ ] If slow, consider moving content to references/

## Iteration and Improvement

### Monitor for Issues

- [ ] Track undertriggering (skill doesn't load when it should)
- [ ] Track overtriggering (skill loads for irrelevant queries)
- [ ] Track execution errors (failures during workflow)
- [ ] Collect user feedback
- [ ] Note edge cases that fail

### Undertriggering Signals

If you observe:
- Skill doesn't load when it should
- Users manually enabling it
- Support questions: "When do I use this?"

**Fix:** Add more trigger phrases to description, include variations

### Overtriggering Signals

If you observe:
- Skill loads for irrelevant queries
- Users disabling it
- Confusion about purpose

**Fix:** Add negative triggers, be more specific in description

### Execution Issues

If you observe:
- Inconsistent results
- API/MCP call failures
- Users need to correct output

**Fix:** Improve instructions, add error handling, add examples

### Update Skill

- [ ] Make improvements based on feedback
- [ ] Test changes thoroughly
- [ ] Update version in metadata (if using versioning)
- [ ] Re-package skill
- [ ] Re-upload to Claude.ai
- [ ] Document changes in CHANGELOG (if applicable)

## Quick Validation Commands

```bash
# Validate skill structure and frontmatter
python scripts/quick_validate.py your-skill-folder/

# Package skill for distribution
python scripts/package_skill.py your-skill-folder/

# Package to specific output directory
python scripts/package_skill.py your-skill-folder/ ./dist/
```

## Common Mistakes to Avoid

- [ ] Avoid: Vague descriptions ("Helps with projects")
- [ ] Avoid: Missing trigger phrases ("when to use")
- [ ] Avoid: Wrong file naming (skill.md instead of SKILL.md)
- [ ] Avoid: Spaces in skill folder name
- [ ] Avoid: README.md inside skill folder
- [ ] Avoid: XML brackets in description
- [ ] Avoid: Incorrect script paths in SKILL.md
- [ ] Avoid: All content in SKILL.md (use references/)
- [ ] Avoid: Not testing scripts before packaging
- [ ] Avoid: Assuming MCP tool names (verify exact names)

## Quality Indicators

Your skill is probably ready if:

- [ ] A new user can understand when to use it (from description alone)
- [ ] Triggers on 80-90% of relevant test queries
- [ ] Doesn't trigger on unrelated topics
- [ ] Completes workflows without user corrections
- [ ] Produces consistent results across runs
- [ ] Validation script passes without errors
- [ ] You've tested it in real scenarios (not just test queries)
- [ ] Documentation is clear enough that you could hand it to someone else

## Reference Resources

**For detailed guidance:**

- Description writing: See references/description-best-practices.md
- Workflow patterns: See references/workflows.md
- Testing approaches: See references/testing-guide.md
- MCP integration: See references/mcp-integration.md
- Troubleshooting: See references/troubleshooting.md
- Frontmatter fields: See references/frontmatter-reference.md
- Distribution: See references/distribution.md

## Pre-Distribution Checklist

### For Public/Open Source Skills

- [ ] GitHub repository created
- [ ] README.md at repo level (for humans, not in skill folder)
- [ ] LICENSE file included
- [ ] .gitignore configured
- [ ] Installation instructions clear
- [ ] Screenshots or examples included
- [ ] GitHub release created with .skill file attached
- [ ] Version number set in metadata
- [ ] CHANGELOG.md maintained
- [ ] Contributing guidelines (if accepting contributions)
- [ ] Issue templates configured
- [ ] Support channels documented

### For MCP Builders

- [ ] Skill linked from MCP documentation
- [ ] "Why MCP + Skill" section written
- [ ] Before/after examples provided
- [ ] Installation guide includes both MCP and skill
- [ ] Versions aligned (skill v1.0 with MCP v1.0)

## Final Check

Before considering your skill complete:

- [ ] I've tested this skill in real usage (not just synthetic tests)
- [ ] At least 2-3 other people have tried it successfully
- [ ] Common issues are documented in troubleshooting
- [ ] I'm confident a stranger could install and use this skill
- [ ] All TODO items in SKILL.md are completed
- [ ] Validation passes without errors
- [ ] I've checked the skill against this entire checklist

## Success Metrics (Optional)

Track these if you want to measure skill effectiveness:

**Quantitative:**
- Trigger rate: ___% (target: 90%)
- Tool calls reduced: ___% (target: 30-50% reduction)
- Failed API calls: ___ (target: 0)
- Token usage: ___ (with skill) vs ___ (without skill)

**Qualitative:**
- Users don't need prompting about next steps: YES / NO
- Consistent results across sessions: YES / NO
- First-time users succeed without guidance: YES / NO

**User Feedback:**
- GitHub stars: ___
- Downloads: ___
- Active users: ___
- Support questions: ___ per week

---

**Print this checklist** or keep it open while developing your skill. Check off items as you complete them to ensure you don't miss anything critical.

**Remember:** The most important items are:
1. Clear, specific description with trigger phrases
2. SKILL.md named exactly right
3. Valid YAML frontmatter
4. Testing with real queries (not just synthetic tests)
5. Validation script passes
