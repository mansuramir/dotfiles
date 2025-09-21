#!/bin/sh -x

picom --config ~/.config/picom/config.msa &
# polybar &

xrdb -merge $HOME/.Xresources

export LANG=en_GB.UTF-8
export LC_TYPE=en_GB.UTF-8
#export XMODIFIERS=@im=uim
#export MOZ_USE_XINPUT2=1
#export MOZ_ACCELERATED=1
#export MOZ_WEBRENDER=1

## no bell
xset b 0 0 0 

## DBus
if [ -x /usr/local/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
  eval `dbus-launch --sh-syntax --exit-with-x11`
fi

## Termbar
#exec xterm -fs 12 -bg "black" -fg "grey" -name termbar -class termbar -T termbar -e ~/.local/bin/termbar &
exec polybar &

## Wallpaper
feh --bg-fill ~/.config/backgrounds/minimalist_sunset.jpg &
#feh --bg-fill ~/.config/backgrounds/sith-cats-star-wars.png &
#feh --bg-fill ~/minimal.jpg &

exec /usr/X11R6/bin/cwm
