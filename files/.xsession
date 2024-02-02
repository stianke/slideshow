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


# Move mouse off screen
xdotool mousemove 10000 10000


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

        # refresh home dir
        rsync -qr --delete --exclude='.Xauthority' $HOME/

        files=(slideshow/*)
        presentation_file="${files[0]}"


        new_sha256=$(sha256sum "$presentation_file")
        old_sha256=$(cat sha256sum.txt)

        if [[ "$new_sha256" == "$old_sha256" ]]; then
                echo "USB stick present, but no new presentation file found" > status.txt
        else
                if [ -z "$(ls -A images_folder 2>/dev/null)" ]; then
                        echo "USB sitck present, but no file found on it" > status.txt
                else
                        echo "USB stick present and new presentation loading" > status.txt

                        feh -rsZFYD 5 loading_presentation.png &

                        # del libreoffice profile to avoid recovery mode
                        rm -r .config/libreoffice
                        cp -r libreoffice_config .config/libreoffice

                        # Convert presentation to images
                        libreoffice --headless --convert-to pdf "$presentation_file" --outdir ~/tmp_folder
                        mv tmp_folder/* slideshow.pdf
                        rm -r tmp_folder

                        rm -r images_folder
                        mkdir images_folder
                        pdftoppm slideshow.pdf images_folder/image-nr -png
                        echo $(sha256sum "$presentation_file" > sha256sum.txt)

                        # Close "please wait" image
                        pkill -f "feh -rsZFYD 5 loading_presentation.png"

                        echo "USB stick present and new presentation loaded" > status.txt
                fi
        fi
fi

# Get interval to sleep between the slideshow images
./fetch_slideshow_interval.sh $usb_path


# If there are no images to display
if [ -z "$(ls -A images_folder 2>/dev/null)" ]; then
        mkdir images_folder
        cp default_image.png images_folder/default_image.png
fi

# refresh home dir
rsync -qr --delete --exclude='.Xauthority' $HOME/


# run forever
while true; do
        feh -rsZFYD $(cat seconds.txt) images_folder

        # If the above command fails for some reason, sleep in order to get time to ssh into the system to fix it
        sleep 1000
done
