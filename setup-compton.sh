#!/bin/bash

do_apt() {
  apt install -y --no-install-recommends ${@}
}

do_apt compton
install -m 644 etc/xdg/autostart/compton.desktop /etc/xdg/autostart
