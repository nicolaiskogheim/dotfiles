#!/bin/bash

dayname=$(date | awk '{ print $1 }')
datenum=$(date | awk '{ print $2 }')
day=$(date | awk '{ print $3 }')
time=$(date '+%H:%M')


#echo '<span background="#8ac6f2" foreground="#000000">'  $dayname $day $time '</span>'
echo '<span foreground="#FFFFFF">'   $day $datenum $time'</span>'
#echo '<span background="#FF414D" foreground="#000000">'  $dayname $day $time '</span>'
