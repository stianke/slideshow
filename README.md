# Slideshow
An Xsession script to run a PowerPoint slideshow using LibreOffice in kiosk style. The device will boot and then automatically launch into the presentation, if slide timings are set up then these will be honoured. To update or change the slideshow that is being used, insert a USB stick with the new slideshow before booting. The USB stick can be removed after booting.

# Installation instructions for running Raspberry Pi slideshow

* Install latest Raspberry Pi OS to SD card and boot Raspberry Pi
* Run through initial Raspi-Config and then boot into GUI
* Open a terminal or SSH onto the decice and issue the following commands
* `wget https://raw.githubusercontent.com/stianke/slideshow/master/install-slideshow.sh`
* `bash install-slideshow.sh`
* Power down the raspberry pi
* Create an autoplay slideshow (supported file types are .pptx, .ppt, .pps, .ppsx or .odt), and put it on a USB stick. Reboot the Pi with the USB stick plugged in, the Pi will then update the presentation that it holds with the presentation from the USB stick
* The USB stick is only needed for updating the presentation, without the USB stick it'll just play the last know presentation
* Restart the Raspberry Pi, stand back and enjoy your show

Thanks to Peter Milne and jb2cool for supplying the original code. I have only adjusted their work for my own use.
* https://github.com/milnepe/slideshow
* https://github.com/jb2cool/slideshow

My changes include:
* Support for multiple file types
* No need for a specific filename for the slideshow
* Load custom libreoffice config at boot to avoid startup tips or recovery mode

## Version
1.2 Release

## License
[GPL 3.0](https://raw.githubusercontent.com/jb2cool/slideshow/master/LICENSE)