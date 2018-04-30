#!/bin/bash
#mute=`amixer get Master | grep "Front Left:" | awk '{print $6}'`
#vol=`amixer get Master | grep "Front Left:" | awk '{print $5}' | tr -d '[%]'`
#mute="[on]"
vol=`pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 2 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'`
mute=`pactl list sinks | grep '^[[:space:]]Mute:' | head -n $(( $SINK + 2 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'`

#mute=`pactl list sinks | grep '^[[:space:]]Mute:' | head -n $(( $SINK + 2 )) | tail -n 1'`

#color="#FDAC77"
#color="#8ac6f2"
#color="#000000"
backgroundcolor="#ffffff"

if [ !mute ];
then
    if [ $vol -eq 100 ]
    then 
        #echo "  $vol"
        echo '<span foreground="'$backgroundcolor'">' '' $vol '</span>'
    elif [ $vol -ge 50 ]
    then 
        #echo "   $vol"
        echo '<span foreground="'$backgroundcolor'">' '' $vol '</span>'
    elif [ $vol -lt 50 ]
    then
        if [ $vol -lt 10 ]
        then
            #echo "       $vol"
            echo '<span  foreground="'$backgroundcolor'">' '' $vol '</span>'
        else 
            #echo "    $vol"
            echo '<span  foreground="'$backgroundcolor'">' '' $vol '</span>'
        fi
    else
        :
    fi
else
    echo "  Muted " 
fi
