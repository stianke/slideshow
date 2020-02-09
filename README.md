# About
Xsession script to run slideshow using LibreOffice in kiosk style

# Version
1.0 Release.

# Installation instructions for running Raspberry Pi slideshow   

* Install latest Raspbian OS to SD card and boot Pi   
* Run through initial Raspi-Config and then boot into GUI   

* Update repositry info and upgrade packages to latest versions   
`sudo apt-get update`   
`sudo apt-get dist-upgrade`   

* Install following applications;   
  Matchbox - Lightweight window manager    
  `sudo apt-get install matchbox`   

  rsync - File synchronisation application   
  `sudo apt-get install rsync`   

  LibreOffice - Office suite including presentation application   
  'sudo apt-get install libreoffice`   

  USBmount - Mounts usb stick automatically   
  `sudo apt-get install usbmount`   

* Fix some issues that crept in when Debian moved to the Stretch release   
  `sudo sed -i 's/MountFlags=slave/MountFlags=shared/g' /lib/systemd/system/systemd-udevd.service`   

* Reboot (to apply new mount settings)   
  `sudo reboot`   

* Copy .xsession to /home/pi - assuming pi is the user id setup to run on bootup   
This script starts the display manager and syncs the default user home with a fresh copy from /media/usb/pi   
It also deletes any previous LibreOffice config allowing clean start of slideshow   
  `wget --no-check-certificate https://raw.github.com/jb2cool/slideshow/master/.xsession`   

* Insert the USB transfer stick (should have the label usb or you'll need to change some stuff)   

* Create a copy of the default user (pi) in /media/usb   
  `sudo cp -r /home/pi /media/usb/`   
  `cd /media/usb/pi/`   
  `sudo chmod -R a+r .`   
  `sudo chmod a+x .xsession`   

* Create a slideshow named slideshow.ppt and copy to /media/usb/pi - This will autostart on bootup   
To update the slideshow simply replace the version on the USB stick and reboot with the USB stick plugged in (USB stick is only needed if you want to update the presentation, without the USB stick it'll just play the last know presentation)   
Restart the Raspberry Pi, stand back and enjoy your show   

Thanks to Peter Milne for supplying the original code. I have only adjusted his work for my own use   
https://github.com/milnepe/slideshow   


Copyright 2020 Jason Bramwell.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
