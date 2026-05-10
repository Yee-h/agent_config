---
name: slides-creator
description: End-to-end presentation creation from content to finished PPTX, with AI illustration generation and 18 design styles. Trigger on requests like "做PPT", "做幻灯片", "演示文稿", "Keynote", "slides".
---

# AI Presentation Workflow

Create professional presentations: Content → Design → Build → Assembly → Polish.

## Hard Rules (Enforced Across All Modes)

### Rule 1: Outline First (Markdown Document)
**Before generating any PPT content, you must have a complete slide outline as a markdown document file** (e.g. `<project>-outline.md`). **If a qualified outline already exists, reuse it directly — do NOT recreate.** See Step 0.5 for quality assessment criteria. Only proceed to Design System (Step 2) and Build Slides (Step 3) after the user confirms the outline. The saved markdown file serves as the sole content source for all subsequent steps — never deviate from it. Any content changes must first update the markdown outline file.

### Rule 2: Repeat Verification (Mandatory, All Modes)
After PPT creation is complete, **verify every slide repeatedly until ALL pass**. This is the most critical quality gate — do not shortcut.

**Three categories of defects to eliminate:**
- 🚫 **Formatting errors** — Text overlap, overflow, misalignment, blank pages, broken layouts
- 🚫 **Content omissions** — Missing slides, missing text, incomplete sections, truncated content
- 🚫 **Text corruption** — Garbled characters, wrong fonts, AI-hallucinated text, wrong terminology

**Repeat cycle:**
1. Run full verification against the outline (5-A through 5-D)
2. If any issue found → fix immediately → log in record → go back to step 1
3. Only when ALL items pass with zero issues → proceed to delivery

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

| Method | How it works | Best for |
|--------|-------------|----------|
| **Editable HTML** (Path A) | HTML slides + selective AI illustrations → html2pptx → editable PPTX | Need to edit text later, precise layout, corporate decks |
| **Full AI Visual** (Path B) | Every slide as a complete AI-generated image → create_slides.py → image PPTX | Maximum visual impact, artistic presentations, quick drafts |

**Trade-offs:**

| | Path A: Editable HTML | Path B: Full AI Visual |
|---|---|---|
| Text | Editable in PPT | Baked into image (not editable) |
| Visual quality | Good with illustrations | Excellent — cohesive design |
| Layout control | Pixel-precise | AI-interpreted |
| File size | Smaller (~5-25MB) | Larger (~30-80MB) |
| Chinese text | Perfect (font rendering) | Usually good (AI may occasionally misrender) |
| Speed | Faster (HTML creation) | Slower (image generation per slide) |

If the user doesn't specify, default to **Path A** (Editable HTML).

---

## Step 0.5: Outline Pre-Check (Reuse or Create New)

> **Core rule: If a qualified outline already exists, reuse it directly — never recreate. Only rebuild when quality is insufficient.**

### Pre-Check Actions

Before entering Step 1, run these checks:

1. **Search for existing outline files**: Look in the project directory for `<project>-outline.md` or `*-outline.md`, `*-storyboard.md`, `*-flow.md`, etc.
2. **If found** → enter Quality Assessment
3. **If not found** → proceed directly to Step 1 to create a new outline

### Outline Quality Assessment (7 Checks)

| # | Check | Pass Criteria | Fail Indicators |
|---|-------|--------------|-----------------|
| 1 | **Completeness** | Covers all planned slides (cover → body → closing), no missing sections | Title only with no content, missing cover/closing, page count mismatch |
| 2 | **Assertion titles** | Every slide title is a complete assertion sentence (expresses a view), not a topic word | "Q3 Sales", "Methodology", "Summary" |
| 3 | **Sufficient key points** | 2-5 key points per slide with substantive content | Empty points, only 1 vague point, or >8 overloaded |
| 4 | **Visual type labeled** | Each slide has a visual type (illustration / chart / diagram / icon / quote) | All marked "text" or unmarked |
| 5 | **Illustration/scene description** | Path A: illustration need + description labeled; Path B: visual scene description per slide | All blank or overly vague (e.g. "nice design") |
| 6 | **Narrative logic** | Slide order follows a clear narrative arc (problem → analysis → solution → conclusion) | Random order, logical jumps, duplicated content |
| 7 | **Language standard** | Chinese primary, only essential English terms retained | All English or mixed without pattern |

### Pre-Check Decision

| Assessment | Action |
|-----------|--------|
| **7/7 pass** | ✅ Reuse directly, skip Step 1, proceed to Step 2 |
| **5-6/7 pass** | ⚠️ Flag failing items, **patch the existing file** (don't rebuild), confirm then proceed to Step 2 |
| **≤4/7 pass** | ❌ Quality insufficient, enter Step 1 to recreate |

### Cross-Skill Outline Interop

- If the outline comes from **design-studio** (e.g. `<project>-storyboard.md`, `<project>-flow.md`), check whether its format contains the fields slides need (per-slide title + key points + visual type)
- Format compatible → reuse directly, supplement slide-specific fields (illustration labels) as needed
- Format incompatible → convert its content into slide outline format, rather than creating from scratch

---

## Step 1: Content Structuring

Turn raw material into a slide-by-slide outline, saved as a markdown document file (e.g. `<project>-outline.md`).

**This outline markdown file is the "content contract" for all subsequent steps** — the Build phase must follow the outline exactly, without additions, omissions, or deviations. After the outline is confirmed, any content changes must first update the outline's markdown file.

**Per slide, define:**
- **Title** — a complete assertion sentence (not a topic word)
- **Key points** — 3-4 maximum
- **Visual type** — illustration / chart / diagram / icon / quote
- **Path A:** Illustration needed? — Yes/No. If yes, one-line description.
- **Path B:** Visual scene description — one paragraph describing the complete slide visual (layout + imagery + mood).

**Assertion-Evidence rule:**

| Bad title | Good title |
|-----------|-----------|
| Q3 Sales | Q3销售增长23%，新用户是主要驱动力 |
| Methodology | 我们通过双盲实验验证了这个结论 |

**Language rule: Slide content must be in Chinese, with only essential English terms retained (people names, brand names, technical terminology).** Section labels (e.g., INSIGHT, TAKEAWAY) may use English as design elements.

### ✅ Checkpoint 1 (Guided + Collaborative)

Save the outline as a markdown document file (e.g. `<project>-outline.md`), then present its content to the user. The file must include the outline table:

**Path A:**
```
| # | Title (assertion) | Key Points | Visual Type | Illustration? |
|---|-------------------|------------|-------------|---------------|
| 1 | Cover: ... | — | Decorative | Yes: ... |
| 2 | ... | 1. ... 2. ... | Chart | No |
| 3 | ... | 1. ... 2. ... | Illustration | Yes: ... |
```

**Path B:**
```
| # | Title (assertion) | Key Points | Visual Scene Description |
|---|-------------------|------------|--------------------------|
| 1 | Cover: ... | — | Dark gradient bg, large title centered, abstract network nodes |
| 2 | ... | 1. ... 2. ... | Split layout: text left, bar chart right, clean white bg |
| 3 | ... | 1. ... 2. ... | Full illustration: person at crossroads with floating clocks |
```

**Ask the user:**
- Approve / adjust slide count
- Path A: Approve / adjust which slides get illustrations
- Path B: Approve / adjust visual scene descriptions
- Any content to add or remove

---

## Step 2: Design System

**Present 3 design system options for the user to choose from.** Each is a complete visual language, not just a color palette.

**CRITICAL: A design system is NOT just colors.** It defines visual philosophy, typography ratios, composition rules, and emotional intent. This is the difference between "boring PPT" and "magazine-quality deck."

### 🗣️ Style Discussion (Optional, if user wants to explore)

**If the user says things like:**
- "I want XX style" (Ikko Tanaka, Swiss Internationalism, Bauhaus, Mondrian...)
- "I'm not sure what style I want"
- "Can you show me examples of different styles?"

**Then consult the design movements reference:**
`references/design-movements.md` — Design movements and style reference library

This file maps classic design movements (Neo-Brutalism, Swiss Style, Bauhaus, etc.) to our AI-ready style presets. Use it to:
1. Translate user's aesthetic language into actionable prompts
2. Build shared vocabulary ("This direction leans Ikko Tanaka" vs "That one leans Constructivism")
3. Reference when designing new custom styles from scratch

**After discussing movements, proceed to recommend 3 concrete presets below.**

---

### Design System Presets

Choose a design preset **before** building slides. Each preset defines: colors, fonts, layout rhythm, component pattern.

**18 presets (tiered by recommendation):**

| Tier | Presets | Best for |
|------|---------|----------|
| ⭐ Tier 1 (Best for AI) | Warm Narrative, Neo-Pop Magazine, Ligne Claire Comics, Whiteboard Sketch, Manga Educational, Warm Comic Strip | Full AI Slide Generation (Path B) — illustration/comic styles generate best |
| ✅ Tier 2 (Solid) | Modern Editorial, Tech Dark Mode, Minimal, WIRED Editorial, Data Journalism, Magazine Spread, Vintage Ad, Blueprint, Bauhaus, Pixel Art | HTML slides (Path A) — these need precise layout control |
| 🔬 Tier 3 (Niche) | Constructivism, Isometric, Risograph, Ukiyo-e, Dada Collage, Dunhuang Mural | Specific aesthetic requests |

Full details (colors, fonts, mood, composition rules for each preset):
- `references/proven-styles-gallery.md` — All 18 presets with complete specs
- `references/proven-styles-snoopy.md` — Snoopy/Peanuts style detailed per-slide templates
- `references/prompt-templates.md` §3 — Full AI Slide Generation prompts per preset

### 🎨 Custom Character Style (User-Defined)

Users may want to reference specific cartoon/anime aesthetics. When a user says "do it in Doraemon style" or "like Studio Ghibli", treat this as a **style reference**, not a request to draw copyrighted characters. Build a custom Design System by extracting the visual DNA of that style.

**How to convert a character reference into a Design System:**

| User says | Extract these visual traits |
|-----------|---------------------------|
| "Doraemon style" | Round shapes, bright primary blue + white + red, simple backgrounds, cute proportions, magical gadget reveals |
| "Studio Ghibli" | Watercolor textures, natural greens and sky blues, detailed backgrounds with simple characters, warmth and wonder |
| "Calvin and Hobbes" | Dynamic ink brushwork, expressive motion lines, philosophical contrast between fantasy and reality, lush outdoor scenes |
| "One Piece manga" | Bold dynamic lines, exaggerated proportions, dramatic action poses, high energy, thick outlines |
| "Crayon Shin-chan" | Crude crayon-like lines, flat bright colors, comedic proportions, everyday scenarios made absurd |
| "Adventure Time" | Geometric simple shapes, pastel candy colors, thin outlines, whimsical surreal backgrounds |

**Template for custom style:**
```
[User Style]: "[reference name]"
→ Shape language: [round/angular/geometric/organic]
→ Line quality: [thin uniform / thick varied / sketchy / brushwork]
→ Color palette: [specific colors extracted from that aesthetic]
→ Character style: [proportions, expressiveness level]
→ Background treatment: [detailed/minimal/abstract]
→ Emotional tone: [warm/energetic/philosophical/surreal]
```

### Typography Rules (All Presets)

- Max 2 font families (1 heading + 1 body)
- Heading: bold, personality — ≥36pt (trend: even larger, as graphic surface)
- Body: clean, readable — ≥18pt
- Chinese: system default (PingFang SC / Microsoft YaHei)
- **Key principle**: Typography is a DESIGN ELEMENT, not just an information container

### ✅ Checkpoint 2 (Guided + Collaborative)

**Ask the user to pick one of the 3 proposed design systems**, or describe their own preference. Show the full description including philosophy, visual language, and reference.

---

## Step 3: Build Slides

---

### Step 3-A: HTML + Selective Illustrations (Path A)

Generate AI illustrations for key slides, then create HTML slide files.

**Which slides need illustrations?** Prioritize:
1. **Cover slide** — always. Sets the visual tone.
2. **Key insight slides** — the "aha moment" slides benefit most.
3. **Closing slide** — optional but impactful.
4. **Data-heavy slides** — charts/diagrams instead of AI art.

**Illustration Generation** — use `nano-banana-pro` skill:

```bash
export $(grep GEMINI_API_KEY ~/.config/opencode/.env) && \
uv run ~/.claude/skills/nano-banana-pro/scripts/generate_image.py \
  --prompt "[description]" \
  --filename "[timestamp]-slide-[N]-[name].png" \
  --resolution 2K
```

**Base Style Prompt** — define ONE style suffix, append to every illustration:

```
[Base Style]: flat vector illustration, [palette background color] background,
[accent color] highlight elements, clean minimalist aesthetic,
professional presentation style, no text in image
```

**Per-slide prompt = [specific content] + [Base Style]**

**Key rules:**
- Always include "no text in image" — text will be added as editable elements
- Use descriptive paragraphs, not keyword lists
- Specify hex colors explicitly
- Use "flat vector" / "flat illustration" for consistency

**Embedding in HTML slides:**

```html
<!-- Side illustration (recommended) -->
<div class="left"><!-- text content --></div>
<div class="right"><img src="illustration.png" style="width: 280pt; height: 280pt;"></div>

<!-- Background illustration -->
<body style="background-image: url('illustration.png'); background-size: cover;">
```

**✅ Checkpoint 3-A** (Guided: preview 2-3 key illustrations; Collaborative: every one)

Show generated illustrations. Ask: Approve / regenerate / style consistent?

---

### Step 3-B: Full AI Slide Generation (Path B)

Generate EVERY slide as a complete AI image — layout, text, visuals, all in one.

**The Golden Rule**: SHORT prompts > LONG prompts. Describe mood and content, NOT layout positions or color ratios.

| DON'T (kills diversity) | DO (enables creativity) |
|---|---|
| Specify color ratios or layout positions | Describe the mood ("warm like a Sunday comic page") |
| Restrict characters or list every element | Reference a specific aesthetic |
| Repeat base style in every per-slide prompt | Define base style once, keep per-slide short |

**Base Style**: Define once, append to every slide. Keep under 5 lines.
```
VISUAL REFERENCE: [Specific art/design aesthetic in one sentence]
CANVAS: 16:9 aspect ratio, 2048x1152 pixels, high quality rendering.
COLOR SYSTEM: [Describe the mood/feel of colors, not exact ratios]
```

**Per-Slide Prompt Structure**:
```
Create a [style] slide about [topic].
[Base Style]
DESIGN INTENT: [1 sentence — what the viewer should FEEL]
TEXT TO RENDER:
- Title: "[exact text]"
- Body: "[exact text]"
[Optional: 1-2 sentences describing mood or scene.]
```

For full examples (GOOD vs BAD comparison, detailed Base Style Templates, Per-Slide examples), see `references/prompt-templates.md` section 3.

**Prompt Quality Checklist** (verify before every generation):
1. **Visual Reference** — Names a specific art style/publication, not "professional" or "modern"
2. **Mood, not Layout** — Describes what viewer should FEEL
3. **Text Content** — All texts listed clearly and accurately
4. **Short Enough** — Concise; remove anything AI can decide on its own
5. **NO Micro-Management** — No hex ratios, typography sizes, composition percentages

**Technical Rules:**
- **Always specify resolution**: `2048x1152` (2K, 16:9) for crisp text
- **Include ALL text verbatim** — AI must render exact words
- **Chinese priority**: All slide text must be in Chinese, keep only essential English terms
- **Chinese text tip**: Keep titles short (≤8 characters) for best rendering
- **Use descriptive paragraphs**, not keyword lists
- **Generate in parallel**: Run 3-5 slide generations concurrently for speed
- **Consistency**: The Base Style is applied to EVERY slide. It's a system, not a suggestion

**Generation command** (same tool, but full-slide prompts):

```bash
export $(grep GEMINI_API_KEY ~/.config/opencode/.env) && \
uv run ~/.claude/skills/nano-banana-pro/scripts/generate_image.py \
  --prompt "[full slide prompt]" \
  --filename "slide-[NN]-[name].png" \
  --resolution 2K
```

**Quality check after generation:**
1. **Text accuracy** — verify all Chinese/English text rendered correctly
2. **Layout** — elements positioned as described
3. **Style consistency** — colors and design language match across slides
4. If a slide has text errors → regenerate with adjusted prompt (simplify text or shorten)

**✅ Checkpoint 3-B** (Guided: preview all slides as a set; Collaborative: approve each)

Show ALL generated slide images to the user. Ask:
- Text readable and accurate?
- Visual style consistent across slides?
- Any slides to regenerate?

---

## Step 4: PPTX Assembly

### 4-A: html2pptx Workflow (Path A)

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

**HTML rules** (from pptx skill):
- Body dimensions: `width: 720pt; height: 405pt` (16:9)
- ALL text must be in `<p>`, `<h1>`-`<h6>`, `<ul>`, `<ol>` tags
- Backgrounds/borders only on `<div>` elements
- No CSS gradients — pre-render as PNG with Sharp
- Use web-safe fonts only (Arial, Helvetica, Georgia, etc.)
- Images: `<img src="illustration.png" style="width: Xpt; height: Ypt;">`

**Known issue:** Chinese characters in file paths can break image loading. Use symlinks to ASCII paths if needed:
```bash
ln -sf "/path/with/中文/" /tmp/ascii-path
```

### 4-B: Image Assembly (Path B)

Assemble generated slide images into PPTX using `create_slides.py`:

```bash
uv run ~/.claude/skills/image-to-slides/scripts/create_slides.py \
  slide-01-cover.png slide-02-intro.png slide-03-definition.png ... \
  --layout fullscreen \
  --bg-color 000000 \
  -o output.pptx
```

**Recommended layout for Path B: `fullscreen`** — images fill the entire slide since they already contain all layout, text, and visuals.

| Layout | Use case |
|--------|----------|
| `fullscreen` | AI-generated full-page slides (Path B default) |
| `title_above` | Image + editable title (hybrid approach) |
| `title_left` | Split: text + visual |
| `center` | Centered image with padding |
| `grid` | Multiple images per slide |

---

## Step 5: Content Verification (Hard Rule 2)

> ⚠️ **This step is mandatory for all modes**. Do not deliver until verification passes.
>
> ⚡ **Critical: Verification must be repeated in cycles until ZERO issues remain.** One pass is never enough — after fixing found issues, re-verify EVERY slide again. Formatting errors, content omissions, and text corruption must ALL be eliminated before delivery.

After PPT assembly is complete, verify every slide against the outline.

### 5-A: Text Completeness

Compare text in the PPT against the outline, slide by slide:
1. **Content complete** — Every title and key point from the outline exists in the PPT
2. **No truncation** — Long text (especially Chinese sentences) is not cut off or overflowing
3. **No AI hallucination** — No irrelevant content added by AI
4. **Terminology correct** — Proper nouns, names, and brand names spelled correctly

**Path A (HTML→PPTX):** Use Playwright to screenshot each HTML slide; visually verify text completeness.
**Path B (Full AI Image):** Re-examine each generated image; verify rendered text word by word.

### 5-B: Layout Verification

1. **No overlap** — Text blocks don't overlap with images or decorative elements
2. **Boundary alignment** — Content stays within safe area, no overflow
3. **Clear hierarchy** — Title > body font size hierarchy is correct
4. **Consistent spacing** — Line spacing, paragraph spacing, and margins are uniform

### 5-C: Display Quality

1. **Font rendering** — Chinese fonts display correctly (no boxes or garbled characters)
2. **Color accuracy** — Matches the selected Design System colors
3. **Image display** — All illustrations load correctly, positioned properly
4. **No blank pages** — No empty pages with missing content

### 5-D: Page Sequence

1. **Page count matches** — Total pages match the outline
2. **Correct order** — Slide sequence matches the outline exactly
3. **Cover/Closing** — If defined, cover and closing slides exist and are correctly positioned

### Verification Record Template

```
## Verification Record
| # | Slide Title | Text Complete | No Truncation | Layout Correct | Display OK | Notes |
|---|------------|--------------|--------------|----------------|------------|-------|
| 1 | Cover      | ✅           | ✅           | ✅             | ✅         | —     |
| 2 | ...        | ✅           | ✅           | ✅             | ✅         | —     |
...

**Result:** [All Passed / Issues Exist (see notes)]
```

If issues found → log details → fix → re-verify ALL slides again → repeat cycle until all pass.
**One fix pass is never enough — fixing one issue can introduce another. Always run a full re-verification cycle after every fix round.**

### Zero-Defect Declaration
Before delivering, confirm in writing:
- ☐ Zero formatting errors (overlap, overflow, misalignment, blank pages)
- ☐ Zero content omissions (all outline content present and complete)
- ☐ Zero text corruption (no garbled characters, no truncated text, no AI hallucination)
- ☐ All items from verification record table are ✅

Only sign off when ALL four boxes are checked.

### ✅ Checkpoint 5 (All modes)

Present verification results to the user:
- All passed → proceed to delivery
- Issues exist → explain problems and fix plan, re-verify after fixes

---

## Step 6: Preview & Polish

### Preview

**Path A:** Screenshot 3-4 key HTML slides with Playwright:
```bash
npx playwright screenshot "file:///path/to/slide.html" preview.png \
  --viewport-size=960,540 --wait-for-timeout=1000
```

**Path B:** Show the generated slide images directly (they ARE the slides). Use `Read` tool to display 3-4 key PNGs.

### ✅ Checkpoint 6 (All modes)

**Show preview to the user.** The PPTX file is ready — ask:
- Any slides to adjust?
- Ready to open in Keynote/PowerPoint?

### Final Polish (in Keynote/PowerPoint)
- Transitions and animations
- Speaker notes
- Brand logo placement
- Path A: Final text adjustments (editable)
- Path B: Text NOT editable — if text errors found, regenerate the slide image

---

## References Route Table

| 任务 | 读 |
|------|-----|
| 选择风格/设计系统 | `references/proven-styles-gallery.md`（18 种风格） |
| Snoopy/Peanuts 风格详情 | `references/proven-styles-snoopy.md` |
| AI 提示词模板（内容/配图/全 AI 生成） | `references/prompt-templates.md` |
| 设计原则、配色、排印 | `references/design-principles.md` |
| 设计运动/审美画像 | `references/design-movements.md` |
| 深入 20 种设计哲学 | `design-philosophy` skill 的 `references/design-styles.md` |

**5/5/5 rule:** ≤5 words/line, ≤5 bullets/slide, ≤5 text-heavy slides in a row
**Cognitive load:** One idea per slide. ~1 min per slide.
**Visual hierarchy:** F/Z-pattern reading flow. Title:body size ≈ 3:1.

## Related Skills

| Skill | Role |
|-------|------|
| `pptx` | Advanced PPTX creation/editing (html2pptx, templates) |
| `nano-banana-pro` | AI illustration generation (Gemini 3 Pro Image) |
| `multi-model` | External AI for content drafting |
| `design-philosophy` | Deep reference for 20 design philosophies (style DNA, scenario templates, review criteria). Detailed prompts and review guides for Professional/Editorial styles |

## Output

- `.pptx` files compatible with PowerPoint, Keynote, Google Slides
- Web-safe fonts for cross-platform compatibility
- AI illustrations as separate PNG files (reusable)

