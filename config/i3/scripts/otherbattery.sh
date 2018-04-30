#!/bin/bash

#color="#FDC882"
#color="#8ac6f2"
color="#000000"

# show charging icon if the laptop is charging
#charging=$(acpi -V | grep -Eo 'Adapter\ 0:\ on-line')
#if [ -n "$charging" ]; then
#    echo '<span background="'$color'" foreground="#000000">  AC </span>'
#fi

# get remaining battery time
#remaining=$(acpi -V | grep -o [0-9][0-9]:[0-9][0-9])

#echo '<span background="'$color'" foreground="#000000">'  $remaining '</span>'

charging=$(acpi -V | grep -Eo 'Adapter\ 0:\ on-line')
if [ -n "$charging" ]; then
    echo '<span background="'$color'" foreground="#FFFFFF">  AC </span>'
fi

# get remaining battery time
remaining=$(acpi -V | grep -o [0-9][0-9]:[0-9][0-9])


echo '<span background="'$color'" foreground="#FFFFFF">'  $remaining '</span>'
