#!/bin/bash


# Remove apt / apt-get files
sudo apt clean
sudo apt -s clean
sudo apt clean all
sudo apt autoremove
sudo apt-get clean
sudo apt-get -s clean
sudo apt-get clean all
sudo apt-get autoclean

sudo snap refresh

# Remove Old Log Files
sudo rm -f /var/log/*gz

# Remove Thumbnail Cache
rm -rf ~/.cache/thumbnails/*
rm -rf ~/.bash_history
history -c

# Remove old snaps
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
while read snapname revision; do
    sudo snap remove "$snapname" --revision="$revision"
done
