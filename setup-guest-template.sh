#!/bin/sh
mkdir /etc/guest-session
adduser --home /etc/guest-session/skel --gecos "Modelo para Sessão de Convidado" --shell /bin/bash guest-template
echo 'touch ${HOME}/.skip-guest-warning-dialog' >> /etc/guest-session/prefs.sh
touch /etc/guest-session/auto.sh
mkdir -m 0777 /var/guest-data
install -d /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/autologin-guest.conf /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/greeter-hide-users.conf /etc/lightdm/lightdm.conf.d
install usr/local/sbin/* /usr/local/sbin
