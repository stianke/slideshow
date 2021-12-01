#!/bin/bash
# Copy .xsession to /home/pi - assuming pi is the user id setup to run on bootup
# This script starts the display manager and syncs the default user home with a fresh copy from /media/usb/pi
# It also deletes any previous LibreOffice config allowing clean start of slideshow
wget --no-check-certificate https://raw.github.com/jb2cool/slideshow/master/.xsession

# Insert the USB transfer stick (should have the label usb or you'll need to change some stuff)   
echo "insert USB stick now"
read -p "Press any key to continue..."

# Create a copy of the default user (pi) in /media/usb
sudo cp -r /home/pi /media/usb/
cd /media/usb/pi/
sudo chmod -R a+r .
sudo chmod a+x .xsession
