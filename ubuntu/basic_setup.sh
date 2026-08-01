#!/bin/bash

timedatectl set-local-rtc 1

rm *~

shopt -s nocasematch

sudo add-apt-repository ppa:unit193/encryption -y

sudo apt -y update
sudo apt -y upgrade
sudo apt -y clean
sudo apt -y autoremove

sudo snap refresh

sudo apt -y install \
	build-essential \
	curl \
	emacs \
	ffmpeg \
	ffmpegthumbnailer \
	git \
	git-lfs \
	gpg \
	htop \
	keepassxc \
	libfuse2 \
	net-tools \
	pipx \
	transmission \
	tree \
	veracrypt \
	vlc \
	wget \
	btop \
	nvtop




pipx ensurepath
pipx install gallery-dl
pipx install yt-dlp


## Git
