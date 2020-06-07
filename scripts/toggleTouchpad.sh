#!/bin/bash	

num=$(xinput list | grep "C.*Touchpad" | cut -f 2| cut -d"=" -f2)
z=$(xinput list-props $num | grep "Device Enabled")
z=${z: -1}
if [ $z = 1 ]
then
	xinput set-prop $num "Device Enabled" 0
else
	xinput set-prop $num "Device Enabled" 1
fi



