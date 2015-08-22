#!/bin/sh
mirror="http://br.archive.ubuntu.com/ubuntu/pool/main/u/ubuntu-font-family-sources"
suffix="_0.83-0ubuntu1_all.deb"
wget $mirror/ttf-ubuntu-font-family$suffix && dpkg -i ttf-ubuntu-font-family$suffix
wget $mirror/fonts-ubuntu-font-family-console$suffix && dpkg -i fonts-ubuntu-font-family-console$suffix

install -d /etc/lightdm/lightdm-gtk-greeter.conf.d
install -m 644 etc/lightdm/lightdm-gtk-greeter.conf.d/ubuntu-font-family.conf /etc/lightdm/lightdm-gtk-greeter.conf.d
