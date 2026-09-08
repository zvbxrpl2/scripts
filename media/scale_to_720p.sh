#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

for filename in *.mp4; do
  name="${filename%.mp4}"
  out="${name}.720p.mp4"
  # Skip files we already created
  [[ "$filename" == *.720p.mp4 ]] && continue
  echo "Scaling: $filename -> $out"
  ffmpeg -hide_banner -i "$filename" \
    -vf "scale=-2:720" \
    -c:v libx264 -crf 23 -preset medium \
    -c:a aac \
    "$out" -y
done
