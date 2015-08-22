#!/bin/bash

pacotes_base="desktop-base"
pacotes_xorg="xorg dbus-x11"
pacotes_lightdm="lightdm"
pacotes_lxde="lxde lxtask gtk2-engines notification-daemon evince-gtk"
pacotes_gvfs="gvfs-backends gvfs-fuse ntfs-3g dosfstools"
pacotes_audio="pulseaudio pulseaudio-module-x11 rtkit"

do_apt() {
  apt install -y --no-install-recommends ${@}
}

install -m 644 etc/apt/sources.list /etc/apt

apt update
apt -y upgrade

do_apt ${pacotes_base} ${pacotes_xorg} ${pacotes_lightdm} ${pacotes_lxde} ${pacotes_gvfs} ${pacotes_audio}

install -d /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/vt1.conf /etc/lightdm/lightdm.conf.d

install -d /etc/systemd/system/lightdm.service.d
install -m 644 etc/systemd/system/lightdm.service.d/vt1.conf /etc/systemd/system/lightdm.service.d
