#!/bin/bash

total_passos=16
passo_atual=0

progresso() {
  passo_atual=$(( passo_atual + 1 ))
  echo ">>> (${passo_atual}/${total_passos}) ${1}"
}

do_apt() {
  apt install --no-install-recommends ${@}
}

progresso "Instalando os arquivos de regras do udev"

install -m 644 etc/udev/rules.d/71-3seats-2hubs.rules /etc/udev/rules.d
install -m 644 etc/udev/rules.d/72-3seats-2hubs-late.rules /etc/udev/rules.d

progresso "Ativando as novas regras do udev e trazendo os novos terminais à vida"

udevadm trigger

progresso "Instalando os arquivos de serviço do systemd"

install -m 644 etc/systemd/scripts /etc/systemd
install -m 644 etc/systemd/system/*.service /etc/systemd/system

progresso "Atualizando o arquivo /etc/apt/sources.list"

install -m 644 etc/apt/sources.list /etc/apt

progresso "Adicionando o repositório próprio com os pacotes modificados para os computadores do ProInfo"

install -m 644 etc/apt/sources.list.d/obs-home-lbssousa-multiseat-debian.list /etc/apt/sources.list.d
apt-key add etc/apt/sources.list.d/obs-home-lbssousa-multiseat-debian.key

progresso "Preparando o sistema para a instalação dos novos pacotes"

apt update
apt upgrade

progresso "Instalando os pacotes básicos do Xorg"

do_apt desktop-base xorg xserver-xephyr dbus-x11

progresso "Instalando os arquivos de configuração do Xorg para a placa de vídeo TN-502"

install -m 644 -D etc/X11/xorg.conf.d/sm501-dualhead.conf.in /etc/X11/xorg.conf.d/sm501-dualhead.conf.in

progresso "Instalando o gerenciador de login LightDM"

do_apt lightdm

progresso "Instalando os scripts do LightDM para manipulação de contas de convidado"

install -m 755 usr/local/sbin/* /usr/local/sbin

progresso "Instalando os arquivos de configuração do LightDM para multiterminais"

install -m 644 -D etc/lightdm/lightdm.conf.d/logind.conf /etc/lightdm/lightdm.conf.d/logind.conf
install -m 644 etc/lightdm/lightdm.conf.d/multi-seat-xephyr.conf /etc/lightdm/lightdm.conf.d

progresso "Ativando o serviço do systemd necessário para o multiterminal"

systemctl enable x-daemon@:90.service

progresso "Instalando o ambiente de trabalho LXDE"

do_apt lxde lxtask gtk2-engines gt2-engines-murrine notification-daemon

progresso "Instalando a infra-estrutura necessária para gerenciamento de sistemas de arquivos"

do_apt gvfs-backends gvfs-fuse ntfs-3g dosfstools

progresso "Instalando o sistema de áudio"

do_apt pulseaudio pulseaudio-module-x11 rtkit

progresso "Ativando a interface gráfica"

systemctl start lightdm.service
