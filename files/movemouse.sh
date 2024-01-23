#!/bin/bash

# Move mouse to the bottom right of the screen
xdotool mousemove 10000 10000

# Move mouse 1 pixel up/down every second
while true
do
	xdotool mousemove_relative -- 0 -1
	sleep 1
	xdotool mousemove_relative 0 1
	sleep 1
done

