#!/usr/bin/env bash
set -euo pipefail

# --- apt ---
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove -y

# --- system logs ---
sudo find /var/log -maxdepth 1 -name '*.gz' -delete

# --- user caches ---
rm -rf ~/.cache/thumbnails/*
rm -f ~/.bash_history

# --- old snap revisions ---
while read -r snapname revision; do
    sudo snap remove "$snapname" --revision="$revision" || true
done < <(snap list --all | awk '/disabled/{print $1, $3}')
