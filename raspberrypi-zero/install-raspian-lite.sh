#!/bin/bash
# tested on OSX el capitan
# do not forget to run this with sudo
cd ~/Downloads
read -n 1 -s -p "Downloading raspbian lite latest. Press any key to download."
wget https://downloads.raspberrypi.org/raspbian_lite_latest
read -n 1 -s -p "Insert disk you want to install raspbian on. Press any key to continue once inserted."
df -h
read -n1 -p "Disk # to unmount? (should match size of external listed above) [1,2,3,4,5]: " doit 
diskutil unmountDisk /dev/disk$doit
read -n 1 -s -p "Burning raspbian to the disk you selected. This may take up to 5 minutes. Press any key to begin."
sudo dd bs=1m if=~/Downloads/2016-05-27-raspbian-jessie-lite.img of=/dev/rdisk$doit
echo "completed burning to disk successfully. now let's go into the volume and edit the config files needed to boot properly."
cd /Volumes/boot
echo "dtoverlay=dwc2" >> config.txt
sed -i '' ' 1 s/.*rootwait/& modules-load=dwc2,g_ether/' cmdline.txt # osx specific
echo "all done, eject card and put in the pi zero and boot up."
echo "try ssh pi@raspberrypi.local with password raspberry and should be gtg"
