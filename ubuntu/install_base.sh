#!/bin/bash

timedatectl set-local-rtc 1

rm *~

shopt -s nocasematch

sudo apt -y update
sudo apt -y upgrade
sudo apt -y clean
sudo apt -y autoremove

sudo snap refresh

sudo apt -y install build-essential
sudo apt -y install transmission
sudo apt -y install vlc
sudo apt -y install python3-pip
sudo apt -y install ffmpeg
sudo apt -y install net-tools
sudo apt -y install git
sudo apt -y install git-lfs
sudo apt -y install htop
sudo apt -y install neofetch
sudo apt -y install emacs
sudo apt -y install curl
sudo apt -y install tree
sudo apt -y install wget gpg
sudo apt -y install keepassxc
sudo apt -y install libfuse2

python3 -m pip install -U gallery-dl
python3 -m pip install -U yt-dlp

## Veracrypt

sudo add-apt-repository ppa:unit193/encryption -y
sudo apt update -y
sudo apt install veracrypt -y

## Aliases

if grep --quiet "alias emacs" ~/.bashrc; then
	echo emacs alias already exists
else
	echo writing emacs alias
	echo 'alias emacs="emacs -nw"' >> ~/.bashrc
fi

## Replace Snap Firefox with Apt Firefox

sudo snap disable firefox
sudo snap remove --purge firefox

sudo add-apt-repository ppa:mozillateam/ppa -y

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap1-0ubuntu2
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo apt install firefox -y --allow-downgrades

## Git

git config --global user.email "zvbxrpl@protonmail.com"
git config --global user.name "zvbxrpl"