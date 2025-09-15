#!/bin/env bash

# Options for powermenu
lock="    Lock"
logout="    Logout"
shutdown="    Shutdown"
reboot="    Reboot"
sleep="   Sleep"

# Get answer from user via rofi
selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu\
                  -i\
                  -p "Power"\
                  -config "powermenu.rasi"\
                  -font "JetBrainsMono Nerd Font Mono 12"\
                  -width "15"\
                  -lines 5\
                  -line-margin 3\
                  -line-padding 10\
                  -scrollbar-width "0" )

# Do something based on selected option
if [ "$selected_option" == "$lock" ]
then
    # /home/$USER/.config/scripts/i3lock-fancy/i3lock-fancy.sh
    echo "Lock"
elif [ "$selected_option" == "$logout" ]
then
    # loginctl terminate-user `whoami`
    echo "Logout"
elif [ "$selected_option" == "$shutdown" ]
then
    echo "Shutdown"
    #doas shutdown -p now
elif [ "$selected_option" == "$reboot" ]
then
    echo "Reboot"
    #doas reboot
elif [ "$selected_option" == "$sleep" ]
then
    #amixer set Master mute
    #systemctl suspend
    echo "Sleep"
else
    echo "No match"
fi

