#!/bin/bash

do_apt() {
  apt install -y --no-install-recommends ${@}
}

install -m 644 etc/apt/sources.list /etc/apt

apt update
apt -y upgrade

do_apt ${@} libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-gtk libreoffice-l10n-pt-br libreoffice-style-sifr
apt purge libreoffice-style-tango libreoffice-style-galaxy
