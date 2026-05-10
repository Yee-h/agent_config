#!/usr/bin/env bash
set -euo pipefail

# ~/.agents/ is the shared staging area from `npx skills --global`.
# It is NOT agent-specific — all agents download skills here.
# Delete it only after moving skills to the current agent's skills directory.
AGENTS_DIR="${HOME}/.agents"
FORCE="${FORCE:-}"

if [ ! -d "$AGENTS_DIR" ]; then
    echo "Not found: ${AGENTS_DIR}" >&2
    exit 1
fi

skill_count=0
if [ -d "${AGENTS_DIR}/skills" ]; then
    skill_count=$(find "${AGENTS_DIR}/skills" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
fi

echo "Target: ${AGENTS_DIR}"
echo "Skills subdirs: ${skill_count}"
echo "Warning: This folder may be shared by other tools (GitHub Copilot, Cline, etc.)"
echo ""

if [ -z "$FORCE" ]; then
    read -r -p "Delete entire ${AGENTS_DIR} ? [y/N] " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "Cancelled."
        exit 0
    fi
fi

rm -rf "$AGENTS_DIR"
echo "[✓] Deleted: ${AGENTS_DIR}"
