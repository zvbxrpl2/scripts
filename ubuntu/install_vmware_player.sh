#!/bin/bash

sudo apt install build-essential linux-headers-generic -y
wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getplayer-linux
chmod +x getplayer-linux
sudo ./getplayer-linux --required --eulas-agreed
