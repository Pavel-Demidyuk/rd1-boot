#!/usr/bin/env bash

# INITIAL RD1 Configurator

# this file should be called remotely by next command:
#  bash -c "$(curl -sSL https://raw.githubusercontent.com/Pavel-Demidyuk/rd1-boot/master/boot.sh)"


wget --no-check-certificate https://github.com/Pavel-Demidyuk/rd1-boot/archive/master.zip
unzip master.zip
mv rd1-boot-master rd1-boot
cd rd1-boot && run install.sh
