
usb_path=$1

mkdir tmp
cp -r $usb_path/*.txt tmp

if test -f "$usb_path/seconds.txt"; then
        seconds=$(cat $usb_path/seconds.txt)
elif [ "$(ls -A tmp)" ]; then
        files=(tmp/*txt)
        seconds=$(cat "${files[0]}")
elif test -f seconds.txt; then
        seconds=$(cat seconds.txt)
else
        seconds=12
fi

rm -r tmp

echo $seconds > seconds.txt
