#!/bin/bash
# Installation instructions for running Raspberry Pi slideshow

# Install latest Raspberry Pi OS to SD card and boot Raspberry Pi
# Run through initial Raspi-Config and then boot into GUI

# Check to see if slideshow part 1 has been completed and if not, so it now
function install-slideshow-part1()
{
    if [ -f ~/slideshow.part1 ]; then
        echo "Slideshow part 1 already installed, skipping"
    else
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
        #sudo wget --no-check-certificate https://raw.githubusercontent.com/jb2cool/slideshow/master/files/00-my-custom-mountflags.conf -O /etc/systemd/system/systemd-udevd.service.d/00-my-custom-mountflags.conf
        sudo wget -P /etc/systemd/system/systemd-udevd.service.d https://raw.githubusercontent.com/jb2cool/slideshow/master/files/00-my-custom-mountflags.conf

        # Create part1 flag file
        echo "Slideshow part 1 has been completed" > ~/slideshow.part1
        
        # Reboot (to apply new mount settings)
	      clear
	      echo "I'm about to reboot, please re-run script after reboot."
        sudo reboot
    fi
}

# Check to see if slideshow part 2 has been completed and if not, so it now
function install-slideshow-part2()
{
    if [ -f ~/slideshow.part2 ]; then
        echo "Slideshow part 2 already installed, skipping"
    else
        # Copy .xsession to /home/pi - assuming pi is the user id setup to run on bootup
        # This script starts the display manager and syncs the default user home with a fresh copy from /media/usb/pi
        # It also deletes any previous LibreOffice config allowing clean start of slideshow
        cd $HOME
        wget --no-check-certificate https://raw.github.com/jb2cool/slideshow/master/files/.xsession
        
        # Insert the USB transfer stick (should have the label usb or you'll need to change some stuff)   
        echo "Insert USB stick now"
        read -p "Press any key to continue...(This may look like it's not doing much, just leave it alone)"
        
        # Create a copy of the default user (pi) in /media/usb
        sudo cp -r /home/pi /media/usb/
        cd /media/usb/pi/
        sudo chmod -R a+r .
        sudo chmod a+x .xsession

        # Create part2 flag file
        echo "Slideshow part 2 has been completed" > ~/slideshow.part2
        
        # Reboot (to boot into slideshow)
	      clear
	      echo "I'm about to reboot."
        sudo reboot
    fi
}

install-slideshow-part1
install-slideshow-part2
