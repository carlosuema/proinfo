#!/bin/bash

do_apt() {
  apt install -y --no-install-recommends ${@}
}

do_apt gtk2-engines-pixbuf

wget -c https://copy.com/R20vwNTRwu21kFiG/boxtheme.tar.gz?download=1 -O boxtheme.tar.gz
wget -c https://copy.com/6HXRIlh0skL9e27S/boxicons.tar.gz?download=1 -O boxicons.tar.gz
wget -c http://bazaar.launchpad.net/~lubuntu-art/lubuntu-artwork/quantal/download/head:/1504lubuntulogo.png-20141027134250-a73q706yynr2mx3v-4/1504-lubuntu-logo.png -O lubuntu-logo.png

[ -d /usr/local/share/themes ] || mkdir -p /usr/local/share/themes
[ -d /usr/local/share/icons ] || mkdir -p /usr/local/share/icons
[ -d /usr/local/share/lxde/images ] || mkdir -p /usr/local/share/lxde/images

tar xzvf boxtheme.tar.gz -C /usr/local/share/themes
tar xzvf boxicons.tar.gz -C /usr/local/share/icons
install -m 644 lubuntu-logo.png /usr/local/share/lxde/images

for theme in /usr/local/share/icons/*
do
    update-icon-caches -ftq ${theme}
done

for theme in /usr/local/share/themes/*
do
    ln -sf ${theme} /usr/share/themes
done
