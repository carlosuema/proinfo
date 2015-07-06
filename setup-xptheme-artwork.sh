#!/bin/bash

wget -c http://xfce-look.org/CONTENT/content-files/162880-XPTheme.zip -O xptheme.zip

[ -d /usr/local/share/themes ] || mkdir -p /usr/local/share/themes
[ -d /usr/local/share/lxde/images ] || mkdir -p /usr/local/share/lxde/images

unzip xptheme.zip -d /usr/local/share/themes
mv /usr/local/share/themes/*.{jpg,png} /usr/local/share/lxde/images

ln -sf "/usr/local/share/themes/XP Blue" /usr/share/themes
ln -sf "/usr/local/share/themes/XP Olive" /usr/share/themes
ln -sf "/usr/local/share/themes/XP Silver" /usr/share/themes
