---
name: openspec
description: >-
  Spec-Driven Development full lifecycle management. Covers four phases:
  Explore (context discovery) → Propose (change proposal creation) →
  Apply (change implementation) → Archive (archive and merge). Loads only
  the sub-skill needed for the current phase to avoid unnecessary context
  usage. Use when the user mentions "openspec", "spec", "specification",
  "proposal", "change plan", "archive", "review", "SDD", "requirements
  document", "behavior contract", "spec-driven", or any project
  specification-related need. Also applies to workflow state questions like
  "how to start", "current progress", "what's next", "project status".
  Note: when the user explicitly requests a specific action (e.g. "create
  proposal", "implement change", "archive"), load the corresponding
  sub-skill directly without going through this parent skill.
---
# Openspec: Spec-Driven Development

The core loop of Spec-Driven Development (SDD) methodology.

## Workflow Overview

Explore → Propose → Apply → Archive

Each phase maps to a sub-skill, loaded on demand:

| Phase    | Goal                                      | Sub-skill                   |
| -------- | ----------------------------------------- | --------------------------- |
| Explore  | Understand context, existing specs, changes | `openspec-context-loading` |
| Propose  | Create structured change proposals        | `openspec-proposal-creation` |
| Apply    | Execute tasks sequentially                | `openspec-implementation`   |
| Archive  | Merge spec deltas and archive             | `openspec-archiving`        |

## Quick Dispatch

Load the corresponding sub-skill directly based on user intent, without going through the parent skill:

**User intent → Direct sub-skill to load**

```
"What specs exist" / "show changes" / "search password requirements"
  → openspec-explore

"Plan a new feature" / "create a proposal"
  → openspec-propose

"Start implementation" / "apply the change" / "build this feature"
  → openspec-apply-change

"Archive" / "merge into living docs" / "mark as done"
  → openspec-archive-change

"Start from scratch: first see what exists, then plan a new feature"
  → load openspec-explore first to understand context
  → then switch to openspec-propose based on findings
```

Do not load multiple sub-skills in a single session. Close the current sub-skill context before loading the next.

## Sub-Skill Load Paths

When loading a sub-skill is needed, read the corresponding path:

```
skills/openspec/openspec-explore/SKILL.md
skills/openspec/openspec-propose/SKILL.md
skills/openspec/openspec-apply-change/SKILL.md
skills/openspec/openspec-archive-change/SKILL.md
```

Each sub-skill's SKILL.md contains the full workflow checklist, command templates, best practices, and anti-patterns.

## Project Spec Structure

openspec artifacts live under `spec/` at the project root:

```
spec/
├── specs/                 # Living docs - currently active specifications
│   ├── {capability}/
│   │   └── spec.md
│   └── ...
├── changes/               # Active changes
│   ├── {change-id}/
│   │   ├── proposal.md    # Rationale for the change
│   │   ├── tasks.md       # Implementation task list
│   │   ├── specs/         # Spec deltas
│   │   │   └── {capability}/
│   │   │       └── spec-delta.md
│   │   └── IMPLEMENTED    # Completion marker
│   └── ...
└── archive/               # Archived change history
    └── {YYYY-MM-DD}-{change-id}/
```

## Workflow Principles

1. **SSOT (Single Source of Truth)**: Living docs under `spec/specs/` are the single authoritative source for specifications. During active changes, deltas are stored in `spec/changes/{change-id}/specs/` and merged back during archiving.

2. **Validation Loop**: Each phase must be validated before proceeding. During the Apply phase, every task must pass tests before being marked complete.

3. **Atomicity**: One proposal addresses one concern. Merging multiple changes into one proposal makes specifications hard to track.

4. **Progressive Disclosure**: Do not load sub-skills that are not needed. Actively clean up context when switching workflows.

## AGENTS.md Mapping

The Skill dispatch table defined in the project's AGENTS.md maps to this parent skill as follows:

| AGENTS.md Scenario      | Corresponding Sub-skill |
| ----------------------- | ----------------------- |
| Requirements clarification | `openspec-explore`    |
| Change proposal         | `openspec-propose`      |
| Task execution          | `openspec-apply-change` |
| Change archiving        | `openspec-archive-change` |

---

**Design Principle**: This skill is a router, not a content container. Specific workflow details live in the 4 sub-skills, each with its own responsibility. Keep the parent skill lightweight (~150 lines), providing only dispatch logic and a bird's-eye view.
