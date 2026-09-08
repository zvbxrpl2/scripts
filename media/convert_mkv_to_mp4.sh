#!/usr/bin/env bash
set -euo pipefail
shopt -s globstar nullglob

files=(**/*.mkv)
if (( ${#files[@]} == 0 )); then
  echo "No .mkv files found."
  exit 0
fi

for i in "${files[@]}"; do
  out="${i%.mkv}.mp4"
  echo "Converting: $i -> $out"
  ffmpeg -hide_banner -i "$i" -map 0:v -map 0:a -c copy "$out" -y
  touch -r "$i" "$out"
done
