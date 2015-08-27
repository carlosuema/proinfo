#!/bin/bash

pacotes_base="desktop-base"
pacotes_xorg="xorg"
pacotes_lightdm="lightdm"
pacotes_mate="mate-desktop-environment-core mate-themes mate-applets mate-notification-daemon mate-media atril engrampa eom ffmpegthumbnailer mate-system-monitor pluma caja-gksu caja-open-terminal caja-share system-config-printer system-config-printer-udev cups-pk-helper wicd"
pacotes_gvfs="ntfs-3g dosfstools"
pacotes_audio="rtkit"

do_apt() {
  apt install -y --no-install-recommends ${@}
}

install -m 644 etc/apt/sources.list /etc/apt

apt update
apt -y upgrade

do_apt ${pacotes_base} ${pacotes_xorg} ${pacotes_lightdm} ${pacotes_mate} ${pacotes_gvfs} ${pacotes_audio}

install -d /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/vt1.conf /etc/lightdm/lightdm.conf.d

install -d /etc/systemd/system/lightdm.service.d
install -m 644 etc/systemd/system/lightdm.service.d/vt1.conf /etc/systemd/system/lightdm.service.d
