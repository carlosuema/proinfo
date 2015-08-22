#!/bin/bash

pacotes_base="desktop-base"
pacotes_xorg="xorg"
pacotes_lightdm="lightdm"
pacotes_xfce="xfce4 tango-icon-theme thunar-volman gtk3-engines-xfce xfce4-whiskermenu-plugin mousepad ristretto thunar-archive-plugin thunar-media-tags-plugin xfburn xfce4-artwork xfce4-datetime-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-notifyd xfce4-places-plugin xfce4-quicklauncher-plugin xfce4-systemload-plugin xfce4-taskmanager xfce4-terminal xfce4-volumed evince-gtk gnome-themes-standard-data"
pacotes_gvfs="gvfs-backends gvfs-fuse ntfs-3g dosfstools"
pacotes_audio="pulseaudio pulseaudio-module-x11 rtkit"

do_apt() {
  apt install -y --no-install-recommends ${@}
}

install -m 644 etc/apt/sources.list /etc/apt
install -m 644 etc/apt/sources.list.d/obs-home-lbssousa-debian.list /etc/apt/sources.list.d
install -m 644 etc/apt/sources.list.d/obs-home-lbssousa-debian-xfce.list /etc/apt/sources.list.d

apt-key add etc/apt/sources.list.d/obs-home-lbssousa.key

apt update
apt -y upgrade

do_apt ${pacotes_base} ${pacotes_xorg} ${pacotes_lightdm} ${pacotes_xfce} ${pacotes_gvfs} ${pacotes_audio}

install -d /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/vt1.conf /etc/lightdm/lightdm.conf.d

install -d /etc/systemd/system/lightdm.service.d
install -m 644 etc/systemd/system/lightdm.service.d/vt1.conf /etc/systemd/system/lightdm.service.d
