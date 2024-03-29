#!/bin/bash

total_passos=11
passo_atual=0

tn502_endereco="$(lspci | grep SM501 | cut -d' ' -f1 | sed 's/\./:/')"

progresso() {
  passo_atual=$(( passo_atual + 1 ))
  echo ">>> (${passo_atual}/${total_passos}) ${1}"
}

do_apt() {
  apt install -y --no-install-recommends ${@}
}

progresso "Instalando os arquivos de regras do udev"

install -m 644 etc/udev/rules.d/71-usb-3seats-3hubs.rules /etc/udev/rules.d
install -m 644 etc/udev/rules.d/72-usb-3seats-late.rules /etc/udev/rules.d

progresso "Instalando os arquivos de serviço do systemd"

install -m 644 etc/systemd/system/*.{socket,service} /etc/systemd/system

progresso "Atualizando o arquivo /etc/apt/sources.list"

install -m 644 etc/apt/sources.list /etc/apt

progresso "Adicionando o repositório próprio com os pacotes modificados para os computadores do ProInfo"

install -m 644 etc/apt/sources.list.d/obs-home-lbssousa-debian-multiseat.list /etc/apt/sources.list.d
apt-key add etc/apt/sources.list.d/obs-home-lbssousa.key

progresso "Preparando o sistema para a instalação dos novos pacotes"

apt update
apt -y upgrade

progresso "Instalando os pacotes necessários"

do_apt xserver-xorg-video-nested

progresso "Instalando os arquivos de configuração do Xorg para a placa de vídeo TN-502"

install -d /etc/X11/xorg.conf.d
install -m 644 etc/X11/xorg.conf.d/tn502-3seats.conf.in /etc/X11/xorg.conf.d/tn502-3seats.conf
install -m 644 etc/X11/xorg.conf.d/nested-3seats.conf /etc/X11/xorg.conf.d/nested-3seats.conf
sed -i -e "s/@TN502_ADDRESS@/${tn502_endereco}/" /etc/X11/xorg.conf.d/tn502-3seats.conf

progresso "Instalando os scripts do LightDM para manipulação de contas de convidado"

install -m 755 usr/local/sbin/* /usr/local/sbin

progresso "Instalando os arquivos de configuração do LightDM para multiterminais"

install -d /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/logind.conf /etc/lightdm/lightdm.conf.d

progresso "Ativando os serviços do systemd necessários para os computadores do Proinfo"

systemctl enable xorg@0.socket
systemctl start xorg@0.socket

progresso "Ativando as novas regras do udev e trazendo os novos terminais à vida"

udevadm trigger
systemctl restart lightdm.service
