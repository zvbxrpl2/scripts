#!/usr/bin/env bash
set -euo pipefail

# Resolve paths relative to this script's location
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$script_dir/../config/yt-dlp.conf"
dest="$HOME/.config/yt-dlp.conf"

[[ -f "$src" ]] || { echo "Source not found: $src" >&2; exit 1; }

mkdir -p "$(dirname "$dest")"

# Back up an existing config before overwriting
if [[ -f "$dest" ]]; then
  backup="${dest}.bak"
  cp -p "$dest" "$backup"
  echo "Existing config backed up to $backup"
fi

cp "$src" "$dest"
echo "Copied $src -> $dest"

# Show contents only when explicitly requested
if [[ "${1:-}" == "-v" || "${1:-}" == "--verbose" ]]; then
  echo "Contents of $dest:"
  cat "$dest"
fi
