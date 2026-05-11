# Skill Writing Guide

Load this reference when drafting a new skill or rewriting an existing one's content. Covers structure, SSO (Skill Search Optimization), bulletproofing, and anti-patterns. Note: this guide uses "the agent" to refer to the AI assistant generically — applies across all platforms (Claude, OpenCode, Copilot, Gemini, etc.).

## What is a Skill?

A **skill** is a reference guide for proven techniques, patterns, or tools. Skills help future agent instances find and apply effective approaches.

**Skills are:** Reusable techniques, patterns, tools, reference guides
**Skills are NOT:** Narratives about how you solved a problem once

## When to Create a Skill

**Create when:**
- Technique wasn't intuitively obvious to you
- You'd reference this again across projects
- Pattern applies broadly (not project-specific)
- Others would benefit

**Don't create for:**
- One-off solutions
- Standard practices well-documented elsewhere
- Project-specific conventions (put in AGENTS.md or CLAUDE.md)
- Mechanical constraints (if enforceable with regex/validation, automate it — save documentation for judgment calls)

## Skill Types

### Technique
Concrete method with steps to follow (e.g., condition-based-waiting, root-cause-tracing)

### Pattern
Way of thinking about problems (e.g., flatten-with-flags, test-invariants)

### Reference
API docs, syntax guides, tool documentation (e.g., office docs)

## Directory Structure

```
skill-name/
├── SKILL.md              # Required — main reference
├── scripts/              # Optional — executable code for deterministic tasks
├── references/           # Optional — docs loaded on demand
└── assets/               # Optional — templates, icons, fonts used in output
```

**Separate files for:**
- Heavy reference (100+ lines) — API docs, comprehensive syntax
- Reusable tools — scripts, utilities, templates

**Keep inline:**
- Principles and concepts
- Code patterns (< 50 lines)

## SKILL.md Structure Template

```markdown
---
name: skill-name-with-hyphens
description: Use when [specific triggering conditions and symptoms]
---

# Skill Name

## Overview
What is this? Core principle in 1-2 sentences.

## When to Use
[Small inline flowchart IF decision non-obvious]

Bullet list with SYMPTOMS and use cases
When NOT to use

## Core Pattern (for techniques/patterns)
Before/after code comparison

## Quick Reference
Table or bullets for scanning common operations

## Implementation
Inline code for simple patterns
Link to file for heavy reference or reusable tools

## Common Mistakes
What goes wrong + fixes
```

### Frontmatter Requirements

- `name`: letters, numbers, hyphens only (no parentheses, special chars), max 64 chars
- `description`: third person, describes triggering conditions. Max 1024 chars.
- Keep frontmatter under 1024 characters total

## Skill Search Optimization (SSO)

SSO ensures skills are discovered and loaded at the right time.

### 1. Description: When to Use, NOT What the Skill Does

**CRITICAL:** The description should ONLY describe triggering conditions. Do NOT summarize the skill's process or workflow.

**Why:** Testing revealed that when a description summarizes the workflow, the agent follows the summary instead of reading the full skill. A description saying "code review between tasks" caused the agent to do ONE review, even though the skill's flowchart showed TWO reviews.

```yaml
# BAD: Summarizes workflow — the agent may follow this instead of reading skill
description: Use for TDD — write test first, watch it fail, write minimal code, refactor

# BAD: Too abstract
description: For async testing

# BAD: First person
description: I can help you with async tests when they're flaky

# GOOD: Just triggering conditions, no workflow summary
description: Use when implementing any feature or bugfix, before writing implementation code

# GOOD: Triggers with specific symptoms
description: Use when tests have race conditions, timing dependencies, or pass/fail inconsistently
```

**Content guidelines:**
- Start with "Use when..." to focus on triggering conditions
- Use concrete triggers, symptoms, and situations
- Describe the *problem* (race conditions, inconsistent behavior) not *language-specific symptoms* (setTimeout, sleep)
- If skill is technology-specific, make that explicit in the trigger
- Write in third person — description is injected into the system prompt

### 2. Keyword Coverage

Use words agents would search for:
- Error messages: "Hook timed out", "ENOTEMPTY", "race condition"
- Symptoms: "flaky", "hanging", "zombie", "pollution"
- Synonyms: "timeout/hang/freeze", "cleanup/teardown/afterEach"
- Tools: actual commands, library names, file types

### 3. Name by Action or Insight

- Use active voice, verb-first: `creating-skills` not `skill-creation`
- Gerunds (-ing) work well for processes: `debugging-with-logs`, `testing-skills`
- ✅ `condition-based-waiting` > `async-test-helpers`
- ✅ `flatten-with-flags` > `data-structure-refactoring`

### 4. Token Efficiency

**Problem:** Heavily used skills load into every conversation. Every token counts.

**Targets:**
- Getting-started / frequently-loaded: <200 words
- Other skills: <500 words

**Techniques:**
- Move details to tool help: `search --help` instead of documenting all flags
- Use cross-references instead of repeating content from other skills
- Compress examples — one excellent example beats three verbose ones
- Eliminate redundancy — don't repeat what's in cross-referenced skills

## Writing Principles

### Explain the Why

Explain WHY each instruction matters, rather than using heavy-handed MUSTs. Today's LLMs have good theory of mind — understanding the reasoning produces more reliable compliance than rigid ALL-CAPS rules.

### One Excellent Example

Choose the most relevant language. One complete, well-commented, runnable example from a real scenario beats many mediocre ones across multiple languages.

**Good example:** Complete, commented, from real scenario, shows pattern clearly, ready to adapt
**Don't:** Implement in 5+ languages, create fill-in-the-blank templates, write contrived examples

### Match Degrees of Freedom

| Freedom | Use when | Example |
|---------|----------|---------|
| **High** (text instructions) | Multiple approaches valid, context-dependent | Code review process |
| **Medium** (pseudocode/scripts with params) | Preferred pattern exists, some variation OK | Report generation with format options |
| **Low** (specific scripts, no params) | Fragile operations, consistency critical | Database migration with exact command |

### Flowchart Usage

Use flowcharts ONLY for:
- Non-obvious decision points
- Process loops where you might stop too early
- "When to use A vs B" decisions

Never use flowcharts for:
- Reference material → Tables, lists
- Code examples → Markdown blocks
- Linear instructions → Numbered lists
- Labels without semantic meaning (step1, helper2)

## Bulletproofing: Making Skills Resist Rationalization

Skills that enforce discipline need to resist rationalization. Agents are smart and will find loopholes when under pressure.

### Close Every Loophole Explicitly

Don't just state the rule — forbid specific workarounds:

```markdown
# WEAK
Write code before test? Delete it.

# STRONG
Write code before test? Delete it. Start over.

**No exceptions:**
- Don't keep it as "reference"
- Don't "adapt" it while writing tests
- Don't look at it
- Delete means delete
```

### Add a Foundational Principle

```markdown
**Violating the letter of the rules is violating the spirit of the rules.**
```

This cuts off entire class of "I'm following the spirit" rationalizations.

### Build Rationalization Table

Every excuse agents make gets a counter:

```markdown
| Excuse | Reality |
|--------|---------|
| "Too simple to test" | Simple code breaks. Test takes 30 seconds. |
| "I'll test after" | Tests passing immediately prove nothing. |
| "This case is different because..." | It never is. The rule exists precisely for these moments. |
```

### Create Red Flags List

```markdown
## Red Flags — STOP

- "I already manually tested it"
- "Tests after achieve the same purpose"
- "It's about spirit not ritual"
- "This is different because..."

**All of these mean: Stop and follow the rule.**
```

### Persuasion Principles Quick Reference

Skills apply persuasion psychology to ensure compliance. Use deliberately, not manipulatively.

| Principle | Mechanism | Use for | Avoid for |
|-----------|-----------|---------|-----------|
| **Authority** | Imperative language, non-negotiable framing | Discipline-enforcing skills | Collaborative guidance |
| **Commitment** | Require announcements, force explicit choices | Multi-step processes | Reflective tasks |
| **Scarcity** | Time-bound requirements, sequential dependencies | Verification steps | Open-ended exploration |
| **Social Proof** | Universal patterns: "Every time", "Always" | Establishing norms | Individual judgment calls |
| **Unity** | Collaborative language: "we", "our codebase" | Non-hierarchical practices | — |
| **Liking + Reciprocity** | — | Almost never | Creates sycophancy, conflicts with honest feedback |

**Bright-line rules reduce rationalization:** "YOU MUST" removes decision fatigue. Absolute language eliminates "is this an exception?" questions.

## Anti-Patterns

- **Narrative example:** "In session 2025-10-03, we found..." — too specific, not reusable
- **Multi-language dilution:** example-js.js, example-py.py, example-go.go — mediocre quality, maintenance burden
- **Code in flowcharts** — can't copy-paste, hard to read
- **Generic labels:** helper1, step3 — labels need semantic meaning
- **Vague names:** "Helper", "Utils", "Tools" — invisible during search
- **Deeply nested references:** SKILL.md → advanced.md → details.md — keep exactly one level deep from SKILL.md
- **Windows-style paths:** `scripts\helper.py` — use forward slashes: `scripts/helper.py`
- **Summarizing workflow in description:** the agent skips the skill body — see SSO section 1

## File Organization Patterns

**Self-contained skill** — all content fits in SKILL.md, no heavy reference needed

**Skill with reusable tools:**
```
condition-based-waiting/
├── SKILL.md        # Overview + patterns
└── example.ts      # Working helpers to adapt
```

**Skill with heavy reference:**
```
pptx/
├── SKILL.md         # Overview + workflows
├── references/
│   ├── pptxgenjs.md # 600 lines API reference
│   └── ooxml.md     # 500 lines XML structure
└── scripts/         # Executable tools
```

## Checklist Before Leaving Draft Phase

- [ ] Name uses only letters, numbers, hyphens
- [ ] Description starts with "Use when...", third person, no workflow summary
- [ ] Description includes specific triggers, symptoms, and contexts
- [ ] Keywords throughout for discovery (errors, symptoms, tools)
- [ ] SKILL.md body under 500 lines
- [ ] One excellent, runnable code example (not multi-language)
- [ ] Small flowchart only if decision non-obvious
- [ ] Common mistakes section
- [ ] No narrative storytelling
- [ ] File references one level deep
