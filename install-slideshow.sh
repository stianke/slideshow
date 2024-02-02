#!/bin/bash
# Installation instructions for running Raspberry Pi slideshow

# Install latest Raspberry Pi OS to SD card and boot Raspberry Pi
# Run through initial Raspi-Config and then boot into GUI


# Update repositry info and upgrade packages to latest versions
sudo apt-get update && sudo apt-get dist-upgrade -y

# Install following applications:
# Matchbox - Lightweight window manager
sudo apt-get install matchbox -y

# Rsync - File synchronisation application   
sudo apt-get install rsync -y

# LibreOffice - Office suite including presentation application
sudo apt-get install libreoffice -y

# PowerPoint to PDF converter (TODO: This may fail??? If so, manually install an older version of the library it tries to autoinstall)
sudo pip install unoserver

# PDF to PNG converter
sudo apt-get install pdftoppm -y

# USBmount - Mounts usb stick automatically
sudo apt-get install usbmount -y

# Fix some issues that crept in when Debian moved to the Bullseye release
sudo mkdir /etc/systemd/system/systemd-udevd.service.d
#sudo wget --no-check-certificate https://raw.githubusercontent.com/stianke/slideshow/master/files/00-my-custom-mountflags.conf -O /etc/systemd/system/systemd-udevd.service.d/00-my-custom-mountflags.conf
sudo wget -P /etc/systemd/system/systemd-udevd.service.d https://raw.githubusercontent.com/stianke/slideshow/master/files/00-my-custom-mountflags.conf

# xdotool - Move mouse programmatically. For some reason, the slideshow often stops playing, but it can be fixed by moving the mouse. 
# A script that moves the mouse to the bottom right corner, and then moves it one pixel every second is executed at boot.
sudo apt-get install xdotool -y

cd $HOME

# Copy sctipt that moves the mouse programmatically
wget https://raw.githubusercontent.com/stianke/slideshow/master/files/fetch_slideshow_interval.sh
chmod +x fetch_slideshow_interval.sh

# Make libreoffice config preset
mkdir libreoffice_config
mkdir libreoffice_config/4
mkdir libreoffice_config/4/user
wget -P libreoffice_config/4/user https://raw.githubusercontent.com/stianke/slideshow/master/files/libreoffice_config/4/user/registrymodifications.xcu


# Copy .xsession to /home/pi - assuming pi is the user id setup to run on bootup
# This script starts the display manager and syncs the default user home with a fresh copy from /media/usb/pi
# It also deletes any previous LibreOffice config allowing clean start of slideshow
wget --no-check-certificate https://raw.github.com/stianke/slideshow/master/files/.xsession

wget https://raw.github.com/stianke/slideshow/master/files/default_image.png
wget https://raw.github.com/stianke/slideshow/master/files/loading_presentation.png

# Make directory to store presentations in
mkdir slideshow

# Initialize with a dummy sha256sum.txt
echo "dummy" > sha256sum.txt

# Disable sleep (may not be neccesary)
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

