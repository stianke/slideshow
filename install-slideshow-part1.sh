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
