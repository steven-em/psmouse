#!/bin/bash

make -f mouseMakefile

#delete the old psmouse kernel module and insert the new one
rmmod psmouse
insmod ./psmouse.ko

sleep 8

NUM=$(ls /sys/devices/platform/i8042/serio1/ | grep serio)
NUM=$((${NUM:5}+0))
# NUM=$((${NUM:5}+1))

#set speed and sensitivity
(echo -n 185 > /sys/devices/platform/i8042/serio1/serio${NUM}/speed ; echo -n 255 > /sys/devices/platform/i8042/serio1/serio${NUM}/sensitivity)

#key repeat delay
xset r  rate 449 49

#change the vol keys to mouse buttons
xkbset m
xkbset exp =m
xmodmap -e 'keycode 121 = Pointer_Button1'
xmodmap -e 'keycode 122 = Pointer_Button2'
xmodmap -e 'keycode 123 = Pointer_Button3'

exit 0
