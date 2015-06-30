#!/bin/bash

total_passos=16
passo_atual=0

progresso() {
  passo_atual=$(( passo_atual + 1 ))
  echo ">>> (${passo_atual}/${total_passos}) ${1}"
}

do_apt() {
  apt install -y --no-install-recommends ${@}
}

progresso "Instalando os arquivos de regras do udev"

install -m 644 etc/udev/rules.d/71-*.rules.in /etc/udev/rules.d
install -m 644 etc/udev/rules.d/72-*.rules.in /etc/udev/rules.d
ln -sf /etc/udev/rules.d/71-2seats-1hub.rules.in /etc/udev/rules.d/71-tn-seat.rules

progresso "Ativando as novas regras do udev e trazendo os novos terminais à vida"

udevadm trigger

progresso "Instalando os arquivos de serviço do systemd"

install -d /etc/systemd/scripts
install -m 755 etc/systemd/scripts/* /etc/systemd/scripts
install -m 644 etc/systemd/system/*.service /etc/systemd/system

progresso "Atualizando o arquivo /etc/apt/sources.list"

install -m 644 etc/apt/sources.list /etc/apt

progresso "Preparando o sistema para a instalação dos novos pacotes"

apt update
apt -y upgrade

progresso "Instalando os pacotes básicos do Xorg"

do_apt desktop-base xorg dbus-x11 compton

progresso "Instalando o arquivo de auto-execução do compton"

install -m 644 etc/xdg/autostart/compton.desktop /etc/xdg/autostart

progresso "Instalando os arquivos de configuração do Xorg para a placa de vídeo TN-502"

install -d /etc/X11/xorg.conf.d
install -m 644 etc/X11/xorg.conf.d/*.conf.in /etc/X11/xorg.conf.d
ln -sf /etc/X11/xorg.conf.d/tn502-2seats.conf.in /etc/X11/xorg.conf.d/tn502-2seats.conf

progresso "Instalando o gerenciador de login LightDM"

do_apt lightdm

progresso "Instalando os scripts do LightDM para manipulação de contas de convidado"

install -m 755 usr/local/sbin/* /usr/local/sbin

progresso "Instalando os arquivos de configuração do LightDM para multiterminais"

install -d /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/* /etc/lightdm/lightdm.conf.d

progresso "Ativando os serviços do systemd necessários para os computadores do Proinfo"

systemctl enable zramswap.service
systemctl start zramswap.service

progresso "Instalando o ambiente de trabalho LXDE"

do_apt lxde lxtask gtk2-engines gtk2-engines-murrine notification-daemon

progresso "Instalando a infra-estrutura necessária para gerenciamento de sistemas de arquivos"

do_apt gvfs-backends gvfs-fuse ntfs-3g dosfstools

progresso "Instalando o sistema de áudio"

do_apt pulseaudio pulseaudio-module-x11 rtkit

progresso "Ativando a interface gráfica"

systemctl start lightdm.service
