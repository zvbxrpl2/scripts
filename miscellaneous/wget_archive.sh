#!/usr/bin/env bash
# wget_archive.sh — mirror a website (with its assets) for offline viewing.
# Usage: wget_archive.sh <url>
#
# --mirror = recursive, no-parent, ignore timestamps, infinite depth
# --no-clobber: don't re-download files that already exist
set -euo pipefail

if [[ $# -lt 1 || -z "${1:-}" ]]; then
  echo "Usage: $0 <url>" >&2
  exit 1
fi

# Current browser UA — some sites throttle 2018-era fingerprints
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"

wget \
    --mirror \
    --no-clobber \
    --html-extension \
    --page-requisites \
    --convert-links \
    --restrict-file-names=windows \
    --wait=1 \
    --random-wait \
    --timeout=30 \
    --user-agent="$UA" \
    "$1"

