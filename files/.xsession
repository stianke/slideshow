#!/bin/bash
# xinit script to run slideshow in libreoffice

# ref: https://github.com/milnepe/slideshow/


# switch off screensaver
xset s off
xset -dpms

# start window manager in background
matchbox-window-manager &

get_usb_path() {
	local lsblk_output=$(lsblk)
	if [[ $lsblk_output =~ "/media/" ]]; then
		usb_path=$(echo "$lsblk_output" | awk '/\/media\// {print $NF}')
		usb_path="$usb_path"
		echo $usb_path
	else
		echo ""
	fi
}

usb_path=$(get_usb_path)


# If a USB stick is detected
if [ -z $usb_path ]; then
	echo "No USB stick detected" > status.txt
else
	# Remove contents of slideshow directory, and copy everything from the USB
	rm -r slideshow/*
	cp -r $usb_path/*.pptx slideshow
	cp -r $usb_path/*.ppt  slideshow
	cp -r $usb_path/*.pps  slideshow
	cp -r $usb_path/*.ppsx slideshow
	cp -r $usb_path/*.odt  slideshow
	echo "Files loaded from USB stick" > status.txt
fi




# When loading the default config profile, it seems the mouse must move to initiate
# the slideshow. Call a script that moves the mouse
./movemouse.sh &
./next_slide_timer.sh $usb_path &

# run forever
while true; do
	# refresh home dir
	rsync -qr --delete --exclude='.Xauthority' /opt/${USER}/ $HOME/ /media/usb/

	# del libreoffice profile to avoid recovery mode
	rm -r .config/libreoffice
	cp -r libreoffice_config .config/libreoffice

	files=(slideshow/*)
	presentation_file="${files[0]}"

	# run libreoffice in kiosk mode
	soffice --norestore -show "$presentation_file"
	#soffice --norestore -view $presentation_file # Open without starting slideshow
done
