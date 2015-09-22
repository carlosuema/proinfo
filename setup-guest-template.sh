#!/bin/sh
mkdir -p /etc/guest-session/skel
addgroup guests
adduser --gecos "Modelo para Sessão de Convidado" --shell /bin/bash --ingroup guests guest-template
echo 'touch ${HOME}/.skip-guest-warning-dialog' >> /etc/guest-session/prefs.sh
touch /etc/guest-session/auto.sh
mkdir -m 0777 /var/guest-data
install -d /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/autologin-guest.conf /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/greeter-hide-users.conf /etc/lightdm/lightdm.conf.d
install usr/local/sbin/* /usr/local/sbin
apt install aufs-tools bindfs
