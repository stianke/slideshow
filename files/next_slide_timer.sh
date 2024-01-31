

usb_path=$1

rm -r tmp
mkdir tmp

cp -r $usb_path/*.txt tmp
if test -f "$usb_path/seconds.txt"; then
        seconds=$(cat $usb_path/seconds.txt)
	echo $seconds > seconds.txt
elif [ "$(ls -A tmp)" ]; then
        files=(tmp/*txt)
        seconds=$(cat "${files[0]}")
	echo $seconds > seconds.txt
elif test -f seconds.txt; then
	seconds=$(cat seconds.txt)
else
        seconds=15
fi

echo $seconds


while true; do
        sleep $(($seconds-1))
        xdotool mousemove_relative -- 0 -1
        sleep 0.5
        xdotool mousemove_relative 0 1
        sleep 0.5
        xdotool key space
done


