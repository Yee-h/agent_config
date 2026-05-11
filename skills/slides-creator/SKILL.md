---
name: slides-creator
description: Use when the user asks to create a presentation, PPT, slides, or slide deck. Use when the user mentions 做PPT, 做幻灯片, 演示文稿, Keynote, slides, create presentation, 生成PPT, or 制作演示文稿. For end-to-end presentation creation with design systems, AI illustrations, and repeat verification.
---

# AI Presentation Workflow

## Overview

Three complementary presentation paths sharing one contract: **outline first, verify repeat**. Choose by editability vs visual impact vs source fidelity.

## Hard Rules (Enforced Across All Paths)

### Rule 1: Outline First (Markdown Document)
Before generating any PPT content, you must have a complete slide outline as a markdown document file (e.g. `<project>-outline.md`). If a qualified outline already exists, reuse it directly — do NOT recreate. See Step 0.5 for quality assessment criteria. Only proceed to Design System (Step 2) and Build Slides (Step 3) after the user confirms the outline. The saved markdown file serves as the sole content source for all subsequent steps — never deviate from it. Any content changes must first update the markdown outline file.

### Rule 2: Repeat Verification (Mandatory, All Paths)
After PPT creation is complete, verify every slide repeatedly until ALL pass. This is the most critical quality gate — do not shortcut.

**Three categories of defects to eliminate:**
- Formatting errors — Text overlap, overflow, misalignment, blank pages, broken layouts
- Content omissions — Missing slides, missing text, incomplete sections, truncated content
- Text corruption — Garbled characters, wrong fonts, AI-hallucinated text, wrong terminology

**Repeat cycle:**
1. Run full verification against the outline (5-A through 5-D)
2. If any issue found → fix immediately → log in record → go back to step 1
3. Only when ALL items pass with zero issues → proceed to delivery

---

## Step 0: Choose Workflow Settings

**At the start of every presentation task, ask the user TWO choices:**

### 0-A. Collaboration Mode

| Mode | Description | Checkpoints |
|------|-------------|-------------|
| **Full Auto** | Minimal interaction. Confirm topic only, deliver final PPTX. | 1 checkpoint |
| **Guided** (recommended) | Confirm outline, pick design, preview before assembly. | 3 checkpoints |
| **Collaborative** | Review every slide, approve every illustration, full control. | Per-slide |

If the user doesn't specify, default to **Guided** mode.

### 0-B. Assembly Method

Three paths — pick based on what matters most: editability, visual impact, or source fidelity.

| Path | What it does | Best for |
|------|-------------|----------|
| **A: Editable HTML** | Outline → Design system → HTML slides + selective AI illustrations → html2pptx → editable PPTX | Need to edit text later, precise layout control, corporate decks |
| **B: Full AI Visual** | Outline → Design system → AI generates every slide as a complete image → create_slides.py → image PPTX | Maximum visual impact, artistic presentations, quick drafts |
| **C: Native SVG → PPTX** | Source document → Project init → Strategist design → Executor SVG generation → DrawingML compiler → fully editable native PPTX | Source documents (PDF/Word/URL), need everything editable, formal/long decks, template-driven branding |

**Key trade-offs:**

| | Path A | Path B | Path C |
|---|---|---|---|
| Text editability | Editable in PPT | Baked into image | Fully editable (native shapes) |
| Visual quality | Good + illustrations | Excellent — AI artistry | Excellent — vector graphics |
| Speed | Faster | Slower | Slowest (serial pipeline) |
| Source formats | Text/outline | Text/outline | PDF/DOCX/PPTX/URL/MD |
| File size | ~5-25MB | ~30-80MB | ~5-20MB |

If the user doesn't specify, default to **Path A** (Editable HTML).

---

## Step 0.5: Outline Pre-Check (Reuse or Create New)

Core rule: If a qualified outline already exists, reuse it directly — never recreate. Only rebuild when quality is insufficient.

### Pre-Check Actions

1. Search for existing outline files: `<project>-outline.md`, `*-outline.md`, `*-storyboard.md`, `*-flow.md`, etc.
2. If found → enter Quality Assessment
3. If not found → proceed directly to Step 1 to create a new outline

### Outline Quality Assessment (7 Checks)

| # | Check | Pass Criteria | Fail Indicators |
|---|-------|--------------|-----------------|
| 1 | Completeness | Covers all planned slides (cover → body → closing), no missing sections | Title only with no content, missing cover/closing, page count mismatch |
| 2 | Assertion titles | Every slide title is a complete assertion sentence (expresses a view), not a topic word | "Q3 Sales", "Methodology", "Summary" |
| 3 | Sufficient key points | 2-5 key points per slide with substantive content | Empty points, only 1 vague point, or >8 overloaded |
| 4 | Visual type labeled | Each slide has a visual type (illustration / chart / diagram / icon / quote) | All marked "text" or unmarked |
| 5 | Illustration/scene description | Path A/B: illustration need + description labeled | All blank or overly vague (e.g. "nice design") |
| 6 | Narrative logic | Slide order follows a clear narrative arc (problem → analysis → solution → conclusion) | Random order, logical jumps, duplicated content |
| 7 | Language standard | Chinese primary, only essential English terms retained | All English or mixed without pattern |

### Pre-Check Decision

| Assessment | Action |
|-----------|--------|
| 7/7 pass | Reuse directly, skip Step 1, proceed to Step 2 |
| 5-6/7 pass | Flag failing items, patch the existing file (don't rebuild), confirm then proceed to Step 2 |
| ≤4/7 pass | Quality insufficient, enter Step 1 to recreate |

### Cross-Skill Outline Interop

- If the outline comes from **design-studio** (e.g. `<project>-storyboard.md`, `<project>-flow.md`), check whether its format contains the fields slides need (per-slide title + key points + visual type)
- Format compatible → reuse directly, supplement slide-specific fields as needed
- Format incompatible → convert its content into slide outline format, rather than creating from scratch

---

## Step 1: Content Structuring

Turn raw material into a slide-by-slide outline, saved as a markdown document file (e.g. `<project>-outline.md`).

**This outline markdown file is the "content contract" for all subsequent steps** — the Build phase must follow the outline exactly, without additions, omissions, or deviations. After the outline is confirmed, any content changes must first update the outline's markdown file.

**Per slide, define:**
- **Title** — a complete assertion sentence (not a topic word)
- **Key points** — 3-4 maximum
- **Visual type** — illustration / chart / diagram / icon / quote
- **Path A/B:** Illustration needed? — Yes/No. If yes, one-line description.
- **Path C:** No per-slide visual description needed here — Strategist handles this in the design spec.

**Assertion-Evidence rule:**

| Bad title | Good title |
|-----------|-----------|
| Q3 Sales | Q3销售增长23%，新用户是主要驱动力 |
| Methodology | 我们通过双盲实验验证了这个结论 |

**Language rule: Slide content must be in Chinese, with only essential English terms retained.** Section labels (e.g., INSIGHT, TAKEAWAY) may use English as design elements.

### ✅ Checkpoint 1 (Guided + Collaborative)

Save the outline as a markdown document file (e.g. `<project>-outline.md`), then present its content to the user.

| # | Title (assertion) | Key Points | Visual Type | Illustration? |
|---|-------------------|------------|-------------|---------------|
| 1 | Cover: ... | — | Decorative | Yes: ... |
| 2 | ... | 1. ... 2. ... | Chart | No |

**Ask the user:** Approve / adjust slide count, which slides get illustrations, any content to add or remove.

---

## Step 2: Design System

Present 3 design system options for the user to choose from. Each is a complete visual language, not just a color palette.

**CRITICAL: A design system is NOT just colors.** It defines visual philosophy, typography ratios, composition rules, and emotional intent.

### 🗣️ Style Discussion (Optional)

If the user wants to explore styles, consult `references/design-movements.md` — maps classic design movements (Neo-Brutalism, Swiss Style, Bauhaus, etc.) to AI-ready style presets. Translate user's aesthetic language into actionable prompts.

### Design System Presets

18 presets across 3 tiers. Full gallery: `references/proven-styles-gallery.md`.

| Tier | Style | Best for |
|------|-------|----------|
| ⭐ Tier 1 | Warm Narrative, Neo-Pop, Ligne Claire, Whiteboard, Manga, Comic Strip | Path B — illustration styles generate best |
| ✅ Tier 2 | Editorial, Tech Dark, Minimal, WIRED, Data Journalism, Magazine, Vintage, Blueprint, Bauhaus, Pixel Art | Path A — precise layout control |
| 🔬 Tier 3 | Constructivism, Isometric, Risograph, Ukiyo-e, Dada, Dunhuang | Specific aesthetic requests |

Full visual details and prompt templates: `references/proven-styles-gallery.md`, `references/prompt-templates.md` §3.

> **Note for Path C**: The 18 design presets are for Path A/B. Path C uses its own Strategist-driven design system with the Eight Confirmations — see `references/native-svg-pipeline.md` and `references/strategist.md`. Style descriptions from this step flow naturally into the Strategist's recommendations.

### 🎨 Custom Character Style (User-Defined)

When a user says "do it in Doraemon style" or "like Studio Ghibli", treat this as a style reference, not a request to draw copyrighted characters. Build a custom Design System by extracting the visual DNA of that style.

| User says | Extract these visual traits |
|-----------|---------------------------|
| "Doraemon style" | Round shapes, bright primary blue + white + red, simple backgrounds, cute proportions |
| "Studio Ghibli" | Watercolor textures, natural greens and sky blues, warmth and wonder |
| "One Piece manga" | Bold dynamic lines, exaggerated proportions, dramatic action poses, thick outlines |
| "Adventure Time" | Geometric simple shapes, pastel candy colors, thin outlines, whimsical surreal backgrounds |

### Typography Rules (All Presets)

- Max 2 font families (1 heading + 1 body)
- Heading: bold, personality — ≥36pt
- Body: clean, readable — ≥18pt
- Chinese: system default (PingFang SC / Microsoft YaHei)
- Typography is a DESIGN ELEMENT, not just an information container

### ✅ Checkpoint 2 (Guided + Collaborative)

Ask the user to pick one of the 3 proposed design systems, or describe their own preference.

---

## Path-Specific Build & Assembly

From here, the workflow splits by the path chosen in Step 0-B. Jump to your path:

| Path | Section below | Key deliverable |
|------|--------------|-----------------|
| A: Editable HTML | [Path A](#path-a-editable-html) | `.pptx` with editable text |
| B: Full AI Visual | [Path B](#path-b-full-ai-visual) | `.pptx` with full-slide images |
| C: Native SVG → PPTX | [Path C](#path-c-native-svg--pptx) | `.pptx` with fully editable native shapes |

---

### Path A: Editable HTML

**Step 3-A: Build Slides**

Generate AI illustrations for key slides, then create HTML slide files.

Which slides need illustrations? Prioritize: 1) Cover slide (always), 2) Key insight slides, 3) Closing slide, 4) Data-heavy slides → charts/diagrams instead.

**Illustration Generation** — use `nano-banana-pro` skill:

```bash
export $(grep GEMINI_API_KEY ~/.config/opencode/.env) && \
uv run ~/.claude/skills/nano-banana-pro/scripts/generate_image.py \
  --prompt "[description]" \
  --filename "[timestamp]-slide-[N]-[name].png" \
  --resolution 2K
```

**Base Style Prompt** — define ONE style suffix, append to every illustration. Always include "no text in image" — text will be added as editable elements. Use descriptive paragraphs, not keyword lists. Specify hex colors explicitly. Use "flat vector" for consistency.

**Embedding in HTML slides:**

```html
<div class="left"><!-- text content --></div>
<div class="right"><img src="illustration.png" style="width: 280pt; height: 280pt;"></div>
```

**✅ Checkpoint 3-A** (Guided: preview 2-3 key illustrations; Collaborative: every one)

**Step 4-A: PPTX Assembly**

Create HTML files per slide, convert with `html2pptx.js`:

```javascript
const pptxgen = require('pptxgenjs');
const html2pptx = require(process.env.HOME + '/.config/opencode/skills/design-studio/scripts/html2pptx.js');

const pptx = new pptxgen();
pptx.layout = 'LAYOUT_16x9';
await html2pptx('slide1.html', pptx);
await html2pptx('slide2.html', pptx);
await pptx.writeFile({ fileName: 'output.pptx' });
```

HTML rules: body `720pt × 405pt`, all text in `<p>/<h1>-<h6>/<ul>/<ol>`, backgrounds/borders only on `<div>`, no CSS gradients (pre-render as PNG), web-safe fonts only.

**Known issue:** Chinese characters in file paths can break image loading. Use symlinks to ASCII paths if needed.

---

### Path B: Full AI Visual

**Step 3-B: Generate Slides**

Generate EVERY slide as a complete AI image — layout, text, visuals, all in one.

**The Golden Rule**: SHORT prompts > LONG prompts. Describe mood and content, NOT layout positions or color ratios.

| DON'T (kills diversity) | DO (enables creativity) |
|---|---|
| Specify color ratios or layout positions | Describe the mood ("warm like a Sunday comic page") |
| Restrict characters or list every element | Reference a specific aesthetic |

**Base Style** — under 5 lines:
```
VISUAL REFERENCE: [Specific art/design aesthetic in one sentence]
CANVAS: 16:9 aspect ratio, 2048x1152 pixels, high quality rendering.
COLOR SYSTEM: [Describe the mood/feel of colors, not exact ratios]
```

**Per-Slide Prompt**:
```
Create a [style] slide about [topic].
[Base Style]
DESIGN INTENT: [1 sentence — what the viewer should FEEL]
TEXT TO RENDER:
- Title: "[exact text]"
- Body: "[exact text]"
```

**Prompt Quality Checklist** (verify before every generation):
1. Names a specific art style/publication, not "professional" or "modern"
2. Describes what viewer should FEEL
3. All texts listed clearly and accurately
4. Concise; remove anything AI can decide on its own
5. NO hex ratios, typography sizes, composition percentages

**Technical Rules:** Always specify `2048x1152` (2K, 16:9). Include ALL text verbatim. Keep titles short (≤8 characters) for best Chinese rendering. Generate 3-5 slides concurrently for speed.

```bash
export $(grep GEMINI_API_KEY ~/.config/opencode/.env) && \
uv run ~/.claude/skills/nano-banana-pro/scripts/generate_image.py \
  --prompt "[full slide prompt]" \
  --filename "slide-[NN]-[name].png" \
  --resolution 2K
```

Full examples (GOOD vs BAD, detailed templates): see `references/prompt-templates.md` §3.

**Quality check:** text accuracy, layout, style consistency. If text errors → regenerate with adjusted prompt.

**✅ Checkpoint 3-B** (Guided: preview all slides as a set; Collaborative: approve each)

**Step 4-B: PPTX Assembly**

```bash
uv run ${SKILL_DIR}/scripts/create_slides.py \
  slide-01-cover.png slide-02-intro.png ... \
  --layout fullscreen \
  --bg-color 000000 \
  -o output.pptx
```

| Layout | Use case |
|--------|----------|
| `fullscreen` | AI-generated full-page slides (Path B default) |
| `title_above` | Image + editable title (hybrid) |
| `center` | Centered image with padding |
| `grid` | Multiple images per slide |

---

### Path C: Native SVG → PPTX

> ⛔ **Gate rules — read before entering Path C:**
> - Do NOT delegate SVG generation to sub-agents — main agent only
> - SVG pages MUST be generated sequentially one at a time, never batched
> - `spec_lock.md` MUST be re-read before every page
> - The Eight Confirmations in Step 4 are ⛔ BLOCKING — wait for explicit user confirmation

Path C is a strict serial pipeline. Activation: first read `references/native-svg-pipeline.md` (global rules, script index, template index), then `references/native-svg-workflow.md` (Steps 1–8). As directed by each step, load role-specific references:

| Step | Required reference | Optional |
|------|-------------------|----------|
| Step 4 (Strategist) | `templates/design_spec_reference.md`, `references/strategist.md` | — |
| Step 5 (Images) | `references/image-base.md` | `references/image-generator.md`, `references/image-searcher.md` |
| Step 6 (Executor) | `references/executor-base.md`, `references/shared-standards.md` | `references/executor-general.md` / `executor-consultant.md` / `executor-consultant-top.md` |
| Step 7 (Export) | — | `references/animations.md` |

**Key differences from Path A/B:** starts from source documents (PDF/Word/PPTX/URL), uses project directories (`projects/<name>/`), Strategist + Executor multi-role collaboration, SVG→DrawingML compilation for fully editable native shapes, supports animations and speaker notes.

**Standalone workflows** (load on demand):

| Workflow | Trigger |
|----------|---------|
| `workflows/topic-research.md` | User provides only a topic, no source files |
| `workflows/create-template.md` | User wants to create a new layout template |
| `workflows/resume-execute.md` | Resume generation in a fresh chat |
| `workflows/verify-charts.md` | Deck contains data charts |
| `workflows/customize-animations.md` | User wants to tune animation order |
| `workflows/visual-edit.md` | User wants browser-based visual editing |

---

## Step 5: Content Verification (Hard Rule 2)

> ⚠️ **This step is mandatory for all paths.** Do not deliver until verification passes.
>
> Verification must be repeated in cycles until ZERO issues remain.

### 5-A: Text Completeness

Compare text in the PPT against the outline, slide by slide:
1. Every title and key point from the outline exists in the PPT
2. No truncation — long text is not cut off or overflowing
3. No AI hallucination — no irrelevant content added by AI
4. Terminology correct — proper nouns, names, and brand names spelled correctly

**Path A:** Use Playwright to screenshot each HTML slide; visually verify text completeness.
**Path B:** Re-examine each generated image; verify rendered text word by word.
**Path C:** Run `svg_quality_checker.py` for structural checks; visually verify key slides in PowerPoint.

### 5-B: Layout Verification

1. No overlap — Text blocks don't overlap with images or decorative elements
2. Boundary alignment — Content stays within safe area, no overflow
3. Clear hierarchy — Title > body font size hierarchy is correct
4. Consistent spacing — Line spacing, paragraph spacing, and margins are uniform

### 5-C: Display Quality

1. Font rendering — Chinese fonts display correctly (no boxes or garbled characters)
2. Color accuracy — Matches the selected Design System colors
3. Image display — All illustrations load correctly, positioned properly
4. No blank pages — No empty pages with missing content

### 5-D: Page Sequence

1. Page count matches — Total pages match the outline
2. Correct order — Slide sequence matches the outline exactly
3. Cover/Closing — If defined, cover and closing slides exist and are correctly positioned

### Verification Record Template

Create a per-slide verification table:
```
| # | Slide Title | Text Complete | No Truncation | Layout Correct | Display OK |
```
If issues found → fix → re-verify ALL slides → repeat cycle until all pass.

### Zero-Defect Declaration
Before delivering, confirm in writing:
- ☐ Zero formatting errors (overlap, overflow, misalignment, blank pages)
- ☐ Zero content omissions (all outline content present and complete)
- ☐ Zero text corruption (no garbled characters, no truncated text, no AI hallucination)
- ☐ All items from verification record table are ✅

Only sign off when ALL four boxes are checked.

### ✅ Checkpoint 5 (All modes)

Present verification results to the user. All passed → proceed to delivery. Issues exist → explain problems and fix plan.

---

## Step 6: Preview & Polish

### Preview

**Path A:** Screenshot 3-4 key HTML slides with Playwright:
```bash
npx playwright screenshot "file:///path/to/slide.html" preview.png \
  --viewport-size=960,540 --wait-for-timeout=1000
```

**Path B:** Show the generated slide images directly (they ARE the slides). Use `Read` tool to display 3-4 key PNGs.

**Path C:** The exported PPTX is in `exports/<project_name>_<timestamp>.pptx`. Open in PowerPoint/Keynote for preview. Key slides are in SVG under `svg_final/` for inspection.

### ✅ Checkpoint 6 (All modes)

Show preview to the user. The PPTX file is ready — ask:
- Any slides to adjust?
- Ready to open in Keynote/PowerPoint?

### Final Polish (in Keynote/PowerPoint)
- Transitions and animations (Path C: built-in via `--transition` and `--animation` flags)
- Speaker notes (Path C: auto-generated)
- Brand logo placement
- Path A: Final text adjustments (editable)
- Path B: Text NOT editable — if text errors found, regenerate the slide image
- Path C: Fully editable — all text, shapes, colors, sizes modifiable

---

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Skipping outline → straight to slides | Outline is the contract. Enforced by Hard Rule 1. |
| Shortcutting verification after one pass | Repeat until zero issues. Enforced by Hard Rule 2. |
| Generating AI images without base style prompt | Define ONE style suffix, append to every prompt. |
| Too-long image prompts (Path B) | SHORT prompts > LONG. Describe mood, not layout positions. |
| Chinese chars in file paths for images | Symlink to ASCII path: `mklink /D short → "中文路径"`. |
| Batching SVG pages (Path C) | Sequential only, re-read `spec_lock.md` before every page. |
| Missing the Eight Confirmations (Path C) | ⛔ BLOCKING — wait for explicit user confirmation. |
| Skipping Path C pipeline read | Always read `native-svg-pipeline.md` then `native-svg-workflow.md` first. |

## References Route Table

### All Paths

| Priority | Task | Read |
|----------|------|------|
| 🔴 Required | Choose style / design system | `references/proven-styles-gallery.md` |
| 🔴 Required | AI prompt templates | `references/prompt-templates.md` |
| 🟡 On-demand | Snoopy/Peanuts style details | `references/proven-styles-snoopy.md` |
| 🟡 On-demand | Design principles, color, typography | `references/design-principles.md` |
| 🟡 On-demand | Design movements / aesthetic profiles | `references/design-movements.md` |
| 🟡 On-demand | Deep design philosophy (20 styles) | `design-philosophy` skill |

### Path C Only

| Priority | Task | Read |
|----------|------|------|
| 🔴 Required | Pipeline rules, scripts, templates | `references/native-svg-pipeline.md` |
| 🔴 Required | Full workflow Steps 1–8 | `references/native-svg-workflow.md` |
| 🔴 Required | Strategist role (Step 4) | `references/strategist.md` |
| 🔴 Required | Executor common guidelines | `references/executor-base.md`, `references/shared-standards.md` |
| 🟡 On-demand | Executor style variants | `references/executor-general.md` / `executor-consultant.md` / `executor-consultant-top.md` |
| 🟡 On-demand | Image acquisition | `references/image-base.md`, `references/image-generator.md`, `references/image-searcher.md` |
| 🟡 On-demand | Canvas formats | `references/canvas-formats.md` |
| 🟡 On-demand | Animations | `references/animations.md` |
| 🔴 Required | Design Spec template (Step 4) | `templates/design_spec_reference.md` |

**5/5/5 rule:** ≤5 words/line, ≤5 bullets/slide, ≤5 text-heavy slides in a row
**Cognitive load:** One idea per slide. ~1 min per slide.
**Visual hierarchy:** F/Z-pattern reading flow. Title:body size ≈ 3:1.

## Related Skills

| Skill | Role |
|-------|------|
| `design-studio` | html2pptx.js for Path A conversion; advanced HTML slide design |
| `nano-banana-pro` | AI illustration generation (Gemini 3 Pro Image) for Path A/B |
| `multi-model` | External AI for content drafting |
| `design-philosophy` | Deep reference for 20 design philosophies |

## Output

- `.pptx` files compatible with PowerPoint, Keynote, Google Slides
- Path A/B: Web-safe fonts for cross-platform compatibility
- Path C: Native shapes with system fonts; fully editable in PowerPoint
