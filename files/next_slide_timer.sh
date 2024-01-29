

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
        seconds=20
fi

echo $seconds


while true; do
        sleep $seconds
        xdotool key space
done


