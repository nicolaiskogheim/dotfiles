#!/bin/sh

# This is the device ID of the mouse I use.
MOUSE_DEVICE_ID=04:4B:ED:C5:79:F7

bluetoothctl power on
bluetoothctl trust ${MOUSE_DEVICE_ID} 
bluetoothctl connect ${MOUSE_DEVICE_ID}
