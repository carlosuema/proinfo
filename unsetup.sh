#!/bin/bash

systemctl disable x-daemon-Nseats.service
systemctl disable xorg@0.socket

rm -r -f /etc/udev/rules.d/71-usb-*seats*.rules         \
         /etc/udev/rules.d/72-usb-*seats-late.rules     \
         /etc/X11/xorg.conf.d/tn502-*seats.conf         \
         /etc/X11/xorg.conf.d/nested-*seats.conf        \
         /etc/lightdm/lightdm.conf.d/logind.conf        \
         /etc/lightdm/lightdm.conf.d/xephyr-*seats.conf \
         /etc/systemd/scripts/x-daemon                  \
         /etc/systemd/system/x-daemon-Nseats.service    \
         /etc/systemd/system/x-daemon-Nseats.service.d  \
         /etc/systemd/system/xorg@.service              \
         /etc/systemd/system/xorg@.service.d            \
         /etc/systemd/system/xorg@.socket

echo "Reinicie o computador para finalizar a remoção das configurações."
