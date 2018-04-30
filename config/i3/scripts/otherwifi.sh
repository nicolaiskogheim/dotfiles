
#!/bin/bash

# Signal strength = STRENGTH/70*100 ... dont ask me
strength=$(cat /proc/net/wireless | awk 'NR==3' | awk '{ print $3 }' | tr -d '.')
percentage=$(expr $strength/70*100 | awk '{ print $1 }' | tr -d '~')
rounded=$(echo $percentage | grep -Eo '[0-9]{1,3}' | awk NR==1)

# get SSD name
SSID=$(iwgetid -r)

color="#8ac6f2"


#if [ $rounded>60 ]
#then
    #echo '<span background=#CCFEA5 foreground="#000000">'  $SSID $rounded% '</span>'
#    color=#CCFEA5
#elif [ $rounded>30 ]
#then
#    #echo '<span background=#FC8366 foreground="#000000">'  $SSID $rounded% '</span>'
#    color=#FC8366
#else
#    #echo '<span background=#FF414D foreground="#000000">'  $SSID $rounded% '</span>'
#    color=#FF414D
#fi


# print out the results
#echo  $SSID $rounded% 
echo '<span foreground="#ffffff">'  $SSID $rounded%'</span>'
#"#FC8366"
