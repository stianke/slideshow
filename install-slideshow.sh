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

# USBmount - Mounts usb stick automatically
sudo apt-get install usbmount -y

# Fix some issues that crept in when Debian moved to the Bullseye release
sudo mkdir /etc/systemd/system/systemd-udevd.service.d
sudo wget --no-check-certificate https://raw.githubusercontent.com/jb2cool/slideshow/master/00-my-custom-mountflags.conf -O /etc/systemd/system/systemd-udevd.service.d/00-my-custom-mountflags.conf

# Reboot (to apply new mount settings)
sudo reboot

# Copy .xsession to /home/pi - assuming pi is the user id setup to run on bootup
# This script starts the display manager and syncs the default user home with a fresh copy from /media/usb/pi
# It also deletes any previous LibreOffice config allowing clean start of slideshow
wget --no-check-certificate https://raw.github.com/jb2cool/slideshow/master/.xsession

# Insert the USB transfer stick (should have the label usb or you'll need to change some stuff)   

# Create a copy of the default user (pi) in /media/usb
sudo cp -r /home/pi /media/usb/
cd /media/usb/pi/
sudo chmod -R a+r .
sudo chmod a+x .xsession
