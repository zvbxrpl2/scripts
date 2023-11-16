#!/bin/bash

wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb
sudo apt-get -y install ./protonvpn-stable-release_1.0.3_all.deb
sudo apt-get -y update
rm -rf protonvpn-stable-release_1.0.3_all.deb