#!/usr/bin/env bash
# Generic rsync wrapper (command name: easy_sync).
# Always: -a (archive), --modify-window=1, --no-perms
# Usage: easy_sync <source> <dest> [extra rsync options]
#   -a is implied; add -v -h --progress etc. as extra options if you want them.
#
# Examples:
#   easy_sync ./photos /mnt/backup/photos
#   easy_sync ./videos server:/backups/videos -v -h --progress
#   easy_sync ./project ~/backup/project --delete
set -euo pipefail

if (( $# < 2 )); then
  echo "Usage: $0 <source> <dest> [extra rsync options]" >&2
  exit 1
fi

source="$1"
dest="$2"
shift 2
extra=("$@")

# Create the destination for local relative paths (rsync handles absolute/remote).
if [[ "$dest" != /* && "$dest" != *:* ]]; then
  mkdir -p "$dest"
fi

echo "rsync from '$source' to '$dest'"
rsync --modify-window=1 -avzh --no-perms "${extra[@]}" "$source" "$dest"

