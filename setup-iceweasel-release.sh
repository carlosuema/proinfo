#!/bin/sh
wget http://mozilla.debian.net/pkg-mozilla-archive-keyring_1.1_all.deb -O /tmp && dpkg -i /tmp/pkg-mozilla-archive-keyring_1.1_all.deb
install -m 644 etc/apt/sources.list.d/debian-mozilla-team-iceweasel-release.list /etc/apt/sources.list.d
apt update
