---
name: skill-creator
description: Use when creating, editing, or improving a skill. Covers the complete lifecycle: designing skill content with SSO and bulletproofing, pressure-testing with subagents, running quantitative eval benchmarks, optimizing description triggering, and packaging into .skill files. Use when user asks to "create a skill", "write a skill", "improve a skill", "update a skill", "optimize a skill", "edit SKILL.md", "test a skill", "refine a skill", or "package a skill". Trigger whenever a skill needs to be written, modified, or made more effective.
---

# Skill Creator

A skill for creating new skills and iteratively improving existing ones.

## Core Principles

### Iron Law

```
NO SKILL WITHOUT A FAILING TEST FIRST
```

This applies to NEW skills AND EDITS to existing skills. Write skill before testing? Delete it. Start over. Edit without testing? Same violation.

**No exceptions:** no "simple additions", no "just adding a section", no "it's obviously fine." If you wouldn't deploy untested code, don't deploy untested skills.

### Language Consistency

When modifying an existing skill, BEFORE making any changes:
1. Read the existing SKILL.md and note its language
2. ALL updates — description, body text, reference files, examples — MUST match the detected language
3. English skill → all edits in English. 中文 skill → 所有编辑用中文.
4. If the skill mixes languages, follow the dominant language (>80% of content)

This applies to every artifact: SKILL.md body, description field, reference/*.md, code comments in scripts, and eval prompts.

## Process Overview

The skill lifecycle has three phases. Follow them in order.

```
DESIGN → VERIFY → SHIP
  │         │        │
  │   Fail? Loop back  │
  │         │        │
  └─────────┴────────┘
```

## Phase 1: Design

### Step 1: Capture Intent

Ask — or extract from conversation history:
1. What should this skill enable Claude to do?
2. When should it trigger? (what phrases, contexts)
3. What's the expected output format?
4. Should we set up test cases? Skills with objectively verifiable outputs (file transforms, code generation) benefit from test cases. Subjective outputs (writing style, art) often don't. Suggest the appropriate default, let the user decide.

### Step 2: Interview and Research

Probe edge cases, input/output formats, example files, success criteria, and dependencies. Check available MCP tools if relevant.

### Step 3: Write the Draft

For content writing guidance — structure templates, SSO principles, anti-patterns, bulletproofing techniques — read `references/skill-writing-guide.md`.

Key requirements for the draft:
- YAML frontmatter with `name` and `description`
- Description: third person, "Use when...", triggering conditions only — do NOT summarize workflow
- SKILL.md body under 500 lines; use progressive disclosure for details (see `references/anthropic-best-practices.md`)
- One excellent example, not multiple languages

### Step 4: Create Test Cases

Draft 2-3 realistic test prompts. Save to `evals/evals.json` (prompts only, assertions come later):

```json
{
  "skill_name": "example-skill",
  "evals": [
    {
      "id": 1,
      "prompt": "User's task prompt",
      "expected_output": "Description of expected result",
      "files": []
    }
  ]
}
```

See `references/schemas.md` for the full schema.

## Phase 2: Verify

This phase uses the testing pipeline. For detailed testing methodology — pressure scenarios, rationalization hunting, RED-GREEN-REFACTOR cycle — read `references/testing-methodology.md`.

### For New Skills

Run the full cycle: baseline (without skill) → with skill → iterate.

### For Improving Existing Skills

1. **Snapshot the current version:** `cp -r <skill-path> <workspace>/skill-snapshot/`
2. **Check language** (see Language Consistency principle above)
3. Use the snapshot as the baseline (instead of `without_skill`)
4. Full Phase 2 cycle against the snapshot baseline

### Step 1: Spawn All Runs in Parallel

Put results in `<skill-name>-workspace/` as a sibling to the skill directory. Organize by iteration (`iteration-1/`, `iteration-2/`) and within that, per test case directory.

Launch two subagents per test case simultaneously:

**With-skill run:**
```
Execute this task:
- Skill path: <path-to-skill>
- Task: <eval prompt>
- Input files: <eval files if any, or "none">
- Save outputs to: <workspace>/iteration-<N>/eval-<ID>/with_skill/outputs/
- Outputs to save: <what the user cares about>
```

**Baseline run** (same prompt, different config):
- New skill: no skill at all. Save to `without_skill/outputs/`.
- Improving existing skill: point at the snapshot. Save to `old_skill/outputs/`.

Write `eval_metadata.json` per test case (assertions can be empty for now):

```json
{
  "eval_id": 0,
  "eval_name": "descriptive-name-here",
  "prompt": "The user's task prompt",
  "assertions": []
}
```

### Step 2: Draft Assertions While Runs Are in Progress

Draft quantitative assertions for each test case. Good assertions are objectively verifiable and have descriptive names. Update `eval_metadata.json` and `evals/evals.json`. Explain them to the user.

### Step 3: Capture Timing Data

When each subagent task completes, save `total_tokens` and `duration_ms` to `timing.json` in the run directory. Process each notification as it arrives — this is the only opportunity to capture this data.

### Step 4: Grade, Aggregate, and Launch the Viewer

1. **Grade each run** — spawn a grader subagent using `agents/grader.md` that evaluates each assertion against the outputs. Save to `grading.json`. The `expectations` array must use fields `text`, `passed`, `evidence`.

2. **Aggregate into benchmark:**
   ```bash
   python -m scripts.aggregate_benchmark <workspace>/iteration-N --skill-name <name>
   ```
   Produces `benchmark.json` and `benchmark.md`.

3. **Analyst pass** — read `agents/analyzer.md` and surface patterns: assertions that always pass (non-discriminating), high-variance evals (flaky), time/token tradeoffs.

4. **Launch the viewer:**
   ```bash
   nohup python <skill-creator-path>/eval-viewer/generate_review.py \
     <workspace>/iteration-N \
     --skill-name "my-skill" \
     --benchmark <workspace>/iteration-N/benchmark.json \
     > /dev/null 2>&1 &
   ```
   For iteration 2+, add `--previous-workspace <workspace>/iteration-<N-1>`.
   
   **No browser:** use `--static <output_path>` for a standalone HTML file. After feedback, `feedback.json` will be downloaded.

5. **Tell the user:** "I've opened the results. 'Outputs' shows each test case with feedback boxes, 'Benchmark' shows quantitative comparison. When you're done, let me know."

### Step 5: Read Feedback and Decide

Read `feedback.json`. Empty feedback means the user thought it was fine. Focus improvements on test cases with specific complaints. Kill the viewer server when done.

## Improving the Skill (Iteration Loop)

### How to Think About Improvements

1. **Generalize from feedback.** These few test cases stand in for millions of future uses. Don't overfit — if a fix works only for the test cases, it's useless. Try different metaphors, different patterns.

2. **Keep the prompt lean.** Read transcripts, not just outputs. Remove sections that make the model waste time.

3. **Explain the why.** The model is smart — understanding reasoning produces more reliable compliance than rigid MUSTs.

4. **Look for repeated work.** If all test runs independently wrote similar helper scripts, bundle that script into `scripts/`.

### The Loop

1. Apply improvements to the skill
2. Rerun all test cases into `iteration-<N+1>/`
3. Launch reviewer with `--previous-workspace` pointing at prior iteration
4. Wait for user review → read feedback → improve again

**Stop when:** user says they're happy, feedback is all empty, or you're not making meaningful progress.

## Phase 3: Ship

### Description Optimization

The description in SKILL.md frontmatter determines whether Claude invokes a skill. Optimize it after the skill content is stable.

**Step 1: Generate trigger eval queries** — 20 queries, mix of should-trigger (8-10) and should-not-trigger (8-10). Edge cases, casual speech, adjacent domains. Good: detailed, realistic user prompts with context. Bad: "Format this data", "Extract text from PDF".

**Step 2: Review with user** — use the `assets/eval_review.html` template to let the user edit and export the eval set.

**Step 3: Run optimization loop:**
```bash
python -m scripts.run_loop \
  --eval-set <path-to-trigger-eval.json> \
  --skill-path <path-to-skill> \
  --model <model-id-powering-this-session> \
  --max-iterations 5 \
  --verbose
```
This splits eval set 60/40 train/test, iterates up to 5 times, selects best description by test score.

**Step 4: Apply result** — take `best_description` from JSON output, update SKILL.md frontmatter, show before/after.

### Package and Present

```bash
python -m scripts.package_skill <path/to/skill-folder>
```

Direct the user to the resulting `.skill` file.

## Advanced: Blind Comparison

For rigorous comparison between two skill versions, read `agents/comparator.md` and `agents/analyzer.md`. Basic idea: give two outputs to an independent agent without telling it which is which, let it judge quality, analyze why the winner won. Optional — the human review loop is usually sufficient.

## Platform-Specific Instructions

### Claude.ai

No subagents → run test cases one at a time, skip baselines, present results inline. Skip quantitative benchmarking and description optimization (requires `claude -p` CLI). Packaging works.

### Cowork

Subagents work, but no browser → use `--static` for viewer. Feedback via `feedback.json` download. Packaging and description optimization work.

### Updating an Existing Skill

- Preserve the original name and directory name.
- Copy to a writable location before editing if the installed path is read-only.
- Check language consistency before any change.

## Reference Files

Load on demand as needed for each phase:

| File | When to Read | Content |
|------|-------------|---------|
| `references/skill-writing-guide.md` | Phase 1 — drafting | SSO, structure templates, bulletproofing, anti-patterns |
| `references/testing-methodology.md` | Phase 2 — verification | Pressure scenarios, RED-GREEN-REFACTOR, rationalization hunting |
| `references/anthropic-best-practices.md` | Any phase — reference | Official Anthropic guidance on skill authoring |
| `references/schemas.md` | Phase 2 — eval setup | JSON structures for evals.json, grading.json, etc. |
| `agents/grader.md` | Phase 2 — grading | How to evaluate assertions against outputs |
| `agents/comparator.md` | Advanced | Blind A/B comparison between outputs |
| `agents/analyzer.md` | Phase 2 — analysis | Analyzing benchmark results |
