#!/usr/bin/env bash
# One-off playlist/channel downloads (no archive).
# Folder naming matches download_channels.sh: %(playlist,channel)s
# Format (1080p mp4/mp3), --ignore-errors, and metadata come from
# ~/.config/yt-dlp.conf — do not duplicate them here.
#
# Usage: yt-dlp-playlist.sh <url> [url...] [extra yt-dlp options]

set -euo pipefail

if (( $# < 1 )); then
  echo "Usage: $0 <url> [url...]" >&2
  exit 1
fi

yt-dlp -o "%(playlist,channel)s/%(playlist_index)02d - %(title,id)s.%(ext)s" "$@"
