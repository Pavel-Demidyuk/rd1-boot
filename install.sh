#!/bin/bash
PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH
# step 1: login to dietpi and setup internet connection
# step 2: run this file
# install docker
/boot/dietpi/dietpi-software install 162 || exit 1 &
# install avahi
/boot/dietpi/dietpi-software install 152 || exit 1 &
# install chromium
/boot/dietpi/dietpi-software install 113 || exit 1 &


# pull rd1-app
docker pull eu.gcr.io/rd1-build/rd1-app:arm &
# pull rd1-owserver
docker pull eu.gcr.io/rd1-build/rd1-owserver:arm &
# pull mqtt
docker pull eclipse-mosquitto:latest &
#setup rd1 service
wait

#setup hassio
sudo apt-get install python3 python3-dev python3-venv python3-pip libffi-dev libssl-dev autoconf build-essential
sudo useradd -rm homeassistant -G dialout,gpio,i2c
cd /srv
sudo mkdir homeassistant
sudo chown homeassistant:homeassistant homeassistant
sudo -u homeassistant -H -s
cd /srv/homeassistant
python3 -m venv .
source bin/activate
python3 -m pip install wheel
pip3 install homeassistant

cp services/home-assistant@homeassistant.service /etc/systemd/system/home-assistant@homeassistant.service
sudo systemctl --system daemon-reload
sudo systemctl enable home-assistant@homeassistant

# install display driver
#chmod -R 755 LCD-show
#bash LCD-show/LCD35-show

