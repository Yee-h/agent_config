#!/usr/bin/env bash
set -euo pipefail

# Usage: bash move-agents-to-skills.sh                         # default: OpenCode
#        SKILLS_DIR=$HOME/.claude/skills bash move-agents-to-skills.sh  # Claude Code
#        SKILLS_DIR=$HOME/.cursor/skills bash move-agents-to-skills.sh  # Cursor
AGENTS_DIR="${HOME}/.agents/skills"
SKILLS_DIR="${SKILLS_DIR:-${HOME}/.config/opencode/skills}"
# Expand ~ in case env var was passed with tilde
SKILLS_DIR="${SKILLS_DIR/#\~/$HOME}"
WHAT_IF="${WHAT_IF:-}"

move_skill() {
    local src_name="$1" src_dir="$2" rel_path="$3"
    local dst_dir="${SKILLS_DIR}/${rel_path}"

    if [ ! -d "$dst_dir" ]; then
        mkdir -p "$dst_dir"
    fi

    if [ -n "$WHAT_IF" ]; then
        echo "  [~] MOVE: ${src_name} -> ${rel_path}"
    else
        mv "$src_dir"/* "$dst_dir"/
        rmdir "$src_dir" 2>/dev/null || true
        echo "  [✓] ${src_name} -> ${rel_path}"
    fi
}

resolve_target() {
    local name="$1"

    if [[ "$name" =~ ^obra-superpowers-(.+)$ ]]; then
        echo "superpowers/${BASH_REMATCH[1]}"
        return
    fi

    case "$name" in
        openspec-proposal-creation) echo "openspec/openspec-propose" ;;
        openspec-implementation)    echo "openspec/openspec-apply-change" ;;
        openspec-archiving)         echo "openspec/openspec-archive-change" ;;
        openspec-context-loading)   echo "openspec/openspec-explore" ;;
        openspec-*)
            echo "[?] unknown openspec variant: ${name}, using as-is" >&2
            echo "$name" ;;
        *)
            echo "$name" ;;
    esac
}

if [ ! -d "$AGENTS_DIR" ]; then
    echo "Source not found: ${AGENTS_DIR}" >&2
    exit 1
fi

count=0
for entry in "$AGENTS_DIR"/*/; do
    [ -d "$entry" ] || continue
    src_name=$(basename "$entry")
    rel_path=$(resolve_target "$src_name")
    move_skill "$src_name" "$entry" "$rel_path"
    count=$((count + 1))
done

echo ""
echo "Done. ${count} skills moved."
