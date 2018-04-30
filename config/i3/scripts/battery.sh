#!/bin/bash
status=`acpi -b | acpi -b | awk '{print $3}' | tr -d , | sed 's/Unknown//g'`
percent=`acpi -b | awk '{print $4}' | cut -d % -f 1 | sed  '$ d'`
if [ $status == "Charging" ]; then
    echo "  $percent" 
else
    if   [ $percent -lt 20 ]; then
        echo " $percent"
    elif [ $percent -lt 40 ]; then 
        echo " $percent"
    elif [ $percent -lt 60 ]; then
        echo " $percent"
    elif [ $percent -lt 80 ]; then
        echo " $percent"
    else
        echo " $percent"
    fi 
fi
