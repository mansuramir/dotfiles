#export GDK_SCALE=2
export GDK_SCALE=1.75
export QT_SCALE_FACTOR=1.75
xrandr --output eDP-1 --mode 2560x1440 #default --dpi 163 #--mode 1856x1392 --dpi 163 

xrdb -merge ~/.Xresources
#exec /usr/X11R6/bin/cwm
picom &
dunst &
polybar &
exec /usr/X11R6/bin/cwm
#exec /usr/local/bin/startxfce4 --with-ck-launch
