#!/bin/bash

do_apt() {
  apt install -y --no-install-recommends ${@}
}

install -m 644 etc/apt/sources.list /etc/apt

apt update
apt -y upgrade

do_apt ${@} iceweasel iceweasel-l10n-pt-br flashplugin-nonfree
