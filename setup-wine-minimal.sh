#!/bin/bash

do_apt() {
  apt install -y --no-install-recommends ${@}
}

install -m 644 etc/apt/sources.list /etc/apt

dpkg --add-architecture i386
apt update
apt -y upgrade

do_apt ${@} wine winetricks
