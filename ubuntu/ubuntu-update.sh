#!/usr/bin/env bash
set -euo pipefail

# apt
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt autoremove --purge -y
sudo apt-get clean

# pipx
if command -v pipx >/dev/null 2>&1; then
    pipx upgrade-all
else
    echo "pipx not found on PATH — skipping pipx upgrade-all" >&2
fi

