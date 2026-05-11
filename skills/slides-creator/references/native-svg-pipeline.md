# Native SVG → PPTX Pipeline

> AI-driven multi-format source-to-native-PPTX production pipeline. Converts source documents (PDF/DOCX/PPTX/URL/Markdown) into high-quality SVG pages through multi-role collaboration, then compiles them to fully-editable native PPTX via a custom SVG → DrawingML compiler.

**Core Pipeline**: `Source Document → Create Project → [Template] → Strategist → [Image Acquisition] → Executor → Post-processing → Export`

---

## Global Execution Discipline (Mandatory)

**This pipeline is a strict serial pipeline. The following rules have the highest priority — violating any one of them constitutes execution failure:**

1. **Serial Execution** — Steps MUST be executed in order; the output of each step is the input for the next. Non-BLOCKING adjacent steps may proceed continuously once prerequisites are met, without waiting for the user to say "continue"
2. **BLOCKING = Hard Stop** — Steps marked ⛔ BLOCKING require a full stop; the AI MUST wait for an explicit user response before proceeding and MUST NOT make any decisions on behalf of the user
3. **No Cross-Phase Bundling** — Cross-phase bundling is FORBIDDEN. (Note: the Eight Confirmations in Step 4 are ⛔ BLOCKING — the AI MUST present recommendations and wait for explicit user confirmation before proceeding. Once the user confirms, all subsequent non-BLOCKING steps — design spec output, SVG generation, speaker notes, and post-processing — may proceed automatically without further user confirmation)
4. **Gate Before Entry** — Each Step has prerequisites (🚧 GATE) listed at the top; these MUST be verified before starting that Step
5. **No Speculative Execution** — "Pre-preparing" content for subsequent Steps is FORBIDDEN (e.g., writing SVG code during the Strategist phase)
6. **No Sub-Agent SVG Generation** — Executor Step 6 SVG generation is context-dependent and MUST be completed by the current main agent end-to-end. Delegating page SVG generation to sub-agents is FORBIDDEN
7. **Sequential Page Generation Only** — In Executor Step 6, after the global design context is confirmed, SVG pages MUST be generated sequentially page by page in one continuous pass. Grouped page batches (for example, 5 pages at a time) are FORBIDDEN
8. **Spec-Lock Re-Read Per Page** — Before generating each SVG page, Executor MUST `read_file <project_path>/spec_lock.md`. All colors / fonts / icons / images MUST come from this file — no values from memory or invented on the fly. Executor MUST also look up the current page's `page_rhythm` (`anchor` / `dense` / `breathing`), `page_layouts` (which template SVG to inherit, if any), and `page_charts` (which chart template to adapt, if any). Empty / absent entries are intentional Strategist signals — see executor-base.md §2.1. This rule exists to resist context-compression drift on long decks and to break the uniform "every page is a card grid" default

---

## Language & Communication Rule

- **Response language**: match the user's input and source materials. Explicit user override (e.g., "Please answer in English") takes precedence
- **Template format**: `design_spec.md` MUST follow its original English template structure (section headings, field names) regardless of conversation language. Content values may be in the user's language

---

## Compatibility With Generic Coding Skills

- This is a repository-specific workflow, not a general application scaffold
- Do NOT create `.worktrees/`, `tests/`, branch workflows, or generic engineering structure by default
- On conflict with a generic coding skill, follow this skill unless the user explicitly says otherwise

---

## Main Pipeline Scripts

> All paths use `${SKILL_DIR}` as the skill root. For complete tool documentation, see `${SKILL_DIR}/scripts/README.md`.

| Script | Purpose |
|--------|---------|
| `${SKILL_DIR}/scripts/source_to_md/pdf_to_md.py` | PDF → Markdown |
| `${SKILL_DIR}/scripts/source_to_md/doc_to_md.py` | Documents → Markdown — native Python for DOCX/HTML/EPUB/IPYNB, pandoc fallback for legacy formats |
| `${SKILL_DIR}/scripts/source_to_md/excel_to_md.py` | Excel workbooks → Markdown |
| `${SKILL_DIR}/scripts/source_to_md/ppt_to_md.py` | PowerPoint → Markdown |
| `${SKILL_DIR}/scripts/source_to_md/web_to_md.py` | Web page → Markdown (supports WeChat via `curl_cffi`) |
| `${SKILL_DIR}/scripts/project_manager.py` | Project init / validate / manage |
| `${SKILL_DIR}/scripts/analyze_images.py` | Image analysis |
| `${SKILL_DIR}/scripts/image_gen.py` | AI image generation (multi-provider) |
| `${SKILL_DIR}/scripts/svg_quality_checker.py` | SVG quality check |
| `${SKILL_DIR}/scripts/total_md_split.py` | Speaker notes splitting |
| `${SKILL_DIR}/scripts/finalize_svg.py` | SVG post-processing (unified entry) |
| `${SKILL_DIR}/scripts/svg_to_pptx.py` | Export to PPTX |
| `${SKILL_DIR}/scripts/update_spec.py` | Propagate spec_lock.md color / font changes across all generated SVGs |

---

## Template Index

| Index | Path | Purpose |
|-------|------|---------|
| Layout templates | `${SKILL_DIR}/templates/layouts/layouts_index.json` | Query available page layout templates |
| Visualization templates | `${SKILL_DIR}/templates/charts/charts_index.json` | Query available visualization SVG templates (charts, infographics, diagrams, frameworks) |
| Icon library | `${SKILL_DIR}/templates/icons/` | See `${SKILL_DIR}/templates/icons/README.md`; search icons on demand with `ls templates/icons/<library>/ \| grep <keyword>` |

---

## Standalone Workflows

> These workflow files are loaded on demand after native SVG pipeline activation.

| Workflow | Path | Purpose |
|----------|------|---------|
| `topic-research` | `workflows/topic-research.md` | Pre-pipeline — gather web sources when the user supplies only a topic with no source files |
| `create-template` | `workflows/create-template.md` | Standalone template creation workflow |
| `resume-execute` | `workflows/resume-execute.md` | Phase B entry — resume execution in a fresh chat after Phase A (Steps 1–5) completed in another session (split mode) |
| `verify-charts` | `workflows/verify-charts.md` | Chart coordinate calibration — run after SVG generation if the deck contains data charts |
| `customize-animations` | `workflows/customize-animations.md` | Object-level PPTX animation customization — run only when the user explicitly asks to tune animation order/effects/timing |
| `visual-edit` | `workflows/visual-edit.md` | Browser-based visual editor for fine-grained edits — run only when the user explicitly requests it after export |

---

## Reference Files

> The following reference files are loaded on demand at the corresponding steps of the native SVG pipeline.

| File | When to Load |
|------|-------------|
| `references/native-svg-workflow.md` | Loaded first upon native SVG pipeline activation — contains full Steps 1–8 |
| `references/strategist.md` | Step 4: Strategist role definition |
| `references/executor-base.md` | Step 6: Executor common guidelines (required) |
| `references/executor-general.md` | Step 6: General flexible style |
| `references/executor-consultant.md` | Step 6: Consulting style |
| `references/executor-consultant-top.md` | Step 6: Top consulting style (MBB level) |
| `references/shared-standards.md` | Step 6: SVG/PPT technical constraints (required) |
| `references/canvas-formats.md` | Step 2: Full canvas format list |
| `references/image-base.md` | Step 5: Image acquisition common framework |
| `references/image-generator.md` | Step 5: AI image generation (only when ai rows exist) |
| `references/image-searcher.md` | Step 5: Web image search (only when web rows exist) |
| `references/image-layout-spec.md` | Step 5: Image layout specification |
| `references/animations.md` | When customizing animations |
| `references/svg-image-embedding.md` | When embedding SVG images |
| `references/template-designer.md` | When designing templates |
| `templates/design_spec_reference.md` | Step 4: Design Spec template |
| `templates/spec_lock_reference.md` | Step 4: spec_lock skeleton |
