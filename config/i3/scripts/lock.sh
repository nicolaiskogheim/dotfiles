#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
IMAGE="$1"
if [[ -f "$IMAGE" ]]
then
    convert /tmp/screen.png "$IMAGE" -gravity center -composite -matte -colors 6 /tmp/screen.png
    i3lock -u -i /tmp/screen.png
    rm /tmp/screen.png
else
    i3lock
fi
