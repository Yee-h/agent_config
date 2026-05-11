# Native SVG → PPTX: Full Workflow

> **Prerequisite**: Must have read `references/native-svg-pipeline.md` (global execution discipline, script index, template index).
>
> This file contains the full Steps 1–8 pipeline for native SVG generation. Execute in order, strictly following all gates and checkpoints.

---

### Step 1: Source Content Processing

🚧 **GATE**: User has provided source material (PDF / DOCX / EPUB / URL / Markdown file / text description / conversation content — any form is acceptable).

> **No source content?** When the user supplies only a topic name or requirements without any file or substantive description, run the [`topic-research`](../workflows/topic-research.md) workflow first, then return here with its products as input.

When the user provides non-Markdown content, convert immediately:

| User Provides | Command |
|---------------|---------|
| PDF file | `python3 ${SKILL_DIR}/scripts/source_to_md/pdf_to_md.py <file>` |
| DOCX / Word / Office document | `python3 ${SKILL_DIR}/scripts/source_to_md/doc_to_md.py <file>` |
| XLSX / XLSM / Excel workbook | `python3 ${SKILL_DIR}/scripts/source_to_md/excel_to_md.py <file>` |
| CSV / TSV | Read directly as plain-text table source |
| PPTX / PowerPoint deck | `python3 ${SKILL_DIR}/scripts/source_to_md/ppt_to_md.py <file>` |
| EPUB / HTML / LaTeX / RST / other | `python3 ${SKILL_DIR}/scripts/source_to_md/doc_to_md.py <file>` |
| Web link | `python3 ${SKILL_DIR}/scripts/source_to_md/web_to_md.py <URL>` |
| WeChat / high-security site | `python3 ${SKILL_DIR}/scripts/source_to_md/web_to_md.py <URL>` (requires `curl_cffi`, included in `requirements.txt`) |
| Markdown | Read directly |

**✅ Checkpoint — Confirm source content is ready, proceed to Step 2.**

---

### Step 2: Project Initialization

🚧 **GATE**: Step 1 complete; source content is ready (Markdown file, user-provided text, or requirements described in conversation are all valid).

```bash
python3 ${SKILL_DIR}/scripts/project_manager.py init <project_name> --format <format>
```

Format options: `ppt169` (default), `ppt43`, `xhs`, `story`, etc. For the full format list, see `references/canvas-formats.md`.

Import source content (choose based on the situation):

| Situation | Action |
|-----------|--------|
| Has source files (PDF/MD/etc.) | `python3 ${SKILL_DIR}/scripts/project_manager.py import-sources <project_path> <source_files...> --move` |
| User provided text directly in conversation | No import needed — content is already in conversation context; subsequent steps can reference it directly |

> ⚠️ **MUST use `--move`** (not copy): all source files — Step 1's generated Markdown, original PDFs / MDs / images — go into `sources/` via `import-sources --move`. After execution they no longer exist at the original location. Intermediate artifacts (e.g., `_files/`) are handled automatically.

**✅ Checkpoint — Confirm project structure created successfully, `sources/` contains all source files, converted materials are ready. Proceed to Step 3.**

---

### Step 3: Template Option

🚧 **GATE**: Step 2 complete; project directory structure is ready.

**Default — free design.** Proceed directly to Step 4. Do NOT query `layouts_index.json` unless triggered. Do NOT ask the user. Do NOT proactively suggest, hint at, or fuzzy-match any template based on content, slug-like words, or vague style descriptions.

**Template flow triggers ONLY on an explicit template directory path** supplied by the user in their initial message. The trigger rule is mechanical, not interpretive:

| User input contains | Step 3 action |
|---|---|
| An explicit path to a template directory (e.g. `skills/slides-creator/templates/layouts/academic_defense/`, `projects/foo/template/`, or any other absolute / relative path that resolves to a directory containing `design_spec.md` and one or more page SVGs) | Copy that directory's SVGs + `design_spec.md` + assets into the project, advance |
| Anything else — including bare template names ("用 academic_defense 模板"), style descriptions ("麦肯锡风格" / "Google style"), brand mentions ("招商银行风格"), vague intent ("想用个模板"), or silence | Skip Step 3, free design |

There is no slug matching, no name lookup, no fuzzy resolution. A template name without a path does not trigger — the user must give a path the AI can `cd` into.

The path may live anywhere — `skills/slides-creator/templates/layouts/<name>/` (the built-in library), `projects/<other_project>/template/` (reusing a previous project's templates), or any other location. Location is irrelevant; what matters is that the user named the path.

```bash
TEMPLATE_DIR=<user-supplied path>
cp ${TEMPLATE_DIR}/*.svg <project_path>/templates/
cp ${TEMPLATE_DIR}/design_spec.md <project_path>/templates/
cp ${TEMPLATE_DIR}/*.png <project_path>/images/ 2>/dev/null || true
cp ${TEMPLATE_DIR}/*.jpg <project_path>/images/ 2>/dev/null || true
```

> Style descriptions ("麦肯锡风格" / "Keynote 风" / "极简风" / etc.) never trigger Step 3. They flow naturally into Strategist's Eight Confirmations as part of the user's input — Strategist uses them as a style brief when proposing color / typography / tone in confirmations e and g.

> Bare template names ("academic_defense", "招商银行") do NOT trigger Step 3 even if a folder by that name exists in the library. The user must give a path. AI must not "helpfully" resolve a name to a path.

> "What templates exist?" is out-of-band Q&A — answer by listing entries from `layouts_index.json` together with their paths. Listing alone does not advance the pipeline; the user still has to send a path to trigger the Step 3 copy.

> To create a new template, read `workflows/create-template.md`.

**✅ Checkpoint — Default path proceeds to Step 4 without user interaction. If the user's input contains an explicit template directory path, that directory is copied before advancing.**

---

### Step 4: Strategist Phase (MANDATORY — cannot be skipped)

🚧 **GATE**: Step 3 complete; default free-design path taken, or (if triggered) template files copied into the project.

First, read the role definition:
```
Read references/strategist.md
```

> ⚠️ **Mandatory gate**: before writing `design_spec.md`, Strategist MUST `read_file templates/design_spec_reference.md` and follow its full I–XI section structure. See `strategist.md` §1.

**Eight Confirmations** (full template: `templates/design_spec_reference.md`):

⛔ **BLOCKING**: present the Eight Confirmations as a single bundled recommendation set and **wait for explicit user confirmation or modification** before outputting Design Specification & Content Outline. This is the single core confirmation point — once confirmed, all subsequent steps proceed automatically.

1. Canvas format
2. Page count range
3. Target audience
4. Style objective
5. Color scheme
6. Icon usage approach
7. Typography plan
8. Image usage approach

**Mandatory — split-mode note** (not a ninth confirmation): after listing the eight confirmation details, you MUST append exactly one short line (rendered in the user's language, prefixed with 💡) about generation mode. Pick the variant by qualitative read of Phase A signals — recommended page count, source-material bulk, whether `topic-research` ran with substantial web-fetch accumulation:

| Signal read | Line content |
|---|---|
| Heavy (long page count / bulky sources / heavy web-fetch accumulation) | State estimated page count and large source size; recommend switching to [split mode](../workflows/resume-execute.md) after Step 5 — stop this chat, open a fresh window and input `继续生成 projects/<project_name>` to enter Phase B (SVG generation + export); no response or "continue" = default continuous mode. |
| Normal (default) | State scale is moderate, default continuous mode generates in one go; if mid-way window switch is desired, input `继续生成 projects/<project_name>` after Step 5 to switch to [split mode](../workflows/resume-execute.md). |

This line is required output every run — the user must always see the mode choice exists. Whether to act on it is the user's call.

If the user provided images, run analysis **before outputting the design spec**:
```bash
python3 ${SKILL_DIR}/scripts/analyze_images.py <project_path>/images
```

> ⚠️ **Image handling**: NEVER directly read / open / view image files (`.jpg`, `.png`, etc.). All image info comes from `analyze_images.py` output or the Design Spec's Image Resource List.

**Output**:
- `<project_path>/design_spec.md` — human-readable design narrative
- `<project_path>/spec_lock.md` — machine-readable execution contract (skeleton: `templates/spec_lock_reference.md`); Executor re-reads before every page

**✅ Checkpoint — Phase deliverables complete, auto-proceed to next step**:
```markdown
## ✅ Strategist Phase Complete
- [x] Eight Confirmations completed (user confirmed)
- [x] Split-mode note appended below the eight items (heavy or normal variant)
- [x] Design Specification & Content Outline generated
- [x] Execution lock (spec_lock.md) generated
- [ ] **Next**: Auto-proceed to [Image_Generator / Executor] phase
```

---

### Step 5: Image Acquisition Phase (Conditional)

🚧 **GATE**: Step 4 complete; Design Specification & Content Outline generated and user confirmed.

> **Trigger**: At least one row in the resource list has `Acquire Via: ai` and/or `Acquire Via: web`. If every row is `user` or `placeholder`, skip to Step 6.

**Always load the common framework**:

```
Read references/image-base.md
```

Then **lazy-load the path-specific reference** for each row that actually needs it:

| Acquire Via | Load reference (only if any such row exists) | Run |
|---|---|---|
| `ai` | `references/image-generator.md` | `python3 ${SKILL_DIR}/scripts/image_gen.py ...` |
| `web` | `references/image-searcher.md` | `python3 ${SKILL_DIR}/scripts/image_search.py ...` |
| `user` / `placeholder` | (skip) | (skip) |

A deck with only `ai` rows never loads `image-searcher.md`; a deck with only `web` rows never loads `image-generator.md`. A mixed deck loads both, processes each row through its own path, and writes both `image_prompts.md` and `image_sources.json`.

Workflow:

1. Extract all rows with `Status: Pending` and `Acquire Via ∈ {ai, web}` from the design spec
2. Generate prompts (ai rows) and/or run search (web rows) per [image-base.md](image-base.md) §2 dispatch table
3. Verify every row reaches a terminal status: `Generated` (ai success), `Sourced` (web success), or `Needs-Manual`

**✅ Checkpoint — Confirm acquisition attempted for every row**:
```markdown
## ✅ Image Acquisition Phase Complete
- [x] image_prompts.md created (when any ai rows processed)
- [x] image_sources.json created (when any web rows processed)
- [x] Each row: status is `Generated` / `Sourced` / `Needs-Manual` (no `Pending` remaining)
```

**Default — auto-proceed to Step 6.** Only when the user's Step 4 response explicitly opted into split mode (in reply to the optional hint), output the Phase A hand-off below and stop this conversation:

```markdown
## ✅ Phase A Complete
- [x] Spec: `design_spec.md`, `spec_lock.md`
- [x] Resources: `sources/`, `images/`, `templates/`
- [ ] **Next**: open a fresh chat window and input `继续生成 projects/<project_name>` to enter Phase B via the [`resume-execute`](../workflows/resume-execute.md) workflow.
```

> On acquisition failure, do NOT halt — follow the Failure Handling rule in [image-base.md](image-base.md) §5: retry once, then mark the row `Needs-Manual`, report to user, and continue to the checkpoint above.

---

### Step 6: Executor Phase

🚧 **GATE**: Step 4 (and Step 5 if triggered) complete; all prerequisite deliverables are ready.

Read the role definition based on the selected style:
```
Read references/executor-base.md          # REQUIRED: common guidelines
Read references/shared-standards.md       # REQUIRED: SVG/PPT technical constraints
Read references/executor-general.md       # General flexible style
Read references/executor-consultant.md    # Consulting style
Read references/executor-consultant-top.md # Top consulting style (MBB level)
```

> Only read executor-base + shared-standards + one style file.

**Design Parameter Confirmation (Mandatory)**: before the first SVG, output key design parameters from the spec (canvas dimensions, color scheme, font plan, body font size). See executor-base.md §2.

**Pre-generation Batch Read (Mandatory)**: before the first SVG, batch-read every distinct layout SVG referenced in `spec_lock.page_layouts` and every distinct chart SVG referenced in `spec_lock.page_charts` (plus any §VII backup charts). One read per file, up front — do not re-read these during page generation. See executor-base.md §1.0.

**Per-page spec_lock re-read (Mandatory)**: before **each** SVG page, `read_file <project_path>/spec_lock.md` and use only its colors / fonts / icons / images, plus the per-page `page_rhythm` / `page_layouts` / `page_charts` lookups (resolves to template SVGs already loaded in the batch read above). Resists context-compression drift on long decks. See executor-base.md §2.1.

> ⚠️ **Main-agent only**: SVG generation MUST stay in the current main agent — page design depends on full upstream context. Do NOT delegate to sub-agents.
> ⚠️ **Generation rhythm**: generate pages sequentially, one at a time, in the same continuous context. Do NOT batch (e.g., 5 per group).

**Visual Construction Phase**: generate SVG pages sequentially, one at a time, in one continuous pass → `<project_path>/svg_output/`

**Quality Check Gate (Mandatory)** — after all SVGs, before speaker notes:
```bash
python3 ${SKILL_DIR}/scripts/svg_quality_checker.py <project_path>
```

- Every SVG has a matching section header in `total.md`
- Every SVG ≤ 16:9 bounds
- All `href` or `src` in SVGs are valid file paths
- `spec_lock.md` `svr_transform` reaches consistency
- No cross-file icon consistency checks

Quality issues → stop, fix SVGs, re-run quality checker → proceed only after all pass.

**Speaker Notes**:

```bash
python3 ${SKILL_DIR}/scripts/total_md_split.py <project_path>
```

Splits project `total.md` into one speaker notes file per SVG → `notes/`.

- Notes path: `notes/<filename>.md`
- All notes files must be created before converting speaker notes to audio
- Full guide in script comments

**✅ Checkpoint — Executor deliverables complete**:
```markdown
## ✅ Executor Phase Complete
- [x] SVG pages generated (svg_output/)
- [x] SVG quality check passed
- [x] Speaker notes split (notes/)
- [ ] [Optional] Proceed to Post-processing (not auto-run)
```

---

### Step 7: Post-processing & Export

🚧 **GATE**: Step 6 complete; `svg_output/` and `notes/` exist.

**Post-processing**: final SVG injection, image embedding, tspan flattening.

```bash
python3 ${SKILL_DIR}/scripts/finalize_svg.py <project_path>
```

Output → `<project_path>/svg_final/` (recommended source for PPTX conversion).

```bash
python3 ${SKILL_DIR}/scripts/svg_to_pptx.py <project_path>
```

Default output:
- `exports/<project_name>_<timestamp>.pptx` — main native editable pptx
- `backup/<timestamp>/<project_name>_svg.pptx` — SVG snapshot for visual reference
- `backup/<timestamp>/svg_output/` — copy of Executor SVG source

**svg_to_pptx.py key parameters**:

| Parameter | Effect |
|-----------|--------|
| `-t / --transition` | Slide transition effect: `fade`/`push`/`wipe`/`split`/`cover`/`none` |
| `-a / --animation` | Element entrance animation: single effect name / `mixed` / `random` |
| `--animation-duration` | Entrance animation duration (default 0.4s) |
| `--animation-stagger` | Gap between elements in after-previous mode (default 0.5s) |
| `--animation-trigger` | `after-previous` / `on-click` / `with-previous` |
| `--no-notes` | Skip speaker notes embedding |
| `--recorded-narration audio` | Embed recorded narration audio |

**Narration audio (optional)**:

```bash
python3 ${SKILL_DIR}/scripts/notes_to_audio.py <project_path> --voice zh-CN-XiaoxiaoNeural
python3 ${SKILL_DIR}/scripts/svg_to_pptx.py <project_path> --recorded-narration audio
```

**✅ Checkpoint — Export complete, PPTX file ready.**

---

### Step 8: Troubleshooting

- **Layout overflow, export errors, blank images, etc.**: see `${SKILL_DIR}/scripts/docs/troubleshooting.md`
- **Common issues**: see `${SKILL_DIR}/scripts/docs/faq.md`
- **Chart coordinate calibration**: run `workflows/verify-charts.md`
- **Animation customization**: run `workflows/customize-animations.md`
- **Visual editing**: run `workflows/visual-edit.md`
