#!/bin/bash

install -m 644 etc/apt/sources.list.d/obs-home-lbssousa-debian.list /etc/apt/sources.list.d
apt update
apt -y upgrade
