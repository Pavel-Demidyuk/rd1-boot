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
wget --no-check-certificate https://github.com/Pavel-Demidyuk/rd1-boot/archive/master.zip && mv master.zip boot.zip
wget --no-check-certificate https://github.com/Pavel-Demidyuk/rd1-dashboard/archive/master.zip  && mv master.zip dashboard.zip

unzip boot.zip
unzip dashboard.zip
rm -rf boot.zip dashboard.zip
mv rd1-boot-master rd1-boot
mv rd1-dashboard-master rd1-dashboard
chmod -R +x rd1-boot
cd rd1-boot && ./install.sh
