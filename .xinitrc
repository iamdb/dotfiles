#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS
systemctl --no-block --user start xsession.target

nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=0"
xrandr --dpi 111

if [ -x "$(command -v eww)" ]; then
  eww daemon &
fi

# Set background
if [ -x "$(command -v feh)" ]; then
  feh --bg-scale "$HOME/Pictures/Wallpapers/earth.jpg"
fi

if [ -x "$(command -v xsettingsd)" ]; then
  xsettingsd &
fi

if [ -x "$(command -v xss-lock)" ]; then
  xss-lock xsecurelock &
fi

if [ -x "$(command -v xfce4-power-manager)" ]; then
  xfce4-power-manager &
fi

if [ -f "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1" ]; then
  /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
fi

if [ -x "$(command -v 1password)" ]; then
  1password --silent &
fi

if [ -x "$(command -v redshift)" ]; then
  redshift &
fi

if [ -x "$(command -v wired)" ]; then
  wired &
fi

if [ -x "$(command -v stalonetray)" ]; then
  stalonetray &
fi


exec "$HOME/.local/bin/xmonad"
