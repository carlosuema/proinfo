#!/bin/sh

tn502_endereco="$(lspci | grep SM501 | cut -d' ' -f1 | sed 's/\./:/')"
tn502_display=":$(echo ${tn502_endereco} | awk -F: '{ print $1 * 100 + $2 * 10 + $3 }')"

systemctl disable x-daemon-3seats@${tn502_display}.service

rm -f /etc/udev/rules.d/71-usb-*seats-*hub*.rules    \
      /etc/udev/rules.d/72-usb-*seats-late.rules     \
      /etc/X11/xorg.conf.d/tn502-*seats.conf         \
      /etc/X11/xorg.conf.d/nested-3seats.conf        \
      /etc/lightdm/lightdm.conf.d/logind.conf        \
      /etc/lightdm/lightdm.conf.d/xephyr-*seats.conf \
      /etc/systemd/scripts/x-daemon                  \
      /etc/systemd/system/x-daemon-3seats@.service

echo "Reinicie o computador para finalizar a remoção das configurações."
