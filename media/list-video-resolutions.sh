#!/usr/bin/env bash
set -euo pipefail

out="resolutions.txt"
: > "$out"   # truncate/create

while IFS= read -r -d '' f; do
  dims="$(ffprobe -v error -select_streams v:0 \
           -show_entries stream=width,height \
           -of csv=s=x:p=0 "$f")"
  printf '%s\t%s\n' "$dims" "$f" >> "$out"
done < <(find . -name '*.mp4' -print0)

# Sort by resolution, then filename, and replace the file
sort -t $'\t' -k1,1 -k2,2 "$out" -o "$out"

echo "Wrote $(wc -l < "$out") entries to $out"
