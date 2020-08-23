#!/usr/bin/env bash
wget --no-check-certificate https://github.com/Pavel-Demidyuk/rd1-boot/archive/master.zip
unzip master.zip
mv rd1-boot-master rd1-boot
cd rd1-boot && run install.sh
