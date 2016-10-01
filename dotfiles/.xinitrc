#!/bin/sh
# ~/.xinitrc is executed by startx
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Add fonts installed in this path
xset +fp /usr/share/fonts/local
xset fp rehash

exec /usr/bin/awesome
