#!/bin/bash

do_apt() {
  apt install -y --no-install-recommends ${@}
}

install -m 644 etc/apt/sources.list /etc/apt

apt update
apt -y upgrade

do_apt ${@} gcompris gcompris-sound-ptbr childsplay childsplay-alphabet-sounds-pt gbrainy tuxmath tuxtype tuxpaint tuxpaint-stamps-default
