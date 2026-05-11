# Skill Authoring Best Practices (Anthropic Official)

> Official guidance from Anthropic. Read when you need the authoritative reference on skill structure, progressive disclosure, and evaluation patterns.

## Core Principles

### Concise is Key

The context window is a public good. Your Skill shares it with the system prompt, conversation history, other Skills' metadata, and the actual request. Only add context Claude doesn't already have. Challenge each piece of information: "Does Claude really need this explanation?"

### Set Appropriate Degrees of Freedom

Match specificity to the task's fragility:
- **High freedom** (text instructions): Multiple approaches valid, decisions depend on context
- **Medium freedom** (pseudocode with parameters): Preferred pattern exists, some variation OK
- **Low freedom** (specific scripts): Operations are fragile, consistency critical

### Test with All Models

Skills act as additions to models, so effectiveness depends on the underlying model. Test with all models you plan to use.

## Skill Structure

### Frontmatter

- `name`: Human-readable, max 64 characters. Use gerund form: "Processing PDFs", "Managing databases"
- `description`: One-line, max 1024 characters. Third person. Include both what it does and when to use it.

### Naming Conventions

Use gerund form (verb + -ing) for consistency:
- ✅ "Processing PDFs", "Analyzing spreadsheets"
- ❌ "PDF Processing", vague names like "Helper", "Utils"

### Progressive Disclosure

Keep SKILL.md body under 500 lines. For complex skills, organize references by domain:

```
bigquery-skill/
├── SKILL.md (overview and navigation)
└── references/
    ├── finance.md
    ├── sales.md
    └── product.md
```

Keep references exactly one level deep from SKILL.md. Nested references (SKILL.md → advanced.md → details.md) cause partial reads.

### Structure Reference Files

For reference files over 100 lines, include a table of contents at the top so Claude can see the full scope even with partial reads.

## Workflows and Feedback Loops

### Break Complex Operations into Steps

Provide a checklist Claude can copy and check off as it progresses through multi-step workflows.

### Implement Feedback Loops

Common pattern: run validator → fix errors → repeat. This catches errors early. For critical operations, validate before proceeding.

## Content Guidelines

### Avoid Time-Sensitive Information

Don't include info that will become outdated. Use "old patterns" sections for deprecated approaches.

### Use Consistent Terminology

Choose one term and use it throughout: always "API endpoint", not mixing "URL", "route", "path".

### Template Pattern

For strict output requirements, use exact templates with "ALWAYS use this exact template." For flexible guidance, provide a sensible default and note that adaptation is acceptable.

### Examples Pattern

Provide input/output pairs. Examples help Claude understand desired style and detail level more clearly than descriptions alone.

## Evaluation and Iteration

### Build Evaluations First

Create evaluations BEFORE extensive documentation:
1. Identify gaps by running Claude without a Skill on representative tasks
2. Create three scenarios that test these gaps
3. Establish baseline performance
4. Write minimal instructions to address gaps
5. Iterate: execute evaluations, compare against baseline, refine

### Develop Skills Iteratively

Work with one Claude instance to design the skill, test with another. The designing Claude understands agent needs; the testing Claude reveals gaps through real usage.

### Observe Usage Patterns

Watch for: unexpected exploration paths, missed connections to reference files, overreliance on certain sections, ignored content.

## Anti-Patterns

- **Windows-style paths**: Always use forward slashes (`scripts/helper.py`)
- **Too many options**: Provide one default, mention alternatives only when necessary
- **Deeply nested references**: Keep exactly one level deep from SKILL.md
- **Assuming tools are installed**: List dependencies explicitly
- **Vague descriptions**: "Helps with documents" → "Extracts text and tables from PDF files, fills forms, and merges documents"

## Advanced: Skills with Executable Code

### Solve, Don't Punt

Handle error conditions in scripts rather than failing and leaving Claude to figure it out.

### Provide Utility Scripts

Pre-made scripts are more reliable than generated code, save tokens, and ensure consistency. Make clear whether Claude should execute the script or read it as reference.

### Create Verifiable Intermediate Outputs

For complex operations, use plan-validate-execute pattern: Claude creates a structured plan, a script validates it, then Claude executes. Catches errors before they become problems.

## Checklist for Effective Skills

- [ ] Description is specific, in third person, includes both what and when
- [ ] SKILL.md body under 500 lines
- [ ] Additional details in separate files with progressive disclosure
- [ ] No time-sensitive information
- [ ] Consistent terminology throughout
- [ ] File references one level deep
- [ ] Scripts solve problems rather than punt to Claude
- [ ] At least three evaluations created
- [ ] Tested with all target models
- [ ] Tested with real usage scenarios
