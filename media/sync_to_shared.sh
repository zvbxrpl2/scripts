#!/usr/bin/env bash
set -euo pipefail

# --- Config (edit these) ---
SMB_HOST="192.168.2.254"
SMB_SHARE="shared"
REMOTE_PATH="Media/Videos/Youtube/Channels"
# ---

mount_path="/run/user/$(id -u)/gvfs/smb-share:server=${SMB_HOST},share=${SMB_SHARE}/${REMOTE_PATH}"
source="."

if [[ ! -d "$mount_path" ]]; then
  echo "Error: SMB mount not found at:" >&2
  echo "  $mount_path" >&2
  echo "Mount it first (e.g. via Nautilus or: gio mount smb://${SMB_HOST}/${SMB_SHARE})" >&2
  exit 1
fi

rsync --modify-window=1 -avzh --no-perms \
  --timeout=60 --partial \
  "$source/" "$mount_path/"

