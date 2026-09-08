#!/usr/bin/env bash
# link_all.sh — make every .sh script in this repo available as a command.
#
# Creates symlinks in <repo>/bin. Add that directory to PATH once:
#   export PATH="$HOME/Code/scripts/bin:$PATH"
#
# Naming rules:
#   - script name without the .sh extension (e.g. cleanup.sh -> cleanup)
#   - if the name is taken (another script, or an existing command such as
#     rsync/wget), it gets a "<folder>-<name>-N" form (e.g. miscellaneous-rsync-2)
#     so it never shadows a system binary
#   - explicit overrides in the table below take priority (repo path -> name)
#
# Idempotent: safe to re-run; removes stale links whose targets moved.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bin_dir="$repo_root/bin"
mkdir -p "$bin_dir"

# Explicit name overrides (repo-relative path -> command name)
declare -A overrides=(
  # e.g. ["media/download_channels.sh"]="dl-channels"
)

# PATH without our own bin/, so we don't "collide" with our own old links
clean_path="$(printf '%s\n' "$PATH" | tr ':' '\n' | grep -vxF "$bin_dir" | paste -sd: -)"

declare -A used=()
picked=""

pick_name() {
  local script="$1" rel base dir candidate i=1
  rel="${script#"$repo_root"/}"
  # Explicit override wins
  if [[ -n "${overrides[$rel]:-}" ]]; then
    picked="${overrides[$rel]}"
    used["$picked"]=1
    return
  fi
  base="$(basename "$script" .sh)"
  dir="$(basename "$(dirname "$script")")"
  candidate="$base"
  while
    [[ -n "${used[$candidate]:-}" ]] ||
    PATH="$clean_path" command -v "$candidate" >/dev/null 2>&1
  do
    i=$((i + 1))
    candidate="${dir}-${base}-${i}"
  done
  picked="$candidate"
  used["$picked"]=1
}

# Remove stale symlinks whose targets are no longer inside the repo
for link in "$bin_dir"/*; do
  [[ -L "$link" ]] || continue
  target="$(readlink -f "$link" 2>/dev/null || true)"
  if [[ "$target" != "$repo_root"/* ]]; then
    rm -f "$link"
    echo "removed stale link: ${link##*/}"
  fi
done

count=0
while IFS= read -r -d '' script; do
  pick_name "$script"
  ln -sf "$script" "$bin_dir/$picked"
  printf '  %-24s -> %s\n' "$picked" "${script#"$repo_root"/}"
  count=$((count + 1))
done < <(find "$repo_root" -type f -name '*.sh' -not -path "$bin_dir/*" -print0 | sort -z)

echo "Linked $count scripts into $bin_dir"
