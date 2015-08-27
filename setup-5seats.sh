#!/bin/bash

total_passos=11
passo_atual=0

get_display () {
    echo ${1} | awk -F: '{ print $1 * 100 + $2 * 10 + $3 }'
}

tn502_endereco=($(lspci | grep SM501 | cut -d' ' -f1 | sed 's/\./:/'))
tn502_display=":$(( $(get_display ${tn502_endereco[0]}) + $(get_display ${tn502_endereco[1]}) ))"

progresso() {
  passo_atual=$(( passo_atual + 1 ))
  echo ">>> (${passo_atual}/${total_passos}) ${1}"
}

do_apt() {
  apt install -y --no-install-recommends ${@}
}

progresso "Instalando os arquivos de regras do udev"

install -m 644 etc/udev/rules.d/71-usb-5seats.rules /etc/udev/rules.d
install -m 644 etc/udev/rules.d/72-usb-5seats-late.rules /etc/udev/rules.d

progresso "Instalando os arquivos de serviço do systemd"

install -d /etc/systemd/scripts
install -m 755 etc/systemd/scripts/* /etc/systemd/scripts
install -m 644 etc/systemd/system/*.service /etc/systemd/system

progresso "Atualizando o arquivo /etc/apt/sources.list"

install -m 644 etc/apt/sources.list /etc/apt

progresso "Adicionando o repositório próprio com os pacotes modificados para os computadores do ProInfo"

install -m 644 etc/apt/sources.list.d/obs-home-lbssousa-multiseat-debian.list /etc/apt/sources.list.d
apt-key add etc/apt/sources.list.d/obs-home-lbssousa-multiseat-debian.key

progresso "Preparando o sistema para a instalação dos novos pacotes"

apt update
apt -y upgrade

progresso "Instalando os pacotes necessários"

do_apt xserver-xorg-video-nested

progresso "Instalando os arquivos de configuração do Xorg para a placa de vídeo TN-502"

install -d /etc/X11/xorg.conf.d
install -m 644 etc/X11/xorg.conf.d/tn502-5seats.conf.in /etc/X11/xorg.conf.d/tn502-5seats.conf
install -m 644 etc/X11/xorg.conf.d/nested-5seats.conf.in /etc/X11/xorg.conf.d/nested-5seats.conf
sed -i -e "s/@TN502_DISPLAY@/${tn502_display}/g" -e "s/@TN502_ADDRESS_0@/${tn502_endereco[0]}/g" -e "s/@TN502_ADDRESS_1@/${tn502_endereco[1]}/g" /etc/X11/xorg.conf.d/tn502-5seats.conf
sed -i -e "s/@TN502_DISPLAY@/${tn502_display}/g" /etc/X11/xorg.conf.d/nested-5seats.conf

progresso "Instalando os scripts do LightDM para manipulação de contas de convidado"

install -m 755 usr/local/sbin/* /usr/local/sbin

progresso "Instalando os arquivos de configuração do LightDM para multiterminais"

install -d /etc/lightdm/lightdm.conf.d
install -m 644 etc/lightdm/lightdm.conf.d/logind.conf /etc/lightdm/lightdm.conf.d

progresso "Ativando os serviços do systemd necessários para os computadores do Proinfo"

systemctl enable x-daemon-Nseats@${tn502_display}.service

progresso "Ativando as novas regras do udev e trazendo os novos terminais à vida"

udevadm trigger
systemctl restart lightdm.service
