#!/bin/bash

apt install --no-install-recommends gtk2-engines-murrine

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
  ln -sf .numix-icon-theme/Numix .
  ln -sf .numix-icon-theme/Numix-Light .
  ln -sf .numix-icon-theme-circle/Numix-Circle .
  ln -sf .numix-icon-theme-circle/Numix-Circle-Light .
)

for theme in /usr/local/share/icons/*
do
    update-icon-caches ${theme}
done

for theme in /usr/local/share/themes/*
do
    ln -sf ${theme} /usr/share/themes
done

install -d /etc/lightdm/lightdm-gtk-greeter.conf.d
install -m 644 etc/lightdm/lightdm-gtk-greeter.conf.d/numix.conf /etc/lightdm/lightdm-gtk-greeter.conf.d
