#!/bin/bash

get_display () {
    echo ${1} | awk -F: '{ print $1 * 100 + $2 * 10 + $3 }'
}

tn502_endereco=($(lspci | grep SM501 | cut -d' ' -f1 | sed 's/\./:/'))
tn502_display=":$(( $(get_display ${tn502_endereco[0]}) + $(get_display ${tn502_endereco[1]}) ))"

systemctl disable x-daemon-Nseats@${tn502_display}.service

rm -r -f /etc/udev/rules.d/71-usb-*seats*.rules         \
         /etc/udev/rules.d/72-usb-*seats-late.rules     \
         /etc/X11/xorg.conf.d/tn502-*seats.conf         \
         /etc/X11/xorg.conf.d/nested-*seats.conf        \
         /etc/lightdm/lightdm.conf.d/logind.conf        \
         /etc/lightdm/lightdm.conf.d/xephyr-*seats.conf \
         /etc/systemd/scripts/x-daemon                  \
         /etc/systemd/system/x-daemon-Nseats@.service   \
         /etc/systemd/system/x-daemon-Nseats@.service.d

echo "Reinicie o computador para finalizar a remoção das configurações."
