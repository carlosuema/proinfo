#!/bin/bash

do_apt() {
  apt install -y --no-install-recommends $@
}

do_apt libgtk2.0-bin libgtk-3-bin

[ -d /usr/local/share/themes ] || mkdir -p /usr/local/share/themes
[ -d /usr/local/share/icons ] || mkdir -p /usr/local/share/icons

(
  cd /usr/local/share/themes
  git clone git://github.com/shimmerproject/numix Numix
)

(
  cd /usr/local/share/icons
  git clone git://github.com/numixproject/numix-icon-theme .numix-icon-theme
  git clone git://github.com/numixproject/numix-icon-theme-circle .numix-icon-theme-circle
  ln -s .numix-icon-theme/Numix .
  ln -s .numix-icon-theme/Numix-Light .
  ln -s .numix-icon-theme-circle/Numix-Circle .
  ln -s .numix-icon-theme-circle/Numix-Circle-Light .
)

for theme in /usr/local/share/icons/*
do
    gtk-update-icon-cache -ftq ${theme}
    gtk-update-icon-cache-3.0 -ftq ${theme}
done

for theme in /usr/local/share/themes/*
do
    ln -sf ${theme} /usr/share/themes
done
