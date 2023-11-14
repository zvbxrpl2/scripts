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
sudo apt -y install nvidia-driver-535
sudo apt -y install curl
sudo apt -y install tree
sudo apt -y install wget gpg

python3 -m pip install -U gallery-dl
python3 -m pip install -U yt-dlp

## VS Code

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt -y install apt-transport-https
sudo apt -y update
sudo apt -y install code # or code-insiders

## ProtonVPN

wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb
sudo apt-get -y install ./protonvpn-stable-release_1.0.3_all.deb
sudo apt-get -y update
rm -rf protonvpn-stable-release_1.0.3_all.deb

## Aliases

if grep --quiet "alias emacs" ~/.bashrc; then
	echo emacs alias already exists
else
	echo writing emacs alias
	echo 'alias emacs="emacs -nw"' >> ~/.bashrc
fi

# Replace Snap Firefox with Apt Firefox

snap disable firefox
snap remove --purge firefox

sudo add-apt-repository ppa:mozillateam/ppa -y

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap1-0ubuntu2
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo apt install firefox -y
