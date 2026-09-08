#!/usr/bin/env bash
set -euo pipefail

# Ubuntu basic setup
# Usage: sudo bash ubuntu-basic-setup.sh

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo: sudo bash $0" >&2
  exit 1
fi

# Only enable if you have a non-UTC hardware clock (e.g., Windows dual-boot)
# timedatectl set-local-rtc 1

# Remove editor backup files in the current directory (safe)
find . -maxdepth 1 -name '*~' -delete || true

apt-add-repository -y ppa:unit193/encryption

apt -y update
apt -y upgrade
apt -y install \
  build-essential \
  btop \
  curl \
  emacs \
  ffmpeg \
  ffmpegthumbnailer \
  git \
  git-lfs \
  gpg \
  htop \
  keepassxc \
  net-tools \
  nvtop \
  pipx \
  transmission \
  tree \
  veracrypt \
  vlc \
  wget

apt -y autoremove
apt -y clean

snap refresh

pipx ensurepath
pipx install gallery-dl yt-dlp
pipx ensurepath
pipx upgrade gallery-dl yt-dlp
