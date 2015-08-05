#!/bin/bash

total_passos=9
passo_atual=0

tn502_endereco="$(lspci | grep SM501 | cut -d' ' -f1 | sed 's/\./:/')"

progresso() {
  passo_atual=$(( passo_atual + 1 ))
  echo ">>> (${passo_atual}/${total_passos}) ${1}"
}

progresso "Instalando os arquivos de regras do udev"

install -m 644 etc/udev/rules.d/71-usb-2seats-1hub.rules /etc/udev/rules.d

progresso "Instalando os arquivos de serviço do systemd"

install -d /etc/systemd/scripts
install -m 755 etc/systemd/scripts/zramctrl /etc/systemd/scripts
install -m 644 etc/systemd/system/le-nextboot-*.service /etc/systemd/system
install -m 644 etc/systemd/system/zramswap.service /etc/systemd/system

progresso "Atualizando o arquivo /etc/apt/sources.list"

install -m 644 etc/apt/sources.list /etc/apt

progresso "Preparando o sistema para a instalação dos novos pacotes"

apt update
apt -y upgrade

progresso "Instalando os arquivos de configuração do Xorg para a placa de vídeo TN-502"

install -d /etc/X11/xorg.conf.d
install -m 644 etc/X11/xorg.conf.d/tn502-2seats.conf.in /etc/X11/xorg.conf.d/tn502-2seats.conf
sed -i -e "s/@TN502_ADDRESS@/${tn502_endereco}/" /etc/X11/xorg.conf.d/tn502-2seats.conf

progresso "Instalando os scripts do LightDM para manipulação de contas de convidado"

install -m 755 usr/local/sbin/* /usr/local/sbin

progresso "Instalando os arquivos de configuração do LightDM para multiterminais"

install -d /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/logind.conf /etc/lightdm/lightdm.conf.d

progresso "Ativando os serviços do systemd necessários para os computadores do Proinfo"

systemctl enable zramswap.service
systemctl start zramswap.service

progresso "Ativando as novas regras do udev e trazendo os novos terminais à vida"

udevadm trigger
systemctl restart lightdm.service
