#!/usr/bin/env bash

# INITIAL RD1 Configurator

# this file should be called remotely by next command:
#  bash -c "$(wget --no-check-certificate https://cutt.ly/rd1-start && cat rd1-start)"
#
# cutt.ly stands for https://raw.githubusercontent.com/Pavel-Demidyuk/rd1-boot/master/boot.sh
#
# TODO:
# 1. cleanup adfter install  (delete wifi)
# 2. enable i2c
# 3. [ INFO ] DietPi has detected an increased GPU memory is required for your installed software:

rm -rf master* rd1*
wget --no-check-certificate https://github.com/Pavel-Demidyuk/rd1-boot/archive/master.zip
unzip master.zip
rm -rf master.zip
mv rd1-boot-master rd1-boot
chmod -R +x rd1-boot
cd rd1-boot && ./install.sh
