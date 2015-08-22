#!/bin/sh
install -m 644 etc/apt/apt.conf.d/00aptproxy.in /etc/apt/apt.conf.d/00aptproxy
sed -i -e "s/@APT_CACHER_NG_SERVER@/${1}/g" /etc/apt/apt.conf.d/00aptproxy
