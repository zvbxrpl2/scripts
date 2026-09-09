#!/usr/bin/env bash
# Download whole YouTube channels/playlists into per-playlist folders.
# Dedupes across all runs via a shared archive file.
# Format (1080p mp4/mp3), --ignore-errors, and metadata come from
# ~/.config/yt-dlp.conf — do not duplicate them here.

set -uo pipefail

# Resolve the script's real directory even when invoked via a symlink
# (e.g. bin/download_channels -> media/download_channels.sh), so channels.txt
# and archive.txt are found next to the actual script, not the link.
src="${BASH_SOURCE[0]}"
if command -v readlink >/dev/null 2>&1; then
  src="$(readlink -f "$src" 2>/dev/null)" || src="${BASH_SOURCE[0]}"
fi
base_dir="$(cd "$(dirname "$src")" && pwd)"
archive="${YT_ARCHIVE:-$base_dir/archive.txt}"
list_file="${CHANNELS_FILE:-$base_dir/channels.txt}"
out_template="%(playlist,channel)s/%(title,id)s.%(ext)s"

# --- options (defaults) ---
only=""
audio_only=0
dry_run=0
list_only=0

usage() {
  cat <<EOF
Usage: $(basename "$0") [options]

Downloads whole YouTube channels/playlists (from $list_file) into
per-channel folders, deduping across runs via a download archive.
Format (1080p mp4/mp3), --ignore-errors, and metadata come from
~/.config/yt-dlp.conf.

Options:
  --list                 List configured channels and exit (no download)
  --only <match>         Only channels whose label or URL contains <match>
  --audio-only           Download audio only (pass -x to yt-dlp)
  --dry-run              Simulate; show what would download (--simulate)
  -h, --help             Show this help and exit

Environment:
  CHANNELS_FILE   Path to the channel list (default: <script dir>/channels.txt)
  YT_ARCHIVE      Path to the download archive file

Examples:
  $(basename "$0") --list
  $(basename "$0") --only veritasium
  $(basename "$0") --only Digikey --audio-only --dry-run
EOF
}

die() { echo "error: $*" >&2; exit 1; }

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --list)         list_only=1; shift ;;
      --only)         [[ $# -ge 2 ]] || die "--only requires an argument"; only="$2"; shift 2 ;;
      --audio-only)   audio_only=1; shift ;;
      --dry-run)      dry_run=1; shift ;;
      -h|--help)      usage; exit 0 ;;
      -*)             die "unknown option: $1 (see --help)" ;;
      *)              : ;; # ignore stray positional args
    esac
  done
}

# Derive a short human label from a YouTube URL.
derive_label() {
  local url="$1"
  if [[ "$url" =~ /@([A-Za-z0-9_.-]+) ]]; then
    printf '%s\n' "${BASH_REMATCH[1]}"
  elif [[ "$url" =~ list=([A-Za-z0-9_-]+) ]]; then
    printf 'playlist-%s\n' "${BASH_REMATCH[1]}"
  elif [[ "$url" =~ youtube\.com/([^/]+) ]]; then
    printf '%s\n' "${BASH_REMATCH[1]}"
  else
    printf '%s\n' "$url"
  fi
}

# Load the channel list into parallel arrays LABELS and URLS.
declare -a LABELS=() URLS=()
load_channels() {
  [[ -f "$list_file" ]] || die "channel list not found: $list_file"
  local line label url
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%%$'\r'}"
    line="${line#"${line%%[![:space:]]*}"}"   # ltrim
    line="${line%"${line##*[![:space:]]}"}"   # rtrim
    [[ -z "$line" || "$line" == \#* ]] && continue
    if [[ "$line" =~ ^[^\ ]+\ https:// ]]; then
      label="${line%% *}"        # "label url" form
      url="${line#* }"
    else
      url="$line"
      label="$(derive_label "$url")"
    fi
    LABELS+=("$label")
    URLS+=("$url")
  done < "$list_file"
}

# Download one channel/url with the current options.
dl() {
  local url="$1"
  local -a args=(--download-archive "$archive" -o "$out_template")
  (( audio_only )) && args+=(-x)
  (( dry_run )) && args+=(--simulate)
  yt-dlp "${args[@]}" "$url"
}

parse_args "$@"
load_channels

# --- --list: print configured channels and exit ---
if (( list_only )); then
  printf '%-24s %s\n' "LABEL" "URL"
  for i in "${!LABELS[@]}"; do
    printf '%-24s %s\n' "${LABELS[i]}" "${URLS[i]}"
  done
  echo
  echo "${#LABELS[@]} channel(s) configured."
  exit 0
fi

command -v yt-dlp >/dev/null 2>&1 || die "yt-dlp not found in PATH"

total=${#LABELS[@]}
selected=0
failed=0

for i in "${!LABELS[@]}"; do
  label="${LABELS[i]}"
  url="${URLS[i]}"

  # --only: keep channels whose label or URL contains the match (case-insensitive)
  if [[ -n "$only" ]]; then
    lc_label="${label,,}"
    lc_url="${url,,}"
    lc_only="${only,,}"
    if [[ "$lc_label" != *"$lc_only"* && "$lc_url" != *"$lc_only"* ]]; then
      continue
    fi
  fi

  selected=$((selected + 1))
  echo "[$selected/$total] $label"
  echo "       $url"
  if dl "$url"; then
    echo
  else
    echo "       FAILED: $label" >&2
    echo
    failed=$((failed + 1))
  fi
done

if (( selected == 0 )); then
  [[ -n "$only" ]] && die "no channels matched --only '$only'"
  die "no channels configured in $list_file"
fi

echo "Done. Processed $selected channel(s); $failed failed."
