#!/bin/bash
# xinit script to run slideshow in libreoffice

# ref: https://github.com/milnepe/slideshow/

# switch off screensaver
xset s off
xset -dpms

# start window manager in background
matchbox-window-manager &

# run forever
while true; do
	# refresh home dir
	rsync -qr --delete --exclude='.Xauthority' /media/usb/pi/ $HOME/
	# del libreoffice profile to avoid recovery mode
	rm -r .config/libreoffice
	# run libreoffice in kiosk mode
	soffice -show slideshow.pps
done
