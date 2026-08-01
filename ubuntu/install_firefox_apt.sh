#!/bin/bash

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
