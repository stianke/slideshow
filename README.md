# Slideshow
An Xsession script to run a PowerPoint slideshow using LibreOffice in kiosk style. The device will boot and then automatically launch into the presentation, if slide timings are set up then these will be honoured. There is a facility to update the on-disk slideshow by using a USB stick that is inserted on boot but there are certain caveats with this. This was originally built for the Raspberry Pi single board computer but it should be possible to easily be adapt this for other devices.

# Installation instructions for running Raspberry Pi slideshow   

* Install latest Raspberry Pi OS to SD card and boot Raspberry Pi   
* Run through initial Raspi-Config and then boot into GUI   
* Open a terminal or SSH onto the decice and issue the following commands    
* `wget https://raw.githubusercontent.com/jb2cool/slideshow/master/install-slideshow.sh`   
* `bash install-slideshow.sh`   
* A USB stick will be provisioned as part of the installation process, you can use this to update the slideshow held on the device
* Create an autoplay slideshow named slideshow.pps and copy into the Pi user home directory, this will autostart on bootup. You can skip this step and use the USB stick to populate this if you like   
* To update the slideshow simply place the slideshow.pps file onto the USB stick in /media/usb/pi/ and reboot the Raspberry Pi with the USB stick plugged in, the Pi will then update the presentation that it holds with the presentation thats on the USB stick    
* The USB stick is only needed for updating the presentation, without the USB stick it'll just play the last know presentation   
* Restart the Raspberry Pi, stand back and enjoy your show   

Thanks to Peter Milne for supplying the original code. I have only adjusted his work for my own use (primarily by adding the USB stick updating function)   
https://github.com/milnepe/slideshow   

## Version   
1.1 Release 

## License    
[GPL 3.0](https://raw.githubusercontent.com/jb2cool/slideshow/master/LICENSE)
