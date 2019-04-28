#!/bin/bash

# Script to install spin and ispin
# Author: Michal Kukowski

dir = `pwd`
mkdir -p temp
cd temp
wget spinroot.com/spin/Src/spin649.tar.gz
gunzip spin649.tar.gz
tar -xf spin649.tar
cd Spin/Src*
make
sudo make install
cd ../iSpin
chmod +x install.sh
sudo ./install.sh
cd $dir
rm -rf temp
